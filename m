Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B00B71F404
	for <e@80x24.org>; Mon, 10 Sep 2018 19:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbeIKA3M (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 20:29:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:45294 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727742AbeIKA3M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 20:29:12 -0400
Received: (qmail 20207 invoked by uid 109); 10 Sep 2018 19:33:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 10 Sep 2018 19:33:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11797 invoked by uid 111); 10 Sep 2018 19:33:48 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 10 Sep 2018 15:33:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2018 15:33:34 -0400
Date:   Mon, 10 Sep 2018 15:33:34 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3701-add-interactive: tighten the check of trace output
Message-ID: <20180910193333.GA24850@sigill.intra.peff.net>
References: <20180910140714.19617-1-szeder.dev@gmail.com>
 <20180910154453.GA15270@sigill.intra.peff.net>
 <20180910191932.GB17224@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180910191932.GB17224@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 10, 2018 at 09:19:32PM +0200, SZEDER Gábor wrote:

> > I'd have thought that anybody
> > adding index-specific tracing would do it as GIT_TRACE_INDEX.
> 
> Depends on the purpose, I guess.  For tracing that is aimed to become
> part of in git, definitely.  However, for my own ad-hoc tracing used
> to try to make sense of some split-index corner cases, trace_printf()
> is perfect.

I don't mind it as a temporary debug thing, but it would be nice if it
wasn't a temptation for people to include in their actual patches.

-Peff
