Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D0701F404
	for <e@80x24.org>; Thu, 15 Mar 2018 14:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbeCOOMY (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 10:12:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:57934 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751889AbeCOOMX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 10:12:23 -0400
Received: (qmail 26285 invoked by uid 109); 15 Mar 2018 14:12:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Mar 2018 14:12:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14974 invoked by uid 111); 15 Mar 2018 14:13:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Mar 2018 10:13:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Mar 2018 10:12:21 -0400
Date:   Thu, 15 Mar 2018 10:12:21 -0400
From:   Jeff King <peff@peff.net>
To:     Michele Locati <michele@locati.it>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] filter-branch: return 2 when nothing to rewrite
Message-ID: <20180315141220.GB27748@sigill.intra.peff.net>
References: <20180315130359.6108-1-michele@locati.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180315130359.6108-1-michele@locati.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 15, 2018 at 02:03:59PM +0100, Michele Locati wrote:

> Using the --state-branch option allows us to perform incremental filtering.
> This may lead to having nothing to rewrite in subsequent filtering, so we need
> a way to recognize this case.
> So, let's exit with 2 instead of 1 when this "error" occurs.

That sounds like a good feature. It doesn't look like we use "2" for
anything else currently.

> ---
>  git-filter-branch.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This should probably get a mention in the manpage at
Documentation/git-filter-branch.txt, too.

Thanks.

-Peff
