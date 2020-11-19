Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0941C388F9
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 11:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E4A2168B
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 11:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="IVVvRjgz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgKSLXP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 06:23:15 -0500
Received: from mout.gmx.net ([212.227.17.21]:46583 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgKSLXP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 06:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605784990;
        bh=fRrkOjj0Aarx0fC59wCQ2cz8h4QCdvZIrkaUstx7GGs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IVVvRjgzwwFTa4G+su6e9zGTUbEJm4bU+BBXOGPSK9xBV42PrC7w4A8dIWshdXRES
         7DL/8K93VIqbER2B7JfP+PfbImICsZYujq0E+qzcYO8MvuqR+sQ1KPH9qWvidXUeFF
         aoNHVgzVgd4R1Snf0j/vZwTzl8HU7y+n94GLyDIg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([213.196.212.61]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KYb-1kDTlv1uTR-016gK5; Thu, 19
 Nov 2020 12:23:10 +0100
Date:   Thu, 19 Nov 2020 12:23:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] t3040: remove stale note
In-Reply-To: <xmqqwnyiz8x3.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011191222020.56@tvgsbejvaqbjf.bet>
References: <pull.793.git.1605727526797.gitgitgadget@gmail.com> <xmqqwnyiz8x3.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vHRjGaQmFx8yhqiufpHylMJG43pR4w/MGxSFQKstN3u+vMd4Iqg
 5WSEA0bFHjreUNaxDUGPNiDKxAorX8oAxcpL6wyBV0+tvZ9ypOnldsDQkf43JOR7Yj2027w
 D0+HoJqmwUJO3gSSnpteA8tOXQ4GtiXE+a49EXlDAVki+MHqTgvhLohIMw38FWgoMFLZwsq
 lQmjtojUQZn56DmM4yNxw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:18JmHmTmv24=:bnrsWZ2s7Y0y2VoOT6YUZp
 GPKdshROeDv+qYnwhnma7Csp7u0ySVE0dgq9agbdQa8Lr+eNFnmxvsZR0Hx/Wi7oGMOlGMSme
 cDoQLHGANn1I/sK8PW03dArCX/7g/7uAsp2p1V6KAH2qoym0kJSS9HG690CGsd3FRM2bDf/78
 3U34mUsx5Sv+qLIeIG9RltTWBJP3AsBseEukG3RlR6pnKaVaiwpuosGDEe0d7ftmUrGltpWAF
 J0HF2Tex9BZ4PaHnSe5NHEVvQb1+6TSaF7YWxlBnEfx9dayTyj/ZQmmNTwD3HiCrpdd4gPeQw
 t4Rf9wIsmURG5J5zj38Sue/tPF5F4o5ejK6DrnvwQlurmi+29xjMRvBS5hyVyhPLl4LgIwWj2
 rzUUn+cTqz4bLQnBXd8PyIj1GfNdcnr9zXMDD1V/soXQE2e/kA+Sr722LadriF3je7cXTbHv7
 20cxLohgS4m+lVbRlypSeuJxa67/fmDavvubdJscIqjYpUaIPpb5NMk7JAUyFhuFGl9+m0/ye
 Rn1kPQBqqsFCC8yuhUI5HcVzycVPrwKjsxjJLRgcvnZbIge+IyjhlXLrm9IljP1hvNZJ3eY1I
 UA48oR/T1jjZRt1vsZhfPvsVF/vwunhWHgomoV3MjDlfT15WObDguotsJMVin0jshmle9X+Oo
 IPchyteYh4MCUhTVS2rLHD3JFyAGyAQzilXPyj9T65qzQtzf1pD/ppr3d9nFY0T2Oy25B4y1L
 gI+gB/cnyftznMICyf6RMxft4iRYJRsUzpNCCBt20mBjhMEEbssMT6Ldgz0212luHW41ucV66
 uBmrJNJtzMrnZqsHIgwOAq+Vbswmn7QtieN9UOo3M9MCacPyuVxDZPNnI5ts3RKvmmVbNKvLS
 vrHNhIC1SwAZ7eGggy16cKitL4MmshmuTjJF3aDEE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 18 Nov 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > This comment was most likely a "note to self" during the development o=
f
> > 1c3e5c4ebc3 (Tests for core subproject support, 2007-04-19) and is
> > neither needed nor comprehensible at this point. Let's remove it.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     t3040: remove stale note
> >
> >     And yet another thing I noticed while working on
> >     https://github.com/gitgitgadget/git/pull/762.
>
> It seems that all test updates from you today are some form of
> refinement to the 27-patch series we have in 'seen'.  I'll resolve
> conflicts in favor of these new ones as they look strict improvement
> (modulo @{2} thing I mentioned separately) in the meantime, but
> let's not forget to remove them from a reroll of the large series.

I didn't ;-) See
https://lore.kernel.org/git/pull.762.v3.git.1605743086.gitgitgadget@gmail.=
com/

Ciao,
Dscho
