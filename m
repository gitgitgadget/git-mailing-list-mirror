Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB28EC433ED
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 09:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9784661152
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 09:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232059AbhDOJQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:16:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:53158 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231979AbhDOJQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 05:16:29 -0400
Received: (qmail 9789 invoked by uid 109); 15 Apr 2021 09:16:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Apr 2021 09:16:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14397 invoked by uid 111); 15 Apr 2021 09:16:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Apr 2021 05:16:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Apr 2021 05:16:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: clarify "do not capitalize the first word" rule
Message-ID: <YHgEVZ/vN5hEAgoQ@coredump.intra.peff.net>
References: <xmqq7dl4whl6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7dl4whl6.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 14, 2021 at 04:51:17PM -0700, Junio C Hamano wrote:

> The same "do not capitalize the first word" rule is applied to both
> our patch titles and error messages, but the existing description
> was fuzzy in two aspects.
> 
>  * For error messages, it was not said that this was only about the
>    first word that begins the sentence.
> 
>  * For both, it was not clear when a capital letter there was not an
>    error.  We avoid capitalizing the first word when the only reason
>    you would capitalize it is because it happens to be the first
>    word in the sentence.  If a proper noun that is usually spelled
>    in caps happens to come at the beginning of the sentence, that is
>    not a reason to downcase it.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * I saw in the GGG inbox a well-intended patch that took the "do
>    not capitalize" rule too far, but with documentation unclear, it
>    was understandable, so here is to remedy the situation.

After reading the patch, I wouldn't have thought it needed to be spelled
out, but if you saw a case in the wild, it doesn't hurt to be as clear
as possible.

The patch text itself looks good to me.

-Peff
