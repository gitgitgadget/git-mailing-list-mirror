Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4292E1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 21:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfKMVOb (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 16:14:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37643 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKMVOb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 16:14:31 -0500
Received: by mail-wm1-f68.google.com with SMTP id b17so3612842wmj.2
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 13:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uBGnmh6C8b3U8srmNO7oGNYBad2Ysh1xnMTiZq5goYM=;
        b=S4VBwJ5Hx3lsQFuVTmGkoDuRJq84CuWXHQsBQ1jEYvwCsA0U/p8ZMYn04t4x026hTf
         wdhPAwhkrROiHXx6ucy07V9nxoAUaHOOd6yslxbh3HHoF534QVtJrD9unJxS7yQ3O41a
         TrHZMyIKD2JoOzj04pNH4jzwUkIZDd7FAoFwMOo6yzYH9I6ZJci3cqnUTLjaKqVaeMOJ
         VOIVZ1j7k9U5qme4Kyq/1GN3FkyByRxkmW1ZoZZqyIgVHAhcblUeRI29UjUCccCz4YOw
         2YZj6OwyRmWCrNtzZeaebuyC2Cu8Yu8Gn7nsMQq/bd6tx3mgPfu1Tkte/EGfu9Q7M2pH
         mMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uBGnmh6C8b3U8srmNO7oGNYBad2Ysh1xnMTiZq5goYM=;
        b=ExHB8qC+da/K3LqiNPmaDqQvYZFilXQGziDit/lEm/kfYRjBWZSZY4y7iMsOsy7+If
         92oURiSu1sYF7y4gfdSPzT++sOQcS4VKYIwS7kLtMGeC8790hkkZYdtNP3IM301WJGbo
         W9XdFGTdEnVIZFdQ/fRnzckjT+wCq+JFpFA/aajm0ZSrxa4xkD/3Bl/lW7PywBOutR8I
         2Tbrx5CYQP3uLZ9VPxvpHXdmF1TfvKGn8ts6iMNXkEzVy2GFsFefE/g9C+CafZC/euUQ
         JwBpcz8BszBLhT7BAKNKmJfTYFsyZTLaR9Sgl5pEg478ykJof98H6Op7qj6neErPnV/U
         WtNw==
X-Gm-Message-State: APjAAAWIrP5QcuplRMh5C48aYpar6ceyhy3la8RzmQfdeeRclWuBJaN5
        i2IvEBOQS1pNb2/+XIFp4ym9fxcQ
X-Google-Smtp-Source: APXvYqzwiINg9O75StUE/OapzVtB4L0JianRjWfDYwbcJcVt8OlZ0Su265Xrwk1RnmGhpMFkFa1jAg==
X-Received: by 2002:a1c:1b07:: with SMTP id b7mr4711976wmb.111.1573679667914;
        Wed, 13 Nov 2019 13:14:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t24sm5561622wra.55.2019.11.13.13.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 13:14:27 -0800 (PST)
Message-Id: <98bae92fda9ca01d01b2e9fb70b04b00470e7bec.1573679665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.465.git.1573679665.gitgitgadget@gmail.com>
References: <pull.465.git.1573679665.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Nov 2019 21:14:25 +0000
Subject: [PATCH 2/2] Added general variable git-p4.binary and added a default
 for windows of 'P4.EXE'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 Documentation/git-p4.txt |  5 +++++
 git-p4.py                | 14 +++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 3494a1db3e..e206e69250 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -547,6 +547,11 @@ git-p4.retries::
 	Set the value to 0 to disable retries or if your p4 version
 	does not support retries (pre 2012.2).
 
+git-p4.binary::
+	Specifies the p4 executable used by git-p4 to process commands.
+	The default value for Windows is `p4.exe` and for all other
+	systems the default is `p4`. 
+
 Clone and sync variables
 ~~~~~~~~~~~~~~~~~~~~~~~~
 git-p4.syncFromOrigin::
diff --git a/git-p4.py b/git-p4.py
index 6e8b3a26cd..160d966ee1 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -26,6 +26,8 @@
 import zlib
 import ctypes
 import errno
+import os.path
+from os import path
 
 # support basestring in python3
 try:
@@ -85,7 +87,17 @@ def p4_build_cmd(cmd):
     location. It means that hooking into the environment, or other configuration
     can be done more easily.
     """
-    real_cmd = ["p4"]
+    # Look for the P4 binary
+    p4bin = gitConfig("git-p4.binary")
+    real_cmd = []
+    if p4bin != "":
+        if path.exists(p4bin):
+            real_cmd = [p4bin]
+    if real_cmd == []:
+        if (platform.system() == "Windows"):
+            real_cmd = ["p4.exe"]    
+        else:
+            real_cmd = ["p4"]
 
     user = gitConfig("git-p4.user")
     if len(user) > 0:
-- 
gitgitgadget
