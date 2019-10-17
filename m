Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C70021F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 05:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394134AbfJQFkx (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 01:40:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:50416 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731603AbfJQFkx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 01:40:53 -0400
Received: (qmail 19802 invoked by uid 109); 17 Oct 2019 05:40:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Oct 2019 05:40:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5981 invoked by uid 111); 17 Oct 2019 05:43:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Oct 2019 01:43:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Oct 2019 01:40:52 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] doc: provide guidance on user.name format
Message-ID: <20191017054051.GA10253@sigill.intra.peff.net>
References: <20191017005330.9021-1-sandals@crustytoothpaste.net>
 <20191017005330.9021-2-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191017005330.9021-2-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 17, 2019 at 12:53:28AM +0000, brian m. carlson wrote:

> It's a frequent misconception that the user.name variable controls
> authentication in some way, and as a result, beginning users frequently
> attempt to change it when they're having authentication troubles.
> Document that the convention is that this variable represents some form
> of a human's personal name, although that is not required.  In addition,
> address concerns about whether Unicode is supported.
> 
> Use the term "personal name" as this is likely to draw the intended
> contrast, be applicable across cultures which may have different naming
> conventions, and be easily understandable to people who do not speak
> English as their first language.  Indicate that "some form" is
> conventionally used, as people may use a nickname or preferred name
> instead of a full legal name.
> 
> Point users who may be confused about authentication to an appropriate
> configuration option instead.

I think this is a good distinction to draw, but...

>  Documentation/git-commit-tree.txt | 6 ++++++
>  1 file changed, 6 insertions(+)

...I was surprised to see it here, where I think most users wouldn't
find it. Would it make sense in git-commit(1), or in the description of
the user.name config?

-Peff
