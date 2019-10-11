Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2E2C1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 06:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfJKGE6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 02:04:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:45380 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726401AbfJKGE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 02:04:58 -0400
Received: (qmail 13134 invoked by uid 109); 11 Oct 2019 06:04:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Oct 2019 06:04:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30402 invoked by uid 111); 11 Oct 2019 06:07:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Oct 2019 02:07:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Oct 2019 02:04:57 -0400
From:   Jeff King <peff@peff.net>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] git-rev-list.txt: prune options in synopsis
Message-ID: <20191011060457.GC20094@sigill.intra.peff.net>
References: <645cc54c4c86493c855ec6b0b892a0bc8e999249.1570234118.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <645cc54c4c86493c855ec6b0b892a0bc8e999249.1570234118.git.liu.denton@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 04, 2019 at 05:13:08PM -0700, Denton Liu wrote:

> The synopsis section in git-rev-list.txt has grown to be a huge list
> that probably needs its own synopsis. Since the list is huge, users may
> be given the false impression that the list is complete, however it is
> not. It is missing many of the available options.
> 
> Since the list of options in the synopsis is not only annoying but
> actively harmful, replace it with `[<options>]` so users know to
> explicitly look through the documentation for further information.
> 
> While we're at it, update the optional path notation so that it is more
> modern.

Yes, thank you! This has bugged me for a while. I suspect there are
other pages that could use similar treatment, but I don't mind at all
doing it incrementally.

(One of them is git-branch, where I think the synopsis should focus on
showing the major modes and not listing every possible branch-listing
option).

-Peff
