Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F35FA1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393226AbfAPNgY (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:36:24 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36920 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393214AbfAPNgX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:36:23 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so5437508edb.4
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sWRntq7x9k3MAHX6XyhqaSg3cYHmaN4xC2+w1hNZ+fo=;
        b=ZGQSOZYxgRscH5VVJ9QF/a/dgBYnyE6HLZnxHtwyp3yIjC4vAiQxUiRvLJEXtJu6jp
         EPHfA/lg2y4Qey21R+KnHhCfyD85YOeSdkvHl9JdgwnNM6a6/UEatgJiH1zr/xhrbzRh
         r0211hjpH9GYeN8LtIyLosoqemuTWZC6k8JB6dW5jQtz6mG9Mou1X2JeKTV1s+9JF6w0
         E9BL9wvfVJh/4/V+caeUZwjiFhM+jKJ6YLhlYXdf5rzwGBfFk2kd90ICJrUSDtZ3X/N4
         +lzlu7R5egfqE8qM44QNdZoRk2k6OLRgGRgqo+CoApxB4WV6IAcq3ryKwt2vzTOap8+x
         YtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sWRntq7x9k3MAHX6XyhqaSg3cYHmaN4xC2+w1hNZ+fo=;
        b=dygyyVFmlfsNqfkgNq1QnYTNSXrXHMAg2V92ZPdk7rtGELR1kF9aPjqai9SRBaN7jM
         fdHU+ffxGhgIk4VyumbSSizYnphJYKhytNbd/ufbvpmO4tN2GFaqAT0daJr6MRs8tZjo
         GSgJBmn+OzP/pbAdmsWTlqojUus4/fvDox18DSVXKryjJ/oL9BaR7jMcrgK0AQ666Adw
         10WZvdFqJ2Un9SHVshOXak+yTeoADBK1HkefULpApVE9gmyTguLfYk8SyAvKEj9XIVXy
         9jtr0HN4LdYIzKJiydBns08AsFQKM6+4Tg2r7uTMu4VJjPhueI+71OvV/ZCZe/jOiCBG
         WDIQ==
X-Gm-Message-State: AJcUukehPiwysDrb2nwPUjzKVLFmjdcnOLPRrAjlLHUp9Wb8hGAEuNFD
        GAhLC1I0SoI9OYzWzpQkl7rMbD/t
X-Google-Smtp-Source: ALg8bN5dIILwSeoT9C1REWEtOevAoZw+D781l2XGeGgyFXBLNGOup6htX0ELTXrBbCN1XY4OcxfU9w==
X-Received: by 2002:a50:b3c9:: with SMTP id t9mr7598093edd.270.1547645780667;
        Wed, 16 Jan 2019 05:36:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v14sm5260082edq.74.2019.01.16.05.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:36:20 -0800 (PST)
Date:   Wed, 16 Jan 2019 05:36:20 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 13:35:58 GMT
Message-Id: <58bb8d0469a4a9f7bd422b7ca60df4ab70ef5a29.1547645770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v3.git.gitgitgadget@gmail.com>
References: <pull.31.v2.git.gitgitgadget@gmail.com>
        <pull.31.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 10/21] ci: move the Windows job to the top
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The Windows job currently takes a whopping ~1h20m to complete. Which is
*far* longer than the next-longest job takes (linux-gcc, ~35m). As such,
it makes sense to start the Windows job first, to minimize the overall
run time (which is now pretty safely the run time of the Windows job).

This affects only the Azure Pipelines configuration, not the Travis one,
of course, as Travis cannot run our Windows job: 1h20m is distinctly
longer than the 50 minute timeout of Travis' free tier.

This commit is best viewed with `--color-moved`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 azure-pipelines.yml | 172 ++++++++++++++++++++++----------------------
 1 file changed, 86 insertions(+), 86 deletions(-)

diff --git a/azure-pipelines.yml b/azure-pipelines.yml
index f3cabb0dd0..e44d2733a4 100644
--- a/azure-pipelines.yml
+++ b/azure-pipelines.yml
@@ -3,6 +3,92 @@ resources:
   fetchDepth: 1
 
 jobs:
