Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D515FC43217
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 14:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347116AbiDAO27 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 10:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346981AbiDAO2T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 10:28:19 -0400
Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [IPv6:2001:8b0:0:30::52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E9B2856B1
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 07:26:26 -0700 (PDT)
Received: from [195.110.77.193] (helo=red.nvidia.com)
        by painless-b.tch.aa.net.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jholdsworth@nvidia.com>)
        id 1naIEL-009TW3-P0; Fri, 01 Apr 2022 15:26:25 +0100
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v5 14/22] git-p4: remove spaces between dictionary keys and colons
Date:   Fri,  1 Apr 2022 15:24:56 +0100
Message-Id: <20220401142504.58995-15-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220401142504.58995-1-jholdsworth@nvidia.com>
References: <20220401142504.58995-1-jholdsworth@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 makes no specific recommendation about spaces preceding colons in
dictionary declarations, but all the code examples contained with it
declare dictionaries with a single space after the colon, and none
before.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 471a26744a..167bc19775 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -4379,13 +4379,13 @@ def printUsage(commands):
 
 
 commands = {
-    "submit" : P4Submit,
-    "commit" : P4Submit,
-    "sync" : P4Sync,
-    "rebase" : P4Rebase,
-    "clone" : P4Clone,
-    "branches" : P4Branches,
-    "unshelve" : P4Unshelve,
+    "submit": P4Submit,
+    "commit": P4Submit,
+    "sync": P4Sync,
+    "rebase": P4Rebase,
+    "clone": P4Clone,
+    "branches": P4Branches,
+    "unshelve": P4Unshelve,
 }
 
 
-- 
2.35.GIT

