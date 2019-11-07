Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43D0A1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 06:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfKGGGH (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 01:06:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:41682 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725893AbfKGGGH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 01:06:07 -0500
Received: (qmail 28934 invoked by uid 109); 7 Nov 2019 06:06:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Nov 2019 06:06:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32202 invoked by uid 111); 7 Nov 2019 06:09:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Nov 2019 01:09:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 Nov 2019 01:06:05 -0500
From:   Jeff King <peff@peff.net>
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 5/8] sequencer: reencode revert/cherry-pick's todo list
Message-ID: <20191107060605.GD6431@sigill.intra.peff.net>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1573094789.git.congdanhqx@gmail.com>
 <304ac6c28972a7bec9c5c7b5e2ae3c107161e84f.1573094789.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <304ac6c28972a7bec9c5c7b5e2ae3c107161e84f.1573094789.git.congdanhqx@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 07, 2019 at 09:56:16AM +0700, Doan Tran Cong Danh wrote:

> Keep revert/cherry-pick's todo list in line with rebase todo list.

I think this is the right thing to do, but it might bear a little more
explanation. Maybe:

  The user may see this todo list in their editor, so we should output
  it in the encoding they generally expect to see, not whatever encoding
  the commit was originally in. This also matches the behavior of the
  rebase todo list.

-Peff
