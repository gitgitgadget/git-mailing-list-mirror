Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56C31202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 17:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932560AbdJ3Rjo (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:39:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:40302 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932137AbdJ3Rjn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:39:43 -0400
Received: (qmail 8992 invoked by uid 109); 30 Oct 2017 17:39:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Oct 2017 17:39:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25279 invoked by uid 111); 30 Oct 2017 17:39:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Oct 2017 13:39:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Oct 2017 10:39:41 -0700
Date:   Mon, 30 Oct 2017 10:39:41 -0700
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH] t0000: check whether the shell supports the "local"
 keyword
Message-ID: <20171030173941.bye4vyi3jmkzxfr5@sigill.intra.peff.net>
References: <6ecab31e7ed05f5e79ecd454b133a2bfa6ac9ab7.1509005669.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ecab31e7ed05f5e79ecd454b133a2bfa6ac9ab7.1509005669.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 26, 2017 at 10:18:53AM +0200, Michael Haggerty wrote:

> Add a test balloon to see if we get complaints from anybody who is
> using a shell that doesn't support the "local" keyword. If so, this
> test can be reverted. If not, we might want to consider using "local"
> in shell code throughout the git code base.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> This has been discussed on the mailing list [1,2].

Thanks for following up, this looks nice and thorough to me.

-Peff
