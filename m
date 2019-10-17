Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5735C1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 05:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394575AbfJQFoQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 01:44:16 -0400
Received: from cloud.peff.net ([104.130.231.41]:50436 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731603AbfJQFoQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 01:44:16 -0400
Received: (qmail 19904 invoked by uid 109); 17 Oct 2019 05:44:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Oct 2019 05:44:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6000 invoked by uid 111); 17 Oct 2019 05:47:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Oct 2019 01:47:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Oct 2019 01:44:14 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] doc: dissuade users from trying to ignore tracked
 files
Message-ID: <20191017054414.GB10253@sigill.intra.peff.net>
References: <20191017005330.9021-1-sandals@crustytoothpaste.net>
 <20191017005330.9021-3-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191017005330.9021-3-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 17, 2019 at 12:53:29AM +0000, brian m. carlson wrote:

> There is no sensible behavior in this case, because sometimes the data
> is precious, such as certain configuration files, and sometimes it is
> irrelevant data that the user would be happy to discard.
> 
> Since this is not a supported configuration and users are prone to
> misuse the existing features for unintended purposes, causing general
> sadness and confusion, let's document the existing behavior and the
> pitfalls in the documentation for git update-index so that users know
> they should explore alternate solutions.

I think this is an improvement. It would be nice if we had some specific
alternatives to point them to. But as you note, Git doesn't really have
a good solution for this built-in. And I don't know offhand of a
complete one that we could recommend. So this is probably the best we
can do for now.

-Peff
