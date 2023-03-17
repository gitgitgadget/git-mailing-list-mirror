Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B03BC74A5B
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 19:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjCQTOP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 15:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjCQTON (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 15:14:13 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16603E1E6
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 12:13:50 -0700 (PDT)
Received: (qmail 25975 invoked by uid 109); 17 Mar 2023 19:13:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Mar 2023 19:13:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27457 invoked by uid 111); 17 Mar 2023 19:13:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Mar 2023 15:13:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Mar 2023 15:13:49 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/4] more unused-parameter fixes
Message-ID: <ZBS77VYL9ZrxKtCN@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are a few more patches to silence some -Wunused-parameter warnings.
I've pulled these ones out specifically because they're a little more
interesting than just "slap an UNUSED marker on the variable".

  [1/4]: mailmap: drop debugging code
  [2/4]: http: drop unused parameter from start_object_request()
  [3/4]: http: mark unused parameter in fill_active_slot() callbacks
  [4/4]: transport: mark unused parameters in fetch_refs_from_bundle()

 http-push.c   |  2 +-
 http-walker.c | 11 +++++------
 mailmap.c     | 42 +++---------------------------------------
 transport.c   |  3 ++-
 4 files changed, 11 insertions(+), 47 deletions(-)

-Peff
