Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E58E1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 10:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeJOR4n (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 13:56:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35119 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJOR4n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 13:56:43 -0400
Received: by mail-pg1-f196.google.com with SMTP id v133-v6so8946114pgb.2
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 03:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m+Q5LWWbECpKHe2DgxjH7XinVp7qDLxZn6Hxn62fG+8=;
        b=jLQvwKdoiQYnOWnqN4KSrHYwt+XHKPLEDBrMPTmpqzOdCxIYFWwBX7BMCMm2Q+ZjgX
         uxi+YnbTezTbwiFe1VzzJf8yRxqKV4V4PZ63JPxW5bYdyUmDj8fjr99uuO80YAxRe2kC
         DsZCe5DCWlyKK83E50XTYTd6lIYMh8+eWvXuKTSWJz/eEsMsAh6eSHzjWcNbliDcHuVc
         UWpoWmicTiTAmRNwMp10kfGOghigJS8DPbteNTJh1J9Ji1TiT/MFlPAeBx0yxsk+9PT8
         vxfTIwUUkl3/r3n+FXJs1u6gi9qOQFTUSUwpPx8/0FNeMzLqAy1sLVz9vHYLwBvGHUSX
         dYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m+Q5LWWbECpKHe2DgxjH7XinVp7qDLxZn6Hxn62fG+8=;
        b=iB2s8XkwIldU87/4fKxgxbXFrul0CRww0bBU/VLpwEsqhvZtc1Uw4JUkUTlt7GVblf
         TTTPjhwfGRdjhPJpokXd+MsldjvkAEE2XniSG7YZsIxiERJzbBy5xLYzL5UOt9EyZJ6u
         8vL/8k0/2aKtlVOZ+pldd0i6EFoM48KqeCxX+mq4rvuBUtD9rZU1ZGF6m+uXTDTIB4eR
         0AUxLFtS5AMhYg2u+jOjxNPeQxesiT+en+Q6+eWtkmA3ktYhDslCokl8lSRfJC6jrcvJ
         XojObrx/GurlWndTfKNNPFzOlO2vemDjrLfaKEHbaIldwIcdeDTWZp8guTHGWlCIgQtD
         tLlw==
X-Gm-Message-State: ABuFfoiyCLblGW6Ij0wDVqeqVOEhe5zcdsjjm5Lt8eAi3lPiMkUg+RGt
        7DY96yEWBUf47SyheMdkWNBo4Cfy
X-Google-Smtp-Source: ACcGV61+EC6Pe7TPtHKX4JSui974ISHOhQ9c6CAPeRnnSbK3bKdodwAgVaxfgZP8o8WiyHkB5Nl/Sw==
X-Received: by 2002:a62:36c3:: with SMTP id d186-v6mr16553432pfa.133.1539598327643;
        Mon, 15 Oct 2018 03:12:07 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id j25-v6sm11812203pff.116.2018.10.15.03.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 03:12:06 -0700 (PDT)
Date:   Mon, 15 Oct 2018 03:12:06 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 10:11:48 GMT
Message-Id: <1a22efe849d6da79f2c639c62a1483361a130238.1539598316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v2.git.gitgitgadget@gmail.com>
References: <pull.31.git.gitgitgadget@gmail.com>
        <pull.31.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 06/13] Add a build definition for Azure DevOps
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

This commit adds an azure-pipelines.yml file which is Azure DevOps'
equivalent to Travis CI's .travis.yml.

To make things a bit easier to understand, we refrain from using the
`matrix` feature here because (while it is powerful) it can be a bit
confusing to users who are not familiar with CI setups. Therefore, we
use a separate phase even for similar configurations (such as GCC vs
Clang on Linux, GCC vs Clang on macOS).

Also, we make use of the shiny new feature we just introduced where the
test suite can output JUnit-style .xml files. This information is made
available in a nice UI that allows the viewer to filter by phase and/or
test number, and to see trends such as: number of (failing) tests, time
spent running the test suite, etc.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 azure-pipelines.yml   | 319 ++++++++++++++++++++++++++++++++++++++++++
 ci/mount-fileshare.sh |  26 ++++
 2 files changed, 345 insertions(+)
 create mode 100644 azure-pipelines.yml
 create mode 100755 ci/mount-fileshare.sh

