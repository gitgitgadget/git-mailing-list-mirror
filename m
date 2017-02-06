Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E7E01FAFC
	for <e@80x24.org>; Mon,  6 Feb 2017 15:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753617AbdBFPWE (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 10:22:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:49772 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752755AbdBFPWD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 10:22:03 -0500
Received: (qmail 9118 invoked by uid 109); 6 Feb 2017 15:22:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Feb 2017 15:22:03 +0000
Received: (qmail 13798 invoked by uid 111); 6 Feb 2017 15:22:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Feb 2017 10:22:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2017 16:22:00 +0100
Date:   Mon, 6 Feb 2017 16:22:00 +0100
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w5h5dmluZCBBIC4=?= Holm <sunny@sunbase.org>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 1/5] Documentation/stash: remove mention of git reset
 --hard
Message-ID: <20170206152200.sszklnow332rf6fj@sigill.intra.peff.net>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170205202642.14216-1-t.gummerer@gmail.com>
 <20170205202642.14216-2-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170205202642.14216-2-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 05, 2017 at 08:26:38PM +0000, Thomas Gummerer wrote:

> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 2e9cef06e6..2e9e344cd7 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -47,8 +47,9 @@ OPTIONS
>  
>  save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
>  
> -	Save your local modifications to a new 'stash', and run `git reset
> -	--hard` to revert them.  The <message> part is optional and gives
> +	Save your local modifications to a new 'stash' and roll them
> +	back to HEAD (in the working tree and in the index).
> +	The <message> part is optional and gives

Nice. I think what you ended up with here is concise and accurate.

-Peff
