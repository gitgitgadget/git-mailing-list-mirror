Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B48081F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 05:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfACFmK (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 00:42:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:53496 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725976AbfACFmK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 00:42:10 -0500
Received: (qmail 20532 invoked by uid 109); 3 Jan 2019 05:42:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 03 Jan 2019 05:42:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7649 invoked by uid 111); 3 Jan 2019 05:41:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 03 Jan 2019 00:41:47 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jan 2019 00:42:08 -0500
Date:   Thu, 3 Jan 2019 00:42:08 -0500
From:   Jeff King <peff@peff.net>
To:     nbelakovski@gmail.com
Cc:     git@vger.kernel.org, rafa.almas@gmail.com, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v4 3/3] branch: Add an extra verbose output displaying
 worktree path for refs checked out in a linked worktree
Message-ID: <20190103054208.GH20047@sigill.intra.peff.net>
References: <20181220145931.GB27361@sigill.intra.peff.net>
 <20181224084756.49952-1-nbelakovski@gmail.com>
 <20181224084756.49952-4-nbelakovski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181224084756.49952-4-nbelakovski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 24, 2018 at 12:47:56AM -0800, nbelakovski@gmail.com wrote:

> From: Nickolai Belakovski <nbelakovski@gmail.com>
> 
> ---
>  builtin/branch.c | 4 ++++
>  1 file changed, 4 insertions(+)

This patch should describe the new behavior in Documentation/git-branch.txt,
I'd think.

-Peff
