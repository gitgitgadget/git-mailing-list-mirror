Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83DAC19F29
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 21:59:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbiGZV7s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 17:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiGZV7r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 17:59:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE4528734
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 14:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1658872783;
        bh=xEYldy9SNG9Tid8Pw4IrWUTwxnFGkztAs86AmtKarSo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=MFG8KcJIf/oVMmAGzmL/VIZCrEOAwvCK2LvWql9gumC+GSHLYZAb7ASfi8FSiwSlg
         sXeOy46DohyJ+NByFBkvCPC9t0i5bxa5nq/TUmhg4RhRz03I9NiegkA+KZMppxRozs
         2zgPFuKW6I5b/3dZCuvdsnY6X/LJkTktaPtiQO2s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.189.231] ([89.1.214.237]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4QsO-1nIY9J1SQo-011PHy; Tue, 26
 Jul 2022 23:59:43 +0200
Date:   Tue, 26 Jul 2022 23:59:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jack Adrian Zappa <adrianh.bsc@gmail.com>
cc:     git-mailing-list <git@vger.kernel.org>
Subject: Re: git not compiling under MSYS2
In-Reply-To: <CAKepmajpJ0Nhr0SPNicg6djhH36f+dT_SHrb7pOEK7J0eXYuFA@mail.gmail.com>
Message-ID: <s3p5rspo-641r-0960-rnsr-518o8p1rso97@tzk.qr>
References: <CAKepmajpJ0Nhr0SPNicg6djhH36f+dT_SHrb7pOEK7J0eXYuFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-844063576-1658872788=:211"
X-Provags-ID: V03:K1:+msuK3p4dMLrf7yRNrTaLL6xA5t0bLuYZlz8N4EQJ54/DiSW0X3
 h95AeBI4O1o+688dFrEGd0VBJC77NZelXZKc7f/PcutJSG9mYFpyhJqqmOwveuRFvr8BQX2
 1IGBEvs0dUpXx+ivIV9bZvZ3vUqVt4YyKoZwVslgqm8yKbZcvwRSyvZzvlCUN0BgJ/v6pk2
 deqv0QrJv6kC+fo0PPs3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EuWMccP+a4A=:R/f5Ynp0jDADZrUhFROYOw
 CLDmtnVH2vQALudcxlVhimyrXzOOpaDK+5zXgeXthJaB+Oqbu4FPOJIcUDyhmvh2mOxxjRn6H
 k+SsTPbTx6jV1C2V2lakOH52335KOVsUsJUFdQDeYfckPH1mW3JHzyg/IQhv5ew4I24ad2N7z
 5ZpHa19/ighqOfeX5rRzld+npvNuiOscTK8yHXPoUEWBBo02voxfeLhpUrL/sZgxI+HeUE6rY
 WK2+iUnvfbK6Feon72pMUgjzCzbRdYpd9/Sz1N2ePvKCMAhp2ug97zi6svoKUdchKg+NOrRfp
 Jueh2lg3nHZHfJOhMSrrzDBBudGuFR32U5NAkJJcO+OWf6VXsN2BFPkLR/OtXy3XMP8uDvb0K
 b73H3ixqfpZY90xp4oTji0do1439yXkTcGd/7umOqfpgYEH5lgY24wtWiGfFHeEdhVamt4L/M
 Vl8jXWXizyH4ImjmRrZ+ddD02jNEFF59LASOjO23NvP+Rey86qGU3D9PyDR0sJomH4eMr6J5q
 THPU65Ch5zGhzX7z0z6qIo1ehXY3ESZXA9FlF/RrH0nzfE10V9+RfK9rp13JflyJ1NAQFFIt0
 HVLBwVz8tlq+5NbqecOX6Yux5ZTiC2BpIPbJyMTh1quuVtbCXdLcgyw02JoQ5mpf3rvRjSmn2
 QkOmHqixouI9ZEQVBbj7P/9u2JxDPn+kUzasaZ0x/N6e6VUTgYUzW558+2UdyuAuPDgXoz2Ir
 bPl/rkis5YBHLJ0MBdLTAJzgXsCzuPSNyprNWaZcog/4Z1QfVGthrX7hHwx8+wlp3c19+PVIt
 L86UWKupEaWHNTQoNfBoEkE+331LdSjtpwaQcfIGr+OUSuVC2kaaPtn7zdgEH0t62IVP2yNTK
 1eWS3Ns6k8hw2brDDnmNIuNzIUBnGW97U53T6SZgn9MNtd8pvQIihWs0z2Usid7PMj+0NGSdg
 g/mGszT+Vl0tpl4wZqyG5MEKmongi6ecAKcjb01wl4gN2mdZVbWBPcfpcjjAVElkKZjaX2D+f
 QnYp+fTg3Hr7a238jJlJMIX/pAfrKCUCsa8S7iL61lcAI/u7pSAxlROj+E3VJhWjfqRtV45eK
 Js/t7ZKoQzi7xDcSygmyUfz7tcIbRE0gXrg6f3rqzlHTHONJEAq5KimDg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-844063576-1658872788=:211
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jack,

On Fri, 29 Apr 2022, Jack Adrian Zappa wrote:

> I just installed MSYS2, cloned the git repo from
> https://github.com/git/git and then tried to build from the "MSYS2
> MinGW Clang x64" prompt.  Of course this was a clean MSYS2 install, so
> I had to first install for myself vim, git to download the repo and
> for the build: make and gcc.  However, after running the make command,
> I'm still getting errors:
>
> ------------->8------------->8------------->8------------->8------------=
->8------------->8------------->8-------------
> $ make
> make: curl-config: No such file or directory
>     CC fuzz-commit-graph.o
> In file included from git-compat-util.h:219,
>                  from commit-graph.h:4,
>                  from fuzz-commit-graph.c:1:
> compat/win32/dirent.h:13:21: error: =E2=80=98MAX_PATH=E2=80=99 undeclare=
d here (not in
> a function); did you mean =E2=80=98O_PATH=E2=80=99?
>    13 |         char d_name[MAX_PATH * 3]; /* file name (* 3 for UTF-8
> conversion) */
>       |                     ^~~~~~~~
>       |                     O_PATH

You most likely installed the `gcc` package, but that would produce an
MSYS version of Git, while you are clearly interested in the MINGW
version. Therefore, you should probably install `mingw-w64-x86_64-gcc`.

To verify that you have the correct `gcc`, run `which gcc`. If it prints
`/usr/bin/git`, you are still stuck with the MSYS variant, what you want
is `/mingw64/bin/git` to be printed.

Ciao,
Johannes

> In file included from commit-graph.h:4,
>                  from fuzz-commit-graph.c:1:
> git-compat-util.h:329: warning: "basename" redefined
>   329 | #define basename gitbasename
>       |
> In file included from git-compat-util.h:209,
>                  from commit-graph.h:4,
>                  from fuzz-commit-graph.c:1:
> /usr/include/string.h:171: note: this is the location of the previous de=
finition
>   171 | # define basename basename
>       |
> In file included from commit-graph.h:4,
>                  from fuzz-commit-graph.c:1:
> git-compat-util.h:336:10: fatal error: iconv.h: No such file or director=
y
>   336 | #include <iconv.h>
>       |          ^~~~~~~~~
> compilation terminated.
> make: *** [Makefile:2569: fuzz-commit-graph.o] Error 1
> -------------8<-------------8<-------------8<-------------8<------------=
-8<-------------8<-------------8<-------------
>
> Anyone have any idea why it's not building?
>
> Thanks,
>
>
> A
>

--8323328-844063576-1658872788=:211--
