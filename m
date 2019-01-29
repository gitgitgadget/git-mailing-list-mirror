Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0B431F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfA2OTf (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:19:35 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:40947 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbfA2OTe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:19:34 -0500
Received: by mail-ed1-f47.google.com with SMTP id g22so16082887edr.7
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 06:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=78IrL+5/ULRbiBWonyqqOoF9pTaUuqJK4U/mjC0vwos=;
        b=YnOqxuZ1YWlLAIG/aYcdbGaY63FnnhuyWTxVEY2JT/iVC/ciu2QFQ9NuVfMyw0cYFQ
         5mBr/pulmDXYKttBodLJQVr4ml87RUze892iPIC1NYBjM2EGojCBmYTa53IiooyEPtxf
         kSlX+4j0c2PyH56DE4Sig57XdmlX23fX+CslJV51zwkOZ4KbFtR6uV+4orbrXkSBZCfC
         3PAoWxxg5KLoPT/m6q0elc4K8gFQHPoRgCGXkWX2wPzorXEITabOYhOfQayBYBQlWvJX
         mCrY6n1vZtxWsbmGBzGMx3TlIcrz4+iATqlWEQh4SvJLTByLF7uPt2fcYCyshO24ve1J
         24FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=78IrL+5/ULRbiBWonyqqOoF9pTaUuqJK4U/mjC0vwos=;
        b=tsS9OOg9pmCNEGdRytgLqbzL2g3uxRsplo6lobRGMYZbZZ8Go4PrTLRSXIqCz9T6hr
         wKuMyU0uOkOH/SNFWpL5JSAjiOqP0sTASbtw9TclBUPn5RM02Jq6SOhve4oQiGr+TZ9N
         9igEchoh6GaZHRf4K9Uy16n7vok6IxOXPiHs/o+GYxPp81BgNmEWjRSeB2WDYWZZLkN0
         VDGvtV22LQBtkDDcYBPiBDkxc4WZRbiq/84UIDFMkvy9X3hXiAMyUb+GUVLx/UJd74qe
         dT11V4brEYvX0VGEhcVBt6kfAVDc6LQh1qsqqCI+jFUPf+XRFQMRMeNi+8kLqGetn6t2
         CtxA==
X-Gm-Message-State: AJcUukc50ZAB60HG1KAJbaOi3nmZj+YbyWHds7dJegYJmR3L+FowOGJi
        zvIgXWx0VHUbvTT70H5uPUGO8pUI
X-Google-Smtp-Source: ALg8bN7liZz2FoBqj5Ht4wCgbNW+qcU2HCWzT2Odq7cxQQWvuS/XjnP8HOfiIAccVdNe9H/5ufKdIQ==
X-Received: by 2002:a17:906:4bd7:: with SMTP id x23-v6mr23278421ejv.105.1548771571549;
        Tue, 29 Jan 2019 06:19:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j4sm14419592edh.69.2019.01.29.06.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 06:19:31 -0800 (PST)
Date:   Tue, 29 Jan 2019 06:19:31 -0800 (PST)
X-Google-Original-Date: Tue, 29 Jan 2019 14:19:10 GMT
Message-Id: <1ab1d14e063969c86db2accf7340dcd5fcde27e5.1548771561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v6.git.gitgitgadget@gmail.com>
References: <pull.31.v5.git.gitgitgadget@gmail.com>
        <pull.31.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 11/21] ci: use git-sdk-64-minimal build artifact
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
index 0f7b2125a1..480e841a85 100644
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
         export DEVELOPER=1
         export NO_PERL=1
         export NO_SVN_TESTS=1
-- 
gitgitgadget

