Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7AD2C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 886C42070A
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgCZIXj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:23:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:51874 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727682AbgCZIXj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 04:23:39 -0400
Received: (qmail 1275 invoked by uid 109); 26 Mar 2020 08:23:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Mar 2020 08:23:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12139 invoked by uid 111); 26 Mar 2020 08:33:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2020 04:33:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Mar 2020 04:23:38 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] test shell-library cleanups
Message-ID: <20200326082338.GA3611364@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Inspired by Dscho's cleanup of lib-gpg.sh in [1], I noticed a few other
things.

  [1/2]: t/lib-credential.sh: drop shebang line
  [2/2]: t/lib-*.sh: drop executable bit

 t/lib-credential.sh       | 3 ++-
 t/lib-gpg.sh              | 0
 t/lib-log-graph.sh        | 0
 t/lib-submodule-update.sh | 0
 4 files changed, 2 insertions(+), 1 deletion(-)
 mode change 100755 => 100644 t/lib-credential.sh
 mode change 100755 => 100644 t/lib-gpg.sh
 mode change 100755 => 100644 t/lib-log-graph.sh
 mode change 100755 => 100644 t/lib-submodule-update.sh

-Peff

[1] https://lore.kernel.org/git/c1811d54190a62e3d35505e2b806c89238b56de8.1585114881.git.gitgitgadget@gmail.com/
