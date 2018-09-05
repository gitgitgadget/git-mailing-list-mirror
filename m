Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 228251F404
	for <e@80x24.org>; Wed,  5 Sep 2018 20:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeIFBDD (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 21:03:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:40442 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727708AbeIFBDD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 21:03:03 -0400
Received: (qmail 28688 invoked by uid 109); 5 Sep 2018 20:31:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Sep 2018 20:31:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23295 invoked by uid 111); 5 Sep 2018 20:31:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 05 Sep 2018 16:31:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Sep 2018 16:31:11 -0400
Date:   Wed, 5 Sep 2018 16:31:11 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Sep 2018, #01; Tue, 4)
Message-ID: <20180905203111.GA9752@sigill.intra.peff.net>
References: <xmqqmusw6gbo.fsf@gitster-ct.c.googlers.com>
 <CAPig+cSETNc5nRxf_zQq6JE8zNyUvKmdPWNsm6=NMSOXm2DV=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSETNc5nRxf_zQq6JE8zNyUvKmdPWNsm6=NMSOXm2DV=A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 05, 2018 at 05:50:04AM -0400, Eric Sunshine wrote:

> On Tue, Sep 4, 2018 at 6:36 PM Junio C Hamano <gitster@pobox.com> wrote:
> > * es/worktree-forced-ops-fix (2018-08-30) 9 commits
> >  - worktree: delete .git/worktrees if empty after 'remove'
> >  - worktree: teach 'remove' to override lock when --force given twice
> >  - worktree: teach 'move' to override lock when --force given twice
> >  - worktree: teach 'add' to respect --force for registered but missing path
> >  - worktree: disallow adding same path multiple times
> >  - worktree: prepare for more checks of whether path can become worktree
> >  - worktree: generalize delete_git_dir() to reduce code duplication
> >  - worktree: move delete_git_dir() earlier in file for upcoming new callers
> >  - worktree: don't die() in library function find_worktree()
> >
> >  Various subcommands of "git worktree" take '--force' but did not
> >  behave sensibly, which has been corrected.
> 
> This series is missing a patch[1] from Peff which he wanted placed at
> the end of the series. It was probably overlooked since he embedded
> it as a reply in that thread rather than sending it as a standalone
> patch.
> 
> [1]: https://public-inbox.org/git/20180830075431.GF11944@sigill.intra.peff.net/

Yeah, I'm not sure which is easier for Junio. I figured by replying
inline, it makes it easy to pick up on top of the others (since it
really does depend on them and should be in the same topic). But it is
easier to overlook as "meh, just more discussion".

Either way, yes, I'd be happy to see that patch on top.

-Peff
