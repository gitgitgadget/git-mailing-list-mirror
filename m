Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1E1F20226
	for <e@80x24.org>; Thu,  4 Aug 2016 07:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbcHDHn3 (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 03:43:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:54624 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750790AbcHDHn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 03:43:27 -0400
Received: (qmail 11464 invoked by uid 102); 4 Aug 2016 07:16:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 03:16:13 -0400
Received: (qmail 10532 invoked by uid 107); 4 Aug 2016 07:16:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 03:16:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2016 03:16:08 -0400
Date:	Thu, 4 Aug 2016 03:16:08 -0400
From:	Jeff King <peff@peff.net>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 3/8] xdl_change_compact(): rename i to end
Message-ID: <20160804071608.p4uo46ye4uztkaz6@sigill.intra.peff.net>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
 <625e39916051e2ea5e09e1c0d3c4f6c25e61302d.1470259583.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <625e39916051e2ea5e09e1c0d3c4f6c25e61302d.1470259583.git.mhagger@alum.mit.edu>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 04, 2016 at 12:00:31AM +0200, Michael Haggerty wrote:

> Rename i to end, and alternate between using start and end as the
> indexing variable as appropriate.
> 
> Rename ixref to end_matching_other.
> 
> Add some more comments.

I'd usually complain that there is too much "what" in your commit
message, but in this case, the diff really is hard to read. Having a
summary up front is nice.

There's no "why", but I imagine it is just "I had to do this to even
make sense of this function".

-Peff
