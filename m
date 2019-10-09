Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58D931F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 20:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731144AbfJIUit (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 16:38:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:43816 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730955AbfJIUit (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 16:38:49 -0400
Received: (qmail 26983 invoked by uid 109); 9 Oct 2019 20:38:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 09 Oct 2019 20:38:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17222 invoked by uid 111); 9 Oct 2019 20:41:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Oct 2019 16:41:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Oct 2019 16:38:48 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] xdiffi: fix typos and touch up comments
Message-ID: <20191009203847.GB7007@sigill.intra.peff.net>
References: <pull.380.git.gitgitgadget@gmail.com>
 <cb677310cecd52e853055e93a75b365a1d133968.1570559270.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb677310cecd52e853055e93a75b365a1d133968.1570559270.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 08, 2019 at 11:27:52AM -0700, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Inspired by the thoroughly stale https://github.com/git/git/pull/159,
> this patch fixes a couple of typos, rewraps and clarifies some comments.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  xdiff/xdiffi.c | 99 ++++++++++++++++++++++++++++----------------------
>  1 file changed, 55 insertions(+), 44 deletions(-)

I scanned through these with diff-highlight, and they all look good to
me!

-Peff
