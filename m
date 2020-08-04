Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F11C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 21:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D201D22B45
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 21:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgHDV2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:28:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:48240 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgHDV2c (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 17:28:32 -0400
Received: (qmail 6159 invoked by uid 109); 4 Aug 2020 21:28:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Aug 2020 21:28:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16486 invoked by uid 111); 4 Aug 2020 21:28:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Aug 2020 17:28:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 4 Aug 2020 17:28:31 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Update .mailmap
Message-ID: <20200804212831.GD2020725@coredump.intra.peff.net>
References: <20200804210758.1241259-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200804210758.1241259-1-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 04, 2020 at 11:07:58PM +0200, Martin Ågren wrote:

> Similar to a35b13fce0 ("Update .mailmap", 2018-11-09), make the output
> of `git shortlog -nse v2.10.0..master` duplicate-free by taking/guessing
> the current and preferred addresses for authors that appear with more
> than one address.

I don't have any specific objections, but you might want to cc all of
the impacted people, which would make them more likely to notice if this
isn't the right thing to do.

-Peff
