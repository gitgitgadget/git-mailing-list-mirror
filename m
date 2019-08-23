Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB0061F461
	for <e@80x24.org>; Fri, 23 Aug 2019 06:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392235AbfHWGAk (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Aug 2019 02:00:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:53418 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2392206AbfHWGAk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Aug 2019 02:00:40 -0400
Received: (qmail 12980 invoked by uid 109); 23 Aug 2019 06:00:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Aug 2019 06:00:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29863 invoked by uid 111); 23 Aug 2019 06:01:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Aug 2019 02:01:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Aug 2019 02:00:39 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] packfile.h: drop extern from function declaration
Message-ID: <20190823060038.GB10806@sigill.intra.peff.net>
References: <58862d9d6f4eb1af7ac6a09a703c2ace66917ee3.1566195817.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58862d9d6f4eb1af7ac6a09a703c2ace66917ee3.1566195817.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 19, 2019 at 02:26:19AM -0400, Denton Liu wrote:

> In 336226c259 (packfile.h: drop extern from function declarations,
> 2019-04-05), `extern` was removed from function declarations because
> it's redundant. However, in 8434e85d5f (repack: refactor pack deletion
> for future use, 2019-06-10), an `extern` was mistakenly included.
> 
> Remove this spurious `extern`.

Thanks. This looks obviously correct.

-Peff
