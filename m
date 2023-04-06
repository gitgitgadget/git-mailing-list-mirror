Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A74C7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 07:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbjDFHUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 03:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236002AbjDFHUN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 03:20:13 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0E0A267
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 00:19:59 -0700 (PDT)
Received: (qmail 12674 invoked by uid 109); 6 Apr 2023 07:19:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Apr 2023 07:19:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23599 invoked by uid 111); 6 Apr 2023 07:19:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Apr 2023 03:19:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 6 Apr 2023 03:19:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH] doc: asciidoc: remove custom header macro
Message-ID: <20230406071958.GB2143526@coredump.intra.peff.net>
References: <20230323221523.52472-1-felipe.contreras@gmail.com>
 <20230406035729.GA2092667@coredump.intra.peff.net>
 <xmqq8rf5r66s.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8rf5r66s.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 05, 2023 at 09:22:03PM -0700, Junio C Hamano wrote:

> Sounds like the proposed log message can use a bit more polishing to
> help future readers of "git log", then.  But I think it is not
> required to be explicit about us leaving the asciidoctor side
> untouched to keep it working (in other words, we do not talk about
> things that we are not doing in our log message, unless it is so
> unnatural not to do them at the same time to warrant such an
> explanation).

Yes, I think the "is it unnatural" is a debatable point here. I'm OK
with the commit message as-is.

> Will queue with your Reviewed-by: in the morning.

Sounds good, thanks.

-Peff
