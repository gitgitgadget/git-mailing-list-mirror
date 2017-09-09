Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A8F120286
	for <e@80x24.org>; Sat,  9 Sep 2017 10:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757413AbdIIKrL (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Sep 2017 06:47:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:33306 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1756862AbdIIKrL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2017 06:47:11 -0400
Received: (qmail 31184 invoked by uid 109); 9 Sep 2017 10:47:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Sep 2017 10:47:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14155 invoked by uid 111); 9 Sep 2017 10:47:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Sep 2017 06:47:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Sep 2017 06:47:08 -0400
Date:   Sat, 9 Sep 2017 06:47:08 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v4 0/4] Rerolling ma/split-symref-update-fix
Message-ID: <20170909104708.hjtn2yi2ma3clf2v@sigill.intra.peff.net>
References: <CAN0heSr0AWj-QwchX2DPzkZs9cx1gsfUTevN4JD1Ze=2t-YZiQ@mail.gmail.com>
 <cover.1504939825.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1504939825.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 09, 2017 at 08:57:14AM +0200, Martin Ågren wrote:

> > I'll take Peff's hint, tweak/add comments for correctness and symmetry
> > with the previous patch and add an if-BUG for symmetry.
> 
> Here's a reroll of ma/split-symref-update-fix. The first three patches
> are v3 plus Michael's Reviewed-By.
> 
> The fourth is the conceptual fix of adding `refname` instead of "HEAD"
> into the list of affected refnames.
> 
> Thanks all for comments, suggestions and help along the way.

This looks good to me, including the explanation in the new patch.
Thanks!

-Peff
