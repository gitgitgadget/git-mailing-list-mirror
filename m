Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C8D1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 12:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbeKLWQm (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 17:16:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:35332 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726725AbeKLWQm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 17:16:42 -0500
Received: (qmail 23573 invoked by uid 109); 12 Nov 2018 12:23:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 12:23:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10158 invoked by uid 111); 12 Nov 2018 12:22:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 07:22:59 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 07:23:38 -0500
Date:   Mon, 12 Nov 2018 07:23:38 -0500
From:   Jeff King <peff@peff.net>
To:     nbelakovski@gmail.com
Cc:     rafa.almas@gmail.com, avarab@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ref-filter: add worktree atom
Message-ID: <20181112122337.GC3956@sigill.intra.peff.net>
References: <20180927204049.GA2628@rigel>
 <20181111235831.44824-1-nbelakovski@gmail.com>
 <20181111235831.44824-2-nbelakovski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181111235831.44824-2-nbelakovski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 11, 2018 at 03:58:30PM -0800, nbelakovski@gmail.com wrote:

> From: Nickolai Belakovski <nbelakovski@gmail.com>
> 
> Add an atom expressing whether the particular ref is checked out in a
> linked worktree.
> 
> Signed-off-by: Nickolai Belakovski <nbelakovski@gmail.com>
> ---
>  ref-filter.c                   | 31 +++++++++++++++++++++++++++++++
>  t/t6302-for-each-ref-filter.sh | 15 +++++++++++++++
>  2 files changed, 46 insertions(+)

I left some more comments elsewhere in the thread, but one more thing to
note: this probably needs to touch Documentation/git-for-each-ref.txt to
describe the new placeholder.

-Peff
