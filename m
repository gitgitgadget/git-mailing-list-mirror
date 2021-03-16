Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BEDC433E9
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 512EC650DF
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbhCPPRs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:17:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:37798 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236061AbhCPPRL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:17:11 -0400
Received: (qmail 19424 invoked by uid 109); 16 Mar 2021 15:17:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Mar 2021 15:17:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28806 invoked by uid 111); 16 Mar 2021 15:17:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Mar 2021 11:17:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Mar 2021 11:17:10 -0400
From:   Jeff King <peff@peff.net>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] config.txt: add missing period
Message-ID: <YFDL9vOM73/LDL5v@coredump.intra.peff.net>
References: <20210316144040.23976-1-kyle@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210316144040.23976-1-kyle@kyleam.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 16, 2021 at 10:40:40AM -0400, Kyle Meyer wrote:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 6ba50b1104..06615d840b 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -46,7 +46,7 @@ Subsection names are case sensitive and can contain any characters except
>  newline and the null byte. Doublequote `"` and backslash can be included
>  by escaping them as `\"` and `\\`, respectively. Backslashes preceding
>  other characters are dropped when reading; for example, `\t` is read as
> -`t` and `\0` is read as `0` Section headers cannot span multiple lines.
> +`t` and `\0` is read as `0`. Section headers cannot span multiple lines.

Yep, looks obviously correct. I wondered if this got introduced during
some formatting cleanup, but it has been present since the text was
added in 1feb061701 (config.txt: document behavior of backslashes in
subsections, 2017-12-21).

Thanks for spotting.

-Peff
