Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A09620248
	for <e@80x24.org>; Fri, 29 Mar 2019 15:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbfC2P4r (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 11:56:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:47883 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728839AbfC2P4q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 11:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553874988;
        bh=do9s7kcz+bU+BDqtEBzzOo1Nq0AHeplUU+F11CA5QIQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DhKwRSffsjKY0kGZSQbgfw/WSrjutao4vxkQ+jFZJ7jvm5S2S5qxqY4v9cBwUUBrV
         MNcRy/UpZiD6vvnxsjy+txVne/9CdJTUmnh1GDIr8utmMpKVIC2/08YqPBWk380qNl
         rjHCOZHvzkUxqfORfSVodYF/r0DwS5Crc3GrYqYs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MDE6y-1hB43E1olQ-00GYis; Fri, 29
 Mar 2019 16:56:28 +0100
Date:   Fri, 29 Mar 2019 16:56:28 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Todd Zullinger <tmz@pobox.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 0/6] Asciidoctor-related formatting and CI fixes
In-Reply-To: <20190329123520.27549-1-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903291653590.41@tvgsbejvaqbjf.bet>
References: <20190324215534.9495-1-szeder.dev@gmail.com> <20190329123520.27549-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1151427003-1553874990=:41"
X-Provags-ID: V03:K1:TPqiaYQy+qDhtyWZlvul5QvSxicwwFsfLx/0i2bHhqjmSKEDMRP
 uRT9thmEuZBK4XJk/u8CDy2Arb060vmGUA9O51FJ8aUkuKorwYEQRaDJEt0NnFXqyfZ4lsq
 FBIvb+BSQzC94yoHht/08v40AOc/DM7e3c5NgrJy9yn9CGPqqSq/ijC7pIXaT6POw11hekH
 3shcEBsCJcwwEacTdMtMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+uQ6kxDf1k8=:9XsIV4K1T0i4yNDXeAWtXp
 6uLQqy0muS25bE3z2SNM2M285TV7PRkwHxaIAoJsl/vSN2NaGKk4jxixDgYe6FTEepNPkbNIK
 5iIE9Iu+WFFXvhI4sOU6psCF/rf6+sNVqHbbfs76U98vWALwFb6KFEUZ4vE8VbRrfnVNbfuer
 WDaQwl6EIP9L3KQ9bLLngh2EgAkxsUwopOHwxRzzYdMaLx0jExNxpAbUaHKvL5Xs/VqW+kKcS
 sRE76jcH1nnGhMREABvygjYpDeK4JHtj0Pgc+hkomotmr9uQv083OKNsMDd0boFt3NOzQPZzB
 RGbI97KmxspAY6BgEvlxxmCwpdMQmWA9VP+moykiy80kTDlc+mOJaOm8psBG47yi5x+yWFs5x
 0+ki241ZHPCMqqht5J0Cs4Dv/VRnT5nNWIqVfHp2WKbd+mtFVwzXu08blgtxl/GWZv+mtQAoh
 5/5F2GgsP4RCvHrxH1ItIAzr6IzUVNddZipPnKb6fplOEtKvkiJ4Q7+h6bMPT1g9pNJAt3UhN
 ODJ+CDPAJFpU4QvxChU/405JldGXGp7lNMilOe4iRVT03hxuGVQuqIvSzYua9by/MKEJotKWg
 CrLijOVxrEP8ApAaYGddWP0YQERhfb0UP38PSExRNNonoJ+muzg4wpCX+IfcBzyBJkYE+hWdQ
 zmP9K05vS6gxaQ/waEASSPtbud+h0E7n9GYCVfZ9Df3D9s+ZoSfn1gI8Qz3M3e5DPhlCJ7T7h
 6nIY1GjshoVyztLKluDVp6P43BaLtGqen8nXKjfAp2o9YCek/wkqDJgeYH9TGoCwa2lb0AW1c
 cC1LmvbeX+iRwwyO7QGGyNX5KCW3GWvwZ4cAnaCyUKXiEWUp5QqHiZFbN2nXAgK11oJnQYQL8
 IGMXNiXB8/l6C5oaCj380ikh+Z9FpXW2x7C8rO3nTnM76SKNjvlgKnNCAYmeL9eoHC34zaalp
 KM66jltebLg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1151427003-1553874990=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 29 Mar 2019, SZEDER G=C3=A1bor wrote:

