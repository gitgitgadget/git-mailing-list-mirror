Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB259C433F5
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 14:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347049AbiDAO2n (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 10:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346918AbiDAO2T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 10:28:19 -0400
Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [IPv6:2001:8b0:0:30::52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304702856BA
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 07:26:28 -0700 (PDT)
Received: from [195.110.77.193] (helo=red.nvidia.com)
        by painless-b.tch.aa.net.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jholdsworth@nvidia.com>)
        id 1naIEO-009TW3-1X; Fri, 01 Apr 2022 15:26:27 +0100
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
Subject: [PATCH v5 19/22] git-p4: only seperate code blocks by a single empty line
Date:   Fri,  1 Apr 2022 15:25:01 +0100
Message-Id: <20220401142504.58995-20-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220401142504.58995-1-jholdsworth@nvidia.com>
References: <20220401142504.58995-1-jholdsworth@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that blank lines should be used sparingly to separate
sections in the "Blank Lines" section:

https://www.python.org/dev/peps/pep-0008/#blank-lines

This patch replaces all double blank-line separations with a single
blank line.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 2f2450f7d9..c003b6246d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3521,7 +3521,6 @@ def getBranchMapping(self):
                 if source not in self.knownBranches:
                     lostAndFoundBranches.add(source)
 
-
         for branch in lostAndFoundBranches:
             self.knownBranches[branch] = branch
 
@@ -3745,7 +3744,6 @@ def importHeadRevision(self, revision):
                 sys.stderr.write("p4 exitcode: %s\n" % info['p4ExitCode'])
                 sys.exit(1)
 
-
             change = int(info["change"])
             if change > newestRevision:
                 newestRevision = change
@@ -3773,7 +3771,6 @@ def importHeadRevision(self, revision):
             print("IO error details: {}".format(err))
             print(self.gitError.read())
 
-
     def importRevisions(self, args, branch_arg_given):
         changes = []
 
-- 
2.35.GIT

