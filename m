Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B4661F453
	for <e@80x24.org>; Wed, 23 Jan 2019 14:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfAWOkn (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 09:40:43 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:38561 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbfAWOkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 09:40:25 -0500
Received: by mail-ed1-f50.google.com with SMTP id h50so1881298ede.5
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 06:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sWRntq7x9k3MAHX6XyhqaSg3cYHmaN4xC2+w1hNZ+fo=;
        b=VcgIedq+IHAobfjmRgreWKCENGEYNiN1OLpd4ZVrVGwOcI4jtdqHUBlqrPx3QryxLA
         O1wFio0qYn2g+leSjJGQfcMN6mnPEUv5NQVV5uX0wpVwBXvhDHzzQyT7sZjNfl6CJ0EX
         kNDHiK9YYgbpZvYL888y22BX3IHzEOx4U5i5/X+mdxGjuwiuzTpvMBLmEQKSsQzCxxr7
         zO1c2SbpB3YH2MbiU3v9X1pRuRFa8SyCafnxx6XQULexAo6VLh9ilAm/h6noeGrEwQd4
         MCcHZ4LQJqOvJ9BXrchqU3oAXUjn4ksHijcYb7Uwgey+MUw6h4s4cIOK5Dve+t5AvjWe
         DPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sWRntq7x9k3MAHX6XyhqaSg3cYHmaN4xC2+w1hNZ+fo=;
        b=QoMTGQie986RDZKOsMUbB/0QdfHRxw6zDFOZ7H35XRBk5CW8LmQ4382TmVZj+NrMs1
         uhq+xI2tAcGJ5LiBikHFy3XM/eeImrdPzt86r2Si7d1Kmc4YpuEvccme2Tmakuyiw9x2
         ZbqSrXF9AuwCbAbcTO9mAJf9JWoSpr0QDJENOwi0lPBowGdQnHRMtzUztjwxxioKG0Wi
         6mLQxEzt7i03Ku84t7l/T2whKphrASMcuHZ8ZGZZmkbhK/W1Gh98qEG6pP35ECUB3qEY
         8ESRenyTu4Q88MrAegTD/C8qh5i91UevzTHVeCr+at/T6InwlPWvvb9Fgf2w/x0Hs0jq
         jSbw==
X-Gm-Message-State: AJcUukfbgMbgqggknb/gg4YukKcJDER/wzo99ATYKPsVAyUgVBjtgW2L
        WGN3ck2oHqgxI3jiUyw59+boYlF4
X-Google-Smtp-Source: ALg8bN7zWtb5U54y3XoetT8bNIBI/ZL0dvGq7TS1W6hDB5Csrd0XkvBEh6H4tgB6G4zCQOGpzuRzUw==
X-Received: by 2002:a17:906:55a:: with SMTP id k26-v6mr2733542eja.218.1548254422441;
        Wed, 23 Jan 2019 06:40:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k12sm47203ejz.4.2019.01.23.06.40.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:40:21 -0800 (PST)
Date:   Wed, 23 Jan 2019 06:40:21 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 14:40:01 GMT
Message-Id: <5bdc6a08a8b8040de3082b1690f16538fcc08682.1548254412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v4.git.gitgitgadget@gmail.com>
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 10/21] ci: move the Windows job to the top
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

