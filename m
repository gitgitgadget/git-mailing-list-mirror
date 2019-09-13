Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23D1E1F463
	for <e@80x24.org>; Fri, 13 Sep 2019 05:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfIMFIL (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 01:08:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:48920 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726389AbfIMFIL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 01:08:11 -0400
Received: (qmail 24389 invoked by uid 109); 13 Sep 2019 05:08:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Sep 2019 05:08:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14595 invoked by uid 111); 13 Sep 2019 05:10:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Sep 2019 01:10:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Sep 2019 01:08:10 -0400
From:   Jeff King <peff@peff.net>
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] Date test code clean-up
Message-ID: <20190913050809.GA28353@sigill.intra.peff.net>
References: <20190909014711.3894-1-ischis2@cox.net>
 <20190912041102.16266-1-ischis2@cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190912041102.16266-1-ischis2@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 11, 2019 at 09:11:00PM -0700, Stephen P. Smith wrote:

> Range Diff:
> 1:  f4170ad553 ! 1:  e2b8322d58 Quit passing 'now' to date code
> [...]

Thanks, this version addresses all of my concerns from v1 (and overall
looks good).

-Peff
