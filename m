Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6D2EDE99E
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 09:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbjINJeV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 05:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236069AbjINJeV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 05:34:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B281BEF
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 02:34:16 -0700 (PDT)
Received: (qmail 27310 invoked by uid 109); 14 Sep 2023 09:34:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 14 Sep 2023 09:34:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21262 invoked by uid 111); 14 Sep 2023 09:34:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 14 Sep 2023 05:34:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 14 Sep 2023 05:34:09 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 0/4] merge-ort unused parameter cleanups
Message-ID: <20230914093409.GA2254811@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A few small cleanups for merge-ort collected from playing with
-Wunused-parameter. The first one actually fixes a user-visible bug, and
the rest are just cleanups.

  [1/4]: merge-ort: drop custom err() function
  [2/4]: merge-ort: stop passing "opt" to read_oid_strbuf()
  [3/4]: merge-ort: drop unused parameters from detect_and_process_renames()
  [4/4]: merge-ort: drop unused "opt" parameter from merge_check_renames_reusable()

 merge-ort.c           | 48 +++++++++++--------------------------------
 t/t6406-merge-attr.sh |  3 ++-
 2 files changed, 14 insertions(+), 37 deletions(-)

-Peff
