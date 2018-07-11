Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA4611F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 14:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732461AbeGKPDb (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 11:03:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:55332 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726340AbeGKPDa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 11:03:30 -0400
Received: (qmail 11767 invoked by uid 109); 11 Jul 2018 14:58:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 11 Jul 2018 14:58:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7725 invoked by uid 111); 11 Jul 2018 14:58:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 11 Jul 2018 10:58:49 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jul 2018 10:58:45 -0400
Date:   Wed, 11 Jul 2018 10:58:45 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Fix occasional test failures in http tests
Message-ID: <20180711145845.GC15269@sigill.intra.peff.net>
References: <20180614123107.11608-1-szeder.dev@gmail.com>
 <20180711125647.16512-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180711125647.16512-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 11, 2018 at 02:56:44PM +0200, SZEDER Gábor wrote:

> 't5561-http-backend.sh' is prone to occasional failures; luckily it's
> not 'git-http-backend's fault, but the test script is a bit racy.  I
> won't go into the details here, patch 3/3's commit message discusses
> it at length.
> 
> v1 is here; it haven't been picked up by Junio:
> 
>   https://public-inbox.org/git/20180614123107.11608-1-szeder.dev@gmail.com/T/#u
> 
> The first two patches are identical to those in v1, and the last patch
> implements a different and simpler fix than in v1, following Peff's
> suggestion.  The third patch was dropped, because it's not necessary for
> this simpler fix.

The first two look obviously correct as before. I picked a few minor
nits in the third one. But if your response is "no, I prefer it the way
I wrote it", then I am perfectly happy seeing it applied as-is.

Thanks for finishing this up.

-Peff
