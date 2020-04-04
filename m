Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D57AC4332B
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 17:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71BE206E6
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 17:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="AiS2t7r8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgDDR7l (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Apr 2020 13:59:41 -0400
Received: from mout.gmx.net ([212.227.17.22]:56783 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgDDR7l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Apr 2020 13:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586023178;
        bh=ct+SJShLQNtfNkAtCMvIRvG4eUJWoaKgpKP1mrlH2r8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AiS2t7r8C8zjoU5iUL6sUQFX0QtwBJbtXA2CHHiZLzMG6mDBwtCFOgJfC49lrj+YI
         2Qo6PQ2vSd4EuVSviQ8ropqthHQpIyKtEGLPb0n52JxSr2Ju0Cx3m1avc+jTZwO2kn
         7OQ/wYb3HEsuoAsm/t+fXCupPjCPFOmyEU9E/dbw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.7]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MGhyc-1jYabI1NK6-00DsA9; Sat, 04 Apr 2020 19:59:38 +0200
Date:   Sat, 4 Apr 2020 19:59:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/5] ci: configure GitHub Actions for CI/PR
In-Reply-To: <20200403220732.GL2224@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.2004041952050.46@tvgsbejvaqbjf.bet>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <36621bdd31a53046450f73ed197585469b1a1b96.1585658913.git.gitgitgadget@gmail.com> <20200403220732.GL2224@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1057302876-1586023178=:46"
X-Provags-ID: V03:K1:H16LQz8l8MHuYmgFkrC/S+xXhOK/uGp+f1nFdZkq0WNqPRjfvaK
 qxSmhzuEhzqPmp64lMWEQZcZzVjy/ZUY0kIB9XrJLraS4qFmSt2wQYLa3tlbQueGDOFA5ZB
 +CRbmEGe5Kdnp/lV/3R0g4SXc59LBpLp1HBRaB6cncheElHAc4mhonbRBT2vtcFlgX6IjVK
 RvpCrSRM4so4ydsQ/e4Ow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rCq3bJIWMi4=:FwS3laVEO8IIrHX7Y6uffB
 mnXrgbNM405ZYN6acC8l5N7Cfozp7GFmy+sbzy3u8BazmshQX1W/Gnt0afQZAyPrHpreqEt3L
 9MXD7GoK4PaSmdpRDW7uLG/Y4yqORqAvwdza95ShKbEGGf2BbvtEQ11Z4bXlB85aeLeB960NY
 0/fORpwgjrHYWKDCseRVTxhUHsFN0XzepokLQrE4N7Jv99rm9iXazpr6jZHQrtNBu6btrHkqF
 CYlodgENZXHD8LohVN5M8JAGNZ+2ZBCbd2DB3Cgp/wQn40d8KFNnnLtfqr2xv8rNkwuxZjyiS
 S6WtH9tCN1uLvEPdVsFRLb1oP4hj8IBgBB5twpOJY/JN58013Vapjz+k3kn4kvudfa7sw5u88
 BF84taJY8uC3Nw/JXOWrZA7ZPkX3tEbzR/lS7wRVmgBNLTuv02pA/U/NCx3OVNPaSAJcISR/6
 YE+ExMZHYY/7l37TC3qhDn95KZ9kCtM/nZjXO4cTRIhw9n7jEhiK5Q1JOKnLko95tqBoSj69w
 tylDSGij6wIo3iZ01FwzN3knWlfbGtXMHjfJbqfWuRS/rDUl8fibzhP4l5TbP3VpiViMpQdhc
 AavgKQ6kTZt3haRzTenlztKleRMiXlTX+pa6QUj1M+TpopDgN6+2Gl7LrknrcX/ceuegkQTfV
 coj/wH/MVYYL4bFpz89t1nTu8DvhvZzKZCLgLX8xH4mlG2ZONfP+xh4Ci+OIkc2dMDXAm4YpU
 6q73D6x60S6HmZlSFyScQ9ZHS/2DfNpvYhJiKSt7idfD/VX6MXx3BNsnXOUi1DFTlxe7I4yRq
 ZnnLcfRKSQa3rpXqDKBj5rcYhNiFnWv/CIUDAErSIl4zFvUx+r4QxqzvCPWJrMgzfC86XTFAT
 YMll0Fr4QKO3k/P+prJrnmenROECBiFSNztc3TcJQADc0sYS/90NsP2oDdOv4YSUeAnNFj78J
 Z5OifMWah6e3aJPvVIxfwH3eztNmHCfaAbitstQhOc3sk2HkvR4GrBAeqUbihHH4xKinMGkhR
 Ucwmn0rsHtQ6dZSI3dvCYk+bPxgoXSIOcoDobOsRkaMQwNGujdBCmEn3SqwDF5bB7T15y58BV
 mzlOqhEX7dgjy9t9dJzOyjmkNYg2GjPWXqVj12bJFCcXoHJDFA+fF6K7Ej2wlMWLAo6HOIULf
 RaNy2NEq0a6ArrZtwwKLZdvPmxiETQD4effO+SNy8imgGqNnNQ0FFlnXHqqVnFYFsgvCVtykh
 6iEHmKcmfSsZKvrTV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1057302876-1586023178=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Sat, 4 Apr 2020, SZEDER G=C3=A1bor wrote:

> On Tue, Mar 31, 2020 at 12:48:31PM +0000, Johannes Schindelin via GitGit=
Gadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > This patch adds CI builds via GitHub Actions. While the underlying
> > technology is at least _very_ similar to that of Azure Pipelines, GitH=
ub
> > Actions are much easier to set up than Azure Pipelines: no need to
> > install a GitHub App, no need to set up an Azure DevOps account, all y=
ou
> > need to do is push to your fork on GitHub.
>
> And then receive emails from GitHub if a build fails, even though you
> never asked for it?  Well, I've always preferred opt-in instead of
> opt-out.

This complaint is misdirected.

You can easily disable it if you want to
(https://help.github.com/en/github/administering-a-repository/disabling-or=
-limiting-github-actions-for-a-repository)
and for the vast majority of Git contributors, the default to run this
workflow is totally the best idea.

> Btw, does it offer direct shell access for debugging?

There is https://github.com/marketplace/actions/debugging-with-tmate

> > Therefore, it makes a lot of sense for us to have a working GitHub
> > Actions setup.
> >
> > While transmogrifying `azure-pipelines.yml` into
> > `.github/workflows/main.yml`, we also use the opportunity to accelerat=
e
> > the step that sets up a minimal subset of Git for Windows' SDK in the
> > Windows-build job: we now download a `.tar.xz` stored in Azure Blobs a=
nd
> > extract it simultaneously (by calling `curl` and piping the result to
> > `tar`, decompressing via `xz`, all three utilities being available by
> > grace of using Git for Windows' Bash that is installed on the build
> > agents). This accelerates that step from ~1m50s to ~7s.
> >
> > Also, we do away with the parts that try to mount a file share on whic=
h
> > `prove` can store data between runs.
>
> ... and on which we store the list of already successfully tested
> trees, so when a branch is rebased changing e.g. only the commit
> messages but leaving the code intact, then the CI won't run
> unnecessary builds.

In practice, I saw this Pipeline being run time and time again, as the
tree _did_ change most of the time.

A pipe dream of mine is to use actual Test Impact Analysis so that we
truly can run only the affected tests, but that seems so, so far away.

> > It is just too complicated to set
> > up, so it's little return on investment there.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
>
> > +  linux-clang:
> > +    runs-on: ubuntu-latest
> > +    steps:
> > +    - uses: actions/checkout@v1
> > +    - name: install dependencies
> > +      env:
> > +        CC: clang
> > +      run: |
> > +        sudo apt-get update &&
> > +        sudo apt-get -y install git gcc make libssl-dev libcurl4-open=
ssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2-bin &&
>
> Why install all these dependencies here, when the very next command is
> 'ci/install-dependencies.sh', whose purpose is to install the
> dependencies?

I copy/pasted these from `azure-pipelines.yml`, and agree that they should
be handled via `ci/install-dependencies.sh` instead.

Danh (is this the correct way to address you?), if you want to have a look
at that, go for it. Otherwise I'll try to find some time to do that
myself.

Thanks,
Dscho

