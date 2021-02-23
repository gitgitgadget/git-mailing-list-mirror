Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268C2C433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E292960231
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 19:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbhBWTGu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 14:06:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:42042 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232549AbhBWTGt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 14:06:49 -0500
Received: (qmail 26923 invoked by uid 109); 23 Feb 2021 19:06:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Feb 2021 19:06:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2807 invoked by uid 111); 23 Feb 2021 19:06:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Feb 2021 14:06:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Feb 2021 14:06:08 -0500
From:   Jeff King <peff@peff.net>
To:     Utku Gultopu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Utku Gultopu <ugultopu@gmail.com>
Subject: Re: [PATCH v2] doc: `--date` in `git-commit` accepts approxidates
Message-ID: <YDVSICgBwPLtDNu4@coredump.intra.peff.net>
References: <pull.969.git.git.1614101746491.gitgitgadget@gmail.com>
 <pull.969.v2.git.git.1614106322760.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.969.v2.git.git.1614106322760.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 06:52:02PM +0000, Utku Gultopu via GitGitGadget wrote:

> +ifdef::git-commit[]
> +In addition to recognizing all date formats above, the `--date` option
> +will also try to make sense of other, more human-centric date formats,
> +such as relative dates like "yesterday" or "last Friday at noon". For
> +further details on what kind of formats are accepted, please refer to
> +the `approxidate_careful` function in `date.c` file in Git source code.
> +endif::git-commit[]

OK. This is still referring to `approxidate_careful`, which may not be
meaningful to most users. But at least it makes a best effort at a
hand-waving definition before then. :)

I'd probably omit the final sentence entirely (as it may simply confuse
people who don't know how to find Git's source), but I'm OK with it
either way.

-Peff
