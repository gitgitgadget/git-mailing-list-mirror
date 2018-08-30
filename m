Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D745B1F404
	for <e@80x24.org>; Thu, 30 Aug 2018 07:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbeH3LjK (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 07:39:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:33632 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727098AbeH3LjK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 07:39:10 -0400
Received: (qmail 12892 invoked by uid 109); 30 Aug 2018 07:38:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 07:38:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24469 invoked by uid 111); 30 Aug 2018 07:38:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 30 Aug 2018 03:38:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2018 03:38:20 -0400
Date:   Thu, 30 Aug 2018 03:38:20 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 7/9] worktree: teach 'move' to override lock when --force
 given twice
Message-ID: <20180830073820.GD11944@sigill.intra.peff.net>
References: <20180828212026.21989-1-sunshine@sunshineco.com>
 <20180828212026.21989-8-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180828212026.21989-8-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 28, 2018 at 05:20:24PM -0400, Eric Sunshine wrote:

> For consistency with "add -f -f", which allows a missing but locked
> worktree path to be re-used, allow "move -f -f" to override a lock,
> as well, as a convenience.

I don't have a strong opinion on this one, as I have never used
"worktree mv" myself. :)

But anytime I see "-f -f", I have to wonder what "-f" does. In this
case, nothing. Is there some future lesser forcing we might use it for?

-Peff
