Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 905382022D
	for <e@80x24.org>; Fri,  4 Nov 2016 16:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936313AbcKDQhR (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Nov 2016 12:37:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:38710 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933214AbcKDQhR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2016 12:37:17 -0400
Received: (qmail 29791 invoked by uid 109); 4 Nov 2016 16:37:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Nov 2016 16:37:16 +0000
Received: (qmail 24450 invoked by uid 111); 4 Nov 2016 16:37:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Nov 2016 12:37:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Nov 2016 12:37:14 -0400
Date:   Fri, 4 Nov 2016 12:37:14 -0400
From:   Jeff King <peff@peff.net>
To:     Tobias Klauser <tklauser@distanz.ch>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] diffcore-delta: remove unused parameter to
 diffcore_count_changes()
Message-ID: <20161104163714.zwzfbmrklzwuaw6u@sigill.intra.peff.net>
References: <20161104102436.23892-1-tklauser@distanz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161104102436.23892-1-tklauser@distanz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2016 at 11:24:36AM +0100, Tobias Klauser wrote:

> The delta_limit parameter to diffcore_count_changes() has been unused
> since commit c06c79667c95 ("diffcore-rename: somewhat optimized.").
> Remove the parameter and adjust all callers.

Sounds like a good idea to get rid of an unused parameter, but I think
this went away in ba23bbc8e (diffcore-delta: make change counter to byte
oriented again., 2006-03-04).

The patch itself looks good.

-Peff
