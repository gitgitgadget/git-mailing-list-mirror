Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5C0B1F461
	for <e@80x24.org>; Sun, 30 Jun 2019 05:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfF3F2j (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jun 2019 01:28:39 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38808 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfF3F2i (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jun 2019 01:28:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id y15so4944861pfn.5
        for <git@vger.kernel.org>; Sat, 29 Jun 2019 22:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=GgqTyuvPyw37Myj3AoR/0AgHgNxRmrLpxiUHl0MYpBY=;
        b=c/2oDOvdIPKnJtpr97ibdDirgJoBsGn2xTn6LU0FPTx1PqxAcMRtbNyYD+8HtpTTiF
         LAvzy6Xb+OvW0ZestfIaO8KEvAIBttsygkpJHrDbaSBxESJeRzOW6orrUc/JRzqcNAoE
         aYq3WHg914vSjuN5sft1Z2IqT5TM0DptKEg8CPJiWRyYxiC60SUryt/oBvjd6vBajZiX
         NUWGzkogPt1raIn23OF3QVSyUj0d5D+r9MpRafmJpm/tAF1AzIfuersGesvzVY1N4OAr
         iea5bhKRvM9mvqp6KseBgaXBOuDS0T4mNzo2T/0dxHIG1z+D+J6YTrpDACj9H+wMrrHd
         2OCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=GgqTyuvPyw37Myj3AoR/0AgHgNxRmrLpxiUHl0MYpBY=;
        b=k+n0ugRn5fgNaLmor9txnVGiQ5f53eELvJ7fV2xjW//rHmn0AhfkFxJf7bWFLAWYhR
         iN5M1zByPVMIcM4JMBOkonZznxy5CYcaY4aEN9ve9KsNgDRf7ZEx2c3p3QVfy6Q6jzRF
         DaJnsYgYz3SSOuPgvEmt7RpiXG8elyeZVYlUj8dDvP+XeZevLTKuJ4UiQQOz6M+yVLYZ
         +LexwUlrFNxTgHK3lfdInHSTf2F1ZyPYBdZQNFMd4sZnaGG/jBtZaVMrVHjrefHNGN1g
         G8/JxsPByrAYdKbD7kmfCcq1o+sQhj7eIAnwyTnmwDZnyy5ihidXht1mWhmW6AnhpnE7
         kZww==
X-Gm-Message-State: APjAAAUbJsEd5fzOm++HsA655pySU1NiuFg9Q+aNkYhWLNz0Ovk49DXW
        ZbAuIoxXb73n7Jk2ueevahCwwMweap6DnVnb/WemjA==
X-Google-Smtp-Source: APXvYqwflYIsNU9Yaaw/7lJbzJwwwVyEwehxpTMoepifZXmJUoQIazCU1rCfYldusc7yjD/1fcE4RnBdIP+BP/CBFeI=
X-Received: by 2002:a63:6b07:: with SMTP id g7mr18302533pgc.325.1561872518192;
 Sat, 29 Jun 2019 22:28:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190630051816.8814-1-eantoranz@gmail.com> <20190630051816.8814-2-eantoranz@gmail.com>
In-Reply-To: <20190630051816.8814-2-eantoranz@gmail.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Sat, 29 Jun 2019 23:28:27 -0600
Message-ID: <CAOc6etazOEvDmEKp7ABV+GoqPoO+Z92oQazyt56rRBDBnyk6ZQ@mail.gmail.com>
Subject: Re: [RFC/PATCH 2/2] rebuash - support for status
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 29, 2019 at 11:18 PM Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
>
> ---
>  wt-status.c | 49 +++++++++++++++++++++++++++++++++++++++++++------
>  wt-status.h |  1 +
>  2 files changed, 44 insertions(+), 6 deletions(-)
>

I bet there are more things to do... like:
- what happens if the user runs git checkout --force some-branch? The
state file has to be deleted, right?
- what should happen on the reflog when there's the merge then reset?
Is it possible to control what will show up on the reflog from the
script?

So any guiding word on the things I should take a look at would be
greatly appreciated.
