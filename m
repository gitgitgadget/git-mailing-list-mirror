Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B63661FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 12:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbdFPMQF (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 08:16:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:41463 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752798AbdFPMQF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 08:16:05 -0400
Received: (qmail 15560 invoked by uid 109); 16 Jun 2017 12:16:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jun 2017 12:16:04 +0000
Received: (qmail 4331 invoked by uid 111); 16 Jun 2017 12:16:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jun 2017 08:16:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Jun 2017 08:16:02 -0400
Date:   Fri, 16 Jun 2017 08:16:02 -0400
From:   Jeff King <peff@peff.net>
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, houstonfortney@gmail.com,
        kostix+git@007spb.ru, sxlijin@gmail.com
Subject: Re: [PATCH 3/3] glossary: define stash entries
Message-ID: <20170616121602.r3vjqmfcmqyvudsv@sigill.intra.peff.net>
References: <20170616043050.29192-1-liambeguin@gmail.com>
 <20170616043050.29192-4-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170616043050.29192-4-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2017 at 12:30:50AM -0400, Liam Beguin wrote:

> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index 6e991c246915..026f66e7240a 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -570,6 +570,10 @@ The most notable example is `HEAD`.
>  	is created by giving the `--depth` option to linkgit:git-clone[1], and
>  	its history can be later deepened with linkgit:git-fetch[1].
>  
> +[[def_stash]]stash entry::
> +	An <<def_object,object>> used to temporarily store the content of a
> +	<<def_dirty,dirty>> working directory for futur reuse.

s/futur/&e/

I think we'd usually say "contents" (plural) of a working directory.

It also stores the contents of the index. git-stash(1) says "current
state of the working directory and the index".

-Peff
