Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCE9C1F4DD
	for <e@80x24.org>; Tue, 29 Aug 2017 17:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751282AbdH2RGA (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Aug 2017 13:06:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:52074 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751242AbdH2RF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2017 13:05:58 -0400
Received: (qmail 28366 invoked by uid 109); 29 Aug 2017 17:05:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Aug 2017 17:05:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12005 invoked by uid 111); 29 Aug 2017 17:06:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 Aug 2017 13:06:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Aug 2017 13:05:56 -0400
Date:   Tue, 29 Aug 2017 13:05:56 -0400
From:   Jeff King <peff@peff.net>
To:     Daniel Watkins <daniel@daniel-watkins.co.uk>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff-highlight: Add clean target to Makefile
Message-ID: <20170829170555.iaxvyar5widvhoso@sigill.intra.peff.net>
References: <20170829112311.16432-1-daniel@daniel-watkins.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170829112311.16432-1-daniel@daniel-watkins.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2017 at 12:23:11PM +0100, Daniel Watkins wrote:

> Now that `make` produces a file, we should have a clean target to remove
> it.
> [...]
> +clean:
> +	$(RM) diff-highlight
> +

Makes sense. Thanks!

-Peff
