Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A37FC04ABA
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEA36222F9
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgL1Wzf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:35 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:59416 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbgL1Tai (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 14:30:38 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1ktyDN-006Pn6-0t
        for git@vger.kernel.org; Mon, 28 Dec 2020 12:29:57 -0700
Received: from mta5.zcs.xmission.com ([166.70.13.69])
        by in02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <seth@eseth.com>)
        id 1ktyDM-001lpO-1U
        for git@vger.kernel.org; Mon, 28 Dec 2020 12:29:56 -0700
Received: from localhost (localhost [127.0.0.1])
        by mta5.zcs.xmission.com (Postfix) with ESMTP id E99C012806A8;
        Mon, 28 Dec 2020 12:29:55 -0700 (MST)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta5.zcs.xmission.com
Received: from mta5.zcs.xmission.com ([127.0.0.1])
        by localhost (mta5.zcs.xmission.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MG7JDkPWzrUX; Mon, 28 Dec 2020 12:29:55 -0700 (MST)
Received: from localhost.localdomain (unknown [139.60.10.209])
        by mta5.zcs.xmission.com (Postfix) with ESMTPSA id 7D86E12806BB;
        Mon, 28 Dec 2020 12:29:55 -0700 (MST)
From:   Seth House <seth@eseth.com>
To:     git@vger.kernel.org
Cc:     Seth House <seth@eseth.com>
Date:   Mon, 28 Dec 2020 12:29:16 -0700
Message-Id: <20201228192919.1195211-3-seth@eseth.com>
X-Mailer: git-send-email 2.30.0.rc2.4.g8f3eabcc0e
In-Reply-To: <20201228192919.1195211-1-seth@eseth.com>
References: <20201228045427.1166911-1-seth@eseth.com>
 <20201228192919.1195211-1-seth@eseth.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1ktyDM-001lpO-1U;;;mid=<20201228192919.1195211-3-seth@eseth.com>;;;hst=in02.mta.xmission.com;;;ip=166.70.13.69;;;frm=seth@eseth.com;;;spf=none
X-SA-Exim-Connect-IP: 166.70.13.69
X-SA-Exim-Mail-From: seth@eseth.com
Subject: [PATCH v9 2/5] mergetool: alphabetize the mergetool config docs
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ordering in this file has drifted a little. Let's make things better
while we're adding new entres. :)

Signed-off-by: Seth House <seth@eseth.com>
---
 Documentation/config/mergetool.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/mergetool.txt b/Documentation/config/mergetool.txt
index 7ce6d0d3ac..3291fa7102 100644
--- a/Documentation/config/mergetool.txt
+++ b/Documentation/config/mergetool.txt
@@ -1,7 +1,3 @@
-mergetool.<tool>.path::
-	Override the path for the given tool.  This is useful in case
-	your tool is not in the PATH.
-
 mergetool.<tool>.cmd::
 	Specify the command to invoke the specified merge tool.  The
 	specified command is evaluated in shell with the following
@@ -13,6 +9,10 @@ mergetool.<tool>.cmd::
 	merged; 'MERGED' contains the name of the file to which the merge
 	tool should write the results of a successful merge.
 
+mergetool.<tool>.path::
+	Override the path for the given tool.  This is useful in case
+	your tool is not in the PATH.
+
 mergetool.<tool>.trustExitCode::
 	For a custom merge command, specify whether the exit code of
 	the merge command can be used to determine whether the merge was
@@ -40,6 +40,9 @@ mergetool.meld.useAutoMerge::
 	value of `false` avoids using `--auto-merge` altogether, and is the
 	default value.
 
+mergetool.autoMerge::
+	Remove lines without conflicts from all the files. Defaults to `true`.
+
 mergetool.keepBackup::
 	After performing a merge, the original file with conflict markers
 	can be saved as a file with a `.orig` extension.  If this variable
@@ -53,14 +56,11 @@ mergetool.keepTemporaries::
 	preserved, otherwise they will be removed after the tool has
 	exited. Defaults to `false`.
 
+mergetool.prompt::
+	Prompt before each invocation of the merge resolution program.
+
 mergetool.writeToTemp::
 	Git writes temporary 'BASE', 'LOCAL', and 'REMOTE' versions of
 	conflicting files in the worktree by default.  Git will attempt
 	to use a temporary directory for these files when set `true`.
 	Defaults to `false`.
-
-mergetool.prompt::
-	Prompt before each invocation of the merge resolution program.
-
-mergetool.autoMerge::
-	Remove lines without conflicts from all the files. Defaults to `true`.
-- 
2.29.2


