Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C71C1F732
	for <e@80x24.org>; Mon,  5 Aug 2019 04:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbfHEEVG (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 00:21:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:33782 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725613AbfHEEVG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 00:21:06 -0400
Received: (qmail 4560 invoked by uid 109); 5 Aug 2019 04:21:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 05 Aug 2019 04:21:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22458 invoked by uid 111); 5 Aug 2019 04:23:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 05 Aug 2019 00:23:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 5 Aug 2019 00:21:04 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v2] l10n: reformat some localized strings for v2.23.0
Message-ID: <20190805042104.GA30941@sigill.intra.peff.net>
References: <20190730033512.7226-1-worldhello.net@gmail.com>
 <20190803195907.3124-1-jn.avila@free.fr>
 <20190803234522.GA5417@sigill.intra.peff.net>
 <5200616.dDItsc6b64@cayenne>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5200616.dDItsc6b64@cayenne>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 04, 2019 at 01:01:51PM +0200, Jean-Noël AVILA wrote:

> This one is not about typos.
> 
> My original fix was more concerning the second sequence, where the
> sentence is broken in the middle, simply for better rendering but this
> does not make sense either, because the lines are too long anyway.

Ah, yeah, the sentence broken over the line is pretty bad for
translation. And I agree the lines are overly long.

> Is it so important that the lines of warning all start with a
> "warning:" prefix?

For some definition of "so". ;) As I said, I think your patch may be the
lesser of two evils, and we should take it until warning() learns to
handle lines breaks better.

-Peff