> [...]
>   - Mention in patch 4's commit message that Asciidoctor is still only
>     installed in the Documentation build job.
> [...]
>
> Range-diff:
> 1:  8026f62876 =3D 1:  8026f62876 Documentation/git-diff-tree.txt: fix f=
ormatting
> 2:  fd19cf4b24 =3D 2:  fd19cf4b24 Documentation/technical/api-config.txt=
: fix formatting
> 3:  638dcd64e9 =3D 3:  638dcd64e9 Documentation/technical/protocol-v2.tx=
t: fix formatting
> 4:  6f8c6ff398 ! 4:  2e94e2b7b6 ci: install Asciidoctor in 'ci/install-d=
ependencies.sh'
>     @@ -6,8 +6,9 @@
>          installation of the 'asciidoctor' gem somehow ended up in
>          'ci/test-documentation.sh'.
>
>     -    Install it in 'ci/install-dependencies.sh', where we install
>     -    everything else.
>     +    Install it in 'ci/install-dependencies.sh', where we install ot=
her
>     +    dependencies of the Documentation build job as well (asciidoc,
>     +    xmlto).

I would have wished for something that more explicitly said that it still
*only* installs it for the Documentation job.

But I can live with the current wording.

>          [1] 657343a602 (travis-ci: move Travis CI code into dedicated s=
cripts,
>              2017-09-10)
> [...]
>
>     @@ -66,15 +77,32 @@
>       +++ b/ci/test-documentation.sh
>      @@
>
>     + . ${0%/*}/lib.sh
>     +
>     ++filter_log () {
>     ++	sed -e '/^GIT_VERSION =3D /d' \
>     ++	    -e '/^    \* new asciidoc flags$/d' \
>     ++	    "$1"
>     ++}
>     ++
>     + make check-builtins
>     + make check-docs
>     +
>       # Build docs with AsciiDoc
>     - make doc > >(tee stdout.log) 2> >(tee stderr.log >&2)
>     +-make doc > >(tee stdout.log) 2> >(tee stderr.log >&2)
>      -! test -s stderr.log
>     -+cat stderr.log
>     ++make doc > >(tee stdout.log) 2> >(tee stderr.raw >&2)
>     ++cat stderr.raw
>     ++filter_log stderr.raw >stderr.log
>      +test ! -s stderr.log
>       test -s Documentation/git.html
>       test -s Documentation/git.xml
>       test -s Documentation/git.1
>     -@@
>     + grep '<meta name=3D"generator" content=3D"AsciiDoc ' Documentation=
/git.html
>     +
>     +-rm -f stdout.log stderr.log
>     ++rm -f stdout.log stderr.log stderr.raw
>     + check_unignored_build_artifacts
>
>       # Build docs with AsciiDoctor
>       make clean
>     @@ -82,8 +110,8 @@
>      -sed '/^GIT_VERSION =3D / d' stderr.log
>      -! test -s stderr.log
>      +make USE_ASCIIDOCTOR=3D1 doc > >(tee stdout.log) 2> >(tee stderr.r=
aw >&2)
>     -+sed '/^GIT_VERSION =3D / d' stderr.raw >stderr.log
>     -+cat stderr.log
>     ++cat stderr.raw
>     ++filter_log stderr.raw >stderr.log
>      +test ! -s stderr.log
>       test -s Documentation/git.html
>       grep '<meta name=3D"generator" content=3D"Asciidoctor ' Documentat=
ion/git.html

Wow. Subtle. And a bit hard to read without color ;-) But from what I
understand, this does the right thing.

So from my side, this patch series is good to go!

Thanks,
Dscho

--8323328-1151427003-1553874990=:41--
