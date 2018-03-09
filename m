Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C52E1F404
	for <e@80x24.org>; Fri,  9 Mar 2018 13:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbeCINEa (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 08:04:30 -0500
Received: from mail-ot0-f180.google.com ([74.125.82.180]:46113 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751106AbeCINE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 08:04:29 -0500
Received: by mail-ot0-f180.google.com with SMTP id g97so8571546otg.13
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 05:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=6tzaGmiXdjfp6ahFbuBfcR3/Spe25SGfUWs1qFp8DQE=;
        b=OfTI6GhMTzXu2BsXQXef1jZ4aWBw8uYnBuH+LSdGfoEZ9p1xOzBVLcZaGfX9MNtueM
         Y9s5oZoTu0Ih3wS527GdD/xSZZcG0iMAHggkQbeQXmCaDU04Aeravp0XKZoBB+tL/wE2
         xjTzNrGx8zL+zgko+fY6GUlIfgMwY5HtGBdet/Rj6qWPNEspuxgonIIuMAjkEEG0TePu
         IHeaMxHqVVMWHvUPU3JLAWjyKGwQzFdbGApO5BPR8+nuZc/w0FvO9fKxrFL9GSHLpdSc
         r7gy3zLgjeFhHA4Z111wry5b7sn8myPbwuANQOwGw70V0bPoXHu7KK4P8c9SiTJGGTwG
         R67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=6tzaGmiXdjfp6ahFbuBfcR3/Spe25SGfUWs1qFp8DQE=;
        b=YFhFxpX5Z7Cehu25xAcITpo/PopyBw0UkQXm9RMtdnYc8pMuXNwdrgotIPybrUBzRc
         eom1V/t+Mc9XuxgE4PkatESlr5yBWQO3x6j2+aVkq4tdY1r2lisl99pBGAI3g7wp9a0r
         YH0MZBUM1zvIViogbS2xLXB33yya4DJl2TFo4gOeltSZ9ON7dN6kfqcauvvR7J7q9F7Q
         jIMYTNWHxt4lJBNXdE17C0dTbYPiuqPpk6aduLlGT15bSPcvSSYVZOsbvvkr7NOM/JTq
         LKUnajTm1jNK+D9lITaIFSm/A/S0S4H94EIBSaEwcZdlWJW8Mj1pDjMZoczIyN9yvkHm
         f1+g==
X-Gm-Message-State: AElRT7FG4FsCWA1p8jVas4C5hB7OhHj4XAGG8vGyzWCmJhJiKSl5lhdm
        KV1cmkR95f5mqsm1RUyYiaGr65qH2R9M9Fr7CWI=
X-Google-Smtp-Source: AG47ELuph3/mZXUXUWR6TVIpatI3xUMatdxxSPim8N3bkDmaYZKev++86QC5Gj9wVcmG488nmeScB/Qy1hDSjgzOkYk=
X-Received: by 10.157.39.138 with SMTP id c10mr22767554otb.132.1520600668823;
 Fri, 09 Mar 2018 05:04:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.52.162 with HTTP; Fri, 9 Mar 2018 05:04:28 -0800 (PST)
In-Reply-To: <1520502026.23648.29.camel@hellion.org.uk>
References: <P56D58$52E406B139FE9D3C295CB5ABAB5C8893@locati.it>
 <87zi3inckw.fsf@evledraar.gmail.com> <1520502026.23648.29.camel@hellion.org.uk>
From:   Michele Locati <michele@locati.it>
Date:   Fri, 9 Mar 2018 14:04:28 +0100
X-Google-Sender-Auth: zGK-7OMId0XFs0aRUXU0qWNAr_0
Message-ID: <CAGen01hYG40jKQSu7ZJpb8TXROC74NfVXVT82wNjYqx1yKYD=w@mail.gmail.com>
Subject: Re: How to use filter-branch with --state-branch?
To:     Ian Campbell <ijc@hellion.org.uk>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-03-08 10:40 GMT+01:00 Ian Campbell <ijc@hellion.org.uk>:
>
> On Thu, 2018-03-08 at 10:25 +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
 wrote:
>
> > > The first filter-branch call required 7168 steps, so did the second c=
all...
> > > I also tried without the --prune option of remote update (I had to ad=
d
> > > --force to the second filter-branch), but nothing changed.
>
> You can see an example of the usage in:
>     https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree=
-rebasing.git/
>
> in the `scripts/` sub dir (flow is `cronjob` =E2=86=92 `filter.sh` =E2=86=
=92 `git
> filter-branch...`.
>
> I think the big difference is rather than `--all` you need to give it
> the `previous..now` range since that is the update you wish to do
> (first time around you just give it `now`).
>
> The devicetree-rebasing scripting arranges that by keeping the previous
> in a separate branch.
>
> Ian.

Thank you for your quick reply, Ian.

Just a couple of questions:

1. it seems to me it's not possible to process all the branches in one
go. Am I right?

2. Why do you have this line in filter.sh?
`rm -f .git/refs/original/refs/heads/${UPSTREAM_REWRITTEN}`

Thank you again,
Michele
