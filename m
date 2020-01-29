Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0A2C33CB2
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 10:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 165E72070E
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 10:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgA2KX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 05:23:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:47356 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726116AbgA2KX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 05:23:28 -0500
Received: (qmail 16189 invoked by uid 109); 29 Jan 2020 10:23:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Jan 2020 10:23:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15487 invoked by uid 111); 29 Jan 2020 10:31:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jan 2020 05:31:04 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jan 2020 05:23:26 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 11/12] sparse-checkout: use C-style quotes in 'list'
 subcommand
Message-ID: <20200129102326.GC4218@coredump.intra.peff.net>
References: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
 <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
 <ec714a4cf04e86f55057e17109a29e74021b73bf.1580236003.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ec714a4cf04e86f55057e17109a29e74021b73bf.1580236003.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 28, 2020 at 06:26:42PM +0000, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> When in cone mode, the 'git sparse-checkout list' subcommand lists
> the directories included in the sparse cone. When these directories
> contain odd characters, such as a backslash, then we need to use
> C-style quotes similar to 'git ls-tree'.

Makes sense, and the code looks correct to me.

-Peff