+- job: windows
+  displayName: Windows
+  condition: succeeded()
+  pool: Hosted
+  timeoutInMinutes: 240
+  steps:
+  - powershell: |
+      if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
+        net use s: \\gitfileshare.file.core.windows.net\test-cache "$GITFILESHAREPWD" /user:AZURE\gitfileshare /persistent:no
+        cmd /c mklink /d "$(Build.SourcesDirectory)\test-cache" S:\
+      }
+    displayName: 'Mount test-cache'
+    env:
+      GITFILESHAREPWD: $(gitfileshare.pwd)
+  - powershell: |
+      # Helper to check the error level of the latest command (exit with error when appropriate)
+      function c() { if (!$?) { exit(1) } }
+
+      # Add build agent's MinGit to PATH
+      $env:PATH = $env:AGENT_HOMEDIRECTORY +"\externals\\git\cmd;" +$env:PATH
+
+      # Helper to initialize (or update) a Git worktree
+      function init ($path, $url, $set_origin) {
+        if (Test-Path $path) {
+          cd $path; c
+          if (Test-Path .git) {
+            & git init; c
+          } else {
+            & git status
+          }
+        } else {
+          & git init $path; c
+          cd $path; c
+        }
+        & git config core.autocrlf false; c
+        & git config core.untrackedCache true; c
+        if (($set_origin -ne 0) -and !(git config remote.origin.url)) {
+          & git remote add origin $url; c
+        }
+        & git fetch --depth=1 $url master; c
+        & git reset --hard FETCH_HEAD; c
+        & git clean -df; c
+      }
+
+      # Initialize Git for Windows' SDK
+      $sdk_path = "$(Build.SourcesDirectory)\git-sdk-64"
+      init "$sdk_path" "https://dev.azure.com/git-for-windows/git-sdk-64/_git/git-sdk-64" 0
+
+      # Let Git ignore the SDK and the test-cache
+      "/git-sdk-64/`n/test-cache/`n" | Out-File -NoNewLine -Encoding ascii -Append "$(Build.SourcesDirectory)\.git\info\exclude"
+    displayName: 'Initialize the Git for Windows SDK'
+  - powershell: |
+      & "git-sdk-64\git-cmd.exe" --command=usr\\bin\\bash.exe -lc @"
+        export MAKEFLAGS=-j10
+        export DEVELOPER=1
+        export NO_PERL=1
+        export NO_SVN_TESTS=1
+        export GIT_TEST_SKIP_REBASE_P=1
+
+        ci/run-build-and-tests.sh || {
+          ci/print-test-failures.sh
+          exit 1
+        }
+      "@
+      if (!$?) { exit(1) }
+    displayName: 'Build & Test'
+    env:
+      HOME: $(Build.SourcesDirectory)
+      MSYSTEM: MINGW64
+  - powershell: |
+      if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
+        cmd /c rmdir "$(Build.SourcesDirectory)\test-cache"
+      }
+    displayName: 'Unmount test-cache'
+    condition: true
+    env:
+      GITFILESHAREPWD: $(gitfileshare.pwd)
+  - task: PublishTestResults@2
+    displayName: 'Publish Test Results **/TEST-*.xml'
+    inputs:
+      mergeTestResults: true
+      testRunTitle: 'windows'
+      platform: Windows
+      publishRunAttachments: false
+    condition: succeededOrFailed()
+
 - job: linux_clang
   displayName: linux-clang
   condition: succeeded()
@@ -153,92 +239,6 @@ jobs:
       publishRunAttachments: false
     condition: succeededOrFailed()
 
-- job: windows
-  displayName: Windows
-  condition: succeeded()
-  pool: Hosted
-  timeoutInMinutes: 240
-  steps:
-  - powershell: |
-      if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
-        net use s: \\gitfileshare.file.core.windows.net\test-cache "$GITFILESHAREPWD" /user:AZURE\gitfileshare /persistent:no
-        cmd /c mklink /d "$(Build.SourcesDirectory)\test-cache" S:\
-      }
-    displayName: 'Mount test-cache'
-    env:
-      GITFILESHAREPWD: $(gitfileshare.pwd)
-  - powershell: |
-      # Helper to check the error level of the latest command (exit with error when appropriate)
-      function c() { if (!$?) { exit(1) } }
-
-      # Add build agent's MinGit to PATH
-      $env:PATH = $env:AGENT_HOMEDIRECTORY +"\externals\\git\cmd;" +$env:PATH
-
-      # Helper to initialize (or update) a Git worktree
-      function init ($path, $url, $set_origin) {
-        if (Test-Path $path) {
-          cd $path; c
-          if (Test-Path .git) {
-            & git init; c
-          } else {
-            & git status
-          }
-        } else {
-          & git init $path; c
-          cd $path; c
-        }
-        & git config core.autocrlf false; c
-        & git config core.untrackedCache true; c
-        if (($set_origin -ne 0) -and !(git config remote.origin.url)) {
-          & git remote add origin $url; c
-        }
-        & git fetch --depth=1 $url master; c
-        & git reset --hard FETCH_HEAD; c
-        & git clean -df; c
-      }
-
-      # Initialize Git for Windows' SDK
-      $sdk_path = "$(Build.SourcesDirectory)\git-sdk-64"
-      init "$sdk_path" "https://dev.azure.com/git-for-windows/git-sdk-64/_git/git-sdk-64" 0
-
-      # Let Git ignore the SDK and the test-cache
-      "/git-sdk-64/`n/test-cache/`n" | Out-File -NoNewLine -Encoding ascii -Append "$(Build.SourcesDirectory)\.git\info\exclude"
-    displayName: 'Initialize the Git for Windows SDK'
-  - powershell: |
-      & "git-sdk-64\git-cmd.exe" --command=usr\\bin\\bash.exe -lc @"
-        export MAKEFLAGS=-j10
-        export DEVELOPER=1
-        export NO_PERL=1
-        export NO_SVN_TESTS=1
-        export GIT_TEST_SKIP_REBASE_P=1
-
-        ci/run-build-and-tests.sh || {
-          ci/print-test-failures.sh
-          exit 1
-        }
-      "@
-      if (!$?) { exit(1) }
-    displayName: 'Build & Test'
-    env:
-      HOME: $(Build.SourcesDirectory)
-      MSYSTEM: MINGW64
-  - powershell: |
-      if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
-        cmd /c rmdir "$(Build.SourcesDirectory)\test-cache"
-      }
-    displayName: 'Unmount test-cache'
-    condition: true
-    env:
-      GITFILESHAREPWD: $(gitfileshare.pwd)
-  - task: PublishTestResults@2
-    displayName: 'Publish Test Results **/TEST-*.xml'
-    inputs:
-      mergeTestResults: true
-      testRunTitle: 'windows'
-      platform: Windows
-      publishRunAttachments: false
-    condition: succeededOrFailed()
-
 - job: linux32
   displayName: Linux32
   condition: succeeded()
-- 
gitgitgadget

