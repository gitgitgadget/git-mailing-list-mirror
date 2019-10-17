Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 871321F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 05:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394044AbfJQFw5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 01:52:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:50446 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2392533AbfJQFw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 01:52:56 -0400
Received: (qmail 20170 invoked by uid 109); 17 Oct 2019 05:52:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Oct 2019 05:52:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6033 invoked by uid 111); 17 Oct 2019 05:56:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Oct 2019 01:56:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Oct 2019 01:52:55 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] docs: mention when increasing http.postBuffer is
 valuable
Message-ID: <20191017055254.GC10253@sigill.intra.peff.net>
References: <20191017005330.9021-1-sandals@crustytoothpaste.net>
 <20191017005330.9021-4-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191017005330.9021-4-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 17, 2019 at 12:53:30AM +0000, brian m. carlson wrote:

> Users in a wide variety of situations find themselves with HTTP push
> problems.  Oftentimes these issues are due to antivirus software,
> filtering proxies, or other man-in-the-middle situations; other times,
> they are due to simple unreliability of the network.
> 
> However, a common solution to HTTP push problems found online is to
> increase http.postBuffer.  This works for none of the aforementioned
> situations and is only useful in a small, highly restricted number of
> cases: essentially, when the connection does not properly support
> HTTP/1.1.
> 
> Document when raising this value is appropriate and what it actually
> does, and discourage people from using it as a general solution for push
> problems, since it is not effective there.

Yeah, I've run into some voodoo advice about this config option before.
I think your advice neatly explains the situation.

-Peff
