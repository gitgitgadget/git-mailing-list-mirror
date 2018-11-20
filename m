Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 390001F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 11:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbeKTWGN (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 17:06:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:45590 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729099AbeKTWGN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 17:06:13 -0500
Received: (qmail 25940 invoked by uid 109); 20 Nov 2018 11:37:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 20 Nov 2018 11:37:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28105 invoked by uid 111); 20 Nov 2018 11:36:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 20 Nov 2018 06:36:53 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Nov 2018 06:37:29 -0500
Date:   Tue, 20 Nov 2018 06:37:29 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib-functions: make 'test_cmp_rev' more informative
 on failure
Message-ID: <20181120113728.GB29319@sigill.intra.peff.net>
References: <20181119132818.3116-1-szeder.dev@gmail.com>
 <20181119194920.GB7330@sigill.intra.peff.net>
 <20181120112538.GX30222@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181120112538.GX30222@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 20, 2018 at 12:25:38PM +0100, SZEDER Gábor wrote:

> > but we do not
> > usually bother to do so for our helper functions (like test_cmp).
> 
> test_i18ngrep() does since your 03aa3783f2 (t: send verbose
> test-helper output to fd 4, 2018-02-22).

Oh, indeed. Usually I find myself forgetting about patches I worked on
from 5 years ago. Forgetting about one from 9 months ago is a new low.
:)

> > I don't think it would ever hurt,
> > though. Should we be doing that for all the others, too?
> 
> I think we should, and you agreed:
> 
> https://public-inbox.org/git/20180303065648.GA17312@sigill.intra.peff.net/
> 
> but then went travelling, and then the whole thing got forgotten.

Stupid vacation. :)

OK, yes, I reaffirm my agreement that this is the right direction, then.
Sorry for my lack of memory.

-Peff
