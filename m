Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643FAC83F12
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 00:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbjH3A23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 20:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238794AbjH3A2F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 20:28:05 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FC3E9
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 17:28:02 -0700 (PDT)
Received: (qmail 15159 invoked by uid 109); 30 Aug 2023 00:28:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Aug 2023 00:28:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20518 invoked by uid 111); 30 Aug 2023 00:28:03 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Aug 2023 20:28:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Aug 2023 20:28:01 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] ci(linux-asan-ubsan): let's save some time
Message-ID: <20230830002801.GB227310@coredump.intra.peff.net>
References: <pull.1578.git.1693304963963.gitgitgadget@gmail.com>
 <pull.1578.v2.git.1693342048633.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1578.v2.git.1693342048633.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2023 at 08:47:28PM +0000, Johannes Schindelin via GitGitGadget wrote:

>     This commit is an attempt to reduce the pain and suffering stemming from
>     this particular job, simply by deciding that the benefit of running the
>     Python/Subversion-related tests in that job is far outweighed by its
>     cost.

FWIW, I am in favor of this patch. I've had the same thought many times
but was worried I was being too dismissive of p4/svn (which I personally
do not care at all about). Omitting them from the sanitizer job (but
still running the basic svn/p4 tests elsewhere) seems like a good
compromise.

-Peff
