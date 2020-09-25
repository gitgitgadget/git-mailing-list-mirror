Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ED1C4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 10:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC54C221EB
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 10:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ioTONiQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgIYKrv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 06:47:51 -0400
Received: from mout.gmx.net ([212.227.17.20]:59357 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbgIYKrv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 06:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601030866;
        bh=bX7z9mtZviIO7ZbgGjJncRPRw2Jauc4C+6LLD9voNTE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ioTONiQ7J4Ab5C9llae/NqrU/IELT7XABsoQe+AuiQnThU789m/nx+R1SSfKT9Mry
         8Zr5oFXB7P7TMw6oQoG6twUL/MTC8zO01w962FgHCmj9PmQimw953o4WisRSqr2U/E
         IGlJC5/Ameb7YpJLcjPKDI8qfNmOxLgSHbc/9h8c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.89.169] ([89.1.212.158]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M5fMY-1kOW9Q1lgw-007G0i; Fri, 25
 Sep 2020 12:47:46 +0200
Date:   Fri, 25 Sep 2020 08:40:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] cmake: ignore generated files
In-Reply-To: <xmqqft78i5zd.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2009250808000.5061@tvgsbejvaqbjf.bet>
References: <pull.735.git.1600375065498.gitgitgadget@gmail.com>        <xmqqtuvwoyz5.fsf@gitster.c.googlers.com>        <nycvar.QRO.7.76.6.2009181510240.5061@tvgsbejvaqbjf.bet>        <xmqqft7fnlxr.fsf@gitster.c.googlers.com>        <20200918155015.GA1837@danh.dev>
        <xmqq7dsrnjhi.fsf@gitster.c.googlers.com>        <nycvar.QRO.7.76.6.2009201916040.5061@tvgsbejvaqbjf.bet>        <xmqqr1qsjxgb.fsf@gitster.c.googlers.com>        <nycvar.QRO.7.76.6.2009232224410.5061@tvgsbejvaqbjf.bet>
 <xmqqft78i5zd.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pJZo6aR76+JoFph04LjEc8Gb+52FQiTedvNdgWYZB4RUBJwvyQP
 audGn84P0furQ+b7OUoPKFqZ1gdWiMlVWL1Z5afSIUd2xr6/EP+4j/s+AyA3urMqxkbnl09
 2r19TevJeMDLW55albEW0ABEr6EQdKKTGGDki+v1xi1W39SMeXcPEAaEIbERZrFjRBVJSBO
 lOr3nQpl4Ef1nDX0CgtcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cY3HmAaOE4w=:wG6VxXqWVuLkS8Km4/TdA5
 qoxQ0kC3dM5M5P870QzG1t90QVufVqEdERrSTg+RTGSheEQTzV6o9Wpmlc7lydtcCLYg1VyUf
 BNHcg66Qa8g5kGIzAmwW3Vlr0T4wiVP+0iJeA4HJC7ctD5DATqXWVwWTLL+qEW/RwGG9f+8o2
 AaY39W37lHr6H5BMczuu69FmYUivmGgHfki8C4QeJn/NF1qwdyp2wzpJTvDIEBaqC4F9DuJ2y
 nVzGi/DkSKrYdYIEtRpjrr5hjkbpcbrR0QMMJ5e62tczNREfYTR9+QapnSgwajxB7nP95VwTC
 54gUhrV9dma+rF/FfBY3V1miVpmz6+UG3SEQT1Al7e6JkWe7GVNp2VMhXroiiB5F5fJkkEZCJ
 3w9BeBkpuUN5cX1hiT+xcrl4DhDVxS3ZbHNFw2on/FkYqHJzkoj4Vn0vqaqRu9JJ5sSwywf7f
 zq7qHuehyjQicoz3odilV/PCEM52AuKfnJUs7krQ34HlqlGOP4kt/UgsavKVtnetjEbsYJEWf
 DbyJh/4uN24YLvgSin6mRgvRG/DVIGDeo9Mvl/kIXD7hyxzwIPlogklB17QHVjxNoIe+d0vvW
 Umfsbnh7/XvUIxvUVJztTdNmkJC/5x/DKJDQxUA3bZErerKHy20kfXdO4lazWM1aIn2P2hja0
 ZM1Ppwb7P99yCoUd2kbmw2pXjkl6AzxWDAEbyXhwqKejiWAka1smKXxMg43Tg8jMJ4zAVmIz2
 dc37dc37KY06OzToLPCMnhg6u5fd8n9BHwThGvBnlsMAv4GCSKusvCj5f+8p6KBIbGZ8F7eNy
 0MrJn4FYP4Qp0Ojr1X1vsTBgF99ImsWZbsLxk7vyP4hdoyGR1XUcIYqEHgIGBf6D0IOmGphHF
 AiDeSP8blD7siTpsxqC0qGp0ZkQ+XtO4C6H3gAC8Sxrs1yvMFMIIMI+h//u3rcH0qejdk6KcD
 mv0tWy5C7BCNDuuOMbnXCUwDS8sjHcVoQ5CTIpj12B/7HE0rCI+XijsecNat2hM7e0Z6bGNrC
 nSBo7SCp3mxaFjPxzJGEjuYkPa9X1o94PDtn57IYtmKg//K6JH5iKE/FSvbSkrCswiVytne+p
 gpygkPXkHSdQ5fF8BnQsOZ3LT23GkMIqfR1EasTJA+dpFvb0KLdmr2ysoqH4vAhdzHT2qEmoJ
 epwXhoIF5lr6nJuGmlTY+dBTb6L2sdKZSC9IIubJOa23+PgbGYq38EfwpZ8UUuy7kY0latgu3
 gsSwGZb6BfxA4Ol/uzrvmikXHJMoXgdg79Pn5yA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 23 Sep 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > All I want is for the CMake support to be easier to use, yet we go in =
the
> > opposite direction: instead of allowing to use CMake under more
> > circumstances (which actually *works*, we just don't have the appropri=
ate
>
> Not, "more", but what you are doing is to ensure it is used at only
> one single place, which is the top-level (and nowhere else, judging
> from the .gitignore additions).
>
> And that is fine---if you were to add .gitignore entries, you cannot
> leave it up to the end-users where the build happens.
>
> So, let's not pretend that you are allowing "more circumstances".
> Forcing a single choice to make things predictable is fine, but
> let's explain it as such, so that people won't be confused into
> thinking that they can follow their experiences gained from using
> CMake in other projects that lets them build in a separate
> directory.  The other things in our project, including the
> patterns added to .gitignore with the patch in question, are not set
> up to allow that.

While I respectfully disagree that I force a single choice on anybody, I
do agree that there is value in having one recommended route that is well
supported.

Thanks,
Dscho
