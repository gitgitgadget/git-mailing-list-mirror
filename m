Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FBC31FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 12:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752792AbdFPMGL (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 08:06:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:41447 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752624AbdFPMGL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 08:06:11 -0400
Received: (qmail 14928 invoked by uid 109); 16 Jun 2017 12:06:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jun 2017 12:06:10 +0000
Received: (qmail 4275 invoked by uid 111); 16 Jun 2017 12:06:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jun 2017 08:06:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Jun 2017 08:06:08 -0400
Date:   Fri, 16 Jun 2017 08:06:08 -0400
From:   Jeff King <peff@peff.net>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, houstonfortney@gmail.com,
        kostix+git@007spb.ru, sxlijin@gmail.com
Subject: Re: [PATCH 1/3] stash: update documentation to use 'stash entries'
Message-ID: <20170616120607.dj474det3dbx6ang@sigill.intra.peff.net>
References: <20170616043050.29192-1-liambeguin@gmail.com>
 <20170616043050.29192-2-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170616043050.29192-2-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2017 at 12:30:48AM -0400, Liam Beguin wrote:

> Most of the time, a 'stash entry' is called a 'stash'
> or a 'stash state'. Lets use 'stash entry' instead.

I agree that this reads better. There is one exception:

> diff --git a/git-stash.sh b/git-stash.sh
> index 2fb651b2b8d9..0dfa4785f361 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -481,7 +481,7 @@ parse_flags_and_rev()
>  
>  	case $# in
>  		0)
> -			have_stash || die "$(gettext "No stash found.")"
> +			have_stash || die "$(gettext "No stash entry found.")"
>  			set -- ${ref_stash}@{0}

I don't think your change is wrong (and it's probably more grammatical
than the original), but should this perhaps be "No stashes found" or "No
stash entries found"?

-Peff
