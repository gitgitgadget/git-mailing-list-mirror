Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D511F20281
	for <e@80x24.org>; Mon,  2 Oct 2017 19:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbdJBTmo (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 15:42:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:58146 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751062AbdJBTmo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 15:42:44 -0400
Received: (qmail 11691 invoked by uid 109); 2 Oct 2017 19:42:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 19:42:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32245 invoked by uid 111); 2 Oct 2017 19:43:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 15:43:24 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 15:42:42 -0400
Date:   Mon, 2 Oct 2017 15:42:42 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] ref-filter.c: pass empty-string as NULL to atom parsers
Message-ID: <20171002194241.sdv7p3wgqok7sapi@sigill.intra.peff.net>
References: <20171002055052.GB10729@D-10-157-251-166.dhcp4.washington.edu>
 <20171002055311.29681-1-me@ttaylorr.com>
 <20171002064335.vzm3j2dgax4q5bxd@sigill.intra.peff.net>
 <20171002161258.GC39723@D-10-157-251-166.dhcp4.washington.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171002161258.GC39723@D-10-157-251-166.dhcp4.washington.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 02, 2017 at 09:12:58AM -0700, Taylor Blau wrote:

> > I know this is getting _really_ subjective, but IMHO this is a lot more
> > reasoning than the comment needs. The commit message goes into the
> > details of the "why", but here I'd have just written something like:
> >
> >   /* treat "%(foo:)" the same as "%(foo)"; i.e., no arguments */
> 
> I sent an updated v2 of this "series" (without a cover-letter) that
> shortens this comment to more or less what you suggested. I've kept the
> commit message longer, since I think that that information is useful
> within "git blame".

Yeah, sorry if I wasn't clear: definitely the commit message is fine and
is the place to go into the detail and rationale.

-Peff
