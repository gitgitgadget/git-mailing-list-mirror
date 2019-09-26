Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48CCB1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 08:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbfIZIac (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 04:30:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42179 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729194AbfIZIa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 04:30:27 -0400
Received: by mail-lj1-f193.google.com with SMTP id y23so1210664lje.9
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 01:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2sgHY/MFdO8y7LIMA6x3QeA95At2V5bCVZfn9F3/7mM=;
        b=MlWjA5HiuPVeKbmzZww66kwhdb6qj8mJVhX2Wa8vxKhwjiQpD+EhtuA2+Qr/k+N2ML
         eQJnlPJVJk7MmWvXxknYP7RLFpEBO4rMxl4wKkjvxJ6bVxJtzb2X8fF8c2NHUeouyO8E
         pxbNwI54k1uG8tbxbzF2CMDTOfPypmGSnV6mdEOZmYEyEm9JQ67E21mZ9qGPupoMt3SB
         s7KuaSGIDIR47PQ2dhWuI4BNN812FW8e5r5TQUVaC0krMxWloRMG4EVE38M/PSMXu6YF
         KfwBGXz0aQtwcQhAOUOYYSYNp+l/4ju99ZotJfN4jFaj2q0TS+QS4aYCTvxz077Mr3Mq
         hwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2sgHY/MFdO8y7LIMA6x3QeA95At2V5bCVZfn9F3/7mM=;
        b=P5pCWt4wTFCK9D1DR52eim6iPNcerX58Sq/i4XIKJf/SIwnC4+ks124Z4poamFXtQb
         Qcw/p6GOwqNAIXhvpmFQ46FM4Wb3Y/lXoig+A8pqJppxrwtzYjdhQxPRqm9A/YOd+fW+
         4ViL1wrBAf1XIUtp1JaUxaNtKzg8jV4NcGNGSGgQpyjj3cgUu0aa7AdA55eEE807zNkZ
         BNVMomYMCgabJ8wJwBTPblB1gj98vQMq7SVDVS72+81LpSSla165Yi0x33OgafkIysw6
         KjS/6LONvzxUlKplRKYSvF1dVdg79sY5Q9uK7CxZaSHzVKml1I8zj1oNz7jNXyGkKTC6
         qxwQ==
X-Gm-Message-State: APjAAAU0z9POBxdZsVancYmZy5Kf/2QaOHW1gbG0yxkGyz52LvWJ4M9+
        Qt6xSg0W/qfW40oZ28KzWPfQLOFC
X-Google-Smtp-Source: APXvYqy5pIGhchwMF5ndsXCD0O7VmE24Eomxp/zCMEUbfFm6MT/FEzZlrb5XHsUaIprL+s3cLzubrQ==
X-Received: by 2002:a2e:b045:: with SMTP id d5mr1719375ljl.105.1569486625254;
        Thu, 26 Sep 2019 01:30:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 77sm341935ljj.84.2019.09.26.01.30.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 01:30:24 -0700 (PDT)
Date:   Thu, 26 Sep 2019 01:30:24 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 08:30:06 GMT
Message-Id: <ece296922be29dc0520c747d391a5cf3982973bc.1569486607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.288.git.gitgitgadget@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 13/13] ci: also build and test with MS Visual Studio on Azure
 Pipelines
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

... because we can, now. Technically, we actually build using `MSBuild`,
which is however pretty close to building interactively in Visual
Studio.

As there is no convenient way to run Git's test suite in Visual Studio,
we unpack a Portable Git to run it, using the just-added test helper to
allow running test scripts in parallel.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile            |   4 ++
 azure-pipelines.yml | 159 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 163 insertions(+)

diff --git a/Makefile b/Makefile
index 3716dadc08..3f6dcec54b 100644
--- a/Makefile
+++ b/Makefile
@@ -3025,6 +3025,10 @@ rpm::
 	@false
 .PHONY: rpm
 
