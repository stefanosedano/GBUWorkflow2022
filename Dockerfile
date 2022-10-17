FROM tensorflow/tensorflow:2.0.0-gpu-py3
#bionic
ENV DEBIAN_FRONTEND=noninteractive

COPY . /GHSLprocessing

COPY ./docker_req.txt /docker_req.txt

RUN apt-get install -y software-properties-common && \
    rm -rf /var/lib/apt/lists/*

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A4B469963BF863CC
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update

RUN apt-get -y install python3.7 python3.7-dev python3.7-distutils python3-pip nano htop 
RUN python3.7 -m pip install --upgrade pip
RUN python3.7 -m pip install setuptools==57.5.0
RUN python3.7 -m pip install protobuf==3.20.0

RUN apt-add-repository ppa:ubuntugis/ubuntugis-unstable
RUN apt-get update
RUN apt-get clean 

RUN apt -y install python3-gdal libgdal-dev gdal-bin
RUN export CPLUS_INCLUDE_PATH=/usr/include/gdal
RUN export C_INCLUDE_PATH=/usr/include/gdal

RUN python3.7 -m pip install GDAL==3.0.0 --global-option=build_ext --global-option="-I/usr/include/gdal" --force-reinstall --upgrade --ignore-installed
RUN python3.7 -m pip install -r docker_req.txt

WORKDIR /GHSLprocessing
