Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CFAC388F9
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 08:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF60220795
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 08:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460779AbgJWIuW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 04:50:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:40312 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S460776AbgJWIuW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 04:50:22 -0400
Received: (qmail 27578 invoked by uid 109); 23 Oct 2020 08:50:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Oct 2020 08:50:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19626 invoked by uid 111); 23 Oct 2020 08:50:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Oct 2020 04:50:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Oct 2020 04:50:21 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/3] Work around flakiness in t5500.43
Message-ID: <20201023085021.GF4012156@coredump.intra.peff.net>
References: <pull.753.git.1602600323973.gitgitgadget@gmail.com>
 <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.753.v2.git.1603136142.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 19, 2020 at 07:35:39PM +0000, Johannes Schindelin via GitGitGadget wrote:

> Changes since v1:
> 
>  * Instead of papering over the underlying cause, the patch was completely
>    changed to actually fix the bug and add a proper regression test for it
>    (originally, I wanted to act according to the common notion that good
>    programmers are lazy, oh my, see how well that worked out for me).

Thanks for fixing this. Your explanation looks thorough and the code
looks correct. Definitely patches 1 and 2 look good to me. I left a few
comments on patch 3.

-Peff
