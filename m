Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6440C636C8
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 05:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 996DA610CB
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 05:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhGRFfk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Jul 2021 01:35:40 -0400
Received: from mout.web.de ([212.227.17.12]:34461 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229578AbhGRFfj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jul 2021 01:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1626586361;
        bh=aIRj3Dy9Pin6flSFVefgysYhjfXe/DITMGCZhXcMm0c=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NTv+iRhvNMcmZ0cTs3SCQNFORvRRH2WvorPgMClH+tFBMSiIxJWjT+llRTWrdbRGZ
         1pRCu2R2O0C7i4t5pyDV5L8+OWxUyWLq7nvvnOlQPybAEIoeDXpBbyR76h1oO6xkG3
         xdN3RZlMeqeEfJmfmmldSy3U3/vwRl7CSMrryFXo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MaJro-1lpeO83ED2-00Jt0F; Sun, 18
 Jul 2021 07:32:40 +0200
Date:   Sun, 18 Jul 2021 07:32:40 +0200
From:   Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>
To:     Rostislav Krasny <rosti.bsd@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Incorrect and inconsistent End-Of-Line characters in .gitmodules
 after "git submodule set-branch --branch <branch_name>"
Message-ID: <20210718053240.bjtzggfgu7g54afn@tb-raspi4>
References: <CANt7McFAu5gAFcgd+dejQjDQDxfcnyhz=BxSAejXGMMtGQzO_w@mail.gmail.com>
 <20210717170536.x2n443dtejk76wfp@tb-raspi4>
 <CANt7McECMjz_=EnB5NxeY9sHSzjNLXtkrqPhyLArBXJswM4xQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANt7McECMjz_=EnB5NxeY9sHSzjNLXtkrqPhyLArBXJswM4xQQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:5sNB0COYmJVC7DBBwHjQGGkPATV0LrhNLpXmnMwxv6MReinAksa
 5aSgn4Qw149u9WwdT04CYki6qDYCegqWtv0ddyrSaqvW7MtOXBTL+wvQWDCrrsiDYJjNPo4
 5ETt1bmL5nijhtNM6L0p2BA37oFbWOpOKoQAJAuBT8fgI0Mj+iWQSXKwSn9a1hBnRzMLBGE
 MMUHaHqYqp1+iVTV7AllA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dE2I1HVxc2Y=:qMMiFfv+WYEH0EmmryztOi
 bByrpSC/d1zTggrdurhph5TyyyQpDxDV9Wa1zSrT50m7nxjOEnFgosQd4A6T2kUkrdCrmRANI
 +c0H3QiiIVX57UdHKY2QQ2eXq41pe3HVVaYZASErxUA7o5pfKJOPKU64q1ZHWG6uyPCTMNsWe
 W+nLmNyxjqwMgjKy+uGZpLPbNZGqPGaoz7zytej3bGU7whWVqCeS1z6oVNyUlv77eAEpjJ6l1
 6D4Ng/V5surAVww8nFY8v+21ISENxeAHOFu64PAqxrAikC0mpm6I+RQtdb7ZQdR3criC6ugZB
 w1vvkPQN3XSI5WNkf5JWdrBd0ySt84E2lMOebNu4a6rv0GX7uvJAKssMKO+23MwhHU75cgcDN
 cx/wexPKfddwJ8/IlE/CwgVIb92+CsPP+5Q8mgl2PfoTYOn2sL8ZeoNvm1YkjyzN0aqsyYBco
 PrXKQrJX/BQl3Gz/C0v80UOgZ63TeXagnI0YPSClsg889UUF4mCuEOYER+FGEdfKeA21FljNc
 bT5oBa+bxSrszF6vyGlMN1JzxnJP9MYTswtqgjPtIEKfX+USCMkj7/q/s8v7ogW7iiiK7oCJs
 zCpO1J9J5B057IYQFBNKRkD1GfOmKQraEhXBKeR+oEJ2xcpSVM2JKiYwTL+wiZor99I3uubpj
 FuE11YN/NJgto/UdziZTrWYkKwfxnE8mzZimWQjzxtIupZVw2yZTBL0P4U5ZRA2noMIk4JmiB
 kzSWK4EwrrQt7YEIL6T0x+BIfbNynD7a5ZxiNaGEikIB2PUmqS6UCHK1CqCaLlgEqMSmGR/uc
 U8oZikVkd5d3aItP4TyDRQ6VLhuK6oDMcMZ/YN15yNbK83MEsqLlbZRa+tz6zjbYXIrcFk/oj
 JbQwdeWlyM9er3f7GHNN5KKWUSb5dKdFo3j/67bYBwK6YCOR87T9OKvuBRMifFkFbggZqbqbh
 n3to3GbuaRLOlSVLWBM80nx4az7bI+PP9YShdMzTjLkOwDzwCeeQ0FcLxhMOAqU2CgR42JqMX
 P2sswL0umTFYQnpckUoyllJrAmdyXBIbhzXOpvqnVivIH25yD48pIEOWS6LJ3T/D1VvBzDQws
 vkc663uLl+X4uwwtSVTyUAxHhl6dLf3xAIW
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 18, 2021 at 01:42:26AM +0300, Rostislav Krasny wrote:
> On Sat, Jul 17, 2021 at 8:05 PM Torsten B??gershausen <tboegi@web.de> wr=
ote:
> >
> > On Fri, Jul 16, 2021 at 12:55:07AM +0300, Rostislav Krasny wrote:
> > > Hello,
> > >
> > > Originally this bug was reported in the Git for Windows project and
> > > contains two screenshots:
> > > https://github.com/git-for-windows/git/issues/3321
> > > Johannes Schindelin (dscho) is convinced that this is not a
> > > Windows-specific issue. Following is a brief description of this bug
> > > as I've faced it:
> > >
> > > After running the "git submodule set-branch --branch master -- ms1"
> > > I've noticed that the .gitmodules file is encoded with both DOS and
> > > UNIX End-of-Line characters simultaneously: all original lines use D=
OS
> > > EOL characters but the added "branch =3D master" line uses UNIX EOL.
> >
> > First of all: Thanks for posting this here.
> >
> > Then there are some questions, at least from my side.
> > How did you get there ?
>
> I just tried to use submodules and wanted to change the default state
> of the submodules (from detached HEAD into some branch) after cloning
> their parent repository together with the submodules. Take a look at
> my question to Brian in this thread.
>
> > In which shell did you enter the command ?
>
> Git Bash inside MINTTY of Git for Windows
>
> $ bash --version
> GNU bash, version 4.4.23(1)-release (x86_64-pc-msys)
> Copyright (C) 2016 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.=
html>
>
> This is free software; you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
>
> > Could you run
> > od -c .gitmodules
> > and post the results here ?
>
> Sure:
> $ od -c .gitmodules
> 0000000   [   s   u   b   m   o   d   u   l   e       "   m   s   1   "
> 0000020   ]  \r  \n  \t   p   a   t   h       =3D       m   s   1  \r  \=
n
> 0000040  \t   u   r   l       =3D       .   .   /   m   s   1  \r  \n  \=
t
> 0000060   b   r   a   n   c   h       =3D       m   a   s   t   e   r  \=
n
> 0000100   [   s   u   b   m   o   d   u   l   e       "   m   s   2   "
> 0000120   ]  \r  \n  \t   p   a   t   h       =3D       m   s   2  \r  \=
n
> 0000140  \t   u   r   l       =3D       .   .   /   m   s   2  \r  \n
> 0000157
>
> > Or is it possible to set up a dummy repo, which does show the problem,
> > somewhere ?
> >
> > What we appreciate is a fully reproducable receipt, so that anybody ca=
n
> > reproduce the problem.
>
> Try to do the following steps on Windows:
> 1. Download https://github.com/git-for-windows/git/files/6835344/git-try=
outs.tar.gz
> 2. Extract the tarball and go into the git-tryouts/local-parent director=
y
> 3. Run the "git clone --recurse-submodules ../parent/ ." command
> 4. Run the "git submodule set-branch --branch master -- ms1" command
>
> Now you can check the content of the .gitmodules file for the EOL issue.

Thanks for the reproducing receipe.
I didn't manage to get there, but this was not on a Windows box.
I still suspect that this has nothing to do with core.autocrlf.
since it never produces "mixed" line endings.
(both CRLF and LF in the same file).
Is anybody else able to reproduce it ?

user@mac:/tmp/2021-07-18-git-submodules-CRLF/git-tryouts/local-parent> les=
s .gitmodules
user@mac:/tmp/2021-07-18-git-submodules-CRLF/git-tryouts/local-parent> od =
-c  .gitmodules
0000000    [   s   u   b   m   o   d   u   l   e       "   m   s   1   "
0000020    ]  \n  \t   p   a   t   h       =3D       m   s   1  \n  \t   u
0000040    r   l       =3D       .   .   /   m   s   1  \n   [   s   u   b
0000060    m   o   d   u   l   e       "   m   s   2   "   ]  \n  \t   p
0000100    a   t   h       =3D       m   s   2  \n  \t   u   r   l       =
=3D
0000120        .   .   /   m   s   2  \n
0000130
user@mac:/tmp/2021-07-18-git-submodules-CRLF/git-tryouts/local-parent> git=
 config core.autocrlf true
user@mac:/tmp/2021-07-18-git-submodules-CRLF/git-tryouts/local-parent> git=
 submodule set-branch --branch master -- ms1
user@mac:/tmp/2021-07-18-git-submodules-CRLF/git-tryouts/local-parent> od =
-c  .gitmodules
0000000    [   s   u   b   m   o   d   u   l   e       "   m   s   1   "
0000020    ]  \n  \t   p   a   t   h       =3D       m   s   1  \n  \t   u
0000040    r   l       =3D       .   .   /   m   s   1  \n  \t   b   r   a
0000060    n   c   h       =3D       m   a   s   t   e   r  \n   [   s   u
0000100    b   m   o   d   u   l   e       "   m   s   2   "   ]  \n  \t
0000120    p   a   t   h       =3D       m   s   2  \n  \t   u   r   l
0000140    =3D       .   .   /   m   s   2  \n
0000151
user@mac:/tmp/2021-07-18-git-submodules-CRLF/git-tryouts/local-parent>




>
> Optional steps:
>
> 5. try to commit the new version of the .gitmodules file and push this
> commit back by "git push" command
> 6. Delete everything in the git-tryouts/local-parent directory, for
> example by the "rm -rf .git* *" command
> 7. Do step number 3 again
>
> There is yet another inconsistency. Right after the commit or commit
> plus push are done the .gitmodules file still has the EOL issue but
> then after deleting everything and cloning the whole repository again
> a different version of .gitmodules is created (because of
> core.autocrlf=3Dtrue). This inconsistency seems to be general and can
> happen with any textual file on Windows.
>
> >
> > I have the slight suspicion that the CR as part of CRLF had sneaked in
> > somewhere via the command line. But that is already a speculation.
> >
> > And I don't know, if there is a problem at all, or is it just cosmetic=
s ?
>
> As I already answered to Brian I don't know, at least in the vi editor
> it looks broken because of all
> those '^M' symbols.
