Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7C4C1F405
	for <e@80x24.org>; Sun, 16 Dec 2018 16:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbeLPQTV (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 11:19:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:43456 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729822AbeLPQTV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 11:19:21 -0500
Received: (qmail 5384 invoked by uid 109); 16 Dec 2018 16:19:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Dec 2018 16:19:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24303 invoked by uid 111); 16 Dec 2018 16:18:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 16 Dec 2018 11:18:53 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Dec 2018 11:19:19 -0500
Date:   Sun, 16 Dec 2018 11:19:19 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] A few Asciidoctor-fixes
Message-ID: <20181216161919.GB1511@sigill.intra.peff.net>
References: <20181216105944.GG13704@sigill.intra.peff.net>
 <cover.1544969984.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1544969984.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 16, 2018 at 03:28:56PM +0100, Martin Ågren wrote:

> This series addresses a few instances where our documentation renders
> badly in Asciidoctor, compared to Asciidoc. The changes made are exactly
> the same as in v1 [1], but the first commit message is corrected, and
> the two patches 2/4 and 3/4 are now just a single patch 2/3.
> 
> Thanks Peff for your comments on v1.

Thanks, this all looks quite sensible to me (I didn't hack up doc-diff
as you did, but I did eyeball the before/after html from asciidoctor).

-Peff
