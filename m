Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3209C1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 14:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732720AbfILOnW (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 10:43:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:47928 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732654AbfILOnW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 10:43:22 -0400
Received: (qmail 13946 invoked by uid 109); 12 Sep 2019 14:43:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Sep 2019 14:43:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8281 invoked by uid 111); 12 Sep 2019 14:45:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Sep 2019 10:45:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Sep 2019 10:43:21 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] upload-pack commit graph segfault fix
Message-ID: <20190912144320.GA30725@sigill.intra.peff.net>
References: <20190912000414.GA31334@sigill.intra.peff.net>
 <20190912144122.GA27815@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190912144122.GA27815@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 12, 2019 at 10:41:22AM -0400, Jeff King wrote:

> Here's a re-roll of my "disable commit graph more gently" fix. Versus
> v1:
> 
>   - I've included a preparatory patch that speeds up
>     prepare_commit_graph(). It's not strictly related, but there's a
>     textual dependency. It could be easily spun off to its own series.

I _didn't_ include here the other speedup from this thread:

  https://public-inbox.org/git/20190912011137.GA23412@sigill.intra.peff.net/

That's worth doing, but is totally independent (conceptually and
textually).

-Peff
