Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4654BC433E2
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 08:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AEBD21481
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 08:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgIGIHT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:07:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:50240 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727953AbgIGIHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 04:07:09 -0400
Received: (qmail 12554 invoked by uid 109); 7 Sep 2020 08:06:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 07 Sep 2020 08:06:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14337 invoked by uid 111); 7 Sep 2020 08:06:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Sep 2020 04:06:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 7 Sep 2020 04:06:32 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Tom Hale <tomnott@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/2] some minor add--interactive fixes
Message-ID: <20200907080632.GA1261825@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There was a mini-mystery about the add--interactive tests on the
git-mentoring list this morning. The second patch here solves the
mystery. But while digging I also noticed a bug in the new C version,
which is fixed by the first patch.

  [1/2]: add-patch: fix inverted return code of repo_read_index()
  [2/2]: add--interactive.perl: specify --no-color explicitly

 add-patch.c                | 2 +-
 git-add--interactive.perl  | 2 +-
 t/t3701-add-interactive.sh | 8 ++++++++
 3 files changed, 10 insertions(+), 2 deletions(-)

-Peff
