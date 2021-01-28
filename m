Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8BDC433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB80964DD8
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 06:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhA1Gc7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 01:32:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:41664 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbhA1Gc6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 01:32:58 -0500
Received: (qmail 9898 invoked by uid 109); 28 Jan 2021 06:32:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Jan 2021 06:32:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25534 invoked by uid 111); 28 Jan 2021 06:32:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 01:32:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 01:32:15 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/4] t0000 cleanups
Message-ID: <YBJab/tKDKOtH+p0@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a re-send of some cleanups from:

  https://lore.kernel.org/git/20201120001458.GA274082@coredump.intra.peff.net/

There were some textual conflicts back then which would have been
tedious to resolve, so we punted. Now that the requisite commits are all
in master, this can be applied there without any conflicts.

  [1/4]: t0000: keep clean-up tests together
  [2/4]: t0000: run prereq tests inside sub-test
  [3/4]: t0000: run cleaning test inside sub-test
  [4/4]: t0000: consistently use single quotes for outer tests

 t/t0000-basic.sh | 570 +++++++++++++++++++++++------------------------
 1 file changed, 284 insertions(+), 286 deletions(-)

-Peff
