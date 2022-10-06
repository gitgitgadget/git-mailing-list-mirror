Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330C1C433F5
	for <git@archiver.kernel.org>; Thu,  6 Oct 2022 13:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbiJFNKS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Oct 2022 09:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiJFNKC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2022 09:10:02 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44009E76
        for <git@vger.kernel.org>; Thu,  6 Oct 2022 06:09:37 -0700 (PDT)
Received: (qmail 11986 invoked by uid 109); 6 Oct 2022 13:09:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Oct 2022 13:09:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26171 invoked by uid 111); 6 Oct 2022 13:09:35 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Oct 2022 09:09:35 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 6 Oct 2022 09:09:35 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/4] a few small unused-parameter fixes
Message-ID: <Yz7Tjy7Rh8cXVxYQ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These ones are not annotations of unused parameters, but rather code
changes that (I hope) make the world a better place while also silencing
-Wunused-parameters.

I've been trying to bubble these up to the front of my series of UNUSED
annotations. I _thought_ I had got all of them, but I think a few of
these are new, and some are ones that just got lost in the shuffle of
earlier series.

  [1/4]: test-submodule: inline resolve_relative_url() function
  [2/4]: multi-pack-index: avoid writing to global in option callback
  [3/4]: commit: avoid writing to global in option callback
  [4/4]: attr: convert DEBUG_ATTR to use trace API

 attr.c                     | 38 +++++++++++++++++---------------------
 builtin/commit.c           |  4 ++--
 builtin/multi-pack-index.c |  7 ++++---
 t/helper/test-submodule.c  | 22 ++++++++--------------
 4 files changed, 31 insertions(+), 40 deletions(-)

-Peff
