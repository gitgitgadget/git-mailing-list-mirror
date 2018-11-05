Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 582F01F453
	for <e@80x24.org>; Mon,  5 Nov 2018 18:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387493AbeKFEKX (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 23:10:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:41122 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728858AbeKFEKW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 23:10:22 -0500
Received: (qmail 18750 invoked by uid 109); 5 Nov 2018 18:49:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 05 Nov 2018 18:49:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21843 invoked by uid 111); 5 Nov 2018 18:48:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 05 Nov 2018 13:48:41 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Nov 2018 13:49:21 -0500
Date:   Mon, 5 Nov 2018 13:49:21 -0500
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] parse-options: deprecate OPT_DATE
Message-ID: <20181105184921.GB30690@sigill.intra.peff.net>
References: <20181105064427.GL25864@sigill.intra.peff.net>
 <20181105183402.9927-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181105183402.9927-1-carenas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 05, 2018 at 10:34:02AM -0800, Carlo Marcelo Arenas Belón wrote:

> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  Documentation/technical/api-parse-options.txt | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
> index 829b558110..2b036d7838 100644
> --- a/Documentation/technical/api-parse-options.txt
> +++ b/Documentation/technical/api-parse-options.txt
> @@ -183,10 +183,6 @@ There are some macros to easily define options:
>  	scale the provided value by 1024, 1024^2 or 1024^3 respectively.
>  	The scaled value is put into `unsigned_long_var`.
>  
> -`OPT_DATE(short, long, &timestamp_t_var, description)`::
> -	Introduce an option with date argument, see `approxidate()`.
> -	The timestamp is put into `timestamp_t_var`.
> -
>  `OPT_EXPIRY_DATE(short, long, &timestamp_t_var, description)`::
>  	Introduce an option with expiry date argument, see `parse_expiry_date()`.
>  	The timestamp is put into `timestamp_t_var`.

Thank you! I forgot to check the documentation.

-Peff
