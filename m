Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B912CC43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 09:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96919206E6
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 09:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgC3J0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 05:26:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:55354 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727376AbgC3J0N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 05:26:13 -0400
Received: (qmail 13340 invoked by uid 109); 30 Mar 2020 09:26:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 30 Mar 2020 09:26:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16575 invoked by uid 111); 30 Mar 2020 09:36:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Mar 2020 05:36:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 30 Mar 2020 05:26:12 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 6/6] INSTALL: drop support for docbook-xsl before 1.74
Message-ID: <20200330092612.GA1735224@coredump.intra.peff.net>
References: <cover.1585486103.git.martin.agren@gmail.com>
 <090ef11aec0476395935acf26c4072617ef1e6f2.1585486103.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <090ef11aec0476395935acf26c4072617ef1e6f2.1585486103.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 29, 2020 at 03:18:10PM +0200, Martin Ågren wrote:

> Several of the previous commits have been bumping the minimum supported
> version of docbook-xsl and dropping various workarounds. Most recently,
> we made the minimum be 1.73.0.
> 
> In INSTALL, we claim that with 1.73, one needs a certain patch in
> contrib/patches/. There is no such patch. It was added in 2ec39edad9
> ("INSTALL: add warning on docbook-xsl 1.72 and 1.73", 2007-08-03) and
> dropped in 9721ac9010 ("contrib: remove continuous/ and patches/",
> 2013-06-03).

Perhaps nobody asking about the missing patch since 2013 should be a
hint that nobody cares about these old versions. :)

> Rather than resurrecting version 1.73 and the patch and testing them,
> just raise our minimum supported docbook-xsl version to 1.74.

Makes sense.

-Peff
