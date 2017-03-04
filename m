Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5BA120133
	for <e@80x24.org>; Sat,  4 Mar 2017 03:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751820AbdCDDuo (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 22:50:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:38482 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751571AbdCDDum (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 22:50:42 -0500
Received: (qmail 4635 invoked by uid 109); 4 Mar 2017 03:42:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 04 Mar 2017 03:42:29 +0000
Received: (qmail 3611 invoked by uid 111); 4 Mar 2017 03:42:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 22:42:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 22:42:27 -0500
Date:   Fri, 3 Mar 2017 22:42:27 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] http: release strbuf on disabled alternates
Message-ID: <20170304034226.uz5pzu5nl2zmisjt@sigill.intra.peff.net>
References: <20170304015016.GA25408@starla>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170304015016.GA25408@starla>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 04, 2017 at 01:50:16AM +0000, Eric Wong wrote:

> This likely has no real-world impact on memory usage,
> but it is cleaner for future readers.

Yep, this looks good.

-Peff
