Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59C2F20986
	for <e@80x24.org>; Tue,  4 Oct 2016 13:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753860AbcJDNrH (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 09:47:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:51997 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751636AbcJDNrF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 09:47:05 -0400
Received: (qmail 21602 invoked by uid 109); 4 Oct 2016 13:47:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 13:47:04 +0000
Received: (qmail 5003 invoked by uid 111); 4 Oct 2016 13:47:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 09:47:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 09:47:02 -0400
Date:   Tue, 4 Oct 2016 09:47:02 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 04/18] t5613: whitespace/style cleanups
Message-ID: <20161004134702.evnm6xea7y6mbppo@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203405.nzijl552nlqg63ab@sigill.intra.peff.net>
 <CA+P7+xoX6XsKRFUCx+vhUo7ARYMEXktzcbFS=zh1NUTgRdhdUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xoX6XsKRFUCx+vhUo7ARYMEXktzcbFS=zh1NUTgRdhdUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2016 at 10:52:39PM -0700, Jacob Keller wrote:

> On Mon, Oct 3, 2016 at 1:34 PM, Jeff King <peff@peff.net> wrote:
> > Our normal test style these days puts the opening quote of
> > the body on the description line, and indents the body with
> > a single tab. This ancient test did not follow this.
> >
> 
> I was surprised you didn't do this first, but it doesn't really make a
> difference either way. This is also a pretty straight forward
> improvement, and I can see why you'd want to split this out to review
> separately.

I was trying to leave it to the end, to move the substantive changes up
front (and because there _isn't_ a correct style for some of the things
it was doing). But it just got too painful to do the "don't chdir" patch
without updating the style. I agree it might have made more sense at the
very beginning, but I didn't think it mattered enough to go through the
trouble of rebasing the earlier patches (which would essentially be
rewriting them).

-Peff
