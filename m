Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41D9E1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390502AbfAPNg0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:36:26 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:44299 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390514AbfAPNgY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:36:24 -0500
Received: by mail-ed1-f51.google.com with SMTP id y56so5391094edd.11
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sI0J8sK8qLVY5A7TwFi50tscdkZxAfA3T+dfrtp7SBQ=;
        b=SZ6V8qxATvZfGBGdzm7yzt0+TowNpjy1GVD1pNk+TSfFS56J1fAGCylYlCDNX7hLTV
         nR0zRsapdgd3cdm1QgSO9mnqIrAdovPhDINb29CQd0chrmGEaPQAPAOEUWpPqCMJrAwT
         3CpzbiwLvV66bvImQiEswHwgeuTbQ+veZSywRdnfwAfZ64KY1Vy2pQ6xckkMtAkGOc8e
         Ti/0/OKEFWgHQx5HhClrGnQH66hIk5C09ttMbJw8UaiYeKJZ46zy3rd5SeBJS+Ngw/8r
         jSsY48gBfZ9eSFwk3z9cTPFdhOI41PUlnrZtmkmKYcNC/8ECuuXiF/fgBbKNKvjZ7Hda
         VbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sI0J8sK8qLVY5A7TwFi50tscdkZxAfA3T+dfrtp7SBQ=;
        b=OEl5Syedk/695huyVszqql7gzdnYW8TEuBLvTasZS+ipVCtgH02UUMmaLd523RgW3/
         jeT17ipBLqYadaq1U895i/F/KsvkAsJfWb6tV3aPgJ/O37PC8UHWRk3FjHVwi0A7KiMB
         OcYV2WLMlK1/vMKlf1rH5R1noH5UBPZreorDEKuU1vCsNU6w4Zbs41fOqNaK9hk5l+6a
         HvKdOqejuitKG1zFlknxuU70hVVBJH3clDWaMV5pdEotRcZNLVAZOZunO0V/Qpcggnb9
         D+TX2ggLH0lKRUCtYER7zAZOTjzqcUW3ntbh6j5RPJIWa99oo5P0JS6AGhGynrIFqRWW
         RhbA==
X-Gm-Message-State: AJcUukd3+TV4rGXrN5igNJVoi09fpZH9gUECfq68BrRA6RU5t3iNcukw
        yuo4CtSg64GaVzz5sd/YAf99UN+0
X-Google-Smtp-Source: ALg8bN7iGlOvYodnvcJaxq5qgoJFQ2T4DCMBw81sJS6b+L5lLoQGGylcns5Oo0AEcbJicYQnGEHR1Q==
X-Received: by 2002:a17:906:1d01:: with SMTP id n1-v6mr6878643ejh.61.1547645781562;
        Wed, 16 Jan 2019 05:36:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n23-v6sm2980934ejx.57.2019.01.16.05.36.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:36:20 -0800 (PST)
Date:   Wed, 16 Jan 2019 05:36:20 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 13:35:59 GMT
Message-Id: <b6bb6a87a302ea146ce2fa0aba835781440dab12.1547645770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v3.git.gitgitgadget@gmail.com>
References: <pull.31.v2.git.gitgitgadget@gmail.com>
        <pull.31.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 11/21] ci: use git-sdk-64-minimal build artifact
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

Instead of a shallow fetch followed by a sparse checkout, we are
better off by using a separate, dedicated Pipeline that bundles
the SDK as a build artifact, and then consuming that build artifact
here.

In fact, since this artifact will be used a lot, we spent substantial
time on figuring out a minimal subset of the Git for Windows SDK, just
enough to build and test Git. The result is a size reduction from around
1GB (compressed) to around 55MB (compressed). This also comes with the
change where we now call `usr\bin\bash.exe` directly, as `git-cmd.exe`
is not included in the minimal SDK.

That reduces the time to initialize Git for Windows' SDK from anywhere
between 2m30s-7m to a little over 1m.

Note: in theory, we could also use the DownloadBuildArtifacts@0 task
here. However, restricted permissions that are in effect when building
from forks would let this fail for PR builds, defeating the whole
purpose of the Azure Pipelines support for git.git.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 azure-pipelines.yml | 44 +++++++++-----------------------------------
 1 file changed, 9 insertions(+), 35 deletions(-)

diff --git a/azure-pipelines.yml b/azure-pipelines.yml
index e44d2733a4..3085ff6ace 100644
--- a/azure-pipelines.yml
+++ b/azure-pipelines.yml
@@ -18,44 +18,18 @@ jobs:
     env:
       GITFILESHAREPWD: $(gitfileshare.pwd)
   - powershell: |
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
+      $urlbase = "https://dev.azure.com/git-for-windows/git/_apis/build/builds"
+      $id = ((Invoke-WebRequest -UseBasicParsing "${urlbase}?definitions=22&statusFilter=completed&resultFilter=succeeded&`$top=1").content | ConvertFrom-JSON).value[0].id
+      $downloadUrl = ((Invoke-WebRequest -UseBasicParsing "${urlbase}/$id/artifacts").content | ConvertFrom-JSON).value[1].resource.downloadUrl
+      (New-Object Net.WebClient).DownloadFile($downloadUrl,"git-sdk-64-minimal.zip")
+      Expand-Archive git-sdk-64-minimal.zip -DestinationPath . -Force
+      Remove-Item git-sdk-64-minimal.zip
 
       # Let Git ignore the SDK and the test-cache
-      "/git-sdk-64/`n/test-cache/`n" | Out-File -NoNewLine -Encoding ascii -Append "$(Build.SourcesDirectory)\.git\info\exclude"
-    displayName: 'Initialize the Git for Windows SDK'
+      "/git-sdk-64-minimal/`n/test-cache/`n" | Out-File -NoNewLine -Encoding ascii -Append "$(Build.SourcesDirectory)\.git\info\exclude"
+    displayName: 'Download git-sdk-64-minimal'
   - powershell: |
-      & "git-sdk-64\git-cmd.exe" --command=usr\\bin\\bash.exe -lc @"
+      & git-sdk-64-minimal\usr\bin\bash.exe -lc @"
         export MAKEFLAGS=-j10
         export DEVELOPER=1
         export NO_PERL=1
-- 
gitgitgadget

