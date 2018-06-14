Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77E1B1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 17:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754783AbeFNR4x (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 13:56:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:44742 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754526AbeFNR4x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 13:56:53 -0400
Received: (qmail 24298 invoked by uid 109); 14 Jun 2018 17:56:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Jun 2018 17:56:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13644 invoked by uid 111); 14 Jun 2018 17:57:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Jun 2018 13:57:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jun 2018 13:56:51 -0400
Date:   Thu, 14 Jun 2018 13:56:51 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] Fix occasional test failures in http tests
Message-ID: <20180614175650.GA15544@sigill.intra.peff.net>
References: <20180614123107.11608-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180614123107.11608-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 14, 2018 at 02:31:03PM +0200, SZEDER Gábor wrote:

> 't5561-http-backend.sh' is prone to occasional failures; luckily it's
> not 'git-http-backend's fault, but the test script is a bit racy.  I
> won't go into the details here, patch 4/4's commit message discusses
> it at length.  4/4 also fixes this issue, but I'm not particularly
> happy with that fix, the note attached to that patch explains why,
> along with possible alternatives, hence the RFC.
> 
> Even if we settle for a different fix, I think the first two patches
> are worthy cleanups on their own right.

Yes, the first two look like improvements on their own (and I left more
detailed comments on the final one). Thanks for tackling this!

-Peff
