Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F11DB1F405
	for <e@80x24.org>; Sun, 16 Dec 2018 10:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729861AbeLPK4E (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 05:56:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:43268 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729811AbeLPK4D (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 05:56:03 -0500
Received: (qmail 24642 invoked by uid 109); 16 Dec 2018 10:56:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Dec 2018 10:56:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22419 invoked by uid 111); 16 Dec 2018 10:55:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 16 Dec 2018 05:55:35 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Dec 2018 05:56:01 -0500
Date:   Sun, 16 Dec 2018 05:56:01 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] rev-list-options.txt: do not nest open blocks
Message-ID: <20181216105601.GF13704@sigill.intra.peff.net>
References: <20181215112742.1475882-1-martin.agren@gmail.com>
 <20181215112742.1475882-4-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181215112742.1475882-4-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 15, 2018 at 12:27:41PM +0100, Martin Ågren wrote:

> Similar to the previous commit, it appears we try to nest open blocks,
> which does not work well with Asciidoctor. Drop the outer one. That
> fixes the indentation similar to the previous patch, and makes us stop
> rendering a literal '+' before "Under --pretty=oneline ...". Asciidoc
> renders identically before and after this patch, both man-page and html.

Makes sense. Arguably this could be squashed into the previous one,
since the rationale is completely the same (but I'm OK with it either
way).

-Peff
