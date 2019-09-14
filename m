Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32EE01F463
	for <e@80x24.org>; Sat, 14 Sep 2019 02:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388221AbfINCC1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 22:02:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:50028 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387643AbfINCC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 22:02:27 -0400
Received: (qmail 7418 invoked by uid 109); 14 Sep 2019 02:02:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 14 Sep 2019 02:02:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21864 invoked by uid 111); 14 Sep 2019 02:04:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Sep 2019 22:04:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Sep 2019 22:02:25 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [RFC PATCH 10/10] pack-objects: improve partial packfile reuse
Message-ID: <20190914020225.GB28422@sigill.intra.peff.net>
References: <20190913130226.7449-1-chriscool@tuxfamily.org>
 <20190913130226.7449-11-chriscool@tuxfamily.org>
 <xmqq7e6bde4z.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7e6bde4z.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 13, 2019 at 03:29:00PM -0700, Junio C Hamano wrote:

> This comment has nothing to do with the change, but the way the
> patch is presented is quite hard to follow, in that the preimage or
> the common context lines do not help understand what the new code is
> doing at all ;-)
> 
> I'll come back to the remainder of the patch later.  Thanks.

I applaud Christian's effort to tease it out into separate patches. I
think I may need to take a pass and try to explain what's going on in
some of them (which will definitely involve paging in some ancient work
mentally, but hopefully between my memory and general familiarity with
the area, I can massage it into something a bit more understandable).

-Peff
