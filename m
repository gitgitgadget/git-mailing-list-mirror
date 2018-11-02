Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A99541F453
	for <e@80x24.org>; Fri,  2 Nov 2018 06:24:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbeKBPae (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 11:30:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:37686 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728216AbeKBPae (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 11:30:34 -0400
Received: (qmail 28846 invoked by uid 109); 2 Nov 2018 06:24:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 02 Nov 2018 06:24:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 821 invoked by uid 111); 2 Nov 2018 06:23:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 02 Nov 2018 02:23:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2018 02:24:29 -0400
Date:   Fri, 2 Nov 2018 02:24:29 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] it's called read_object_file() these days
Message-ID: <20181102062429.GA29939@sigill.intra.peff.net>
References: <xmqqpnvoovzk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpnvoovzk.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 02, 2018 at 03:05:03PM +0900, Junio C Hamano wrote:

> Remnant of the old name of the function still remains in comments.
> Update them all.

Yay. What's here looks obviously correct.

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  apply.c       | 2 +-
>  builtin/gc.c  | 2 +-
>  fast-import.c | 4 ++--
>  notes.c       | 2 +-
>  object.h      | 2 +-
>  sha1-file.c   | 2 +-
>  6 files changed, 7 insertions(+), 7 deletions(-)

There's another mention in Documentation/technical/api-object-access.txt.

But since the entire API is undocumented, I'm not sure it matters much.
That file has been a placeholder since 2007. Maybe we should just delete
it; its existence does not seem to be guilting anyone into documenting,
and these days we'd prefer to do it in-header anyway.

-Peff
