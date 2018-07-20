Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 227F71F597
	for <e@80x24.org>; Fri, 20 Jul 2018 01:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbeGTB6i (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 21:58:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:53562 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730266AbeGTB6h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 21:58:37 -0400
Received: (qmail 18830 invoked by uid 109); 20 Jul 2018 01:12:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 20 Jul 2018 01:12:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18658 invoked by uid 111); 20 Jul 2018 01:12:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 19 Jul 2018 21:12:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2018 21:12:52 -0400
Date:   Thu, 19 Jul 2018 21:12:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] introduce "banned function" list
Message-ID: <20180720011251.GA2667@sigill.intra.peff.net>
References: <20180719203259.GA7869@sigill.intra.peff.net>
 <20180719203901.GA8079@sigill.intra.peff.net>
 <xmqqmuumdetr.fsf@gitster-ct.c.googlers.com>
 <20180720010808.GC2179@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180720010808.GC2179@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 09:08:08PM -0400, Jeff King wrote:

> Contrast this with memcpy(). This is on Microsoft's SDL banned list[1],
> but I think it's silly for it to be. I would never add it to this list.

I forgot my footnote, which was going to be:

  I'm bringing up that list not because I think it's necessarily a good
  list, but because it's _a_ list. And as I was recently subjected to an
  audit that referenced it, I've been thinking a lot about ban-lists and
  whether they are useful (and specifically for which functions).

  It's at https://msdn.microsoft.com/en-us/library/bb288454.aspx if
  you're curious, but again, that is absolutely not the ban-list I am
  working towards. To what I posted already, I'd probably add strcat()
  and vsprintf() based on discussions here, and then call it done.

-Peff
