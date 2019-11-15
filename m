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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F5B51F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 14:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfKOOnE (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 09:43:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36741 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbfKOOnE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 09:43:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id c22so10680825wmd.1
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 06:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uBGnmh6C8b3U8srmNO7oGNYBad2Ysh1xnMTiZq5goYM=;
        b=FZAXUDKsXoPxzQ6FPDxCWEyxBZ18boMet4wCC8CL/inWOBgTi9qD3IpR7xoVQYPjjb
         4g32h4DzGvLKGtNlPVqMK/H12KMxYdiZ1T7YuKMSM9UunrvWRi7JEjX9p6uRWFXQCM/N
         QuRfNQFgm3ng3ivbrHRXsHixDaf4DZoNFpa9lqPvk3O5aq2NV0eKSNP+LzpKqefoYqD7
         ZYqwdjpuz2pLTgTiLlooZAK2TCDr38sjI00hUQ6XI/Y4yoOGlY1G1h8R1usT8+wDwpFn
         cO4F2PV6jaQFiM8jDqONf65+/L8qOP5WsagEIXje0Qf5g7KVv5eAsydC0iBd4vyKZkn6
         Lg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uBGnmh6C8b3U8srmNO7oGNYBad2Ysh1xnMTiZq5goYM=;
        b=CsvyTW4FwNIdBtiXy7zS2IBbIDCxnb306emhu67GnkH9gP6r+/YtQpakci51ni9hXl
         +FDlqPvkAi/BmrgWmtbn5nMQKolzHs3kxvgdc68nJC3X+lNkLrUalnDYwxaEVV3IetG7
         LLtbq25WW7AaUcWcINP3EvKK55hXdAO29Y/e7uMJiBEaCG5tAXWvwynnI4wD6dcgh/ht
         y+0OCTX5Z6dVKXzZaYQOOBVmWHL1V6poRNyIfotZGdzSPlZNIoH6Sgkgysv7ywWIVxFF
         L6PXm+7kFqkTjo+fHWPLwF4nsSYpCuMhOF9szGISYdrseSTUTBn67PgTW+aOumsAVtO9
         eMjA==
X-Gm-Message-State: APjAAAWfIAoI85YqdDNEZE6axR+g6tqPDoRti/T3BAa5FPs9cakQOyY4
        N45i2/5Xl3JWOaXeWRtWp2zKkEBD
X-Google-Smtp-Source: APXvYqynhKnJnM3xSfq8+4th650ZKsl3ChfCa+uyXN9ChtO8OZVSy2zMLxRdG1prbOM2sIO3B1rIEA==
X-Received: by 2002:a7b:c743:: with SMTP id w3mr15588962wmk.165.1573828980695;
        Fri, 15 Nov 2019 06:43:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j11sm11362657wrq.26.2019.11.15.06.43.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 06:43:00 -0800 (PST)
Message-Id: <98bae92fda9ca01d01b2e9fb70b04b00470e7bec.1573828978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.465.v2.git.1573828978.gitgitgadget@gmail.com>
References: <pull.465.git.1573679665.gitgitgadget@gmail.com>
        <pull.465.v2.git.1573828978.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 14:42:57 +0000
Subject: [PATCH v2 2/3] Added general variable git-p4.binary and added a
 default for windows of 'P4.EXE'
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

