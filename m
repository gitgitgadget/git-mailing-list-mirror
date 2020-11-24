Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D609C2D0E4
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 10:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CBE8206E0
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 10:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ViDeaxma"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgKXKJd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 05:09:33 -0500
Received: from mout.gmx.net ([212.227.17.21]:52875 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgKXKJc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 05:09:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606212568;
        bh=w5Tohv0HmCl41WO7A2eIGG7eV3swDCUTaKu6pScG/iQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ViDeaxmaKY8/W28bb9Z+6VQMb8gZsZ13GlymA8uMQjYlDEBTIfTV6T2xaf3ndQJrm
         MbD9QGkI05iX3EIXl0Gf65txm1cQpnd0bH6hGQdX8SBzHpjTQj1YS3dZn+2W4JeSaO
         c25ZOR0hHcuKHWEpiJXik/C3rf/4w2KuEAhXg78o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([89.1.213.133]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MysW2-1kLpPO1OEM-00vxgm; Tue, 24
 Nov 2020 11:09:28 +0100
Date:   Tue, 24 Nov 2020 06:57:16 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] init: provide useful advice about
 init.defaultBranch
In-Reply-To: <xmqq8sarljfn.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011240648160.56@tvgsbejvaqbjf.bet>
References: <pull.921.git.git.1606087406.gitgitgadget@gmail.com>        <pull.921.v2.git.git.1606173607.gitgitgadget@gmail.com>        <bccef953913da629057b3e9b211bc54081fa4475.1606173607.git.gitgitgadget@gmail.com>
 <xmqq8sarljfn.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:CCfMS9ZIbPsl6bW08+ZU5W/lYTsnb3FlbEOlmpm6oKSdzyAbmxo
 nzFwRaF0gjMiLpILGX+W9GFboR67XMVDtR8fCyNBUOICcJCX16nusNMrlW56DIx1shPbla3
 i4BeWUdBiXerhCC14haF4Fzfafj+nSBuOoMsYWezc3ADKgEiiz3Jqu5eI6dLcRC9r38Ah6k
 TMFwdDlr42885CDwGGmSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CoRTkDMHXn4=:ZHkcEqWOlT/N21pj5zV+W2
 je6AWtABzgunTp1foKs+uQkJ93aF17J8AM7izXBS96SZCkohHOLMZth2RAXxkDwNqsOG+MRwQ
 No8NI7UTqLQ9ItYWGnIeDnwty/08i5OCfSvQA7TOMam1IHNUrLzdWXSg6zEa917ASXj/yQndy
 U11eqc8+twIIYl+xLPKTggjCN2acEXH2bbmsUXWVrV0uAD+7bhCL4cwm6tZfV13+9f3SfXLcY
 RLaL2YIsGogueFYHeVgRhYTALMA3s3AlBvnutiKHvcbNtYkib6Oa1JdDkqznufNataCbUIQfE
 iB3ZSboIv5GvX/mbdpYoCKcxOefwqMGU30P/2ba2I5lLcZrqDB+TM7dEnOQiYpWCeunzWRZD/
 XoEAMaYT2oI7tj1t9VmnzO1euGoZjv4uQPm8pUNCBgsB5eaPlU/R278w604MaRiXzg52PYxwH
 QEAv9eRr92kFJMu/4XecO07aL67OTKi7SaY5i3T5zecHCjttYbGNfvtkObWH/l10AdxVsVkGB
 jHafiLJ2TLtlU7n3nxdJoEzC0A4V3ZiqdsKbsf0hGgshe+V+U0mg24sUhVFaipfU0Rc0FQby/
 FbmNRSNnhGnm6z2M4o9elPA6jngJ+CBIFnh72Y40y1EZLTNWUm0uLHKF77iSSwE4MMPoMu8/y
 DFM1tSWO9ysz1J/q/1XfGhM4IVXpP3f/qJtFY5aWPTscK41dRoglqBjbSQYoxRDY3S/6RzKCn
 4kE7Yva/jsoijaoRCSLd7aUs4kMz0biKahgxYTvX3bbls6ImO6fCb7J4KwUr7tVEQwHJA/rZn
 zz0u+F0a4t+S56ENsTm8jJpmrffvPxpRjlcSIxtiko8WkSMY53UaPLfveKPd/WskB/0+Rmast
 2RcpbG/Sd0+AZaKXTL+WNSZJt3abhhb4KLzYjGrPY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 23 Nov 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > +static const char default_branch_name_advice[] =3D N_(
> > +"Using '%s' as the name for the initial branch. This default branch n=
ame\n"
> > +"is subject to change. To configure the initial branch name to use in=
 all\n"
> > +"of your new repositories, run:\n"
>
> I think this is good, assuming that "subject to change" covers the
> case where we end up doing nothing after all.  I'd feel safer if we
> said "s/is subject to change/may change in the future/", but this is
> not a strong preference.

I'd rather keep the current form, as it sounds a bit more firm to me.

> > +"\n"
> > +"\tgit config --global init.defaultBranch <name>\n"
> > +"\n"
> > +"Common names are 'main', 'trunk' and 'development'. If you merely wi=
sh\n"
> > +"to suppress this warning, you can also use the current default branc=
h\n"
> > +"name. The current branch can be renamed via this command:\n"
>
> I think this is worse than the previous one.  Those who merely wish
> to suppress the message without wanting to commit to a particular
> name (i.e. they just want to take whatever the default we give them)
> would be mislead and be frozen in time forever.  We do not give
> "I'll just accept the default of the day" choice, and that is OK,
> but we want to be clear about it, which is why I've kept raising this
> as an issue.
>
>     To configure the initial branch name to use in all of your new
>     repositories and squelch this message, run:
>
> may be better---it makes it clear that the offered two choices are
> (1) do nothing and see this message every time, or (2) commit to a
> name and not see this message again.

Well, I think I finally understand what you are saying: there is a
legitimate need for a way to go with Git's preference but still suppress
that message.

I introduced `advice.defaultBranchName` to that end, and now display
prominently, at the top of the message, how to use that flag to avoid
seeing this advice ever again.

Ciao,
Dscho
