Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF118202DD
	for <e@80x24.org>; Mon,  2 Oct 2017 04:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750798AbdJBExK (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 00:53:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:56966 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750737AbdJBExK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 00:53:10 -0400
Received: (qmail 4982 invoked by uid 109); 2 Oct 2017 04:53:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 04:53:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24919 invoked by uid 111); 2 Oct 2017 04:53:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Oct 2017 00:53:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Oct 2017 00:53:08 -0400
Date:   Mon, 2 Oct 2017 00:53:07 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v4 4/6] doc: use modern "`"-style code fencing
Message-ID: <20171002045307.c66fctdduivicqqm@sigill.intra.peff.net>
References: <20171001161725.GA66172@D-10-157-251-166.dhcp4.washington.edu>
 <20171001161852.84571-1-me@ttaylorr.com>
 <20171001161852.84571-4-me@ttaylorr.com>
 <xmqqlgkutoc6.fsf@gitster.mtv.corp.google.com>
 <20171002000630.GA63556@D-10-157-251-166.dhcp4.washington.edu>
 <xmqqtvziqqku.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtvziqqku.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 02, 2017 at 10:35:45AM +0900, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> >> Is this just me who wants to do s/fenc/quot/g?  Unless somebody
> >> objects, I'd do so while queuing.
> >
> > I don't object, I think that fencing is less appropriate than quoting.
> > I couldn't find the term myself when writing this commit :-).
> >
> > I am happy to send out v5 of this patch series with this commit
> > re-written, or you can change it while queuing. Whichever is easier for
> > you.
> 
> Just FYI, here is what I ended up with.  I do not think this is
> about "modern" vs "old style"; it is more about using the more
> appropriate mark-up and our desire has always been to use `literal`
> for things that users need to type literally.

I think it was my earlier comment that led to the modern/old notion. A
lot of the old code does use single-quotes haphazardly. I'm not sure if
it's "old style" or just "we were less careful" then. Either way, the
patch looks good to me.

I also think fencing isn't the right word; that word implies to me a
multi-line block like

---------------------------
this is fenced
---------------------------

-Peff
