Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB3C51F403
	for <e@80x24.org>; Sat,  9 Jun 2018 09:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753224AbeFIJaa (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 05:30:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:39996 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753207AbeFIJaa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 05:30:30 -0400
Received: (qmail 27644 invoked by uid 109); 9 Jun 2018 09:30:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 09 Jun 2018 09:30:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2305 invoked by uid 111); 9 Jun 2018 09:30:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 09 Jun 2018 05:30:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 09 Jun 2018 05:30:28 -0400
Date:   Sat, 9 Jun 2018 05:30:28 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH v2 0/2] .gitmodules fsck cleanups
Message-ID: <20180609093028.GA8864@sigill.intra.peff.net>
References: <20180609083159.GA6158@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180609083159.GA6158@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a v2 which fixes the comment typo and drops the unnecessary
commit creation in the tests. I've added a preparatory patch to do the
same cleanup in the existing test for consistency.

As before, these should apply on 'maint'.

  [1/2]: t7415: don't bother creating commit for symlink test
  [2/2]: fsck: avoid looking at NULL blob->object

 fsck.c                     |  3 ++-
 t/t7415-submodule-names.sh | 19 ++++++++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

-Peff
