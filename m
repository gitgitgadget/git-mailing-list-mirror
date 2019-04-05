Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59B1D20248
	for <e@80x24.org>; Fri,  5 Apr 2019 18:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbfDESTD (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 14:19:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:48806 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728683AbfDESTD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 14:19:03 -0400
Received: (qmail 11598 invoked by uid 109); 5 Apr 2019 18:19:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 18:19:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28497 invoked by uid 111); 5 Apr 2019 18:19:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Apr 2019 14:19:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2019 14:19:01 -0400
Date:   Fri, 5 Apr 2019 14:19:01 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v2 0/13] a rabbit hole of update-server-info (and midx!)
 fixes
Message-ID: <20190405181900.GB2284@sigill.intra.peff.net>
References: <20190404232104.GA27770@sigill.intra.peff.net>
 <20190405180306.GA21113@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190405180306.GA21113@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 05, 2019 at 02:03:06PM -0400, Jeff King wrote:

> Other than that, it's substantially the same as v1. I did move the
> public declaration of pack_basename() to the patch where it is added,
> rather than doing it later, which shows up in the range diff below.

Sorry, two things I noticed and fixed up while sending out the patches
themselves, but which were too late to be in the cover letter or range
diff:

>   [03/13]: t5319: fix bogus cat-file argument

This fixes the flipped unsorted/unordered words in the commit message,
noticed by Ramsay.

>   [07/13]: http: simplify parsing of remote objects/info/packs

This drops the incorrect claim in the commit message noticed by René.

-Peff
