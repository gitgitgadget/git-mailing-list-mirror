Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C56551F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 19:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfJaTaT (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 15:30:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:35302 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726940AbfJaTaT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 15:30:19 -0400
Received: (qmail 19347 invoked by uid 109); 31 Oct 2019 19:30:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 31 Oct 2019 19:30:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4598 invoked by uid 111); 31 Oct 2019 19:33:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Oct 2019 15:33:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Oct 2019 15:30:18 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Olaf Hering <olaf@aepfle.de>, git@vger.kernel.org
Subject: Re: git fsck, badDate: invalid author/committer line - bad date
Message-ID: <20191031193018.GB12834@sigill.intra.peff.net>
References: <20191031092749.074ed112.olaf@aepfle.de>
 <20191031101539.GY4348@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191031101539.GY4348@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 31, 2019 at 11:15:39AM +0100, SZEDER Gábor wrote:

> However, I don't know how to tell about the skiplist file to GitHub,
> or any other Git hosting service for that matter.

You can contact GitHub support. The usual procedure is:

  1. Find out if rewriting is an option (i.e., if the history isn't
     already widely published), and walk the user through cleaning up
     the history if that's an option.

  2. For established history, we'll sometimes relax the fsck checks
     temporarily to allow it to be pushed (it depends on the exact
     failing check, but this one is mostly cosmetic and would be OK).

-Peff
