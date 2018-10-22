# sullof/ubuntu-jdk8-mongo-node8
# this is an intermediary image used by sullof/trondev

FROM ubuntu:18.04
MAINTAINER sullof


# Install JDK8
# thanks to mlaccetti/docker-oracle-java8-ubuntu-16.04

ENV DEBIAN_FRONTEND noninteractive
ENV JAVA_HOME       /usr/lib/jvm/java-8-oracle
ENV LANG            en_US.UTF-8
ENV LC_ALL          en_US.UTF-8

RUN apt-get update && \
  apt-get install -y --no-install-recommends locales && \
  locale-gen "en_US.UTF-8" && \
  apt-get dist-upgrade -y && \
  apt-get install gnupg apt-utils git -y && \
  echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections && \
  echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > /etc/apt/sources.list.d/webupd8team-java-trusty.list && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886 && \
  apt-get update && \
  apt-get install -y --no-install-recommends oracle-java8-installer oracle-java8-set-default && \
  apt-get clean all


# Install MongoDB

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4 && \
  echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/4.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list && \
  apt-get update && \
  apt-get install -y libcurl4 && \
  apt-get install -y mongodb-org && \
  mkdir -p /data/db


# Install Node

RUN apt-get install -y wget && \
  wget https://deb.nodesource.com/setup_8.x && \
  bash setup_8.x && \
  apt-get install -y nodejs


CMD ["bash"]
