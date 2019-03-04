Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2E1520248
	for <e@80x24.org>; Mon,  4 Mar 2019 21:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfCDVns (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 16:43:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:38442 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726038AbfCDVns (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 16:43:48 -0500
Received: (qmail 29583 invoked by uid 109); 4 Mar 2019 21:43:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 Mar 2019 21:43:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26350 invoked by uid 111); 4 Mar 2019 21:44:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 04 Mar 2019 16:44:04 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Mar 2019 16:43:46 -0500
Date:   Mon, 4 Mar 2019 16:43:46 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] Makefile: use `git ls-files` to list header
 files, if possible
Message-ID: <20190304214346.GC3347@sigill.intra.peff.net>
References: <pull.130.git.gitgitgadget@gmail.com>
 <pull.130.v2.git.gitgitgadget@gmail.com>
 <cb253bd0cf2896cf31516079a89ec2dab21032cf.1551707225.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cb253bd0cf2896cf31516079a89ec2dab21032cf.1551707225.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 04, 2019 at 05:47:06AM -0800, Johannes Schindelin via GitGitGadget wrote:

> Therefore, just like in 335339758c (Makefile: ask "ls-files" to list
> source files if available, 2011-10-18), we now prefer to use `git
> ls-files` to enumerate the header files to enumerating them via `find`,
> falling back to the latter if the former failed (which would be the case
> e.g. in a worktree that was extracted from a source .tar file rather
> than from a clone of Git's sources).

Thanks, this version looks good to me, and seems like an obvious first
step regardless of whether we want to later push it into a sub-make.

-Peff
