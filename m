Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863E9EB64DC
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 06:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjGCGc5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 02:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjGCGcv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 02:32:51 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922EFC4
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 23:32:48 -0700 (PDT)
Received: (qmail 12820 invoked by uid 109); 3 Jul 2023 06:32:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 06:32:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2524 invoked by uid 111); 3 Jul 2023 06:32:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 02:32:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 02:32:47 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] imap-send: some -Wunused-parameter cleanups
Message-ID: <20230703063247.GA3524302@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are a few patches where I opted to clean up code rather than
marking parameters with UNUSED. Plus a bonus cleanup in patch 3 (though
I am also OK to drop that one; I don't care much about the imap-send
code, and I'd be just as happy if we deprecated and eventually dropped
the tool).

  [1/3]: imap-send: use server conf argument in setup_curl()
  [2/3]: imap-send: drop unused parameter from imap_cmd_cb callback
  [3/3]: imap-send: drop unused fields from imap_cmd_cb

 imap-send.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

-Peff