+ifneq ($(INCLUDE_DLLS_IN_ARTIFACTS),)
+OTHER_PROGRAMS += $(shell echo *.dll t/helper/*.dll)
+endif
+
 artifacts-tar:: $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) \
 		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
 		$(MOFILES)
diff --git a/azure-pipelines.yml b/azure-pipelines.yml
index 55ee23ad0f..875e63cac1 100644
--- a/azure-pipelines.yml
+++ b/azure-pipelines.yml
@@ -130,6 +130,165 @@ jobs:
       PathtoPublish: t/failed-test-artifacts
       ArtifactName: failed-test-artifacts
 
+- job: vs_build
+  displayName: Visual Studio Build
+  condition: succeeded()
+  pool: Hosted VS2017
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
+      $urlbase = "https://dev.azure.com/git-for-windows/git/_apis/build/builds"
+      $id = ((Invoke-WebRequest -UseBasicParsing "${urlbase}?definitions=22&statusFilter=completed&resultFilter=succeeded&`$top=1").content | ConvertFrom-JSON).value[0].id
+      $downloadUrl = ((Invoke-WebRequest -UseBasicParsing "${urlbase}/$id/artifacts").content | ConvertFrom-JSON).value[1].resource.downloadUrl
+      (New-Object Net.WebClient).DownloadFile($downloadUrl,"git-sdk-64-minimal.zip")
+      Expand-Archive git-sdk-64-minimal.zip -DestinationPath . -Force
+      Remove-Item git-sdk-64-minimal.zip
+
+      # Let Git ignore the SDK and the test-cache
+      "/git-sdk-64-minimal/`n/test-cache/`n" | Out-File -NoNewLine -Encoding ascii -Append "$(Build.SourcesDirectory)\.git\info\exclude"
+    displayName: 'Download git-sdk-64-minimal'
+  - powershell: |
+      & git-sdk-64-minimal\usr\bin\bash.exe -lc @"
+        make vcxproj
+      "@
+      if (!$?) { exit(1) }
+    displayName: Generate Visual Studio Solution
+    env:
+      HOME: $(Build.SourcesDirectory)
+      MSYSTEM: MINGW64
+      DEVELOPER: 1
+      NO_PERL: 1
+      GIT_CONFIG_PARAMETERS: "'user.name=CI' 'user.email=ci@git'"
+  - powershell: |
+      $urlbase = "https://dev.azure.com/git/git/_apis/build/builds"
+      $id = ((Invoke-WebRequest -UseBasicParsing "${urlbase}?definitions=9&statusFilter=completed&resultFilter=succeeded&`$top=1").content | ConvertFrom-JSON).value[0].id
+      $downloadUrl = ((Invoke-WebRequest -UseBasicParsing "${urlbase}/$id/artifacts").content | ConvertFrom-JSON).value[0].resource.downloadUrl
+      (New-Object Net.WebClient).DownloadFile($downloadUrl, "compat.zip")
+      Expand-Archive compat.zip -DestinationPath . -Force
+      Remove-Item compat.zip
+    displayName: 'Download vcpkg artifacts'
+  - task: MSBuild@1
+    inputs:
+      solution: git.sln
+      platform: x64
+      configuration: Release
+      maximumCpuCount: 4
+  - powershell: |
+      & compat\vcbuild\vcpkg_copy_dlls.bat release
+      if (!$?) { exit(1) }
+      & git-sdk-64-minimal\usr\bin\bash.exe -lc @"
+        mkdir -p artifacts &&
+        eval \"`$(make -n artifacts-tar INCLUDE_DLLS_IN_ARTIFACTS=YesPlease ARTIFACTS_DIRECTORY=artifacts | grep ^tar)\"
+      "@
+      if (!$?) { exit(1) }
+    displayName: Bundle artifact tar
+    env:
+      HOME: $(Build.SourcesDirectory)
+      MSYSTEM: MINGW64
+      DEVELOPER: 1
+      NO_PERL: 1
+      MSVC: 1
+      VCPKG_ROOT: $(Build.SourcesDirectory)\compat\vcbuild\vcpkg
+  - powershell: |
+      $tag = (Invoke-WebRequest -UseBasicParsing "https://gitforwindows.org/latest-tag.txt").content
+      $version = (Invoke-WebRequest -UseBasicParsing "https://gitforwindows.org/latest-version.txt").content
+      $url = "https://github.com/git-for-windows/git/releases/download/${tag}/PortableGit-${version}-64-bit.7z.exe"
+      (New-Object Net.WebClient).DownloadFile($url,"PortableGit.exe")
+      & .\PortableGit.exe -y -oartifacts\PortableGit
+      # Wait until it is unpacked
+      while (-not @(Remove-Item -ErrorAction SilentlyContinue PortableGit.exe; $?)) { sleep 1 }
+    displayName: Download & extract portable Git
+  - task: PublishPipelineArtifact@0
+    displayName: 'Publish Pipeline Artifact: MSVC test artifacts'
+    inputs:
+      artifactName: 'vs-artifacts'
+      targetPath: '$(Build.SourcesDirectory)\artifacts'
+  - powershell: |
+      if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
+        cmd /c rmdir "$(Build.SourcesDirectory)\test-cache"
+      }
+    displayName: 'Unmount test-cache'
+    condition: true
+    env:
+      GITFILESHAREPWD: $(gitfileshare.pwd)
+
+- job: vs_test
+  displayName: Visual Studio Test
+  dependsOn: vs_build
+  condition: succeeded()
+  pool: Hosted
+  timeoutInMinutes: 240
+  strategy:
+    parallel: 10
+  steps:
+  - powershell: |
+      if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
+        net use s: \\gitfileshare.file.core.windows.net\test-cache "$GITFILESHAREPWD" /user:AZURE\gitfileshare /persistent:no
+        cmd /c mklink /d "$(Build.SourcesDirectory)\test-cache" S:\
+      }
+    displayName: 'Mount test-cache'
+    env:
+      GITFILESHAREPWD: $(gitfileshare.pwd)
+  - task: DownloadPipelineArtifact@0
+    displayName: 'Download Pipeline Artifact: VS test artifacts'
+    inputs:
+      artifactName: 'vs-artifacts'
+      targetPath: '$(Build.SourcesDirectory)'
+  - powershell: |
+      & PortableGit\git-cmd.exe --command=usr\bin\bash.exe -lc @"
+        test -f artifacts.tar.gz || {
+          echo No test artifacts found\; skipping >&2
+          exit 0
+        }
+        tar xf artifacts.tar.gz || exit 1
+
+        # Let Git ignore the SDK and the test-cache
+        printf '%s\n' /PortableGit/ /test-cache/ >>.git/info/exclude
+
+        cd t &&
+        PATH=\"`$PWD/helper:`$PATH\" &&
+        test-tool.exe run-command testsuite -V -x --write-junit-xml \
+                `$(test-tool.exe path-utils slice-tests \
+                        `$SYSTEM_JOBPOSITIONINPHASE `$SYSTEM_TOTALJOBSINPHASE t[0-9]*.sh)
+      "@
+      if (!$?) { exit(1) }
+    displayName: 'Test (parallel)'
+    env:
+      HOME: $(Build.SourcesDirectory)
+      MSYSTEM: MINGW64
+      NO_SVN_TESTS: 1
+      GIT_TEST_SKIP_REBASE_P: 1
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
+      testRunTitle: 'vs'
+      platform: Windows
+      publishRunAttachments: false
+    condition: succeededOrFailed()
+  - task: PublishBuildArtifacts@1
+    displayName: 'Publish trash directories of failed tests'
+    condition: failed()
+    inputs:
+      PathtoPublish: t/failed-test-artifacts
+      ArtifactName: failed-vs-test-artifacts
+
 - job: linux_clang
   displayName: linux-clang
   condition: succeeded()
-- 
gitgitgadget
