Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86B351F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbfAQNpV (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:45:21 -0500
Received: from mout.gmx.net ([212.227.15.18]:42343 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbfAQNpV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:45:21 -0500
Received: from [10.49.97.215] ([95.208.59.108]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lk7fW-1hLwZN14Ic-00c8Vv; Thu, 17
 Jan 2019 14:45:15 +0100
Date:   Thu, 17 Jan 2019 14:44:59 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 5/5] travis-ci: build with the right compiler
In-Reply-To: <20190117012913.30562-6-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901171439280.41@tvgsbejvaqbjf.bet>
References: <20181220162452.17732-1-szeder.dev@gmail.com> <20190117012913.30562-1-szeder.dev@gmail.com> <20190117012913.30562-6-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1934975530-1547732715=:41"
X-Provags-ID: V03:K1:weyh/SI44/RfZu11OElye3WmAKBxhv+SKTHBnwssDlL6VBOwYHE
 4uuEBS830UsRlF2cej2pLKXDXoUafd7IkeMQSHW3zS7WgP4xxBEX8qSKDUTLPTFNyoO25CC
 RwdHQQRiAAjd3igYGPdD8tPMjqxYEnqB3WtT6hs/kP9z8DglMgYGX2Mh8VJi3in9P+ZPU67
 v46QKn0cQthHfgfU5Syeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xE/1sJuaMZs=:nOjORUwqbpb7kp4EOw6T4D
 yPl6p1WO6VRtLYw0FKkftO+diilCdTxRasRH4BkihMQsq6aOzuXW8pCOFMUQR+e05YjZZiKmo
 m85lZzhZI+kfgXhvWLhVTKPLNNMVmBgRgDwwLMG7m+QnG4xCtp/4M8HhHBD8fS/1P76bTfAbD
 XwKzB6xeyXkws1daAIjys47PdN/dKDBYLTABu2DEqEg/PSbiikTWMragFZ0fCE0s2RJFaJgYw
 Zfg0jYrTvanHN2jUUT+FSmofsQmPLW3ltLeg/gHRSCLTnRV/NKRcVDxr8c/iaZL1w7yEAXNfD
 9MAi7NVWX4+iM4RWiKj4vCOiK0J9h5pK+bv6BPvjXbEdyQLgx34Lb/Nw21sNXYx4TBfn6ElUt
 tI3d/QRVVdkFBXvOxnOLo5S7IQ9c478Ay5YOudyvbGGwvOoD92pj93VRTTlKLhCKbrs32w/LM
 AaPP3TVsGpK7JO7mBe6J1Ez9EsZyQVdJaM2fmDJV3ABZszO0F0EiF3yRMW/r4btSuOkC5Qn6z
 ZgKKZLD+bgB7ZwcxkpkpHDxdsBE0u765p8w//lf/b6PUuWaaaWgbtIEl8og7bESkaNZkcvZYA
 NfAEUnfQV50Rx11SdWq0d+iJtXgDC0wumVFdt3XHBFqVjYnu9maftUMTFs2jkVsW4wAaqar0i
 inWN/+d/M1nLjlriyy/693ezEUng+Ul53fVejqVilbV/A04JZOmc0qTN4b4++m+rGmc2oBkof
 xuxb68CfKWOX4G114UDbsPtF1L3dmkedFd8r4boKMt3msUb96Mc2LmFpBLp9UKfNuCJCjwQRR
 TNZhCM/Cv7n4pLAMG10iSNe/CL7BE2Li2Idra+FK8Qmt1mmelxJXad0BVOLMl7hxLhUM0Y16V
 nHcPxL6j5o3K8QT75MiApR6WLyaqJxPvDRVCjQBMvPzWN6xOHzrP6q688KDidXCge+2QQ9stu
 dAb6pO6niXw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1934975530-1547732715=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Gábor,

On Thu, 17 Jan 2019, SZEDER Gábor wrote:

> Our 'Makefile' hardcodes the compiler to build Git as 'CC = cc'.  This
> CC variable can be overridden from the command line, i.e. 'make
> CC=gcc-X.Y' will build with that particular GCC version, but not from
> the environment, i.e. 'CC=gcc-X.Y make' will still build with whatever
> 'cc' happens to be on the platform.
> 
> Our build jobs on Travis CI are badly affected by this.  In the build
> matrix we have dedicated build jobs to build Git with GCC and Clang
> both on Linux and macOS from the very beginning (522354d70f (Add
> Travis CI support, 2015-11-27)).  Alas, this never really worked as
> supposed to, because Travis CI specifies the compiler for those build
> jobs as 'export CC=gcc' and 'export CC=clang' (which works fine for
> projects built with './configure && make').  Consequently, our
> 'linux-clang' build job has always used GCC, because that's where 'cc'
> points at in Travis CI's Linux images, while the 'osx-gcc' build job
> has always used Clang.  Furthermore, 37fa4b3c78 (travis-ci: run gcc-8
> on linux-gcc jobs, 2018-05-19) added an 'export CC=gcc-8' in an
> attempt to build with a more modern compiler, but to no avail.
> 
> Set MAKEFLAGS with CC based on the $CC environment variable, so 'make'
> will run the "right" compiler.  The Xcode 10.1 macOS image on Travis
> CI already contains the gcc@8 package from Homebrew, but we have to
> 'brew link' it first to be able to use it.
> 
> So with this patch our build jobs will build Git with the following
> compiler versions:
> 
>   linux-clang: clang version 5.0.0 (tags/RELEASE_500/final)
>   linux-gcc:   gcc-8 (Ubuntu 8.1.0-5ubuntu1~14.04) 8.1.0
> 
>   osx-clang: Apple LLVM version 10.0.0 (clang-1000.11.45.5)
>   osx-gcc:   gcc-8 (Homebrew GCC 8.2.0) 8.2.0
> 
>   GETTEXT_POISON: gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>

Nicely explained and implemented. Thank you!

Apart from the single typo I stumbled over (quite honestly, I do not
really care about typos, I just point them out when I see them to beat
Eric to it), I have just one more wish: I would *love* to see a Travis
run.

Surely you opened a PR at https://github.com/git/git. Oh wait, I can look
for it! But no, there does not seem to be one. So probably in your fork,
https://github.com/szeder/git. No PRs. Ah, but there are branches! 60 of
them. And yes, I guess I found a Travis build:

	https://travis-ci.org/szeder/git/builds/480654256

But no, the associated branch does not look like it reflects this patch
series...

In any case, this series is:

	Reviewed-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Ciao,
Dscho


> ---
>  ci/install-dependencies.sh |  5 +++++
>  ci/lib-travisci.sh         | 15 ++++++++++++---
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 06c3546e1e..dc719876bb 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -40,6 +40,11 @@ osx-clang|osx-gcc)
>  	brew install git-lfs gettext
>  	brew link --force gettext
>  	brew install caskroom/cask/perforce
> +	case "$jobname" in
> +	osx-gcc)
> +		brew link gcc@8
> +		;;
> +	esac
>  	;;
>  StaticAnalysis)
>  	sudo apt-get -q update
> diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
> index 69dff4d1ec..a479613a57 100755
> --- a/ci/lib-travisci.sh
> +++ b/ci/lib-travisci.sh
> @@ -99,12 +99,14 @@ export DEFAULT_TEST_TARGET=prove
>  export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
>  export GIT_TEST_OPTS="--verbose-log -x --immediate"
>  export GIT_TEST_CLONE_2GB=YesPlease
> -if [ "$jobname" = linux-gcc ]; then
> -	export CC=gcc-8
> -fi
>  
>  case "$jobname" in
>  linux-clang|linux-gcc)
> +	if [ "$jobname" = linux-gcc ]
> +	then
> +		export CC=gcc-8
> +	fi
> +
>  	export GIT_TEST_HTTPD=YesPlease
>  
>  	# The Linux build installs the defined dependency versions below.
> @@ -118,6 +120,11 @@ linux-clang|linux-gcc)
>  	export PATH="$GIT_LFS_PATH:$P4_PATH:$PATH"
>  	;;
>  osx-clang|osx-gcc)
> +	if [ "$jobname" = osx-gcc ]
> +	then
> +		export CC=gcc-8
> +	fi
> +
>  	# t9810 occasionally fails on Travis CI OS X
>  	# t9816 occasionally fails with "TAP out of sequence errors" on
>  	# Travis CI OS X
> @@ -127,3 +134,5 @@ GIT_TEST_GETTEXT_POISON)
>  	export GIT_TEST_GETTEXT_POISON=YesPlease
>  	;;
>  esac
> +
> +export MAKEFLAGS="CC=${CC:-cc}"
> -- 
> 2.20.1.499.gf60de1223c
> 
> 
--8323328-1934975530-1547732715=:41--
