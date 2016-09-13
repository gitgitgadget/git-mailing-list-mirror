Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56B0420984
	for <e@80x24.org>; Tue, 13 Sep 2016 18:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759683AbcIMSP6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 14:15:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:42733 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755335AbcIMSP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 14:15:57 -0400
Received: (qmail 5509 invoked by uid 109); 13 Sep 2016 18:15:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 18:15:56 +0000
Received: (qmail 24644 invoked by uid 111); 13 Sep 2016 18:16:06 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Sep 2016 14:16:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Sep 2016 11:15:53 -0700
Date:   Tue, 13 Sep 2016 11:15:53 -0700
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pathspec: removed unnecessary function prototypes
Message-ID: <20160913181552.74bhacoa2q76yv6k@sigill.intra.peff.net>
References: <1473785571-60439-1-git-send-email-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1473785571-60439-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 13, 2016 at 09:52:51AM -0700, Brandon Williams wrote:

> removed function prototypes from pathspec.h which don't have a
> corresponding implementation.

I'm always curious of the "why" in cases like this. Did we forget to add
them? Did they get renamed? Did they go away?

Looks like the latter; 5a76aff (add: convert to use parse_pathspec,
2013-07-14) just forgot to remove them.

-Peff
