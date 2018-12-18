Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F5A81F405
	for <e@80x24.org>; Tue, 18 Dec 2018 17:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeLRRZr (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 12:25:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:45118 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727298AbeLRRZr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Dec 2018 12:25:47 -0500
Received: (qmail 1199 invoked by uid 109); 18 Dec 2018 17:25:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 18 Dec 2018 17:25:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14950 invoked by uid 111); 18 Dec 2018 17:25:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 18 Dec 2018 12:25:18 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Dec 2018 12:25:44 -0500
Date:   Tue, 18 Dec 2018 12:25:44 -0500
From:   Jeff King <peff@peff.net>
To:     nbelakovski@gmail.com
Cc:     git@vger.kernel.org, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v3 0/3]
Message-ID: <20181218172544.GB28455@sigill.intra.peff.net>
References: <20181111235831.44824-1-nbelakovski@gmail.com>
 <20181216215759.24011-1-nbelakovski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181216215759.24011-1-nbelakovski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 16, 2018 at 01:57:56PM -0800, nbelakovski@gmail.com wrote:

> Finally got around to submitting latest changes.
> 
> I think this addresses all the feedback
> 
> The atom now returns the worktree path instead of '+'

Thanks, I think patch 1 is definitely going in the right direction.
There are a few issues I found in its implementation, but they should be
easy to fix (and won't affect the other patches).

I don't really have a strong opinion on the behavior of the other
patches.

-Peff
