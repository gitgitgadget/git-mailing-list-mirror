Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5C451F404
	for <e@80x24.org>; Mon, 27 Aug 2018 09:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeH0Nlx (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 09:41:53 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:45435 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeH0Nlx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 09:41:53 -0400
Received: by mail-qt0-f178.google.com with SMTP id g44-v6so16539453qtb.12
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 02:55:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oVIsPeHjb+Wm690m5DtNRYP2Ogffczz8QVViBE1b9Vc=;
        b=B5kpT0H4ZBUSm5x+/xYpWBaV80rYq6pMu0foi/y8WSW4LJILH5t5+B9/oDCMIgmD2B
         22ZLLIrTbn+sRhVzxsZQOBDnyjEJ3z5JPHDLm9E4bW1iJ6psIUaA761ylTENWsABR3BI
         p785tlNgbjqLtULoselMUETsk/k9hc70IprDtxy+CPgK5xVUvjN4leDtr37wJjKeQ9rM
         7gJ20gRgL0h0vKHVxTrTee7c5Lgeb3zySUhVLtxuECXXc1kkbhJwfUxXxvAblX7YF1BK
         ASnvdYJfwRxm3v/EXwix13N73NY2/NouZIQEPYZ8bmnpTOwZbVHf3H98yWbRSW2+oFk0
         hBsA==
X-Gm-Message-State: APzg51Dg/LLu7IlRhh8rG1hRde3P6WyZFAGIO/B+WHdLtlP9z9m51vZP
        apB/grHp66lo1jNU7B5zmjJCjo22o0DMiMEyHIhE2w==
X-Google-Smtp-Source: ANB0VdZgXQohtfCtaEipbgHpXpT8ChYv401NdwVWx0acson08UtgRlWCjy0Xheo6Wzu8Sti19GgbNwIHuXmW0EmcpL8=
X-Received: by 2002:ac8:764c:: with SMTP id i12-v6mr12736332qtr.250.1535363754583;
 Mon, 27 Aug 2018 02:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180821192321.GA720@sigill.intra.peff.net> <20180821193556.GA859@sigill.intra.peff.net>
 <CAPig+cT+LBSJHoR1kUi+S2h96y_qmVEpK0xAy6sRUGQj6GQEyg@mail.gmail.com>
 <20180821204341.GA24431@sigill.intra.peff.net> <CAPig+cTghgbBo5VfZN+VP2VM00nPkhUqm0dOUqO37arxraxBKw@mail.gmail.com>
 <CACsJy8BxxyRxqCj5ZoOmPaiwmFRKHU72yTxyC_eHXS+cEa94zw@mail.gmail.com>
 <CAPig+cQNkMEUj=6e=6czbkWeozJQ-Go09C6bZwVJUTpM3JJiiw@mail.gmail.com> <20180824232502.GA21265@sigill.intra.peff.net>
In-Reply-To: <20180824232502.GA21265@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 27 Aug 2018 05:55:43 -0400
Message-ID: <CAPig+cQMv=ByvmH=+V3hZ1NC-=eT+CShuM7g+Y4evD1nVFr4XQ@mail.gmail.com>
Subject: Re: worktree duplicates, was: [PATCH] SubmittingPatches: mention doc-diff
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 24, 2018 at 7:25 PM Jeff King <peff@peff.net> wrote:
> On Fri, Aug 24, 2018 at 06:55:24PM -0400, Eric Sunshine wrote:
> > On Fri, Aug 24, 2018 at 10:47 AM Duy Nguyen <pclouds@gmail.com> wrote:
> > > > I was thinking that "worktree add" could start respecting the --force
> > > > option as an escape hatch.
> > >
> > > Sounds good. Eric are you going to implement this? Just checking so
> > > that I can (hopefully) cross this off my backlog ;-)
> >
> > It wasn't something I was planning on working on (at least not
> > immediately) [...]
> > As for the actual implementation, I haven't yet looked at how much
> > surgery will be needed to make 'add' respect --force.
>
> Me either. I may take a look this weekend. [...]

Okay, I got an implementation up and running. It didn't require too
much code, but neither was it a simple 1- or 2-liner.

I still need to update documentation, write tests, and compose the
actual patch series (which will probably run to about 5 patches), so
it's not quite ready to send out, but hopefully soon.
