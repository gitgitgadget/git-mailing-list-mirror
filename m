Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F00EC43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 19:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 054CF20719
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 19:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732677AbgDATZe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 15:25:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:58744 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732219AbgDATZe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 15:25:34 -0400
Received: (qmail 5392 invoked by uid 109); 1 Apr 2020 19:25:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Apr 2020 19:25:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12283 invoked by uid 111); 1 Apr 2020 19:35:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Apr 2020 15:35:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Apr 2020 15:25:33 -0400
From:   Jeff King <peff@peff.net>
To:     Konstantin Tokarev <annulen@yandex.ru>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] clone: use "quick" lookup while following tags
Message-ID: <20200401192533.GA3057718@coredump.intra.peff.net>
References: <2814631585342072@sas8-da6d7485e0c7.qloud-c.yandex.net>
 <20200328144023.GB1198080@coredump.intra.peff.net>
 <20200401121537.GA1916590@coredump.intra.peff.net>
 <111951585768302@iva8-bad53723c646.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <111951585768302@iva8-bad53723c646.qloud-c.yandex.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 01, 2020 at 10:12:30PM +0300, Konstantin Tokarev wrote:

> Would you recommend using this patch in production, or is it better to wait for reviews?

Only you know the risk tolerance of your production systems, so I make
no guarantees.  But I would personally think it is quite safe.

-Peff
