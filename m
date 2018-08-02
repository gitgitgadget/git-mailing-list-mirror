Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99E0E1F597
	for <e@80x24.org>; Thu,  2 Aug 2018 19:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeHBV1w (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 17:27:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:40850 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726590AbeHBV1w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 17:27:52 -0400
Received: (qmail 24245 invoked by uid 109); 2 Aug 2018 19:35:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 02 Aug 2018 19:35:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27390 invoked by uid 111); 2 Aug 2018 19:35:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 02 Aug 2018 15:35:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Aug 2018 15:35:18 -0400
Date:   Thu, 2 Aug 2018 15:35:18 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] pack-objects: document about thread synchronization
Message-ID: <20180802193518.GA29084@sigill.intra.peff.net>
References: <20180729153605.27298-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180729153605.27298-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 29, 2018 at 05:36:05PM +0200, Nguyễn Thái Ngọc Duy wrote:

> These extra comments should be make it easier to understand how to use
> locks in pack-objects delta search code. For reference, see
> 
> 8ecce684a3 (basic threaded delta search - 2007-09-06)
> 384b32c09b (pack-objects: fix threaded load balancing - 2007-12-08)
> 50f22ada52 (threaded pack-objects: Use condition... - 2007-12-16)

Thanks, I think this is an improvement.

-Peff
