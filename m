Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0DEC64EC4
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 09:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjCJJvh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 04:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCJJvf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 04:51:35 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BBC24CBC
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 01:51:34 -0800 (PST)
Received: (qmail 19434 invoked by uid 109); 10 Mar 2023 09:51:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Mar 2023 09:51:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10634 invoked by uid 111); 10 Mar 2023 09:51:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Mar 2023 04:51:33 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Mar 2023 04:51:33 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] format-patch: add format.noprefix option
Message-ID: <ZAr9pcP8Ixuqwt51@coredump.intra.peff.net>
References: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
 <ZAl41V7n77ej844x@coredump.intra.peff.net>
 <xmqq5yb9dfn2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5yb9dfn2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 09, 2023 at 09:00:01AM -0800, Junio C Hamano wrote:

> But that is the other extreme.
> 
> I wonder if the consumer side should be made configurable for
> completeness, though.
> 
> Here is how "apply.pValue" configuration variable would look like.
> Projects whose members want diff.noprefix set can standardise on
> using that and then receiving end configured to match with this.

I don't mind this at all for the sake of completeness, and your patch
looks reasonable to me. I mostly just wouldn't bother if there's not a
demonstrated need (and again, this is something people could be asking
for _now_, because of the way diff.noprefix works, and nobody has done
so).

-Peff
