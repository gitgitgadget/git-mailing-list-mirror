Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F5FE1F405
	for <e@80x24.org>; Tue, 18 Dec 2018 17:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbeLRRfm (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 12:35:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:45146 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726719AbeLRRfm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 12:35:42 -0500
Received: (qmail 1826 invoked by uid 109); 18 Dec 2018 17:35:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Dec 2018 17:35:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15118 invoked by uid 111); 18 Dec 2018 17:35:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Dec 2018 12:35:14 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Dec 2018 12:35:40 -0500
Date:   Tue, 18 Dec 2018 12:35:40 -0500
From:   Jeff King <peff@peff.net>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        avarab@gmail.com, szeder.dev@gmail.com
Subject: Re: [PATCH v4 0/3] Add commit-graph fuzzer and fix buffer overflow
Message-ID: <20181218173539.GA31070@sigill.intra.peff.net>
References: <cover.1544048946.git.steadmon@google.com>
 <cover.1544729841.git.steadmon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1544729841.git.steadmon@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 11:43:55AM -0800, Josh Steadmon wrote:

> Add a new fuzz test for the commit graph and fix a buffer read-overflow
> that it discovered. Additionally, fix the Makefile instructions for
> building fuzzers.
> 
> Changes since V3:
>   * Improve portability of the new test functionality.

I thought there was some question about /dev/zero, which I think is
in this version (I don't actually know whether there are portability
issues or not, but somebody did mention it).

-Peff
