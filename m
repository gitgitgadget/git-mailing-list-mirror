Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A201C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA2C2070A
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgCZIZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:25:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:51898 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726347AbgCZIZy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 04:25:54 -0400
Received: (qmail 1326 invoked by uid 109); 26 Mar 2020 08:25:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Mar 2020 08:25:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12204 invoked by uid 111); 26 Mar 2020 08:35:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2020 04:35:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Mar 2020 04:25:53 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] t/lib-*.sh: drop executable bit
Message-ID: <20200326082553.GB3611762@coredump.intra.peff.net>
References: <20200326082338.GA3611364@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200326082338.GA3611364@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no need for shell libraries to have the executable bit. They're
meant to be sourced, and running them stand-alone is pointless. Let's
reduce any possible confusion by making it more clear they're not meant
to be run this way.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/lib-credential.sh       | 0
 t/lib-gpg.sh              | 0
 t/lib-log-graph.sh        | 0
 t/lib-submodule-update.sh | 0
 4 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 t/lib-credential.sh
 mode change 100755 => 100644 t/lib-gpg.sh
 mode change 100755 => 100644 t/lib-log-graph.sh
 mode change 100755 => 100644 t/lib-submodule-update.sh

diff --git a/t/lib-credential.sh b/t/lib-credential.sh
old mode 100755
new mode 100644
diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
old mode 100755
new mode 100644
diff --git a/t/lib-log-graph.sh b/t/lib-log-graph.sh
old mode 100755
new mode 100644
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
old mode 100755
new mode 100644
-- 
2.26.0.576.gb87790c3c1
