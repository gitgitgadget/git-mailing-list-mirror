Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01A7F1F461
	for <e@80x24.org>; Sun, 23 Jun 2019 18:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFWSzO (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jun 2019 14:55:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52140 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFWSzN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jun 2019 14:55:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id 207so10725503wma.1
        for <git@vger.kernel.org>; Sun, 23 Jun 2019 11:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=euwSgiF0RU1ZIBCaBxttmDu1bZ8l+GT6dpfR9ojnkb8=;
        b=uRWCWGZl+KW1VPtTbmtRqk2c9TJKc9YN9B6Lq1ByG1ac4ZW7NJDf2JTToW7y3zhxpO
         4xe4BMp6Wbr1HFXNT3cp9F4i5/fQImsxVyUUVqoRBmcooPGlLDA5i6vBkCQ5jz90ttcG
         CL4PjYkM+/nkEIs0Z0O1/MRBKB9/vxQwAEcXZqrI/fe19UfumQC22RbfTR+2gao6csXz
         Dn1hcCtByhJbt/31XvwVcBaDn31MUCV3ReYn6Y+rV3GXP2FtztTpNeSumEK+Ht+PpYmF
         61pFIDwh3cpumB6ihsSMq4Q3RMZ9sGmhzAlqW4s2SGRztFBbzDOV7XvQ22M0+85zi32C
         kflw==
X-Gm-Message-State: APjAAAUrzBwzR2+qo9/Xnq1cDEaOK2N1Gx2S0dNQQcc3klF3Ue7UcXld
        Nymmd0mft5MokfKOvsWpiqm6jcyHUTpQABcC6/E=
X-Google-Smtp-Source: APXvYqz9suQCvfeLQTtdSkpRPJCfELevXE5x+prLjghSIJbY+Od+7Xh+d1Q9QJ29gt0Lp8DZKVivpxUH6bxjJKsZp6A=
X-Received: by 2002:a1c:7e85:: with SMTP id z127mr12651618wmc.95.1561316110673;
 Sun, 23 Jun 2019 11:55:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190607010708.46654-1-emilyshaffer@google.com>
 <CAPig+cTZFL=GzM_-S2JMWWxRU7poJ87f3a9ZcFjjUe1T131eEQ@mail.gmail.com>
 <20190617231959.GB100487@google.com> <CAPig+cSyEHUvx39stA0kx1c6kKYO7jk7Sk_Q=etEro_h=3ucOw@mail.gmail.com>
 <20190619233556.GH100487@google.com>
In-Reply-To: <20190619233556.GH100487@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 23 Jun 2019 14:54:59 -0400
Message-ID: <CAPig+cTCfm3wi2G6q1ZW9wVwQB9zp0TQ96BXKKt8E+qxfR-UWA@mail.gmail.com>
Subject: Re: [PATCH] documentation: add tutorial for revision walking
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 7:36 PM Emily Shaffer <emilyshaffer@google.com> wrote:
> On Wed, Jun 19, 2019 at 04:13:35AM -0400, Eric Sunshine wrote:
> > Maybe I got confused because the tiny cmd_walken() snippets followed
> > one another so closely (or because I got interrupted several times
> > during the review), but one way to avoid that would be to present a
> > single _complete_ snippet from the start, followed by a bit of
> > explanation. [...]
>
> Hmm. I can say that I personally would find that much more difficult to
> follow interactively, and I'd be tempted to copy-and-paste and skim
> through the wall of text if I was presented with such a snippet.
> However, I could also imagine the reverse - someone becoming tired of
> having their hand held through a fairly straightforward implementation,
> when they're perfectly capable of reading a long description and would
> just like to get on with it.
>
> (Maybe we can split the difference and present a complete patch or new
> function, followed by a breakdown? That would end up even more verbose
> than the current approach, though.)

It might not be that important and may not need fixing considering
that I read it correctly the second time, and don't know how I managed
to get confused on the first read.

> > As this is just a toy example, I don't care too strongly about the
> > unnecessary second sentence. On the other hand, the tutorial is trying
> > to teach people how to contribute to this project, and on this
> > project, that sort of pointless comment is likely to be called out in
> > review. In fact, given that view, the entire comment block is
> > unnecessary (it doesn't add any value for anyone reviewing or reading
> > the code), so it might make more sense to drop the comment from the
> > code entirely, and just do a better job explaining in prose above the
> > snippet why you are calling that function. For instance:
> >
> >     ... Let's start the helper with the call to `prepare_revision_walk()`,
> >     which does the final setup of the `rev_info` structure before it can
> >     be used.
> >
> > The above observation may be more widely applicable than to just this
> > one instance. Don't use in-code comments for what should be explained
> > in prose if the in-code comment adds no value to the code itself (to
> > wit, if a reviewer would say "don't repeat in a comment what the code
> > already says clearly" or "don't use a comment to state the obvious").
>
> I'm of two minds about this. On the one hand, I'm somewhat in favor of
> leaving contextual, informational comments in the sample code, so the
> sample code can teach on its own without the tutorial (specifically, I
> mean the patchset that was sent alongside this one as RFC). On the other
> hand, you're right that adding these informational comments doesn't
> model best practices for real commits.
>
> I don't have a strong opposition to removing those comments from the
> in-place samples in the tutorial itself. But I do think it's useful to
> include them in the sample patchset, which is intended as an additional
> learning tool, rather than as a pristine code example - especially if we
> make it clear in the commit messages there.

Indeed, having the comments in the sample patch-set makes sense for
people who learn better that way (by seeing a complete piece of code).

> > > > Or make the output more useful by having it be machine-parseable (and
> > > > not localized):
> > > >
> > > >     printf("commits %d\nblobs %d\ntags %d\ntrees %d\n",
> > > >         commit_count, blob_count, tag_cont, tree_count);
> > >
> > > I'm not sure whether I agree, since it's a useless toy command only for human
> > > parsing.
> >
> > True, it's not a big deal, and I don't insist upon it. But, if you
> > mention in prose that this output is easily machine-parseable, then
> > perhaps that nudges the reader a bit in the direction of thinking
> > about porcelain vs. plumbing, which is something a contributor to this
> > project eventually has to be concerned with (the sooner, the better).
>
> Oh, that's a very good point. I'll frame it that way - that's a handy
> place to slip in some bonus context about Git. Thanks.
>
>   NOTE: We aren't localizing the printf here because we have purposefully
>   formatted it in a machine-parseable way. Commands in Git are divided into
>   "plumbing" and "porcelain"; the "plumbing" commands are machine-parseable and
>   intended for use in scripts, while the "porcelain" commands are intended for
>   human interaction. Output intended for script usage doesn't need to be
>   localized; output intended for humans does.

I'd go with stronger language than "doesn't need to be localized" and
say instead that plumbing output "must not be localized" since scripts
depend upon stable output (and stable API).
