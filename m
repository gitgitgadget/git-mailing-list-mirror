Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A067DC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 05:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJUFk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 01:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJUFk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 01:40:27 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639EE1217DB
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 22:40:24 -0700 (PDT)
Received: (qmail 10527 invoked by uid 109); 21 Oct 2022 05:40:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Oct 2022 05:40:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1777 invoked by uid 111); 21 Oct 2022 05:40:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 01:40:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 01:40:23 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, jacob@initialcommit.io, gitster@pobox.com,
        avarab@gmail.com
Subject: Re: [PATCH v2 3/6] shortlog: extract `--group` fragment for
 translation
Message-ID: <Y1Iwx0uD+wx4jzD/@coredump.intra.peff.net>
References: <cover.1665448437.git.me@ttaylorr.com>
 <cover.1666320509.git.me@ttaylorr.com>
 <3665488fc95ee3b097f2e0e1e64d23d523c073fa.1666320509.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3665488fc95ee3b097f2e0e1e64d23d523c073fa.1666320509.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 11:11:35PM -0400, Taylor Blau wrote:

> The subsequent commit will add another unhandled case in
> `read_from_stdin()` which will want to use the same message as with
> `--group=trailer`.
> 
> Extract the "--group=trailer" part from this message so the same
> translation key can be used for both cases.

Continuing my thoughts from the previous patch, this one actually makes
more sense to me in the order you have it. I.e., making it more generic
ahead of time, instead of afterwards saying "hey, these two messages are
very similar".

I'm not sure what makes me see them differently. It's possible I'm
simply not consistent and you should ignore me. :)

-Peff
