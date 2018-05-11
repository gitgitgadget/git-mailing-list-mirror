Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF7B91F42D
	for <e@80x24.org>; Fri, 11 May 2018 08:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752713AbeEKI7f (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 04:59:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:35988 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751406AbeEKI7e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 04:59:34 -0400
Received: (qmail 21846 invoked by uid 109); 11 May 2018 08:59:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 May 2018 08:59:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31689 invoked by uid 111); 11 May 2018 08:59:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 11 May 2018 04:59:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 May 2018 04:59:32 -0400
Date:   Fri, 11 May 2018 04:59:32 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>
Subject: Re: [PATCH v2] commit-graph: fix UX issue when .lock file exists
Message-ID: <20180511085932.GD22086@sigill.intra.peff.net>
References: <20180509141523.89896-1-dstolee@microsoft.com>
 <20180510174242.44346-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180510174242.44346-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 10, 2018 at 05:42:52PM +0000, Derrick Stolee wrote:

> We use the lockfile API to avoid multiple Git processes from writing to
> the commit-graph file in the .git/objects/info directory. In some cases,
> this directory may not exist, so we check for its existence.
> [...]

This version looks good to me. Thanks!

-Peff
