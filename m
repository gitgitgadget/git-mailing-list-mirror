Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD989C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 19:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FCF620773
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 19:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="I2LnIXT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgI1Tjf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 15:39:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:46383 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726565AbgI1Tjf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 15:39:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601321972;
        bh=Tfp5N1rBBFTywh8vAMGiqjyXOFjwz8eX1PZJicSimcM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=I2LnIXT2yWoE398z2oLgTbeq0RyObfpUvbrTd45LLhNL0nqyZxGrWvLIAblwwIguD
         zEyJGRrHHDpR8ikULVLS4WL1wNc6TGOgWgLL+TCeo3heqrm6LLf8QptaT1dP6sLGJ1
         p38kAGQDz/3eEvDJ4Rv5Os3pnpdgwG8LI3xDN/Yc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.113.174] ([89.1.212.27]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNbox-1k2ws31muJ-00P7K6; Mon, 28
 Sep 2020 21:39:32 +0200
Date:   Mon, 28 Sep 2020 21:39:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
cc:     gitgitgadget@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        sibisiddharthan.github@gmail.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com
Subject: Re: [PATCH v2 02/10] cmake: do find Git for Windows' shell
 interpreter
In-Reply-To: <20200928111748.4122-1-oystwa@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2009281557390.50@tvgsbejvaqbjf.bet>
References: <05b4b69fee2b8c32769dd72dea182cfb72a14876.1601155970.git.gitgitgadget@gmail.com> <20200928111748.4122-1-oystwa@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-435613526-1601321972=:50"
X-Provags-ID: V03:K1:bq9JzuQEWqcWDNxnQBaq5KuChFIqZZLmO2v6rm0ws51UFuAJD9L
 uMOjtH9ec+rWg24LUMF3egny57hve5sIa/K1cKd5+aN8aBLJfw8/Su67z+dd4857ebP4Ars
 s4+taZfaObaU4vjjuyyc6H4/FYZQ41gVT270g9irQ4MM8sHtpsnHep2DL3m7MyVUJBSK4z/
 WcW5tPBRcZ7mAUhEX5tLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZF7HJvamPlE=:+Y/t/Vy6Qh2rEL8MDQraVu
 cpQLBlDXfP99fqCPx+wfcAfEJAM6etRi5Ra3t7zB9mjpDFTK/TgMANJHNnN5E6A2SlZa44hSn
 MwmH7cow44hKlYto41x7b+MehC4sLWZGjKdqg3PQxs4ezOcxMkMKNsyc81i1d31whnUsxcpv+
 +G7MdPE+80w7S5eNN8BEZyJj1MHtCxBvWjWQQsboyxlM+7JQpBJvDD/eN86fN4csRh5HIcuVG
 W8aS1UsgPcMVqHimPr1hqL9hfatAdZjEk52pne7rP+kCGU9yE8YVvmcjgEcpGfMEfVDTaVkNe
 5O6CX3Y/zIDnvZjfpYwQ3UIauDGIUHI6h99T+Ro7jSGlmpWIRvbfgQiEoPJT6QQGkpBuq2l9v
 XlyUC3DaVKui6EPO1DDEmRijdkbUERGqZnpE8F6D0rdHC+DFiCLID+jZ9vy4yX/qxHryiszT7
 wP7gX2M4PQSbFIJEOIiaigJ+xYmGucAGucECdkNjJlVr9dah7InUEeDvIczYMBmC56FIb+fpB
 Xg9rZSddsOaq8ty0Z2+DTS5ei+aJLuQcvC4yk5YE+3HEI/lkzXsoLs0AB9RZ6crffig5HUi6/
 bp/lUKwKmwKDGjms6m/as7X9LQ40r+Rj0dRxNIZzyWVG1y3B+wjpNQNgFgPOzBSuIfXWZKcNl
 77qXGxZY5DsexLKmIrYJTxH1lTfjOjBIAbxYvBSnjxmMPBZiinPvLonxCKx8pKVba7MAdsRb4
 KI9OI6d73pJdr+kWfe2kR44cQlbmSz4v2mhsHcFeNlQ3tlgk2++W6YlvLLs7QH6p8NiaZ5BXc
 Zl+QJcI4fGlpGrsW5LXoULg+mN0eHlV4Vdoxaq2CjiWbcIuDAnk7Uj0exPcOA419smV1zcYqr
 i9Jpvny4BVWmevPC96OPGziwwgNW019SWLnheJeI264xL/8HCao2AlWqO+TkXhFeOMzq9DPKO
 c9O+RFSkZesYpqgq0Qnc8Vvi/WVOqrvM9QKf85kmgJwpMdLG2uYFaTfytThiMZ9EMRLV6y2ae
 f+uFCJQ9Pl4QZwnoTpYhcRun+giVogTuxLTHZ2LWdTzwzWtB7fuPSuWr+6iCz8mLqxlSDMHPw
 rGa/7XyqI9lYfdwlf3gWrL1pS0fPFchKwKbB1jufwausvPM5Xxs3ZCfJJmk8lDVZmCCr8KeKh
 Ho+JjnGFWTNuU3EFmw8ATY7YBFjhG4lqHjwJuiRXdQGbHd3z1/AojwBd06KdDiWhQm72bnwCq
 p5skdkBkNF3petEeOg/0/SjI6fIbiNs8eO6AvDg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-435613526-1601321972=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=98ystein,

On Mon, 28 Sep 2020, =C3=98ystein Walle wrote:

> >  find_program(SH_EXE sh)
> >  if(NOT SH_EXE)
> > -	message(FATAL_ERROR "sh: shell interpreter was not found in your pat=
h, please install one."
> > -			"On Windows, you can get it as part of 'Git for Windows' install a=
t https://gitforwindows.org/")
> > +	set(SH_EXE "C:/Program Files/Git/bin/sh.exe")
> > +	if(NOT EXISTS ${SH_EXE})
> > +		message(FATAL_ERROR "sh: shell interpreter was not found in your pa=
th, please install one."
> > +				"On Windows, you can get it as part of 'Git for Windows' install =
at https://gitforwindows.org/")
> > +	endif()
> >  endif()
>
> You can write the find_program() command more succinctly as:
>
> 	find_program(SH_EXE sh PATHS "C:/Program Files/Git/bin")
>
> PATHS is is a list of extra directories to search, which are usually har=
d-coded
> guesses[1]. This way we avoid an extra check and indentation level.

Thank you, I was not aware of this neat feature.

> I found my Visual Studio installation already contains a sh.exe.  I thin=
k it
> ships with VS by default; I can't even find a way to remove it. It's loc=
ated
> at:
>
> C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\ID=
E\CommonExtensions\Microsoft\TeamFoundation\Team Explorer\Git\usr\bin\sh.e=
xe
>
> When I started writing this up I figured that could serve as an addition=
al
> fallback. However, if I use that shell I have to add (...)/usr/bin to PA=
TH as
> the various scripts need expr and sed among other things. I get the same=
 result
> if I search "C:/Program Files/Git/usr/bin", but there is no equivalent
> (...)/bin in the Git included with VS for some reason.

Indeed. This is what I get in that case:

=2D- snip --
1> [CMake] Generating  GIT-VERSION-FILE
1> [CMake] C:/git-sdk-64/usr/src/vs2017-test/contrib/buildsystems/../../GI=
T-VERSION-GEN: line 24: sed: command not found
1> [CMake] C:/git-sdk-64/usr/src/vs2017-test/contrib/buildsystems/../../GI=
T-VERSION-GEN: line 29: expr: command not found
1> [CMake] GIT_VERSION =3D
1> [CMake] CMake Error at C:\git-sdk-64\usr\src\vs2017-test\contrib\builds=
ystems\CMakeLists.txt:79 (string):
1> [CMake]   string sub-command FIND requires 3 or 4 parameters.
1> [CMake]
1> [CMake]
1> [CMake] CMake Error at C:\git-sdk-64\usr\src\vs2017-test\contrib\builds=
ystems\CMakeLists.txt:83 (string):
1> [CMake]   string sub-command REGEX, mode MATCH needs at least 5 argumen=
ts total to
1> [CMake]   command.
1> [CMake]
1> [CMake]
1> [CMake] CMake Error at C:\git-sdk-64\usr\src\vs2017-test\contrib\builds=
ystems\CMakeLists.txt:87 (project):
1> [CMake]   VERSION ".0" format invalid.
=2D- snap --

The explanation is pretty simple: you cannot just call into `sh.exe` via
an absolute path and expect it to add its containing directory to the
`PATH`. It does not, and the symptom is that neither `sed` nor `expr` are
found.

One solution is to add it to the `PATH` manually, which is the original
expectation in our `CMakeLists.txt` version.

Another solution is to point it to `C:\Program Files\Git\bin\sh.exe` which
is not, in fact, a shell, but a small wrapper executable whose job it is
to set up a couple environment variables (`PATH` being one of them) and
then spawning the _actual_ `sh.exe`. The source code for that wrapper:
https://github.com/git-for-windows/MINGW-packages/blob/main/mingw-w64-git/=
git-wrapper.c

As you figured out, it is _not_ enough to use `...\usr\bin\sh.exe`
directly without adjusting the `PATH`.

Ciao,
Dscho

--8323328-435613526-1601321972=:50--
