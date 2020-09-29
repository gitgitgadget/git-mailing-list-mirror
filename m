Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA57C4727C
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 19:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E38207F7
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 19:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DgaN+Ujy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgI2Tj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 15:39:59 -0400
Received: from mout.gmx.net ([212.227.15.15]:59451 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbgI2Tj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 15:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601408396;
        bh=iXNroi6jKia6aUkvhGdAXxL5l2oQI7tcx++b4VBjx6k=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DgaN+Ujyo6I2j3CJGIHCthNFB6d0AMrlxJWMgu1V/kCzzLkyk/H1+4G3jJVx34UCa
         h6vl7aq5OMXwmrC5BgseLVwWQ7aKasf3Nu7/tTa027q3iaeqdK4SqJydupt+Y/lZHF
         wzVgLmCmxBtI4jGNR3iYlTBQlxZ7SCZR4Oktntp4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.113.174] ([89.1.214.86]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwwZd-1kbrOK2rs3-00yRLp; Tue, 29
 Sep 2020 21:39:56 +0200
Date:   Tue, 29 Sep 2020 20:42:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>
cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 02/10] cmake: do find Git for Windows' shell
 interpreter
In-Reply-To: <20200929140400.GE20935@danh.dev>
Message-ID: <nycvar.QRO.7.76.6.2009292039200.50@tvgsbejvaqbjf.bet>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com> <05b4b69fee2b8c32769dd72dea182cfb72a14876.1601044118.git.gitgitgadget@gmail.com> <CAKiG+9V=BGX4k_dM-5JzYmko0cZfYXuSxEk5-UuHZpAqaWoU_A@mail.gmail.com> <nycvar.QRO.7.76.6.2009260821260.50@tvgsbejvaqbjf.bet>
 <20200927022543.GD20935@danh.dev> <nycvar.QRO.7.76.6.2009281553520.50@tvgsbejvaqbjf.bet> <20200929140400.GE20935@danh.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1352567099-1601404933=:50"
X-Provags-ID: V03:K1:Jj5OKgXuhFgYAtYZLVWpQhrSoaG4+hleVG8Ab9JvNpjcQssbaKk
 BmDivIDgEN88zMsivBNQ3LmyAM4A/aCgyT6mX4A2VmsIjFtAqaUykUExNXhyCrmx3cWTven
 hz71iNRbbeKt1Que31frngKksh9tcUDw0wZWgdSg+vPoOw6b8C1I5sOvdp4V/LndCIl707T
 ExObu23KAJyeqKMKFCpHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mNoPJQtFUJc=:FzehbfDaLgvglnZi03yPQ6
 oszgX8JAkfJ0AYN6qzDamP0d5pLg3qKYu0HPgnocT1dH57zCHVzJPmfZXL0Ap4hvPuHQvz9Qm
 66UbYr0ky3a+d616DmO+Ov0ca88EucyzISoD6iu7+eK6NL2Ow8EJQg2GnPV0S56ogAzlzHd4C
 n3EdtzF/WTVbMeGfObj7bFt1X8AIZwBGazRNJSaATL/657WQIoB4xXHMJ3K1HqLWsg8z9Wzuq
 +lwxvC/+i/YheeRqtBPfsLhcFZB+ZIFG1kRDnd9BI4QaJmEyy9+mMc20d1GfAn5W1GOVfAngU
 MV6pHxKd4BOC1p+8Daj+64UP04srRKsLFh7E72fqY3EsiVaQxnU7qTec5Rxe3Bmky2rvS8+GZ
 sjdyhvGxldT3veLp0LvYrqs8OZDxlPgDFKnLJWO/qt1M+i3DZ1efnumMIRioMzNZ71p/BSzMB
 qSEHsOMlnhp5r26mXiIuaR4/OrjgP7niRDeLrRASJoccMrBrzUCRisV2sG4Dv8o7mMM0zj61u
 pqlcs7bujYQbsEeptaYPQQ5n6Ht2mjk93xOS3DBRJmr4fIeA69an2IvOcWeT4Ymi+93nvB87t
 6vfyfTmbATCK3DjGyzBuWwb63oRk+E8by6lz4nu5PtnD+2JnK7HDC980UuuvWsNVvtGUDbqJ2
 S5kMaK7RJNBLYEm/2UbzUdrEMqzoa651OYsaoGgwAd9cWSacB3ReFwDFZN2VzbTxTiZHIdEno
 R4C0qy2BsiebO+i+N9Gr6gDqze5Wc48tvlFPmHWtKBsc0vYxTzz+Z8Q+BMV9TybTjzg1gEPzm
 +4qVs1J/mEqJo1hLIRm6Szr8RyIwX3+LP5Ui43Bae6eazAXiJeeKhP+UcztzVwMLVAsYdLcw5
 8DeY1C9fPJ8Rx9CnWkn2n3zea56cESFvZov2jVrq0N+Lwq/n1EDFFc8rNlsxaOL4OPy49fOBy
 sW5KYktICHuWLbZqRNKpmHgkDTeEhKPxL8aezRL2gm5ZgDTbpPtVpCepoTHr4VfNfmXwu/aG3
 oVOtWizjL7SLrJ6G1MlSs27ajX1avgFMqXSNTyjC9F+uSJksbWs2tp8VLMxccJRRzFSR9RmeV
 3lRshxx2cFodGAoThAG0EdYptVMYjGiO1Mgz+BWWNh2yU1nGPB4TGYs6d0RCX/ypq012fjAoL
 2r0lNX6BNMiykhDc/CL4FHfrqXeHKFlTCbDiRtBluL1lNd9qXwC817vNUB5IxYYZf9pGr3Bcf
 eDBse8sIrtjhV3u6mZirUNJT0IKXQsQa+svnCYQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1352567099-1601404933=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Danh,

