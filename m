Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21ACD1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 18:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391327AbfIESrS (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 14:47:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:40854 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728258AbfIESrS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 14:47:18 -0400
Received: (qmail 2953 invoked by uid 109); 5 Sep 2019 18:47:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Sep 2019 18:47:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30038 invoked by uid 111); 5 Sep 2019 18:49:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2019 14:49:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Sep 2019 14:47:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH] t: use LF variable defined in the test harness
Message-ID: <20190905184716.GA12647@sigill.intra.peff.net>
References: <xmqqwoeprsp1.fsf@gitster-ct.c.googlers.com>
 <20190904002930.GA76383@syl.lan>
 <xmqq7e6mr4iy.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7e6mr4iy.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 05, 2019 at 11:17:57AM -0700, Junio C Hamano wrote:

> Somebody may want to go clean-up the use of various $sq and $SQ
> locally defined by giving a unified $SQ in test-lib.sh, by the way.

Maybe good #leftoverbits material, since we may have Outreachy
applications coming up soon.

-Peff
