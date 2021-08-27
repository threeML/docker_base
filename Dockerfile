FROM condaforge/mambaforge
MAINTAINER Michael Burgess <jburgess@mpe.mpg.de>
USER root
ADD env.yml .

#COPY --chown=micromamba:micromamba env.yml /tmp/env.yml
ENV USER='root'

# Install conda packages and build externals
ENV PATH=/opt/conda/bin:${PATH}

SHELL ["/bin/bash", "-c"]
RUN mamba env create -n env -f env.yml &&\
    conda clean --all --yes &&\
    mamba init &&\
    source activate env &&\
    jt -t grade3 -f firacode -T -N -kl -cellw 90%  -cursc g &&\
     python3 -c "from astromodels.xspec import *" &&\ 
    echo "source activate env" > ~/.bashrc


WORKDIR /workdir

# import xspc modeles

ENV MPLBACKEND='Agg'
ENV OMP_NUM_THREADS='1'
ENV MKL_NUM_THREADS='1'
ENV NUMEXPR_NUM_THREADS='1'


ENV PATH="${CONDA_PREFIX}/lib/python3.7/site-packages/fermitools/GtBurst/commands/:${PATH}"

# CMD ["usleep 5 &&  jupyter notebook --notebook-dir=/workdir --ip='0.0.0.0' --port=8888 --no-browser --allow-root"]

ENTRYPOINT ["/bin/bash","--login","-c"]
