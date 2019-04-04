Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5864020248
	for <e@80x24.org>; Thu,  4 Apr 2019 01:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfDDB5C (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 21:57:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:46264 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726167AbfDDB5C (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 21:57:02 -0400
Received: (qmail 19074 invoked by uid 109); 4 Apr 2019 01:57:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 04 Apr 2019 01:57:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13253 invoked by uid 111); 4 Apr 2019 01:57:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 03 Apr 2019 21:57:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Apr 2019 21:57:00 -0400
Date:   Wed, 3 Apr 2019 21:57:00 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] create FLEX_ALLOC_MEM to FLEX_ALLOC_STR cocci rule
Message-ID: <20190404015659.GE4409@sigill.intra.peff.net>
References: <cover.1554328261.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1554328261.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 03, 2019 at 03:00:03PM -0700, Denton Liu wrote:

> I was playing around with coccinelle and I noticed that we have a use of
> FLEX_ALLOC_MEM that could be converted into FLEX_ALLOC_STR. Convert it
> and write a cocci rule to prevent this from happening.
> 
> Note that this was more of an exercise to teach myself how to use
> coccinelle. I'm just submitting a useful patch that came as a result of
> this. Please let me know if this is unwelcome.

Both look pretty reasonable to me. Obviously it's a pretty trivial
change, but that's sort of the point: automate these things away so we
don't have to think about them during review.

Now if you could figure out a way to point people to FLEX_ALLOC in the
first place when they are not currently using it, _that_ would be pretty
amazing. But I suspect it's a bit too complicated. :)

-Peff
