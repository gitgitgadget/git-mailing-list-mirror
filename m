Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E386D1FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 16:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753718AbdBFQYj (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 11:24:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:49845 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753532AbdBFQYi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 11:24:38 -0500
Received: (qmail 13280 invoked by uid 109); 6 Feb 2017 16:24:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Feb 2017 16:24:38 +0000
Received: (qmail 14215 invoked by uid 111); 6 Feb 2017 16:24:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Feb 2017 11:24:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2017 17:24:36 +0100
Date:   Mon, 6 Feb 2017 17:24:36 +0100
From:   Jeff King <peff@peff.net>
To:     Pranit Bauva <pranit.bauva@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: git-scm.com status report
Message-ID: <20170206162436.wiydnq7sv43wqg3d@sigill.intra.peff.net>
References: <20170202023349.7fopb3a6pc6dkcmd@sigill.intra.peff.net>
 <CAFZEwPPX4LngKrOHxgEp4aMGKOs0w4LHUBKumtmeRJSZ2_iV_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFZEwPPX4LngKrOHxgEp4aMGKOs0w4LHUBKumtmeRJSZ2_iV_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 06, 2017 at 01:41:04AM +0530, Pranit Bauva wrote:

> On Thu, Feb 2, 2017 at 8:03 AM, Jeff King <peff@peff.net> wrote:
> > ## What's on the site
> >
> > We have the domains git-scm.com and git-scm.org (the latter we've had
> > for a while). They both point to the same website, which has general
> > information about Git, including:
> 
> Since we have an "official" control over the website, shouldn't we be
> using the .org domain more because we are more of an organization?
> What I mean is that in many places, we have referred to git-scm.com,
> which was perfectly fine because it was done by github which is a
> company but now I think it would be more appropriate to use
> git-scm.org domain. We can forward all .com requests to .org and try
> to move all reference we know about, to .org. What do you all think?

I don't have a preference myself. I know a lot of non-commercial groups
(which I think the Git project is) try to prefer ".org" to signal that.

Switching it around would require some DNS changes. I think ".org" goes
to a server the DNS provider (Gandi) runs which issues an HTTP 301 to
".com". So we'd want to reverse that, or possibly just treat them both
as equals. That shouldn't be too hard, and will have to be done via
Conservancy.

I don't know what it would mean in terms of search-engine optimization.
I know Google tries to detect duplicate names for sites and treat one as
canonical. And that's going to be ".com" now, based on the existing
redirect and on the fact that most people will have linked to .com.

I'm not sure what disadvantages there are to switching now, or if there
are things we should be doing to tell search engines (I seem to recall
Google's Webmaster tools have options to say "this is the canonical
name"). This is pretty far outside my area of expertise, so it may not
even be something to care about at all. Just things to consider (and
hopefully more clueful people than I can comment on it).

-Peff
