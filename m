Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E142320248
	for <e@80x24.org>; Tue, 12 Mar 2019 23:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfCLXIM (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 19:08:12 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:46987 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfCLXIM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 19:08:12 -0400
Received: by mail-oi1-f179.google.com with SMTP id j10so3525120oij.13
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 16:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eHqj6xXt+e+kANJcmG88TiGtRZng5CauC56V+gYYo64=;
        b=Fvwhw5ZKC3dlL44n3pfjov1hnisdxrKm1yL6kGA7FXsHqDgK6Q2UofCmD4z26UUiC2
         KwSkYL0UQiOw9BQW1ryhZi59Q5zNIKjvzX9lsb/JMEO7pn32svykt96cfw0QusSgW5FN
         DPm0/Y9s97wT71bwgH2KOWeKxL9ftsUtEqDaNGssej1ybyAYqXZDZlgtAqr5JbqeGkyo
         ohtRZTWKM1H4GM6ixDO3QVgAfnsCU/iopMYM0dUY0sX3k6FdWIEmxns9rAMnKmXXk1EU
         77hCfd+uJ6SkLc2nYqTeW9dSxrCRejZpvvNAp1a91ZTSMUW09iwervHt3rbcphoxgRWL
         qQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eHqj6xXt+e+kANJcmG88TiGtRZng5CauC56V+gYYo64=;
        b=HSnwc3zdalxt8Lmvivd6LGEkPlARo1Id/OFm/FsHhWlx2FQ0wqeqGPlT+fbTD3paCE
         +bqDeQRXcvNCU1RGs0Wlylc9kzdPtJafiGX+ByqLJVcY3/+vHI7wystHVLg3jidAIwC9
         ha9bb8bYNKMpR9nhOjzFVqCyWaBa4zJqV9bgrWFjqfbXemhn5gsy5qLIHNxPLN0mwSrA
         X2tOX1yTKaeyoWY1KjHNT/jeaWelvn8mrjFRTxsrYr7A+j9OLoCZeE9frZA1HbvX42rL
         +CnRI3qOYfHwAly9C5iIXJ2i18fnc0nvlJ4d1HLf8Z5YUMAsKmmmYnVnXE/9WLoRFHgu
         z8+w==
X-Gm-Message-State: APjAAAWmFIDnPP8kL5VDzlTlQKLzdJ/FPbhhqCdVwfGdmb9nj7icW2Rr
        PXWII4it0K25m0ZuL4iFLT+2zBNUZYYcYxRhKFo=
X-Google-Smtp-Source: APXvYqxZJNqMnu+D5Fy5xEJJyZf74OOS47SesDmV6I3ZsRit0NtRmaXoG2Yh+sqaij7RWJjfS7s/mq9/eJdXA+gZLyk=
X-Received: by 2002:aca:5a45:: with SMTP id o66mr139877oib.179.1552432091035;
 Tue, 12 Mar 2019 16:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190312213246.GA6252@sigill.intra.peff.net>
In-Reply-To: <20190312213246.GA6252@sigill.intra.peff.net>
From:   Roberto Tyley <roberto.tyley@gmail.com>
Date:   Tue, 12 Mar 2019 23:08:00 +0000
Message-ID: <CAFY1edYQcWzYJXF6f_TRk4=bEMVnFXTAp=5u=TJ4XZ3UUd4EmA@mail.gmail.com>
Subject: Re: [RFC/PATCH] point pull requesters to Git Git Gadget
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 12 Mar 2019 at 21:34, Jeff King <peff@peff.net> wrote:
...
> We could continue to mention _both_ tools, but it's probably better to
> pick one in order to avoid overwhelming the user with choice. After all,
> one of the purposes here is to reduce friction for first-time or
> infrequent contributors. And there are a few reasons to prefer GGG:

That's fair enough - I haven't committed to submitGit for 2 years
(it's continued to work without incident for most of that time I
think!). I would be prepared to spend more time on it if it was
important to people - or, heavens forfend, I could be paid to do so :)
 - but I have a lot of projects (not just software ones!) and
submitGit kind of fell to the bottom of the pile. I wasn't aware of
https://gitgitgadget.github.io/ but it looks good!

>   1. submitGit seems to still have a few rough edges. E.g., it doesn't
>      munge timestamps to help threaded mail readers handled out-of-order
>      delivery.

Yup, very true.

>   2. Subjectively, GGG seems to be more commonly used on the list these
>      days, especially by list regulars.

That's probably true too, though my interest with submitGit was more
driven by helping early/first-time contributors than regulars. Though
I'm sure GGG works well, in an ideal world it would be interesting to
get a perspective from a cohort of those kind of users about what kind
of flow works best for them - although, as I haven't been following
development, maybe this has already been done?

>   3. GGG seems to be under more active development (likely related to
>      point 2).

Definitely true!

> I feel a little bad sending this, because I really value the work that
> Roberto has done on submitGit. So just dropping it feels a bit
> dismissive.

Oh, you're very kind, that's ok! Very glad submitGit could help for a
while, sounds like it was a good proof that GitHub could become part
of the contribution process.

Roberto
