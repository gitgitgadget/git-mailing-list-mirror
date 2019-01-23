Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25DC81F453
	for <e@80x24.org>; Wed, 23 Jan 2019 14:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfAWOk2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 09:40:28 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:42648 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbfAWOkZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 09:40:25 -0500
Received: by mail-ed1-f42.google.com with SMTP id y20so1864448edw.9
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 06:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sI0J8sK8qLVY5A7TwFi50tscdkZxAfA3T+dfrtp7SBQ=;
        b=ZJYdmtqX0TqfEcbIzGHWSycEGvC7AmFFPkqqOGCeZUb4l6gwx1BHPc/8B0DFWRUTeR
         IrqTsLZYmVvY84y4E6fSqx4FIsRd3RwPcuQFhEJEEJilRnRDYRgfTTn1p9U8JMpaXEdc
         +WlckplvgR+dyZ5MBI1b4o3/52jxGP4GYqj4GDLgjCyhJislqEuGZxotacKK88uoq1ad
         Qu5T6POM/8FojuOhRFowC36ZJDQjbBYhpaHJioGEpJjJptMFt4dHmuJj32/rkFKUNAsT
         36o6p5e8ByCgyZvZP+8YpyrReJqu3/cp601bYtozuOCJ8BFvdsC61+l2yfmBcP8wRtOU
         NC3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sI0J8sK8qLVY5A7TwFi50tscdkZxAfA3T+dfrtp7SBQ=;
        b=jKgdqYyOGvm3mRlRAq/0p1sRmcbKkq+RVwarezwcU8lwHnu44kKyq9dq9m2xED5vrX
         BBeK+tMvmTrCEC8D5FJWf+BUx3XjMAy+Vh8TJkCe4Mch+CSVgh7sQp3C8xdl1YSl2ADI
         q630qjzVZG+FJ+lpP9/R4z6ZrtfVGdCs7kWZhmEid+ghh4SWVIVNybbpD7oCmSENHukg
         wsqXN8OUXCyc7e1cqF0PguYM9+yedZIPx14crXsPv2tbjzxwY9mGQqbJf36LmhLwNfbt
         ORHhZn3gpMx4u5oADgmXINagWBg4QKKNhKAd1DjOF+7eh6CtT9/78e9Yd0EO5DBECiaw
         cZjg==
X-Gm-Message-State: AJcUukfNn7lOUSEMmkLwNPrJxNq8f9sfP7uf0+VexsLF4om929gbwmkn
        0qClIMDhSUzWYx8IKDtl+guz0Eao
X-Google-Smtp-Source: ALg8bN7fpZJEgskHXIMxQvadsRh4SAF+09gTeUjyIx3Edm0vM2bXGIzB32hY+TBaMpwwpSCW2U6k5Q==
X-Received: by 2002:a17:906:4584:: with SMTP id t4mr751235ejq.135.1548254423168;
        Wed, 23 Jan 2019 06:40:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r51sm10559209eda.64.2019.01.23.06.40.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:40:22 -0800 (PST)
Date:   Wed, 23 Jan 2019 06:40:22 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 14:40:02 GMT
Message-Id: <93eebb74ce1e5a2dcacee40c5e1750979bd83b10.1548254412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v4.git.gitgitgadget@gmail.com>
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 11/21] ci: use git-sdk-64-minimal build artifact
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

