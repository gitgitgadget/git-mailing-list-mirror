Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D205C54EBE
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 03:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbjAQDE1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 22:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234606AbjAQDE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 22:04:26 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691752681
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 19:04:25 -0800 (PST)
Received: (qmail 19213 invoked by uid 109); 17 Jan 2023 03:04:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 17 Jan 2023 03:04:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3849 invoked by uid 111); 17 Jan 2023 03:04:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Jan 2023 22:04:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Jan 2023 22:04:24 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 1/3] http-push: prefer CURLOPT_UPLOAD to CURLOPT_PUT
Message-ID: <Y8YQOADmbWbdKDvX@coredump.intra.peff.net>
References: <Y8Ljp7yEWTUd92w8@coredump.intra.peff.net>
 <Y8YQBbjjf+i8BWL6@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8YQBbjjf+i8BWL6@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 16, 2023 at 10:03:33PM -0500, Jeff King wrote:

> The two options do exactly the same thing, but the latter has been
> deprecated and in recent versions of curl may produce a compiler
> warning. Since the UPLOAD form is available everywhere (it was
> introduced in the year 2000 by curl 7.1), we can just switch to it.
> 
> Signed-off-by: Jeff King <peff@peff.net>

Whoops, this was supposed to be part of v2, but I accidentally sent it
in reply to the wrong part of the thread. Please ignore, and I'll resend
in the right spot.

-Peff
