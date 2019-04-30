Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F97D1F45F
	for <e@80x24.org>; Tue, 30 Apr 2019 22:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfD3WRC (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 18:17:02 -0400
Received: from mout.gmx.net ([212.227.17.22]:56341 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbfD3WRB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 18:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556662611;
        bh=HD4cETc+lqIp7RoArA9u491PkcwMMOkw96gDccFA3RA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JFUel816clc/5Q57ADPVNzV3NVpbE3drPoZAveYwy/T0dD2mt4SmJKt9rMQg7bWFg
         P321Ic6VepiXHF+INDMtSL2G6AV2WmAjkBMkmKfHPPvuJZai6gTp1W7M6QjKtcKDSV
         IR3+IZnRFhn9nHoPGankIi+VP5Y71BIMCngrcNSU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.96.188] ([12.174.135.204]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MYsEZ-1hI0PJ3V4N-00VkO2; Wed, 01
 May 2019 00:16:51 +0200
Date:   Tue, 30 Apr 2019 18:16:48 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] ci: install 'libsvn-perl' instead of 'git-svn'
In-Reply-To: <20190430123724.16150-1-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1904301816200.45@tvgsbejvaqbjf.bet>
References: <20190430123724.16150-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1223673502-1556662610=:45"
X-Provags-ID: V03:K1:9MlXUg7yQdtji/iKaEgQxbbjOFr2KamTAaOzgi3mByXXIn3EuYu
 zAQS5PvKMk5KtGd26d5kz4677/pEvmsbRrAfZGLJ3HqJyl+Ra7JA3ePWdI5DwpJ3skoAWPU
 7oQkFZyYm/QA1jsFQjOuLIxHho9UNzxXFDQkIovj2+Za0eNW+vVXxQhEa9LY+vfHSonG78K
 6xF5QYwc8PxaluwaAffDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JmPnNjeG9/Q=:lbASK+cDr6m/UAC00Qp9T6
 uF6gHC51ISSbZgmV+lwXGkJ62yaCLgLf8h8qLy8/JQ/1g8zxiWkiiPuAvWDVxfo9WtWUEre0M
 XRffsJU6rQfh4bjKBBAnJwY4nNyFztF8gxxOmpoGCj45M8/Kej6fa8EzvJWw4zFu1Qyd80RGM
 jPpwAPkf8EsjNJVQIH7EewREy+lSrIB9Z69FVUAVccUHIx2mhqjyXK/wirAJkCuY8YcVigNWB
 6OvZIYXQJnslkaTNvYcOZMDT7bDOp+AMm541hZW1NP6ytqSI8EjUamPOmRlTIdZGna4ZxlDBG
 QbXOABjhXHjD2bzp51vpF9G05ZCEiNX854LnGsH/D7JoQjJEbyUKrXoD9YDZ+3BIFhz79akDi
 /Yy2LS/hhdoL7xJ6lWjNsIrhbkTPI14Hi8eAYBocno/P/PhQvnYfvtfmaINXOStCNhFXpkoKp
 PiZkRKAlxbSMjjaTLih4PIejG5vRAu27w9HtzqWANtA0yhay5oOPtsdrQzhcrDSRFqo1Qirlg
 NZWS2dkAjMCN9oWhD2DeSQkkE07qjGUcKZr/dpoOWiJXBv8ZYPI8Dd+PIQDTSkxt3NdHRW7RX
 7czJR9oUCSQJM5ZHSvdmpljiflDZnOQKP32oDxr4rCroJjZeVK6WOrbvKJQO1MNcxjaYBYJG8
 4G/FDmhso/kyX+v+KWdXmIEyKr02OV+Fx/9+hj/VBfblQ+hjMGq1e2CZ82N1aSPFdzkBKL/Cm
 6cbjI8QZW8h8BWLbGg4yZFPsSyzgGgHLdOO4sSWbY/xK528lXfz8qFesk9VDWOh9IGhMHTijD
 QGCWmVKZZgQ8H2hajxtXg49agwCI3y0KP9DNXHV5qlTZluoxt6/YjsqH7terEUKkUTeRJzDCn
 LK/4EmF5fkOz6ol5XUuzJKK224kCj/FT8l2dpMofmY96fqY2OEJB4NQInDjta96r+VzLLq9V5
 WkxzWmQ/euQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1223673502-1556662610=:45
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 30 Apr 2019, SZEDER G=C3=A1bor wrote:

> Since e7e9f5e7a1 (travis-ci: enable Git SVN tests t91xx on Linux,
> 2016-05-19) some of our Travis CI build jobs install the 'git-svn'
> package, because it was a convenient way to install its dependencies,
> which are necessary to run our 'git-svn' tests (we don't actually need
> the 'git-svn' package itself).  However, from those dependencies,
> namely the 'libsvn-perl', 'libyaml-perl', and 'libterm-readkey-perl'
> packages, only 'libsvn-perl' is necessary to run those tests, the
> others arent, not even to fulfill some prereqs.
>
> So update 'ci/install-dependencies.sh' to install only 'libsvn-perl'
> instead of 'git-svn' and its additional dependencies.
>
> Note that this change has more important implications than merely not
> installing three unnecessary packages, as it keeps our builds working
> with Travis CI's Xenial images.  In our '.travis.yml' we never
> explicitly specified which Linux image we want to use to run our Linux
> build jobs, and so far they have been run on the default Ubuntu 14.04
> Trusty image.  However, 14.04 just reached its EOL, and Travis CI has
> already began the transition to use 16.04 Xenial as the default Linux
> build environment [1].  Alas, our Linux Clang and GCC build jobs can't
> simply 'apt-get install git-svn' in the current Xenial images [2],
> like they did in the Trusty images, and, consequently, fail.
> Installing only 'libsvn-perl' avoids this issue, while the 'git svn'
> tests are still run as they should.
>
> [1] https://blog.travis-ci.com/2019-04-15-xenial-default-build-environme=
nt
>
> [2] 'apt-get install git-svn' in the Xenial image fails with:
>
>       The following packages have unmet dependencies:
>        git-svn : Depends: git (< 1:2.7.4-.)
>       E: Unable to correct problems, you have held broken packages.
>
>     The reason is that both the Trusty and Xenial images contain the
>     'git' package installed from 'ppa:git-core/ppa', so it's
>     considerably newer than the 'git' package in the corresponding
>     standard Ubuntu package repositories.  The difference is that the
>     Trusty image still contains these third-party apt repositories, so
>     the 'git-svn' package was installed from the same PPA, and its
>     version matched the version of the already installed 'git'
>     package.  In the Xenial image, however, these third-party
>     apt-repositories are removed (to reduce the risk of unrelated
>     interference and faster 'apt-get update') [3], and the version of
>     the 'git-svn' package coming from the standard Ubuntu package
>     repositories doesn't match the much more recent version of the
>     'git' package installed from the PPA, resulting in this dependecy
>     error.
>
>     Adding back the 'ppa:git-core/ppa' package repository would solve
>     this dependency issue as well, but since the troublesome package
>     happens to be unnecessary, not installing it in the first place is
>     better.
>
> [3] https://docs.travis-ci.com/user/reference/xenial/#third-party-apt-re=
positories-removed
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  ci/install-dependencies.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index 52a44c690a..7f6acdd803 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -12,7 +12,7 @@ case "$jobname" in
>  linux-clang|linux-gcc)
>  	sudo apt-add-repository -y "ppa:ubuntu-toolchain-r/test"
>  	sudo apt-get -q update
> -	sudo apt-get -q -y install language-pack-is git-svn apache2
> +	sudo apt-get -q -y install language-pack-is libsvn-perl apache2

Makes sense.

I assume you verified that this works also with our Azure Pipeline?

Thanks,
Dscho

>  	case "$jobname" in
>  	linux-gcc)
>  		sudo apt-get -q -y install gcc-8
> --
> 2.21.0.1181.g24122a4251
>
>

--8323328-1223673502-1556662610=:45--
