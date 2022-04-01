Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2704C4332F
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 15:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348780AbiDAPFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349873AbiDAOqy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 10:46:54 -0400
Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [IPv6:2001:8b0:0:30::52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEAC29EE29
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 07:36:41 -0700 (PDT)
Received: from [195.110.77.193] (helo=red.nvidia.com)
        by painless-b.tch.aa.net.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jholdsworth@nvidia.com>)
        id 1naIE7-009TW3-G6; Fri, 01 Apr 2022 15:26:10 +0100
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
Subject: [PATCH v5 09/22] git-p4: remove spaces around default arguments
Date:   Fri,  1 Apr 2022 15:24:51 +0100
Message-Id: <20220401142504.58995-10-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220401142504.58995-1-jholdsworth@nvidia.com>
References: <20220401142504.58995-1-jholdsworth@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

PEP8 recommends that there should be no spaces around the = sign of
default argument values of functions.

This guideline is described here:
https://www.python.org/dev/peps/pep-0008/#other-recommendations

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index f8d07cfd7f..0353bca289 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1040,7 +1040,7 @@ def branch_exists(branch):
     return out.rstrip() == branch
 
 
-def findUpstreamBranchPoint(head = "HEAD"):
+def findUpstreamBranchPoint(head="HEAD"):
     branches = p4BranchesInGit()
     # map from depot-path to branch name
     branchByDepotPath = {}
@@ -1068,7 +1068,7 @@ def findUpstreamBranchPoint(head = "HEAD"):
     return ["", settings]
 
 
-def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent=True):
+def createOrUpdateBranchesFromOrigin(localRefPrefix="refs/remotes/p4/", silent=True):
     if not silent:
         print("Creating/updating branch(es) in %s based on origin branch(es)"
                % localRefPrefix)
@@ -2838,7 +2838,7 @@ def isPathWanted(self, path):
                 return True
         return False
 
-    def extractFilesFromCommit(self, commit, shelved=False, shelved_cl = 0):
+    def extractFilesFromCommit(self, commit, shelved=False, shelved_cl=0):
         files = []
         fnum = 0
         while "depotFile%s" % fnum in commit:
@@ -3269,7 +3269,7 @@ def findShadowedFiles(self, files, change):
                     'rev': record['headRev'],
                     'type': record['headType']})
 
-    def commit(self, details, files, branch, parent = "", allow_empty=False):
+    def commit(self, details, files, branch, parent="", allow_empty=False):
         epoch = details["time"]
         author = details["user"]
         jobs = self.extractJobsFromCommit(details)
@@ -4415,8 +4415,8 @@ def main():
 
     parser = optparse.OptionParser(cmd.usage.replace("%prog", "%prog " + cmdName),
                                    options,
-                                   description = cmd.description,
-                                   formatter = HelpFormatter())
+                                   description=cmd.description,
+                                   formatter=HelpFormatter())
 
     try:
         (cmd, args) = parser.parse_args(sys.argv[2:], cmd)
-- 
2.35.GIT

