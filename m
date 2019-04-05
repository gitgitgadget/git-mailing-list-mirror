Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B79FD20248
	for <e@80x24.org>; Fri,  5 Apr 2019 01:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfDEBlN (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Apr 2019 21:41:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:47640 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729635AbfDEBlN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Apr 2019 21:41:13 -0400
Received: (qmail 3063 invoked by uid 109); 5 Apr 2019 01:41:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 01:41:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21569 invoked by uid 111); 5 Apr 2019 01:41:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 04 Apr 2019 21:41:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Apr 2019 21:41:10 -0400
Date:   Thu, 4 Apr 2019 21:41:10 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/12] t5319: fix bogus cat-file argument
Message-ID: <20190405014110.GA25017@sigill.intra.peff.net>
References: <20190404232104.GA27770@sigill.intra.peff.net>
 <20190404232203.GA21839@sigill.intra.peff.net>
 <69f35074-7f83-ea74-41be-c6ea079a9de8@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69f35074-7f83-ea74-41be-c6ea079a9de8@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 05, 2019 at 01:44:09AM +0100, Ramsay Jones wrote:

> 
> 
> On 05/04/2019 00:22, Jeff King wrote:
> > There's no such argument as "--unordered"; it's spelled "--unsorted".
> 
> Err, isn't this back-to-front? (i.e. cat-file has the _option_
> "--unordered" but not "--unsorted").

Oops, yes. The patch is right; we are going the other way.

Sorry for the confusion.

-Peff
