Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90AF61F87F
	for <e@80x24.org>; Thu, 15 Nov 2018 11:08:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbeKOVP1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 16:15:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:40390 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725827AbeKOVP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 16:15:27 -0500
Received: (qmail 17188 invoked by uid 109); 15 Nov 2018 11:08:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Nov 2018 11:08:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14279 invoked by uid 111); 15 Nov 2018 11:07:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Nov 2018 06:07:25 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2018 06:08:02 -0500
Date:   Thu, 15 Nov 2018 06:08:02 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/3] clone: respect configured fetch respecs during
 initial fetch
Message-ID: <20181115110802.GD19032@sigill.intra.peff.net>
References: <20181114104620.32478-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181114104620.32478-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 14, 2018 at 11:46:17AM +0100, SZEDER Gábor wrote:

> This patch series should have been marked as v6, but I chose to reset
> the counter, because:
> 
>   - v5 was sent out way over a year ago [1], and surely everybody has
>     forgotten about it since then anyway.  But more importantly:
> 
>   - A lot has happened since then, most notably we now have a refspec
>     API, which makes this patch series much simpler (now it only
>     touches 'builtin/clone.c', the previous version had to add stuff
>     to 'remote.{c,h}' as well).

Thanks for sticking with this!

I skimmed over the old discussion, mostly just to make sure there wasn't
anything subtle that might have been forgotten. But nope, all of the
subtlety went away because of the refspec API you mentioned.

The whole series looks good to me.

-Peff
