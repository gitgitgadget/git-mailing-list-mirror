Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CC261F597
	for <e@80x24.org>; Wed, 18 Jul 2018 17:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbeGRS2o (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 14:28:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:51328 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731356AbeGRS2o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 14:28:44 -0400
Received: (qmail 10085 invoked by uid 109); 18 Jul 2018 17:49:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Jul 2018 17:49:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 891 invoked by uid 111); 18 Jul 2018 17:49:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 18 Jul 2018 13:49:50 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2018 13:49:44 -0400
Date:   Wed, 18 Jul 2018 13:49:44 -0400
From:   Jeff King <peff@peff.net>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: fix --color option formatting
Message-ID: <20180718174944.GB3084@sigill.intra.peff.net>
References: <ccf73807-1856-1ce8-365a-0c4fb25ea7bf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ccf73807-1856-1ce8-365a-0c4fb25ea7bf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 07:37:48PM +0200, Andrei Rybak wrote:

> Add missing colon in two places to fix formatting of options.

Thanks for catching.

> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 085d177d97..901faef1bf 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -57,7 +57,7 @@ OPTIONS
>  	`xx`; for example `%00` interpolates to `\0` (NUL),
>  	`%09` to `\t` (TAB) and `%0a` to `\n` (LF).
>  
> ---color[=<when>]:
> +--color[=<when>]::
>  	Respect any colors specified in the `--format` option. The
>  	`<when>` field must be one of `always`, `never`, or `auto` (if
>  	`<when>` is absent, behave as if `always` was given).

This is obviously the right fix.

I am guilty of not always building the documentation and eye-balling the
output when I'm not specifically changing the formatting. I wonder if we
could provide tooling to make that easier, by showing a diff between the
text-formatted manpages before and after a series. I've manually hacked
stuff up like that in the past, but there's often a lot of noise around
date and version info in the footers.

-Peff
