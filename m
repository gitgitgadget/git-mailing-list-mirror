Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDB0C433DF
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EDB1206FB
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 19:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391902AbgJOTsZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 15:48:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:33468 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391890AbgJOTsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 15:48:25 -0400
Received: (qmail 24336 invoked by uid 109); 15 Oct 2020 19:48:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Oct 2020 19:48:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32514 invoked by uid 111); 15 Oct 2020 19:48:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Oct 2020 15:48:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Oct 2020 15:48:23 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] Make test selection easier by specifying
 description substrings instead of just numeric counters
Message-ID: <20201015194823.GC1490964@coredump.intra.peff.net>
References: <pull.878.v2.git.git.1602616786.gitgitgadget@gmail.com>
 <pull.878.v3.git.git.1602710025.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.878.v3.git.git.1602710025.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 09:13:42PM +0000, Elijah Newren via GitGitGadget wrote:

> Changes since v2:
> 
>  * Use a glob rather than a regex for selecting tests
>  * Touched up the commit message in patch 3 to mention that the TAP output
>    line is still included for skipped tests and already included the word
>    "skip" to highlight the fact that the test was skipped.
>  * Fixed a bug where -run="!rename" would run all tests instead of skipping
>    the ones with 'rename' in the description

Thanks, this one addresses all my nits. I'm looking forward to using it
in practice. :)

-Peff
