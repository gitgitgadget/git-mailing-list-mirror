Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84DDA1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 21:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755042AbcHSVXG (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 17:23:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:58401 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753990AbcHSVXG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 17:23:06 -0400
Received: (qmail 26732 invoked by uid 109); 19 Aug 2016 21:23:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Aug 2016 21:23:05 +0000
Received: (qmail 30333 invoked by uid 111); 19 Aug 2016 21:23:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Aug 2016 17:23:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Aug 2016 17:23:03 -0400
Date:   Fri, 19 Aug 2016 17:23:03 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Brian Henderson <henderson.bj@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] diff-highlight: add support for git log --graph
 output.
Message-ID: <20160819212302.eciafv2rcvxokzu6@sigill.intra.peff.net>
References: <20160810085635.GA1672@starla>
 <20160817153124.7770-1-henderson.bj@gmail.com>
 <20160819211944.GA16646@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160819211944.GA16646@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2016 at 09:19:44PM +0000, Eric Wong wrote:

> > I've rebased my changes. Unfortunately, having 3 commits made this somewhat
> > tedious. I also find it weird that my new patch set makes it difficult to see
> > what changes I've made from my first set. What's the standard workflow here?
> 
> I check out a new branch with the same base as the previous series
> and "git diff previous current"
> 
> (without git, I'd be using interdiff from the patchutils Debian package)
> 
> Sometimes I will rebase against both old+new against Junio's master
> to avoid/reduce conflicts.

You might also try Thomas Rast's topic-branch diff:

  https://github.com/trast/tbdiff

It gives better patch-by-patch differences. And it handles the case that
the topics have different bases (which is handy if you've rebased, or if
Junio happened to apply on a different base than you did).

-Peff
