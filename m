Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93DA61F858
	for <e@80x24.org>; Thu, 28 Jul 2016 23:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbcG1Xrj (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 19:47:39 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33422 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbcG1Xrh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 19:47:37 -0400
Received: by mail-yw0-f193.google.com with SMTP id z8so7198272ywa.0
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 16:47:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=JGu8t9XVpv6JybZA7m0SKUdvUsrrh0cLTuu5VyK1Rww=;
        b=T2kqpRT5cnKr4zexka/Q1enfdCcmohTbJjQP6UOlCTRkS9g3kXdVmeLa5Rghj3WNs1
         N1egaMa05nLZTsrEawRr++JwcnkD5zhaOBGhJxTUdMb/31pd9mEPNQ6nD/kIlr2kiweK
         MZ2mMrtHbkUhQYlXXxSQ/cESUM7i1w5rdmIiGq9njfQ57JxjUZ5xC9+9SvtyBD8ZxSiK
         ZeXMuRD9UEXro8vvdBe+eeOB7PCI07pFkAa8kKzQmaESJks1fpQyM6WWAPZD1LgPv6YU
         o9j7OgLw2EHDqtXZ8JXNnpM9Es28ueHZKXI+aW606A1CJnBRW2IAvvmfw/NJteDiINCC
         zrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=JGu8t9XVpv6JybZA7m0SKUdvUsrrh0cLTuu5VyK1Rww=;
        b=l+aGgTaeRRa0NSfjPL/cxDaDWNX/EO0Vw3BfOXvG+QGkn2n1gAQ0CpGS3KLBCDQYtK
         cYu5JWeXGZOM1iRiJy33DW3PY/xYWFwKJe4M+ZzUeAhFHoSIChMd0ZZNzH1/shGgJP+N
         1kTe2zORh6T7rwCWiIeR9HQefKSMzmDO85QdtiPq+0gx5dgbiheBK8rdWVmUlBsMQCBX
         EfE1c/s+wLB2/IMgiATRyxRBG6JjoDFQR5ubzvsZarNwlssI3ggFMvOF3dh8mBVmTP4e
         5r/deI7YBaN1gXzWyjbvhsr8Ep9WQ3sJIwC+0k33Oj31g+StK2WvXBC8YcnF6kvzpN0I
         ifVQ==
X-Gm-Message-State: AEkoouuyVYLTsbT7ydgr7Ofr/P0pDujIxVp2bxYIna1uQ/k1545Mq/fzfZrpmtAHzr59iJ3o/HuDdeql7hNzag==
X-Received: by 10.37.66.147 with SMTP id p141mr344535yba.28.1469749656603;
 Thu, 28 Jul 2016 16:47:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Thu, 28 Jul 2016 16:47:17 -0700 (PDT)
In-Reply-To: <CA+55aFxaia7_VkKKF3JiQt76+z5goz3vCpmWi-wTyBH=iaw5ew@mail.gmail.com>
References: <CA+55aFxaia7_VkKKF3JiQt76+z5goz3vCpmWi-wTyBH=iaw5ew@mail.gmail.com>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Thu, 28 Jul 2016 16:47:17 -0700
X-Google-Sender-Auth: FjJNs8GW-bwlneblC5Y1Le4dTcU
Message-ID: <CAPc5daX=MoqEXkV7DdpT+J=4K_qNdo0aNu_XgUs+9yggyrMXbQ@mail.gmail.com>
Subject: Re: Small trivial annoyance with the nice new builtin "git am"
To:	Linus Torvalds <torvalds@linux-foundation.org>
Cc:	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 4:35 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Ok, it's no longer *that* new, but I only now noticed..
>
> So I noticed that when I applied the last patch-bomb series from
> Andrew, all the commit date-stamps are idential.
> ...
> That seems entirely accidental, I think that what happened is that
> "ident_default_date()" just ends up initializing the default date
> string once, and then the date is cached there, because it's now run
> as a single process for the whole series.

Ouch, sorry, that certainly sounds utterly broken. I have a suspicion
that we would see more and more breakages like this in the near
future, as there are folks trying to redo multi-commit commands in
a single process. We need to be very careful to avoid the same
mistake.

Also makes me wonder if "git cherry-pick A..B" shares the same
breakage.

Thanks.
