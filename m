Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95BEC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 05:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJUFvw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 01:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiJUFvv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 01:51:51 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B180C1F0435
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 22:51:50 -0700 (PDT)
Received: (qmail 10588 invoked by uid 109); 21 Oct 2022 05:51:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Oct 2022 05:51:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1949 invoked by uid 111); 21 Oct 2022 05:51:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 01:51:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 01:51:49 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v2 6/6] shortlog: implement `--group=committer` in terms
 of `--group=<format>`
Message-ID: <Y1IzdY3ECyHTdJCu@coredump.intra.peff.net>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666320509.git.me@ttaylorr.com>
 <6a9e204177d486e786574ec682e6d73907a3ce7e.1666320509.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6a9e204177d486e786574ec682e6d73907a3ce7e.1666320509.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 11:11:44PM -0400, Taylor Blau wrote:

> In the same spirit as the previous commit, reimplement
> `--group=committer` as a special case of `--group=<format>`, too.
> 
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/shortlog.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)

And this one is nice and simple, the AUTHOR one having dealt with all of
the shortlog_finish_setup() parts for us. :)

-Peff
