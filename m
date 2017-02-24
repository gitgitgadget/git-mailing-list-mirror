Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17F62201B0
	for <e@80x24.org>; Fri, 24 Feb 2017 08:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbdBXIsQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 03:48:16 -0500
Received: from mx0.elegosoft.com ([78.47.87.163]:52460 "EHLO mx0.elegosoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751321AbdBXIsA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 03:48:00 -0500
Received: from localhost (unknown [10.10.10.227])
        by mx0.elegosoft.com (Postfix) with ESMTPSA id C840816C791;
        Fri, 24 Feb 2017 09:46:27 +0100 (CET)
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>
Subject: [PATCH] docs/git-gc: fix default value for `--aggressiveDepth`
Date:   Fri, 24 Feb 2017 09:46:45 +0100
Message-Id: <952cf1f2cb37b746d823f3b917bfb44171cbc465.1487925983.git.ps@pks.im>
X-Mailer: git-send-email 2.11.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 07e7dbf0d (gc: default aggressive depth to 50, 2016-08-11),
the default aggressive depth of git-gc has been changed to 50. While
git-config(1) has been updated to represent the new default value,
git-gc(1) still mentions the old value. This patch fixes it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-gc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 852b72c67..571b5a7e3 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -127,7 +127,7 @@ the documentation for the --window' option in linkgit:git-repack[1] for
 more details.  This defaults to 250.
 
 Similarly, the optional configuration variable `gc.aggressiveDepth`
-controls --depth option in linkgit:git-repack[1]. This defaults to 250.
+controls --depth option in linkgit:git-repack[1]. This defaults to 50.
 
 The optional configuration variable `gc.pruneExpire` controls how old
 the unreferenced loose objects have to be before they are pruned.  The
-- 
2.11.1