> > +        ci/install-dependencies.sh
> > +    - name: ci/run-build-and-test.sh
> > +      env:
> > +        CC: clang
> > +      run: |
> > +        ci/run-build-and-tests.sh || {
> > +          ci/print-test-failures.sh
> > +          exit 1
> > +        }
> > +  linux-gcc:
> > +    runs-on: ubuntu-latest
> > +    steps:
> > +    - uses: actions/checkout@v1
> > +    - name: install dependencies
> > +      run: |
> > +        sudo add-apt-repository ppa:ubuntu-toolchain-r/test &&
> > +        sudo apt-get update &&
> > +        sudo apt-get -y install git gcc make libssl-dev libcurl4-open=
ssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2 language-=
pack-is git-svn gcc-8 &&
>
> Likewise, and here you install some additional packages compared to
> the clang job as well.
>
> > +        ci/install-dependencies.sh
> > +    - name: ci/run-build-and-tests.sh
> > +      run: |
> > +        ci/run-build-and-tests.sh || {
> > +          ci/print-test-failures.sh
> > +          exit 1
> > +        }
> > +  osx-clang:
> > +    runs-on: macos-latest
> > +    steps:
> > +    - uses: actions/checkout@v1
> > +    - name: install dependencies
> > +      env:
> > +        CC: clang
> > +      run: ci/install-dependencies.sh
> > +    - name: ci/run-build-and-tests.sh
> > +      env:
> > +        CC: clang
> > +      run: |
> > +        ci/run-build-and-tests.sh || {
> > +          ci/print-test-failures.sh
> > +          exit 1
> > +        }
> > +  osx-gcc:
> > +    runs-on: macos-latest
> > +    steps:
> > +    - uses: actions/checkout@v1
> > +    - name: install dependencies
> > +      run: ci/install-dependencies.sh
> > +    - name: ci/run-build-and-tests.sh
> > +      run: |
> > +        ci/run-build-and-tests.sh || {
> > +          ci/print-test-failures.sh
> > +          exit 1
> > +        }
> > +  GETTEXT_POISON:
> > +    runs-on: ubuntu-latest
> > +    steps:
> > +    - uses: actions/checkout@v1
> > +    - name: install dependencies
> > +      run: |
> > +        sudo apt-get update &&
> > +        sudo apt-get -y install git gcc make libssl-dev libcurl4-open=
ssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev
> > +    - name: ci/run-build-and-tests.sh
> > +      env:
> > +        jobname: GETTEXT_POISON
> > +      run: |
> > +        ci/run-build-and-tests.sh || {
> > +          ci/print-test-failures.sh
> > +          exit 1
> > +        }
> > +  linux32:
> > +    runs-on: ubuntu-latest
> > +    steps:
> > +    - uses: actions/checkout@v1
> > +    - name: ci/run-linux32-docker.sh
> > +      run: |
> > +        res=3D0
> > +        sudo GITHUB_ACTIONS=3D"$GITHUB_ACTIONS" RUNNER_OS=3D"$RUNNER_=
OS" GITHUB_REF=3D"$GITHUB_REF" GITHUB_SHA=3D"$GITHUB_SHA" GITHUB_REPOSITOR=
Y=3D"$GITHUB_REPOSITORY" GITHUB_RUN_ID=3D"$GITHUB_RUN_ID" CC=3D$CC MAKEFLA=
GS=3D"$MAKEFLAGS" bash -lxc ci/run-linux32-docker.sh || res=3D1
> > +  static-analysis:
> > +    runs-on: ubuntu-latest
> > +    steps:
> > +    - uses: actions/checkout@v1
> > +    - name: install dependencies
> > +      run: |
> > +        sudo apt-get update &&
> > +        sudo apt-get install -y coccinelle libcurl4-openssl-dev libss=
l-dev libexpat-dev gettext
>
> Likewise, except here you don't even run 'ci/install-dependencies.sh'
> (which would install the same packages, btw.)
>
> > +    - name: ci/run-static-analysis.sh
> > +      env:
> > +        jobname: StaticAnalysis
> > +      run: ci/run-static-analysis.sh
> > +  documentation:
> > +    runs-on: ubuntu-latest
> > +    steps:
> > +    - uses: actions/checkout@v1
> > +    - name: install dependencies
> > +      run: |
> > +        sudo apt-get update &&
> > +        sudo apt-get install -y asciidoc xmlto asciidoctor docbook-xs=
l-ns
> > +    - name: ci/test-documentation.sh
> > +      env:
> > +        ALREADY_HAVE_ASCIIDOCTOR: yes.
> > +        jobname: Documentation
> > +      run: ci/test-documentation.sh
> > --
> > gitgitgadget
> >
>

--8323328-1057302876-1586023178=:46--
