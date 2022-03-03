Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3904EC433FE
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 16:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234905AbiCCQSN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 11:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbiCCQRr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 11:17:47 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BF2199D4D
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 08:16:46 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nihaljere.xyz;
        s=key1; t=1646324202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=G9mYY4Me2pEOHC26JZokLPI5eYuz1AovoMrzLOKtNKM=;
        b=O/HfJXnmu8oXvuoU55HH7KFq0qXDi46i54LCCJzX8OOBZlkTf4B2s7v1UZP01yud4FDYd3
        eYDWqKDYaSiPa2Bsd+TZ9gH7Rrpn+tCyz0+ypLrNhsAPp+FTO2NTPwthtLvxULXmGos7pO
        gLmDYR2HVVqnW1Hksozlswn/MEBE/ag=
From:   Nihal Jere <nihal@nihaljere.xyz>
To:     git@vger.kernel.org
Cc:     Nihal Jere <nihal@nihaljere.xyz>
Subject: [PATCH] Documentation: git-read-tree: separate links using commas
Date:   Thu,  3 Mar 2022 10:15:43 -0600
Message-Id: <20220303161542.11616-1-nihal@nihaljere.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: nihaljere.xyz
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it consistent with the rest of the documentation.

Signed-off-by: Nihal Jere <nihal@nihaljere.xyz>
---
 Documentation/git-read-tree.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 8c3aceb832..8cbf0c82f3 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -420,8 +420,8 @@ support.
 
 SEE ALSO
 --------
-linkgit:git-write-tree[1]; linkgit:git-ls-files[1];
-linkgit:gitignore[5]; linkgit:git-sparse-checkout[1];
+linkgit:git-write-tree[1], linkgit:git-ls-files[1],
+linkgit:gitignore[5], linkgit:git-sparse-checkout[1]
 
 GIT
 ---
-- 
2.34.1

