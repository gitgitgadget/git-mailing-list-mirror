Return-Path: <SRS0=i2G4=DF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E344C2D0A8
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 13:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C854121941
	for <git@archiver.kernel.org>; Mon, 28 Sep 2020 13:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="XvkrSSQn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgI1N4S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 09:56:18 -0400
Received: from mout.gmx.net ([212.227.15.18]:56957 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgI1N4R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 09:56:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601301375;
        bh=Vso5crPWUX9CAqIs5paTKIc+0JaIobPrRhCNF/iNF5c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=XvkrSSQn/1CnvwQyWkZQV/KSK3EHaAsHgnmXYWEZ2NV3uqFAJvz6HnCCW+deiXOUT
         MkmKO/VxnvXkq+JdOS9TgwtF8W2Th0A2l/zAsU2K/qgW0GS+H7s4Jv8mjSclZ3Qqwf
         fJHqTErmvHjyvX/kqB9ZJBvHwv5KmKdPsCN1KyZE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.113.174] ([89.1.212.27]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEV3I-1kCQ211zDe-00FztC; Mon, 28
 Sep 2020 15:56:15 +0200
Date:   Mon, 28 Sep 2020 15:56:13 +0200 (CEST)
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
In-Reply-To: <20200927022543.GD20935@danh.dev>
Message-ID: <nycvar.QRO.7.76.6.2009281553520.50@tvgsbejvaqbjf.bet>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com> <05b4b69fee2b8c32769dd72dea182cfb72a14876.1601044118.git.gitgitgadget@gmail.com> <CAKiG+9V=BGX4k_dM-5JzYmko0cZfYXuSxEk5-UuHZpAqaWoU_A@mail.gmail.com> <nycvar.QRO.7.76.6.2009260821260.50@tvgsbejvaqbjf.bet>
 <20200927022543.GD20935@danh.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-429827783-1601301375=:50"
X-Provags-ID: V03:K1:FeM6NE1cVeu3ee7TzhcxB9f3lCY2N4lMim0evoytCF0ZraOpFFR
 ceW30V/unh9iUjVnAGviKZKtzDy70axF+ZxXC1jUmv3kd3aOUfBntZ5zwJmb/zaTVI5dx5W
 QoLJcl3a+sHteSzENTsuVMub38ECTagPXMEH2hVsxU+LrmGgkc13KeubDVhSUfqGluPWloj
 oUVbNO04nuVrbMQ8PwD2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bq1gx8DW+K4=:2tjrdq7p3mhuHwnGCkNH4L
 CTuervntRDGAYHRaO/bJnEZJ1Q06zvS5b40RwaKgCSi3szDXzo+OeGmWJjfx6IjYWPl3rH5Tk
 q4QuPDhM6jn5YrngEJCctNtKY3ZPhLSRNozEMfDz+aHhw+BWZf8CKHY+bIq2uf+1R0T1qi4lH
 jveo6Kv/bqjTVCMSD0FtJUuC0NbOm3hjThIv2IcVnqikQ+xFWmf7LshlGSxWpkGthysjtuyf0
 yvvqVjEl4u1BHonCEBlM8pK/RT6BBaWp/7fmYaqTfTq5t8EIVnpqzcbcPyse7VA36v/LM9i8/
 m74TJYgKDajBaC9gUi2oeQ03Bb28/J3/cuwylKwmP0udvv4h/X3aryJYRqIa1u3VRyTxAkspy
 qzx0n7yTcsDuW07A0nSCgKt57av469nC3FY/V2kIMJCy+SdORKMuhYH2Ivx8rT0oXLRemOZIQ
 r/AmqsYoegRUmcNHpw0orByxM1HIplPFuyYqUngiB+zf6S5+wt1kjR3Vzr6JslgCKa56tW2In
 44NMWEQhl7Ncr7eb9oP71w/aewOOlD+lXQe6Wnb8kb6VPZ8IZkdyDHYBeMnhBOSbfpDe8243q
 zxpH/18zpgwnyJjtjgY/x79knoBxtGH6VvU+MdLcRAwC6+kgwCjqgrtXxvYKNSTGTDHgyyNGJ
 wI7zXm9gdCdCGE+GXnV7AfHkDnkPq0OnEP9YskqkGL5Ein27ly3ZC60Tdxeprnz4i7F2kMIXj
 dYjjFd7+vEqAd2bLB+qaNJtyXCJWzcCAM35xRSFR5wBQORUvauNBKxuKleX92tcwj/5orfJxA
 RZBzndLCgjcJ57kylzxv5mO6v5+/K7SzrrYE8IHKrVxCObqhWxG3frNi8axYy2tVA6d6DEDye
 7e4vRN2ESDqLJ34Yi90GoOxgAiPQzC3L3tyFCpZivrzreg+sOGao2rnUyEV1JiedHfzhjjhbg
 T+a2jk14HpdA9p4Wk/WXqWsLcl5yEIiWvgbA+TIiVAyQRBtT5gBTbXiHnt4Oz3A5kMonnPzhn
 YnICfQKkG121oCZbB9AqeiMkYf7kufVVSmUprMwf13wObQTL+MmC//Nb+XidCwdhWMqJNOhqS
 Rzx0HGkzcROd0rakCM1zOT+muOWeXkiDzQ2HyvbHcDLsDtfy+jbGP3DKdzbF1MoBp5aQZYgZ7
 iBypcgJyHwzt2eyRuq1D/VCV4XhJdldGoq820P8ASeZlP+Y+It/K4dShyr0X7UZ2C4Y/Menam
 BPN0S1A/W9cpKmAwSPRoZGxui8fYtbLmuTjQU2g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-429827783-1601301375=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Danh,

On Sun, 27 Sep 2020, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> On 2020-09-26 22:32:25+0200, Johannes Schindelin <Johannes.Schindelin@gm=
x.de> wrote:
>
> > > I personally don't install my dev tools(except Visual Studio) to
> > > Program Files(because of the _space_), it messes up the Makefiles.
> >
> > Sure, and that's your prerogative. There's unfortunately no good way t=
o
> > support your use case.
> >
> > Luckily, the vast majority of Git for Windows' users do not change the
> > default location, and this patch is for them. (And "them" in this case
> > includes me, personally ;-))
>
> This doesn't fit into my view of Git for Windows' users
> For some users that have the Administrator right, it's the default
> location if they grant the Administrator right for the installer.
>
> For those poor souls that works for enterprise companies, and thoses
> that not feel comfortable give Administrator right to _another_
> installer, the installer will install into (hopeful, I type it right):
>
> 	%USERPROFILE%/AppData/Local/Programs/Git

Those poor souls that work for enterprise companies often have Git for
Windows installed by default. And of course, that default would be in
`C:\Program Files\Git`.

> I think it's better to offer SH_EXE as an OPTION, let user specify it
> as will. And we'll search in PATH if it's not specified, fallback to
> 2 default value if not found.

That's exactly as it is right now. You can specify `SH_EXE` (but only if
running CMake manually, not via Visual Studio). If you don't, it searches
`PATH`, and with my patch it then falls back to trying to find `sh.exe` in
Git for Windows' default location.

So I think we're in agreement here?

Ciao,
Dscho

--8323328-429827783-1601301375=:50--
