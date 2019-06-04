Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DB791F462
	for <e@80x24.org>; Tue,  4 Jun 2019 13:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfFDNha (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 09:37:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:57685 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727229AbfFDNha (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 09:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559655442;
        bh=cs9mrzzgV2Fux8iQoPYa4xBIPjSsDvVbYtPaKRtvF0g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=GLx0QNxZh3XzaIwy7HRpfdlev1dTBVtDoG4WtW2hS+GdPfIaU4fdimjgJbgBdbK/W
         oeHVQMcehfzqC27jrzlr0F5Zd+xUizDD0Kx35EiD1TtnAtNtz2XEcYXEoYvK9uR5gF
         CRwMLebPK9lKJLExFghZPegnWiITz1lkO0uJl+GI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5fIW-1hVOjg36ba-0079aK; Tue, 04
 Jun 2019 15:37:22 +0200
Date:   Tue, 4 Jun 2019 15:37:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        John Lin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: Re: [PATCH 1/1] status: remove the empty line after hints
In-Reply-To: <CAKO26MugSimxd+fiXR7CjT1uRsWXZ=s_a=ebtZmpSDyGg3HTgA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906041536240.1775@tvgsbejvaqbjf.bet>
References: <pull.196.git.gitgitgadget@gmail.com> <468be8f85426ccf588ad558fab3c8927ef58627f.1557917642.git.gitgitgadget@gmail.com> <CAKO26MsGpEcK74CSdgNGjFdKAMDP5Knm+0_vtcnrBBJjBfjcQA@mail.gmail.com> <xmqq36ky1fe8.fsf@gitster-ct.c.googlers.com>
 <CAKO26Ms6_rJfq6knh14H1O-V2_6v8YxYdjah0vTdvpJTc7hdXw@mail.gmail.com> <nycvar.QRO.7.76.6.1905291349360.44@tvgsbejvaqbjf.bet> <CAKO26MtvBRo76TenubyeVNkeA6e5yrS4DZFSLG1ByztP7mMVXw@mail.gmail.com> <nycvar.QRO.7.76.6.1906031614020.48@tvgsbejvaqbjf.bet>
 <CAKO26MugSimxd+fiXR7CjT1uRsWXZ=s_a=ebtZmpSDyGg3HTgA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-427727206-1559655442=:1775"
X-Provags-ID: V03:K1:UqVIRJ4M+WdkhoY0CIQ0dgG8F9M4sDY+GaGm+7KIVHnJYM39L7l
 ylUX7cUUz1D0hUBc3mElZBx8pypA3GbuxVCjMy2yfD+CqwrsX7K2stmFcreA/xVOzahfzzv
 seYCZ3ONo2BhB7S/HtnHNY7xh6a03SnMA0R2jIZkaPz2+ipXxTHuqf4KoIpD148NcB0NXXy
 a2rUaAnZNwPZble2l9FMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z9EM3g4zfoE=:Ybjitiy8zkauUV5kl6g5Sr
 zjIlj4Ab/W0VjWhj64HUMHQJHs1Dy8d9TZkBVdZdzvuNrLOIEoBSVcdHkrejnsbs1wvYvobg8
 aa9UptJuT22lkymdE7++0iuR+SW63TxEVa96Hk/cPkleVf43zNeLosyhfBUwdj82XlZEiDVvt
 GkbI7BvT9GA5mYPOLc3ZARBiU2oQ4WsDWjxMes4Mvln2I6/m5r0YcnoOtL04YDvgL6XV9zQVf
 iGmKzbe3nOzRW5fSvHFCCTArhZ+aax87GiYKJPd7QlOWbHxjDI6VD89JIi5V2MiC+yVZ2yYfQ
 qfsJTn71HDGaZmhqg6Hm+wrW2LsAaZNtOxwVPdfIjNiSxQe9bsWdJ4BRc94GvMHkcOfZAou47
 4afGWfTjY8VxZDhM7lDJRXezmiImnB2Z0Gy/5y2rI12qbdmp7aPILzHnV+KXnuxASqvg2kNBf
 HsZvJjKp+ik0BN+cg9EWEzUYo58iIJRZyemiMcwV1eSSAsE2JMSOdfRJPdA9FcV3P8CbGtyhc
 dtf9+uDSDBkrz8norHfDL7mLGxqMj5A3BAuuE2k5HY3FCu3UELi07ALDy+8xCp34B0CH72EfT
 hvjTOxKj0vBzugzzwBWI17xMrPONnPpAnB0K57pAvZfTlBwurfovQQCG51CecuI7dej0Vk31U
 KD1KeXrAFes8GCPGnsAMvDmiHQdJCmhiRx1WCrtGJXV9TqAqzwEvsOMWFS3+bQnkjMfShw3Bm
 vDN4ZxLPh8bcF8C4/7g+yoDYHzPy/g/K80i76ztfM68L6biCqKMndmcuk6Uvja8LfykND5CM5
 BL6bm4JdK1uxK/RD1yeBDR/DRQFJxT2U7+qoolPuczCET+d0A9SILDyIn1Ba+nTcyuSjNPjOb
 ki0SMvnRg20rgYFPastVjVvgkJvyL3VS4sMdFh/EHyiWbvg9sYtR9ZdcpRmFl30ARbnklEU5V
 ROgGoB5P+CgS1i1HwCsBEQViBWwJGqc4wNluZJndquNp2ugcfs2o4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-427727206-1559655442=:1775
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi John Lin,

On Mon, 3 Jun 2019, =E6=9E=97=E8=87=AA=E5=9D=87 wrote:

> Thank you for your kind and detailed explanation. I really appreciate
> that. By the way, I just saw it passed all the Azure Pipeline checks.
> Please consider merging it into nd/switch-and-restore. Thank you.

Could you issue a new `/submit`, now that everything is clear? That should
send a new iteration of your patch to the mailing list for review.

Thanks,
Johannes

> Johannes Schindelin <Johannes.Schindelin@gmx.de> =E6=96=BC 2019=E5=B9=B4=
6=E6=9C=883=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=8810:17=E5=AF=AB=
=E9=81=93=EF=BC=9A
> >
> > Hi John Lin,
> >
> > On Sat, 1 Jun 2019, =E6=9E=97=E8=87=AA=E5=9D=87 wrote:
> >
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> =E6=96=BC 2019=E5=
=B9=B45=E6=9C=8829=E6=97=A5 =E9=80=B1=E4=B8=89
> > > =E4=B8=8B=E5=8D=887:51=E5=AF=AB=E9=81=93=EF=BC=9A
> > > >
> > > > You could already rebase it on top of
> > > > https://github.com/gitgitgadget/git/tree/nd/switch-and-restore, sa=
y so in
> > > > your cover letter, and send a new iteration.
> > >
> > > Thanks for the suggestion. I already rebase on your
> > > nd/switch-and-restore: https://github.com/gitgitgadget/git/pull/196
> > > However, it seems to have some conflict with the master branch and
> > > gitgitgadget refused to submit the patch. So I guess I still have to
> > > wait for the nd/switch-and-restore to resolve the conflict.
> >
> > I am so sorry for being so sloppy. I should have said explicitly what =
I
> > had in mind: target the nd/switch-and-restore branch.
> >
> > The GitGitGadget fork mirrors not only maint, master, next and pu, but
> > also the individual branches that Junio merges into pu (which are
> > published at https://github.com/gitster/git). That is, you can click t=
he
> > Edit button next to your PR description, and instead of editing the PR
> > description, choose a different target branch from the drop-down box b=
elow
> > it.
> >
> > Since it was totally my mistake for not telling you this explicitly, I
> > allowed myself to do exactly this for you. The Azure Pipeline is runni=
ng
> > as we speak.
> >
> > Thanks & my apologies,
> > Johannes
>

--8323328-427727206-1559655442=:1775--
