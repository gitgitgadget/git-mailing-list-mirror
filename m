Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 207CC1FA14
	for <e@80x24.org>; Sun, 16 Apr 2017 04:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbdDPE2O (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Apr 2017 00:28:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:34206 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750896AbdDPE2N (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Apr 2017 00:28:13 -0400
Received: (qmail 1394 invoked by uid 109); 16 Apr 2017 04:28:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 16 Apr 2017 04:28:13 +0000
Received: (qmail 12919 invoked by uid 111); 16 Apr 2017 04:28:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 16 Apr 2017 00:28:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Apr 2017 00:28:10 -0400
Date:   Sun, 16 Apr 2017 00:28:10 -0400
From:   Jeff King <peff@peff.net>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t1400: use consistent style for test_expect_success calls
Message-ID: <20170416042810.yrofz2nazsiyshmf@sigill.intra.peff.net>
References: <20170416023102.25387-1-kyle@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170416023102.25387-1-kyle@kyleam.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 15, 2017 at 10:31:02PM -0400, Kyle Meyer wrote:

> Structure calls as
> 
>     test_expect_success 'description' '
>     	body
>     '
> 
> Use double quotes for the description if it requires parameter
> expansion or contains a single quote.
> 
> Signed-off-by: Kyle Meyer <kyle@kyleam.com>

Looks good to me.

> -test_expect_success \
> -    'creating initial files' \
> -    'test_when_finished rm -f M &&
> -     echo TEST >F &&
> -     git add F &&
> -	 GIT_AUTHOR_DATE="2005-05-26 23:30" \
> -	 GIT_COMMITTER_DATE="2005-05-26 23:30" git commit -m add -a &&

Not even sure what's going on with the indentation here in the original.
I don't see any reason this "git add" should start an indented block.
This and the other whitespace fixes all look improvements to me.

-Peff
