Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 845121F4F8
	for <e@80x24.org>; Fri, 23 Sep 2016 03:56:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757829AbcIWD4F (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 23:56:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:46988 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757758AbcIWD4E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 23:56:04 -0400
Received: (qmail 24872 invoked by uid 109); 23 Sep 2016 03:56:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Sep 2016 03:56:04 +0000
Received: (qmail 14274 invoked by uid 111); 23 Sep 2016 03:56:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 22 Sep 2016 23:56:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Sep 2016 23:56:01 -0400
Date:   Thu, 22 Sep 2016 23:56:01 -0400
From:   Jeff King <peff@peff.net>
To:     "Eric S. Raymond" <esr@thyrsus.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] docs/cvs-migration: mention cvsimport caveats
Message-ID: <20160923035601.f5czdieouzvm3ptz@sigill.intra.peff.net>
References: <20160922072350.ivjrfuedodd2rezn@sigill.intra.peff.net>
 <20160922072628.rs47hfiowtobw46s@sigill.intra.peff.net>
 <20160922131526.GB6320@thyrsus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160922131526.GB6320@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 22, 2016 at 09:15:26AM -0400, Eric S. Raymond wrote:

> Jeff King <peff@peff.net>:
> > Back when this guide was written, cvsimport was the only
> > game in town. These days it is probably not the best option.
> 
> It is absolutely not.  As I have tried to point out here before, it
> is *severely* broken in its processing of branchy CVS repositories.
> 
> Nobody wanted to hear that, but it's still true. Recommending it
> is irresponsible.

I think your points came across, and that is why we have the big warning
in git-cvsimport in the first place. This is really just adding a
pointer to that warning from another relevant location (that frankly, I
didn't even know existed until fixing a nearby problem).

I _do_ think cvsimport, buggy as it may be, may still have some
potential value over other solutions (if you have a simple history, and
it is easier to install or run than the alternatives). But I converted
all of my CVS history to git over ten years ago and have never looked
back. I really don't know if that is the case or not.

So personally I have no objection if somebody wants to rewrite the
gitcvs-migration page to discuss the other options more thoroughly, or
warn more clearly about cvsimport's flaws. These patches were just
"Jeez, we are not even warning people _at all_, so at the minimum we
should do so". I am not qualified to write on the current state of
the art in CVS importing.

-Peff
