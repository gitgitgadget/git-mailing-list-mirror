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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DABB1F462
	for <e@80x24.org>; Mon,  3 Jun 2019 14:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfFCORr (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 10:17:47 -0400
Received: from mout.gmx.net ([212.227.15.19]:53667 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbfFCORr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 10:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559571461;
        bh=vl95lf7ask9l98H9gYcNahICSOI1ieKsUlfdJA+5XvA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=G4LqJYaDpz4fD2fyt75NhehD0X34Wlr1l0Ghq7ex9tvDqUbInEZnEm99fF+tBeKp1
         WTJ5s3hDNGtZWWuaBWD9/mqLw13thjwAYN8Ko0i8GMUH7zjkVtYP8efTQuRK/ZDdj8
         u2wsWqTrEWUbGVEchIMH+NTd3G35MUjfZd/+F4Rg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDysg-1hNrd31Ryu-009u3b; Mon, 03
 Jun 2019 16:17:41 +0200
Date:   Mon, 3 Jun 2019 16:17:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     =?UTF-8?B?5p6X6Ieq5Z2H?= <johnlinp@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        John Lin via GitGitGadget <gitgitgadget@gmail.com>,
        Git <git@vger.kernel.org>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: Re: [PATCH 1/1] status: remove the empty line after hints
In-Reply-To: <CAKO26MtvBRo76TenubyeVNkeA6e5yrS4DZFSLG1ByztP7mMVXw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906031614020.48@tvgsbejvaqbjf.bet>
References: <pull.196.git.gitgitgadget@gmail.com> <468be8f85426ccf588ad558fab3c8927ef58627f.1557917642.git.gitgitgadget@gmail.com> <CAKO26MsGpEcK74CSdgNGjFdKAMDP5Knm+0_vtcnrBBJjBfjcQA@mail.gmail.com> <xmqq36ky1fe8.fsf@gitster-ct.c.googlers.com>
 <CAKO26Ms6_rJfq6knh14H1O-V2_6v8YxYdjah0vTdvpJTc7hdXw@mail.gmail.com> <nycvar.QRO.7.76.6.1905291349360.44@tvgsbejvaqbjf.bet> <CAKO26MtvBRo76TenubyeVNkeA6e5yrS4DZFSLG1ByztP7mMVXw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-208471079-1559571468=:48"
X-Provags-ID: V03:K1:36eT3XhSRpTGeWMU7a9FDA2ggekZjAXTmv3ruSvy5dWM91znMCG
 glKZ22YVyEKOT/Cn+3Ug/5y2wsWnR/tJzDwNfIxDiG4FTEHTA/DUblgJKb8A5ATJS+0oNqG
 aPBjx/S0v/Ec3AajqCUkwssiLTXQ4cI092tnh800fZl3nOppc2Hc33+EG17FbWQvyhEQiuH
 Oztz6GFXy+xARhRmeZ6eg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v0RbCQq3omQ=:Oi4twWW+umkNJd25hJ22wS
 lfLc15Mr3UNy0y3tIP8RM5jpzTQOQCcWaTnxpGSZWWapFrvntLD9lyH9C72vVZ0HM6HY75vUT
 PVGDtnpi/WtFRCflkaGGU5nd3RxPoUkOMXRIM0pmU7drxCPhfb7KiWoEOT8licOHJGitl9IMf
 6lG8T/7IdaKXmJ+4WiMTPkpMhxvKkjRJ7qVU4IYC28rI/WSM8Er4DqkPvqUq2xQ77t7Hbxupq
 v1+rWHpCpLYniGwECLX6lC3HPMn2bESL/duEsvV0h2vAOvaKUMaTs7yrXvLMr5/0vFb8W3aEO
 lZxldVMwanDXx5oGdhPKBc0hPyA1r7tq8uo5hbbXZeSH7/OrHvJYLp6VdAxYyF321TJV1c4q4
 xRBQfsfnNtAK3zF/jC3o2S2m9SYW4l0H8KjirYfpAeh8fAXczLGgtOjA3pazhmgOZWrlHmgUM
 w3zqalg0WU/xKBbLaO5l/fsPa2GDRRWLFQbH/YOaPRXbzv2iuuKjYoaGiAe2TlguPkAUQBr5V
 yXrKUnl4yUQp/iPEP0usr9Ybyp/vgSOn/uN1vBMta3Z5zb0h0MSY+2S1hLJ8yEYPkzODr77Tz
 DdjGLeq/i8avUerXs0THLItoZLBQ+jitOLo6q/4VidCMivdvQA0LLOohn3WLlPceR7Anq7gCH
 MH0U6cMZhsjr5S/FAF5aRol2lfda0vMj2ZDevRBecL9+drMB9rLxaDNZ/rO4I4ZMx1RvWanUI
 +8/uT6ovgRo7eXCMeaxXuRRnU1Rw/1sdg6UF1BnLXM0gj4eidauVm+fc0oxjUHG+DdGdKEOXU
 AM9L3hJfq4h4+KUNjZvSBMNQCqf2XS1iPO+Bes7bggpNTm7yU9paeT6VWK1IjQKuLxz8q7T6b
 db6kqhAo+Sjk/lCtOFz3QreCXt/ERl4INaEsD02u0Jqb+5pzSYBsrNyLrXDkMZH1x52rfeRVc
 6Jutk36e4p3SRsFMi5eOjk7dUtZveL4h9VrsqK8FE8QkFABdNoeIt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-208471079-1559571468=:48
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi John Lin,

On Sat, 1 Jun 2019, =E6=9E=97=E8=87=AA=E5=9D=87 wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> =E6=96=BC 2019=E5=B9=B4=
5=E6=9C=8829=E6=97=A5 =E9=80=B1=E4=B8=89
> =E4=B8=8B=E5=8D=887:51=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > You could already rebase it on top of
> > https://github.com/gitgitgadget/git/tree/nd/switch-and-restore, say so=
 in
> > your cover letter, and send a new iteration.
>
> Thanks for the suggestion. I already rebase on your
> nd/switch-and-restore: https://github.com/gitgitgadget/git/pull/196
> However, it seems to have some conflict with the master branch and
> gitgitgadget refused to submit the patch. So I guess I still have to
> wait for the nd/switch-and-restore to resolve the conflict.

I am so sorry for being so sloppy. I should have said explicitly what I
had in mind: target the nd/switch-and-restore branch.

The GitGitGadget fork mirrors not only maint, master, next and pu, but
also the individual branches that Junio merges into pu (which are
published at https://github.com/gitster/git). That is, you can click the
Edit button next to your PR description, and instead of editing the PR
description, choose a different target branch from the drop-down box below
it.

Since it was totally my mistake for not telling you this explicitly, I
allowed myself to do exactly this for you. The Azure Pipeline is running
as we speak.

Thanks & my apologies,
Johannes

--8323328-208471079-1559571468=:48--
