Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79B91201CF
	for <e@80x24.org>; Thu, 18 May 2017 20:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754179AbdERUOV (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 16:14:21 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34074 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753221AbdERUOM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 16:14:12 -0400
Received: by mail-qk0-f193.google.com with SMTP id u75so7542426qka.1
        for <git@vger.kernel.org>; Thu, 18 May 2017 13:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kgPHzv6j4dlCEBsbxgoaRlwZIXiDQNLk15ZewNgOIbg=;
        b=mHgjmnYXEGMfJVTWOJw7ceGiN5rqCqv7TMTw75ixwsTt3hWeQ6hUVbYzNwM+6mER59
         jjkwGtFSCWGVoPJKhw1ud+zjm1Vkn/iI0Arj5OokK8CkhUdK+5qa+8t3OKbJWy30HEqv
         XiF9jBm5HrMpRyIYfrDM20fxHGiwAxnuzXQzEDLtdMvKZaJlqGJ2vfyUZJ5gxpfZLLS6
         sur7YXCLsfFqKS70irHdDvZztjCksN6rB8kgK4SSKLbv1sOhPFzMJPrOInyGO6TvIcUP
         D5CQeqbnhvQjRaQ0W+d1plkcznYGxPXRZrv3eabVWlCCrD2dXf/FwOO9u6TlOLTBTMFL
         ft0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kgPHzv6j4dlCEBsbxgoaRlwZIXiDQNLk15ZewNgOIbg=;
        b=t9YYua8OduD8vHgcnbA/Hjo3OeOFRk1WQv1v2V7MJKzlVpkIcFMSN8/ztiKh4Rf41g
         +//h+b8Tet6VnW5ZS1RCR0KX+PM9JoggxFD2zcCbYa754YqqBxMeeLC1YyzrfB1vkDox
         c/wPxBs6rKe0iOnI8iMIu1CsuqTkDplLhkVFsLW6/pxGBevmbjTNgwUCyP4QOENjLyDi
         ZEs6Q/98dgJJRy0pij718rbxQofKHIGiJybC00TjVNwrqis2szdVNESEjMIMDBSPnlb6
         Zm+KL1F/F/TwloCM5d6cLvh914M2+jRTLgpND2V6oZGSpI+SLR2gytJN9DERycbVnD0r
         eciA==
X-Gm-Message-State: AODbwcDaCogmFWOOOvxruBwJvts7Fa4T34pHTw5CN2qFg+BZO1hq7BIP
        JRaZTLvi7ZWdvQ==
X-Received: by 10.55.24.9 with SMTP id j9mr5311803qkh.25.1495138451883;
        Thu, 18 May 2017 13:14:11 -0700 (PDT)
Received: from localhost.localdomain ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id y17sm4369133qtc.29.2017.05.18.13.14.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 May 2017 13:14:11 -0700 (PDT)
From:   Ben Peart <peartben@gmail.com>
X-Google-Original-From: Ben Peart <benpeart@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, benpeart@microsoft.com, pclouds@gmail.com,
        johannes.schindelin@gmx.de, David.Turner@twosigma.com,
        peff@peff.net
Subject: [PATCH v2 5/6] fsmonitor: add documentation for the fsmonitor extension.
Date:   Thu, 18 May 2017 16:13:32 -0400
Message-Id: <20170518201333.13088-6-benpeart@microsoft.com>
X-Mailer: git-send-email 2.13.0.windows.1.6.g4597375fc3
In-Reply-To: <20170518201333.13088-1-benpeart@microsoft.com>
References: <20170518201333.13088-1-benpeart@microsoft.com>
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
 Documentation/technical/index-format.txt | 18 ++++++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 96e9cf8b73..4ffbf0d4c2 100644
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
index 706091a569..f7b4b4a844 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -448,6 +448,29 @@ The commits are guaranteed to be listed in the order that they were
 processed by rebase.
 
 
+[[query-fsmonitor]]
+query-fsmonitor
+~~~~~~~~~~~~
+
+This hook is invoked when the configuration option core.fsmonitor is
+set and git needs to identify changed or untracked files.  It takes
+a single argument which is the time in elapsed seconds since midnight,
+January 1, 1970.
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
index ade0b0c445..b002d23c05 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -295,3 +295,21 @@ The remaining data of each directory block is grouped by type:
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
+	time which is stored as the seconds elapsed since midnight, January 1, 1970.
+
+  - 32-bit bitmap size: the size of the CE_FSMONITOR_DIRTY bitmap.
+
+  - An ewah bitmap, the n-th bit indicates whether the n-th index entry
+    is CE_FSMONITOR_DIRTY.
-- 
2.13.0.windows.1.6.g4597375fc3

