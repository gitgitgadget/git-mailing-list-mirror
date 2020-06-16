Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D432C433DF
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 14:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C1CE20644
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 14:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgFPOiT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:38:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:33358 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgFPOiT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 10:38:19 -0400
Received: (qmail 22896 invoked by uid 109); 16 Jun 2020 14:38:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jun 2020 14:38:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13670 invoked by uid 111); 16 Jun 2020 14:38:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jun 2020 10:38:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Jun 2020 10:38:16 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Nomen Nescio <nobody@dizum.com>, git@vger.kernel.org
Subject: Re: Consensus on a new default branch name
Message-ID: <20200616143816.GN666057@coredump.intra.peff.net>
References: <6b6f161981a07070871633fe02c4c3f9@dizum.com>
 <20200616022239.GD164606@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200616022239.GD164606@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 15, 2020 at 07:22:39PM -0700, Jonathan Nieder wrote:

> In Git, we make most decisions by a rough consensus of active
> contributors, as judged by the maintainer.[...]

Thanks for writing this out. I agree completely with how you described
the decision making process.

We do bear the responsibility to think carefully about our users, and to
respect their time, and their expectations that things don't break. But
as with any feature, it's a juggling act between stability and progress
that developers and the maintainer must deal with. Somebody might not
care about this name change, but likewise, others might not care about a
particular technical feature. At some point users have to put their
trust in Git's developers that the end product will be stable and
useful. If we break that trust too much, then forking is an option, as
you note. Our track record has been pretty good so far, and I think if
we approach this change carefully, it can continue to be.

-Peff
