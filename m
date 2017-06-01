Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A57020D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 15:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbdFAPvg (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 11:51:36 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34155 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751765AbdFAPv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 11:51:29 -0400
Received: by mail-qk0-f193.google.com with SMTP id d14so3039554qkb.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 08:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h2bAKPDvErCZhjI5ZMyyl7XA0+dlw9U6toXatJWB5fE=;
        b=MGn+ujgBVVSX2p/Rr1ypMBXy5Os0mZvJiEy38h5aPgBvVps3MtrYkkBxAbZylHhv2B
         1yIhsJg1f+We0C5WGsTRCdzYzcZJESat/0YEfbEDNyxDEbOBZIM15vLOOS/CK68ZtKea
         sxP6tSTSkGiBPlNXa3m+24juBbfDr4WKtDAIYk+vItDsWzu7SxxRlD/K+cbh7dkJrjk8
         EAg4lMIgMi4K2P7wPW+IzfZnOH0klk1QqQ2yIaswO4ijozLdNRWKSsM85Js3/7Kel0LM
         n8nggeR/53Ex9mZ1hEHEDKCm6IJKqsdVTGigLyUHw1tLeRAQCQkGCrYl8UNPBpZ9xGGq
         Nt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h2bAKPDvErCZhjI5ZMyyl7XA0+dlw9U6toXatJWB5fE=;
        b=tIUeTwq/ldjI0M4GcRSat03bmYC1PTjWfdGDS8sRf9Bu/QAsPNrnNiZhhcxHsST5rN
         G9M1EoPSk2zYE7fp7GfB6rPOjy52bahpXpAi6oTfya6gc5BGJ3uUmMkDhLdSUU5DAqsL
         10YQM9BKJBuYCTgZ4n00rDr6utMDpYH+HWuq7SoMw8xlXDfH+hoZyTH0nxqgv2y3uIbI
         1nTqpm8eAQ+r25XeWM3ddrR1WjeLK8IXUFJ0PQfaDFfhEciBzs7ogk0+AGcAGsC6qRtO
         1dURMvcp6hq5wt7i8htOKjSl7jdQX67TblHVt5tIcqkPbVZHSGw6sGhZNY4CVvXDXuSj
         oTUw==
X-Gm-Message-State: AKS2vOwUUvhyn1kf6x1Lcl5ZATkTfJSeF4yv1K6hDXqhwLNCvNbyCItQ
        YJ3UCH8Eita/lpQuD7Y=
X-Received: by 10.55.27.206 with SMTP id m75mr2739928qkh.166.1496332283757;
        Thu, 01 Jun 2017 08:51:23 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id w41sm12715524qtg.34.2017.06.01.08.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 08:51:23 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
Subject: [PATCH v4 5/6] fsmonitor: add documentation for the fsmonitor extension.
Date:   Thu,  1 Jun 2017 11:51:04 -0400
Message-Id: <20170601155105.28356-6-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0.windows.1.9.gc201c67b71
In-Reply-To: <20170601155105.28356-1-benpeart@microsoft.com>
References: <20170601155105.28356-1-benpeart@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This includes the core.fsmonitor setting, the query-fsmonitor hook,
and the fsmonitor index extension.

Signed-off-by: Ben Peart <benpeart@microsoft.com>
---
 Documentation/config.txt                 |  7 +++++++
 Documentation/githooks.txt               | 23 +++++++++++++++++++++++
 Documentation/technical/index-format.txt | 19 +++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e0b9fd0bc3..5211388167 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -389,6 +389,13 @@ core.protectNTFS::
 	8.3 "short" names.
 	Defaults to `true` on Windows, and `false` elsewhere.
 
+core.fsmonitor::
+	If set to true, call the query-fsmonitor hook proc which will
+	identify all files that may have had changes since the last
+	request. This information is used to speed up operations like
+	'git commit' and 'git status' by limiting what git must scan to
+	detect changes.
+
 core.trustctime::
 	If false, the ctime differences between the index and the
 	working tree are ignored; useful when the inode change time
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 706091a569..48127e8729 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -448,6 +448,29 @@ The commits are guaranteed to be listed in the order that they were
 processed by rebase.
 
 
+[[query-fsmonitor]]
+query-fsmonitor
+~~~~~~~~~~~~~~~
+
+This hook is invoked when the configuration option core.fsmonitor is
+set and git needs to identify changed or untracked files.  It takes
+two arguments, a version (currently 1) and the time in elapsed
+nanoseconds since midnight, January 1, 1970.
+
+The hook should output to stdout the list of all files in the working
+directory that may have changed since the requested time.  The logic
+should be inclusive so that it does not miss any potential changes.
+The paths should be relative to the root of the working directory
+and be separated by a single NUL.
+
+Git will limit what files it checks for changes as well as which
+directories are checked for untracked files based on the path names
+given.
+
+The exit status determines whether git will use the data from the
+hook to limit its search.  On error, it will fall back to verifying
+all files and folders.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index ade0b0c445..7aeeea6f94 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -295,3 +295,22 @@ The remaining data of each directory block is grouped by type:
     in the previous ewah bitmap.
 
   - One NUL.
+
+== File System Monitor cache
+
+  The file system monitor cache tracks files for which the query-fsmonitor
+  hook has told us about changes.  The signature for this extension is
+  { 'F', 'S', 'M', 'N' }.
+
+  The extension starts with
+
+  - 32-bit version number: the current supported version is 1.
+
+  - 64-bit time: the extension data reflects all changes through the given
+	time which is stored as the nanoseconds elapsed since midnight,
+	January 1, 1970.
+
+  - 32-bit bitmap size: the size of the CE_FSMONITOR_DIRTY bitmap.
+
+  - An ewah bitmap, the n-th bit indicates whether the n-th index entry
+    is CE_FSMONITOR_DIRTY.
-- 
2.13.0.windows.1.9.gc201c67b71