diff --git a/azure-pipelines.yml b/azure-pipelines.yml
new file mode 100644
index 0000000000..b5749121d2
--- /dev/null
+++ b/azure-pipelines.yml
@@ -0,0 +1,319 @@
+resources:
+- repo: self
+  fetchDepth: 1
+
+phases:
+- phase: linux_clang
+  displayName: linux-clang
+  condition: succeeded()
+  queue:
+    name: Hosted Ubuntu 1604
+  steps:
+  - bash: |
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
+
+       sudo apt-get update &&
+       sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2-bin &&
+
+       export CC=clang || exit 1
+
+       ci/install-dependencies.sh
+       ci/run-build-and-tests.sh || {
+           ci/print-test-failures.sh
+           exit 1
+       }
+
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || exit 1
+    displayName: 'ci/run-build-and-tests.sh'
+    env:
+      GITFILESHAREPWD: $(gitfileshare.pwd)
+  - task: PublishTestResults@2
+    displayName: 'Publish Test Results **/TEST-*.xml'
+    inputs:
+      mergeTestResults: true
+      testRunTitle: 'linux-clang'
+      platform: Linux
+      publishRunAttachments: false
+    condition: succeededOrFailed()
+
+- phase: linux_gcc
+  displayName: linux-gcc
+  condition: succeeded()
+  queue:
+    name: Hosted Ubuntu 1604
+  steps:
+  - bash: |
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
+
+       sudo apt-get update &&
+       sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2-bin || exit 1
+
+       ci/install-dependencies.sh
+       ci/run-build-and-tests.sh || {
+           ci/print-test-failures.sh
+           exit 1
+       }
+
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || exit 1
+    displayName: 'ci/run-build-and-tests.sh'
+    env:
+      GITFILESHAREPWD: $(gitfileshare.pwd)
+  - task: PublishTestResults@2
+    displayName: 'Publish Test Results **/TEST-*.xml'
+    inputs:
+      mergeTestResults: true
+      testRunTitle: 'linux-gcc'
+      platform: Linux
+      publishRunAttachments: false
+    condition: succeededOrFailed()
+
+- phase: osx_clang
+  displayName: osx-clang
+  condition: succeeded()
+  queue:
+    name: Hosted macOS
+  steps:
+  - bash: |
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
+
+       export CC=clang
+
+       ci/install-dependencies.sh
+       ci/run-build-and-tests.sh || {
+           ci/print-test-failures.sh
+           exit 1
+       }
+
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || umount "$HOME/test-cache" || exit 1
+    displayName: 'ci/run-build-and-tests.sh'
+    env:
+      GITFILESHAREPWD: $(gitfileshare.pwd)
+  - task: PublishTestResults@2
+    displayName: 'Publish Test Results **/TEST-*.xml'
+    inputs:
+      mergeTestResults: true
+      testRunTitle: 'osx-clang'
+      platform: macOS
+      publishRunAttachments: false
+    condition: succeededOrFailed()
+
+- phase: osx_gcc
+  displayName: osx-gcc
+  condition: succeeded()
+  queue:
+    name: Hosted macOS
+  steps:
+  - bash: |
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
+
+       ci/install-dependencies.sh
+       ci/run-build-and-tests.sh || {
+           ci/print-test-failures.sh
+           exit 1
+       }
+
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || umount "$HOME/test-cache" || exit 1
+    displayName: 'ci/run-build-and-tests.sh'
+    env:
+      GITFILESHAREPWD: $(gitfileshare.pwd)
+  - task: PublishTestResults@2
+    displayName: 'Publish Test Results **/TEST-*.xml'
+    inputs:
+      mergeTestResults: true
+      testRunTitle: 'osx-gcc'
+      platform: macOS
+      publishRunAttachments: false
+    condition: succeededOrFailed()
+
+- phase: gettext_poison
+  displayName: GETTEXT_POISON
+  condition: succeeded()
+  queue:
+    name: Hosted Ubuntu 1604
+  steps:
+  - bash: |
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
+
+       sudo apt-get update &&
+       sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev &&
+
+       export jobname=GETTEXT_POISON || exit 1
+
+       ci/run-build-and-tests.sh || {
+           ci/print-test-failures.sh
+           exit 1
+       }
+
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || exit 1
+    displayName: 'ci/run-build-and-tests.sh'
+    env:
+      GITFILESHAREPWD: $(gitfileshare.pwd)
+  - task: PublishTestResults@2
+    displayName: 'Publish Test Results **/TEST-*.xml'
+    inputs:
+      mergeTestResults: true
+      testRunTitle: 'gettext-poison'
+      platform: Linux
+      publishRunAttachments: false
+    condition: succeededOrFailed()
+
+- phase: windows
+  displayName: Windows
+  condition: succeeded()
+  queue:
+    name: Hosted VS2017
+    timeoutInMinutes: 240
+  steps:
+  - powershell: |
+       # Helper to check the error level of the latest command (exit with error when appropriate)
+       function c() { if (!$?) { exit(1) } }
+
+       if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
+         net use s: \\gitfileshare.file.core.windows.net\test-cache "$GITFILESHAREPWD" /user:AZURE\gitfileshare /persistent:no; c
+         cmd /c mklink /d "$(Build.SourcesDirectory)\test-cache" S:\; c
+       }
+
+       # Add build agent's MinGit to PATH
+       $env:PATH = $env:AGENT_HOMEDIRECTORY +"\externals\\git\cmd;" +$env:PATH
+
+       # Helper to initialize (or update) a Git worktree
+       function init ($path, $url, $set_origin) {
+           if (Test-Path $path) {
+               cd $path; c
+               if (Test-Path .git) {
+                   git init; c
+               } else {
+                   git status
+               }
+           } else {
+               git init $path; c
+               cd $path; c
+           }
+           git config core.autocrlf false; c
+           git config core.untrackedCache true; c
+           if (($set_origin -ne 0) -and !(git config remote.origin.url)) {
+               git remote add origin $url; c
+           }
+           git fetch --depth=1 $url master; c
+           git reset --hard FETCH_HEAD; c
+           git clean -df; c
+       }
+
+       # Initialize Git for Windows' SDK
+       $sdk_path = "$(Build.SourcesDirectory)\git-sdk-64"
+       init "$sdk_path" "https://dev.azure.com/git-for-windows/git-sdk-64/_git/git-sdk-64" 0
+       init usr\src\build-extra https://github.com/git-for-windows/build-extra 1
+
+       cd "$(Build.SourcesDirectory)"; c
+
+       $env:HOME = "$(Build.SourcesDirectory)"
+       $env:MSYSTEM = "MINGW64"
+       git-sdk-64\git-cmd --command=usr\\bin\\bash.exe -lc @"
+         . ci/lib.sh
+
+         make -j10 DEVELOPER=1 NO_PERL=1 || exit 1
+         NO_PERL=1 NO_SVN_TESTS=1 GIT_TEST_OPTS=\"--quiet --write-junit-xml\" time make -j15 -k DEVELOPER=1 test || {
+           NO_PERL=1 NO_SVN_TESTS=1 GIT_TEST_OPTS=\"-i -v -x\" make -k -C t failed; exit 1
+         }
+
+         save_good_tree
+       "@
+       c
+
+       if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
+         cmd /c rmdir "$(Build.SourcesDirectory)\test-cache"
+       }
+    displayName: 'build & test'
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
+- phase: linux32
+  displayName: Linux32
+  condition: succeeded()
+  queue:
+    name: Hosted Ubuntu 1604
+  steps:
+  - bash: |
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
+
+       sudo apt-get update &&
+       sudo apt-get -y install \
+           apt-transport-https \
+           ca-certificates \
+           curl \
+           software-properties-common &&
+       curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
+       sudo add-apt-repository \
+          "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
+          $(lsb_release -cs) \
+          stable" &&
+       sudo apt-get update &&
+       sudo apt-get -y install docker-ce &&
+
+       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS=-j3 bash -lxc ci/run-linux32-docker.sh || exit 1
+
+       sudo chmod a+r t/out/TEST-*.xml
+
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || exit 1
+    displayName: 'ci/run-linux32-docker.sh'
+    env:
+      GITFILESHAREPWD: $(gitfileshare.pwd)
+  - task: PublishTestResults@2
+    displayName: 'Publish Test Results **/TEST-*.xml'
+    inputs:
+      mergeTestResults: true
+      testRunTitle: 'linux32'
+      platform: Linux
+      publishRunAttachments: false
+    condition: succeededOrFailed()
+
+- phase: static_analysis
+  displayName: StaticAnalysis
+  condition: succeeded()
+  queue:
+    name: Hosted Ubuntu 1604
+  steps:
+  - bash: |
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
+
+       sudo apt-get update &&
+       sudo apt-get install -y coccinelle &&
+
+       export jobname=StaticAnalysis &&
+
+       ci/run-static-analysis.sh || exit 1
+
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || exit 1
+    displayName: 'ci/run-static-analysis.sh'
+    env:
+      GITFILESHAREPWD: $(gitfileshare.pwd)
+
+- phase: documentation
+  displayName: Documentation
+  condition: succeeded()
+  queue:
+    name: Hosted Ubuntu 1604
+  steps:
+  - bash: |
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
+
+       sudo apt-get update &&
+       sudo apt-get install -y asciidoc xmlto asciidoctor &&
+
+       export ALREADY_HAVE_ASCIIDOCTOR=yes. &&
+       export jobname=Documentation &&
+
+       ci/test-documentation.sh || exit 1
+
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || exit 1
+    displayName: 'ci/test-documentation.sh'
+    env:
+      GITFILESHAREPWD: $(gitfileshare.pwd)
diff --git a/ci/mount-fileshare.sh b/ci/mount-fileshare.sh
new file mode 100755
index 0000000000..5fb5f74b70
--- /dev/null
+++ b/ci/mount-fileshare.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+
+die () {
+	echo "$*" >&2
+	exit 1
+}
+
+test $# = 4 ||
+die "Usage: $0 <share> <username> <password> <mountpoint"
+
+mkdir -p "$4" || die "Could not create $4"
+
+case "$(uname -s)" in
+Linux)
+	sudo mount -t cifs -o vers=3.0,username="$2",password="$3",dir_mode=0777,file_mode=0777,serverino "$1" "$4"
+	;;
+Darwin)
+	pass="$(echo "$3" | sed -e 's/\//%2F/g' -e 's/+/%2B/g')" &&
+	mount -t smbfs,soft "smb://$2:$pass@${1#//}" "$4"
+	;;
+*)
+	die "No support for $(uname -s)"
+	;;
+esac ||
+die "Could not mount $4"
+
-- 
gitgitgadget

