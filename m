Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 326A82022A
	for <e@80x24.org>; Fri, 28 Oct 2016 11:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756215AbcJ1LIY (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 07:08:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:35345 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750878AbcJ1LIY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 07:08:24 -0400
Received: (qmail 27784 invoked by uid 109); 28 Oct 2016 11:08:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Oct 2016 11:08:22 +0000
Received: (qmail 28451 invoked by uid 111); 28 Oct 2016 11:08:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Oct 2016 07:08:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Oct 2016 07:08:20 -0400
Date:   Fri, 28 Oct 2016 07:08:20 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Christ <contact@stefanchrist.eu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documenation: fmt-merge-msg: fix markup in example
Message-ID: <20161028110820.a46ttxjicq2k5xdk@sigill.intra.peff.net>
References: <1477648886-12096-1-git-send-email-contact@stefanchrist.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1477648886-12096-1-git-send-email-contact@stefanchrist.eu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2016 at 12:01:26PM +0200, Stefan Christ wrote:

> diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
> index 6526b17..44892c4 100644
> --- a/Documentation/git-fmt-merge-msg.txt
> +++ b/Documentation/git-fmt-merge-msg.txt
> @@ -60,10 +60,10 @@ merge.summary::
>  EXAMPLE
>  -------
>  
> ---
> +---------
>  $ git fetch origin master
>  $ git fmt-merge-msg --log <$GIT_DIR/FETCH_HEAD
> ---
> +---------

Thanks. Asciidoc generally requires at least 4 delimiter characters to
open a delimited block (including a ListingBlock, which is what we want
here). There is one exception, "--", which is a generic OpenBlock, which
is just used for grouping, and not any special syntactic meaning (so
that's why this _didn't_ render the "--", but did render the contents
without line breaks).

So looks good, modulo the typo in the subject that somebody else pointed
out.

-Peff
