Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85FCC1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 06:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392562AbfJQGqq (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 02:46:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:50556 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2389340AbfJQGqp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 02:46:45 -0400
Received: (qmail 21766 invoked by uid 109); 17 Oct 2019 06:46:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 17 Oct 2019 06:46:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6366 invoked by uid 111); 17 Oct 2019 06:49:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 17 Oct 2019 02:49:50 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 17 Oct 2019 02:46:44 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: Git Test Coverage Report (October 11)
Message-ID: <20191017064644.GA12915@sigill.intra.peff.net>
References: <c863c09b-f0ed-19c6-356e-12a3ecbc08b9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c863c09b-f0ed-19c6-356e-12a3ecbc08b9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 09:33:11AM -0400, Derrick Stolee wrote:

> Here is today's test coverage report. The usual report format is
> available online [1], [2]. The report listed below is a new format
> that groups lines by the commit that introduced them [3]. Thanks
> Peff for the feedback on that idea.

Thanks. FWIW, I did find this one easier to scan through looking for my
own bits.

-Peff
