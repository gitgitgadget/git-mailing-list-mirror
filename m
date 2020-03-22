Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ADDC4332B
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 19:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B371420724
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 19:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCVTTv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 15:19:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:47292 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725997AbgCVTTv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 15:19:51 -0400
Received: (qmail 30497 invoked by uid 109); 22 Mar 2020 19:19:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 22 Mar 2020 19:19:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2679 invoked by uid 111); 22 Mar 2020 19:29:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Mar 2020 15:29:37 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 22 Mar 2020 15:19:50 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] t3419: drop EXPENSIVE tests
Message-ID: <20200322191950.GB671552@coredump.intra.peff.net>
References: <20200320213916.604658-1-sandals@crustytoothpaste.net>
 <20200322075140.GA600888@coredump.intra.peff.net>
 <20200322171111.GB6499@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200322171111.GB6499@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 22, 2020 at 05:11:11PM +0000, brian m. carlson wrote:

> > Let's simplify the script by dropping the EXPENSIVE run. That in turn
> > lets us drop the do_tests() wrapper, which lets us consistently use
> > single-quotes for our test snippets. And we can drop the useless
> > test_debug() timings, as well as their run() helper. And finally, while
> > we're here, we can replace the count() helper with the standard
> > test_seq().
> 
> I'm also fine with this solution.  As long as this test doesn't fail
> with EXPENSIVE, I'm happy.

Just to be clear, this is meant to go on top of your fix, which is
already in next, so I think that part is fixed either way. :)

-Peff
