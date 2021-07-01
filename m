Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C0DC11F64
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6A6661411
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 16:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhGAQWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 12:22:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:38846 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229664AbhGAQWm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 12:22:42 -0400
Received: (qmail 28268 invoked by uid 109); 1 Jul 2021 16:20:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 01 Jul 2021 16:20:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17309 invoked by uid 111); 1 Jul 2021 16:20:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 01 Jul 2021 12:20:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 1 Jul 2021 12:20:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2021, #07; Wed, 30)
Message-ID: <YN3rOhJDVnyOxctX@coredump.intra.peff.net>
References: <xmqq4kdft122.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4kdft122.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 30, 2021 at 03:55:33PM -0700, Junio C Hamano wrote:

> * jk/test-avoid-globmatch-with-skip-patterns (2021-06-17) 1 commit
>  - test-lib: avoid accidental globbing in match_pattern_list()
> 
>  We broke "GIT_SKIP_TESTS=t?000" to skip certain tests in recent
>  update, which got fixed.
> 
>  Will merge to 'next'.

Not a big deal, but the commit message needs s/t?0000/t?000/ (the
numbers are four-digits, and the "?" is one of them). If it's not too
much trouble before it hits 'next'. :)

-Peff
