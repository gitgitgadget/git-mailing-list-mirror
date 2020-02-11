Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD38C35242
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 19:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DF12086A
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 19:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729856AbgBKTsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 14:48:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:57816 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728843AbgBKTsH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 14:48:07 -0500
Received: (qmail 9375 invoked by uid 109); 11 Feb 2020 19:48:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Feb 2020 19:48:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1405 invoked by uid 111); 11 Feb 2020 19:56:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Feb 2020 14:56:58 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Feb 2020 14:48:06 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/4] Sparse-checkout: Add subcommand and Windows paths
Message-ID: <20200211194806.GB2127797@coredump.intra.peff.net>
References: <pull.546.git.1581433344.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.546.git.1581433344.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 11, 2020 at 03:02:20PM +0000, Derrick Stolee via GitGitGadget wrote:

> This is based on ds/sparse-checkout-harden.
> 
> The sparse-checkout builtin currently lets users modify their
> sparse-checkout file with the all-or-nothing "set" subcommand. It may be
> easier for a user to expand their sparse cone using a "git sparse-checkout
> add <pattern/path> ..." subcommand. To achieve this while reusing as much
> code as possible from the "set" subcommand, the first two patches extract
> methods from sparse_checkout_set().

FWIW, this makes perfect sense to me. I actually expected "set" to
behave like "add" the first time I tried it out.

-Peff