On Tue, 29 Sep 2020, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> On 2020-09-28 15:56:13+0200, Johannes Schindelin <Johannes.Schindelin@gm=
x.de> wrote:
>
> > On Sun, 27 Sep 2020, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> >
> > > On 2020-09-26 22:32:25+0200, Johannes Schindelin <Johannes.Schindeli=
n@gmx.de> wrote:
> > >
> > > > > I personally don't install my dev tools(except Visual Studio) to
> > > > > Program Files(because of the _space_), it messes up the Makefile=
s.
> > > >
> > > > Sure, and that's your prerogative. There's unfortunately no good w=
ay to
> > > > support your use case.
> > > >
> > > > Luckily, the vast majority of Git for Windows' users do not change=
 the
> > > > default location, and this patch is for them. (And "them" in this =
case
> > > > includes me, personally ;-))
> > >
> > > This doesn't fit into my view of Git for Windows' users
> > > For some users that have the Administrator right, it's the default
> > > location if they grant the Administrator right for the installer.
> > >
> > > For those poor souls that works for enterprise companies, and thoses
> > > that not feel comfortable give Administrator right to _another_
> > > installer, the installer will install into (hopeful, I type it right=
):
> > >
> > > 	%USERPROFILE%/AppData/Local/Programs/Git
> >
> > Those poor souls that work for enterprise companies often have Git for
> > Windows installed by default. And of course, that default would be in
> > `C:\Program Files\Git`.
>
> Yes, that's correct, but that Git is usually very old, and I'm not
> sure about its layout. Obviously, you know better in this regard :-p

In Git for Windows v1.x, it would have contained the real Bash (at least
in 32-bit Windows; in 64-bit Windows, it would have been `C:\Program Files
(x86)\Git\bin`). But v1.x is long deprecated, it's over 5 years old.

The `C:\Program Files\Git\bin\sh.exe` stand-in is actually not _all_ that
old, I only reintroduced it relatively recently. Nevertheless, it is the
best bet for a default fall-back that I can think of.

> > > I think it's better to offer SH_EXE as an OPTION, let user specify i=
t
> > > as will. And we'll search in PATH if it's not specified, fallback to
> > > 2 default value if not found.
> >
> > That's exactly as it is right now. You can specify `SH_EXE` (but only =
if
> > running CMake manually, not via Visual Studio). If you don't, it searc=
hes
> > `PATH`, and with my patch it then falls back to trying to find `sh.exe=
` in
> > Git for Windows' default location.
> >
> > So I think we're in agreement here?
>
> Yes, seems good.

Excellent!
Dscho

--8323328-1352567099-1601404933=:50--
