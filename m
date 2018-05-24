Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65A2B1F42D
	for <e@80x24.org>; Thu, 24 May 2018 17:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034074AbeEXRGD (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 13:06:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:51610 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1034052AbeEXRGC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 13:06:02 -0400
Received: (qmail 4889 invoked by uid 109); 24 May 2018 17:06:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 May 2018 17:06:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27267 invoked by uid 111); 24 May 2018 17:06:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 May 2018 13:06:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2018 13:06:00 -0400
Date:   Thu, 24 May 2018 13:06:00 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, B.Steinbrink@gmx.de,
        sbejar@gmail.com
Subject: Re: [PATCH v2] rev-parse: check lookup'ed commit references for NULL
Message-ID: <20180524170600.GB14876@sigill.intra.peff.net>
References: <20180523220915.GB32171@sigill.intra.peff.net>
 <20180524062733.5412-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180524062733.5412-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 23, 2018 at 11:27:33PM -0700, Elijah Newren wrote:

> Commits 2122f8b963d4 ("rev-parse: Add support for the ^! and ^@ syntax",
> 2008-07-26) and 3dd4e7320d ("Teach rev-parse the ... syntax.", 2006-07-04)
> taught rev-parse new syntax, and used lookup_commit_reference() as part of
> their logic.  Neither usage checked the returned commit to see if it was
> non-NULL before using it.  Check for NULL and ensure an appropriate error
> is reported to the user.
> 
> Reported by Florian Weimer and Todd Zullinger.
> 
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Elijah Newren <newren@gmail.com>

This version looks good to me. Thanks for taking care of this!

-Peff
