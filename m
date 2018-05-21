Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D98941F51C
	for <e@80x24.org>; Mon, 21 May 2018 21:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754545AbeEUViI (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 17:38:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:48384 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754580AbeEUViG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 17:38:06 -0400
Received: (qmail 32170 invoked by uid 109); 21 May 2018 21:38:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 21 May 2018 21:38:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31927 invoked by uid 111); 21 May 2018 21:38:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 21 May 2018 17:38:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2018 17:38:04 -0400
Date:   Mon, 21 May 2018 17:38:04 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v5 0/4] unpack_trees_options: free messages when done
Message-ID: <20180521213804.GA16285@sigill.intra.peff.net>
References: <xmqqr2m53leq.fsf@gitster-ct.c.googlers.com>
 <cover.1526913784.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1526913784.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 21, 2018 at 04:54:24PM +0200, Martin Ågren wrote:

> That is, I've replaced the `string_list_appendf()`-patch with Junio's
> `argv_push*()`-patch, then squashed Junio's "redoing the 4/4"-patch into
> patch 4/4 -- with the exception of keeping the `memset(opts->msgs, ...)`
> which I suspect was mistakenly dropped.
> 
> Again, thanks for all the helpful comments and patches pointing me in
> the right direction.

I like it. Thanks for seeing it through. That was a lot of
back-and-forth for a small cleanup, but I hope we've established a
pattern that can be used elsewhere.

-Peff
