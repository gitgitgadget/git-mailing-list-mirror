Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 424EA1F991
	for <e@80x24.org>; Wed,  9 Aug 2017 13:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752095AbdHINBb (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 09:01:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:33242 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751942AbdHINBa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 09:01:30 -0400
Received: (qmail 4904 invoked by uid 109); 9 Aug 2017 13:01:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 13:01:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26936 invoked by uid 111); 9 Aug 2017 13:01:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Aug 2017 09:01:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Aug 2017 09:01:27 -0400
Date:   Wed, 9 Aug 2017 09:01:27 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC] clang-format: outline the git project's coding style
Message-ID: <20170809130127.ekd4tvyp2rrb7ftk@sigill.intra.peff.net>
References: <20170808012554.186051-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170808012554.186051-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 07, 2017 at 06:25:54PM -0700, Brandon Williams wrote:

> I'm sure this sort of thing comes up every so often on the list but back at
> git-merge I mentioned how it would be nice to not have to worry about style
> when reviewing patches as that is something mechanical and best left to a
> machine (for the most part).  I saw that 'clang-format' was brought up on the
> list once before a couple years ago
> (https://public-inbox.org/git/20150121220903.GA10267@peff.net/) but nothing
> really came of it.  I spent a little bit of time combing through the various
> options and came up with this config based on the general style of our code
> base.  The big issue though is that our code base isn't consistent so try as
> you might you wont be able to come up with a config which matches everything we
> do (mostly due to the inconsistencies in our code base).

Right, the reason I stopped pursuing it was that I couldn't find a way
to have it make suggestions for new code without nagging about existing
code. If we were to aggressively reformat to match the tool for existing
code, that would help. But I'm a bit worried that there would always be
suggestions from the tool that we don't agree with (i.e., where the
guiding principle is "do what is readable").

I dunno. I guess "go fmt" people decided to just treat the tool's output
as the One True Way. I haven't written enough Go to have an opinion
myself, but it seems to at least work for them.

What does the tooling look like these days for just adjusting lines
touched by a given patch?

-Peff
