Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAEA11F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfA2OTt (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:19:49 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:46863 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbfA2OTc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:19:32 -0500
Received: by mail-ed1-f46.google.com with SMTP id o10so16042078edt.13
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 06:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6QKYRFfu4o2JPn3Gwqn28G35+BXfLMeTFboEI1dxAj4=;
        b=fwQxWEM4wg8OcPwUiMOf6h51tpb+wCkH+dHCO2cEa0jUlP5GfW3VfzeFuchMTkneo6
         U6oVhwaFlcPeafjLGxkbiQCpWC8xJIAnaKy/p/5nQpSmDP3xY1WWP7fA0tlRkxJGijGS
         8b1ujnbJOKLp/WCEO07N7Bezp4dx44i+G/QpAfHH9SZXhyLRQOkqSRrYcg/H8QFfRnXp
         mdOdOnezOfRK0C3zPgTz/FN0RWySdl7DGS8E6aur3U7O0hgVUB2ATPMbT/xyCK4Cpqwz
         Tm3gf/g6xekHpATMuVauRI/TE21lHsmPJHLAuSTV5PcKYQN00p2ebF0uEEzjumtemueJ
         CBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6QKYRFfu4o2JPn3Gwqn28G35+BXfLMeTFboEI1dxAj4=;
        b=PS6DOqMZS9qjcBb33f3HZRwgioUtEurNbxWCyq6blmcGDkAipdtbx3thJk9YMMsDF0
         m1PkkU3YH3PmcJN/JvbDGZ9M/1dcr+iVFZspwbbmIAwqcjb7S2PlZSqGCgXTODsz3sRq
         RWo9+sr1cSuzmVW8eSQ1Cuo6eVJp1zNlxaHlSt0CH9Pm/WW19G53Vu4KDeR8unHzmoEw
         coDJDFNQivvDUN+qMKKwtKBiwqsLktKvk+fmA8hviUqHicULNtxCGZiK/nwTRi8uh/Yn
         f8vdbXoasY9rOsQ3DEkZDQQmIPN0wP8Ylm3LctofohBXHM3fevMaEuDFZzdYbDpHtN5r
         h15w==
X-Gm-Message-State: AJcUukdpsm9Nlc7ldCjPzE85j9N1knlK1baW7XPY8Z+BXx+3ma26nnJa
        X0H93zB5E1A59czvyZCNKY1+Z1E+
X-Google-Smtp-Source: ALg8bN4R/yLooj6wjkgCIRl+xlgjs57A809Agp9UbE1V6JQgUuoAaMUqdVHOeArTnLFD4qcg/53k9w==
X-Received: by 2002:a17:906:1086:: with SMTP id u6-v6mr23196777eju.82.1548771570926;
        Tue, 29 Jan 2019 06:19:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z40sm14522402edz.86.2019.01.29.06.19.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 06:19:30 -0800 (PST)
Date:   Tue, 29 Jan 2019 06:19:30 -0800 (PST)
X-Google-Original-Date: Tue, 29 Jan 2019 14:19:09 GMT
Message-Id: <d5651317817a44d8f8b565c2cc14f59dfc432916.1548771561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v6.git.gitgitgadget@gmail.com>
References: <pull.31.v5.git.gitgitgadget@gmail.com>
        <pull.31.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 10/21] ci: add a Windows job to the Azure Pipelines
 definition
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

Previously, we did not have robust support for Windows in our CI
definition, simply because Travis cannot accommodate our needs (even
after Travis added experimental Windows support very recently, it takes
longer than Travis' 50 minute timeout to build Git and run the test
suite on Windows). Instead, we used a hack that started a dedicated
Azure Pipeline from Travis and waited for the output, often timing out
(which is quite fragile, as we found out).

With this commit, we finally have first-class support for Windows in our
CI definition (in the Azure Pipelines one, that is).

Due to our reliance on Unix shell scripting in the test suite, combined
with the challenges on executing such scripts on Windows, the Windows
job currently takes a whopping ~1h20m to complete. Which is *far* longer
than the next-longest job takes (linux-gcc, ~35m).

Now, Azure Pipelines's free tier for open source projects (such as Git)
offers up to 10 concurrent jobs for free, meaning that the overall run
time will be dominated by the slowest job(s).

Therefore, it makes sense to start the Windows job first, to minimize
the time the entire build takes from start to end (which is now pretty
safely the run time of the Windows job).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 azure-pipelines.yml | 91 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/azure-pipelines.yml b/azure-pipelines.yml
index 8cdef105c6..0f7b2125a1 100644
--- a/azure-pipelines.yml
+++ b/azure-pipelines.yml
@@ -3,6 +3,97 @@ resources:
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
+  - task: PublishBuildArtifacts@1
+    displayName: 'Publish trash directories of failed tests'
+    condition: failed()
+    inputs:
+      PathtoPublish: t/failed-test-artifacts
+      ArtifactName: failed-test-artifacts
+
 - job: linux_clang
   displayName: linux-clang
   condition: succeeded()
-- 
gitgitgadget

