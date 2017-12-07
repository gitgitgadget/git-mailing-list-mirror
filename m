Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 746C420954
	for <e@80x24.org>; Thu,  7 Dec 2017 21:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbdLGVNB (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 16:13:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:51444 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750993AbdLGVNA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 16:13:00 -0500
Received: (qmail 31098 invoked by uid 109); 7 Dec 2017 21:13:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Dec 2017 21:13:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26481 invoked by uid 111); 7 Dec 2017 21:13:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Thu, 07 Dec 2017 16:13:21 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Dec 2017 16:12:58 -0500
Date:   Thu, 7 Dec 2017 16:12:58 -0500
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] diff: add tests for --relative without optional prefix
 value
Message-ID: <20171207211258.GB12850@sigill.intra.peff.net>
References: <20171207190135.28660-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171207190135.28660-1-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 07, 2017 at 11:01:35AM -0800, Jacob Keller wrote:

> From: Jacob Keller <jacob.keller@gmail.com>
> 
> We already have tests for --relative, but they currently only test when
> a prefix has been provided. This fails to test the case where --relative
> by itself should use the current directory as the prefix.
> 
> Teach the check_$type functions to take a directory argument to indicate
> which subdirectory to run the git commands in. Add a new test which uses
> this to test --relative without a prefix value.

This looks good to me (and I slightly prefer it over Junio's for the
simplicity).

I agree on the ordering suggestion Junio made.

-Peff
