Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C6BC4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 20:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiLIU17 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 15:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLIU15 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 15:27:57 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B792126E
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 12:27:54 -0800 (PST)
Received: (qmail 8240 invoked by uid 109); 9 Dec 2022 20:27:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 Dec 2022 20:27:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28526 invoked by uid 111); 9 Dec 2022 20:27:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 Dec 2022 15:27:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 9 Dec 2022 15:27:53 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v3 2/4] object-file: refactor map_loose_object_1()
Message-ID: <Y5OaScWCzzhIumtM@coredump.intra.peff.net>
References: <Y5KWpXwxdRI4QPNl@coredump.intra.peff.net>
 <20221209181704.106534-1-jonathantanmy@google.com>
 <Y5OaLKmIXvbEI1bP@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y5OaLKmIXvbEI1bP@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 09, 2022 at 03:27:24PM -0500, Jeff King wrote:

> On Fri, Dec 09, 2022 at 10:17:04AM -0800, Jonathan Tan wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > > If you take my suggestion on patch 3, then the only other caller of
> > > map_loose_object_1() goes away, and we can fold it all into one
> > > reasonably-named function:
> > 
> > Ah, that is true as of this patch, but patch 3 introduces another caller
> > of this function. I tried to allude to it in the commit message, but if
> > there is a clearer way to explain that, please let me know.
> 
> Yes, that's the "other caller" I was referring to. :) Hopefully it is
> more clear after you read my comments on v3.

Er, that should be "...comments on patch 3", of course, not "v3".

-Peff
