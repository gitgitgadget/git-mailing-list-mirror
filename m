Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 501C21F45C
	for <e@80x24.org>; Thu, 15 Aug 2019 13:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732646AbfHON4a (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 09:56:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:44324 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732589AbfHON4a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 09:56:30 -0400
Received: (qmail 1772 invoked by uid 109); 15 Aug 2019 13:56:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Aug 2019 13:56:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26358 invoked by uid 111); 15 Aug 2019 13:57:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Aug 2019 09:57:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Aug 2019 09:56:28 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Hong Xu <hong@topbug.net>,
        git@vger.kernel.org
Subject: Re: [PATCH] diff: 'diff.indentHeuristic' is no longer experimental
Message-ID: <20190815135628.GA27091@sigill.intra.peff.net>
References: <58aafeaa-72b0-25ce-27b6-f8480fe48b5e@topbug.net>
 <20190815091245.16525-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190815091245.16525-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 15, 2019 at 11:12:45AM +0200, SZEDER Gábor wrote:

> The indent heuristic started out as experimental, but it's now our
> default diff heuristic since 33de716387 (diff: enable indent heuristic
> by default, 2017-05-08).  Alas, that commit didn't update the
> documentation, and the description of the 'diff.indentHeuristic'
> configuration variable still implies that it's experimental and not
> the default.
> 
> Update the description of 'diff.indentHeuristic' to make it clear that
> it's the default diff heuristic.
> 
> The description of the related '--indent-heuristic' option has already
> been updated in bab76141da (diff: --indent-heuristic is no
> longer experimental, 2017-10-29).

Yeah, this makes perfect sense.

I wondered briefly if we needed to distinguish between plumbing and
porcelain here, but the config option (and its default) are the same for
both.

-Peff
