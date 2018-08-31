Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6888B1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 20:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeIAARY (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 20:17:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:35692 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727249AbeIAARY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 20:17:24 -0400
Received: (qmail 30766 invoked by uid 109); 31 Aug 2018 20:08:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 31 Aug 2018 20:08:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8396 invoked by uid 111); 31 Aug 2018 20:08:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 31 Aug 2018 16:08:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 31 Aug 2018 16:08:20 -0400
Date:   Fri, 31 Aug 2018 16:08:20 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] doc-diff: add "clean" mode & fix portability problem
Message-ID: <20180831200819.GE5120@sigill.intra.peff.net>
References: <20180830195546.GA22407@sigill.intra.peff.net>
 <20180831063318.33373-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180831063318.33373-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 31, 2018 at 02:33:15AM -0400, Eric Sunshine wrote:

> This series replaces Peff's solo patch[1] which updates "make clean" to
> remove doc-diff's temporary directory. Rather than imbuing the Makefile
> with knowledge specific to doc-diff's internals, this series adds a
> "clean" mode to doc-diff which removes its temporary worktree and
> generated files, and has "make clean" invoke that instead. It also fixes
> a portability problem which prevented doc-diff from working on MacOS and
> FreeBSD.

Thanks. I left a few comments, but this looks good to me as-is.

-Peff
