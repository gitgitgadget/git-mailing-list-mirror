Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFEE91F404
	for <e@80x24.org>; Mon,  3 Sep 2018 21:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeIDBci (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 21:32:38 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36426 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeIDBci (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 21:32:38 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1-v6so614915pgo.3
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 14:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PUAncS3DYiDzEVfhVLdoNOoqM61VTflitR5xFhCilVE=;
        b=rM1+tfWhrVU8JBmHrAKL2hLm5/mzGsf1YOsrxtCC3dRSeV4Lj8w70tD+OlkgCUrIbv
         qus3fulwyIpWjU41P5cOi6Sr72hZeDLjCwZgKrxU9gDqogRZMb9G4uv5JqBU7ol1vzMa
         XS7dSn2zdAfCXvonHmINUKCuGMRF8S1SClmdgGn9dtyZ9jDGC3fD6ws5qRwR06Uc7QLP
         hW/hB+wPQL8IyyFlbREfLW2Uf5puA6XoftSjh+2CyIq2Uyf4K12YsS0l2MVbZhObR2tX
         MwQXAMThfOMoolbBW/FC/ka+T0PZ+ugWI+JKEBote3nvqaxem8GB/QTleBLPW8Zapfcv
         kCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PUAncS3DYiDzEVfhVLdoNOoqM61VTflitR5xFhCilVE=;
        b=QEtLyV1A6hH2mm7vnLAMJJEueu94eQkdFRjMuVQWf8rsQ4RGIAWEItnEInk9nOwiTD
         /R6WozsxwCtLTF98wR6caeEbDvyFQa9YiRukF10nOeYXXZ/YkZFdzd2vzcBspmImWlJN
         P68SNekOFfEYg79hTvZPrekE+joVQieuHQD4uvlQaeLcuuOhIVOuSRODuh3GTdjFea6B
         7cEWcIiB1/AaT2PquGbcpWbuiXmtF8eZgNfLus2kE/OeRNvgNqnJaO/clZAiNxXAHumL
         O729B8uGom156lp2LzvD2xWBvT0fVfJP5Y6SKhO1DwcKCaBOPgyZWLo5IsRmT7FLeXPT
         Iw2A==
X-Gm-Message-State: APzg51DvoNoVVWLLGdaRj6Wo6joFCWtMb9lmctTKQOQuphSXK/DaAcEM
        JQSjO1+XJjcxxjxUN6isESh66vGg
X-Google-Smtp-Source: ANB0VdZdXiFhgJAR46qzT3LZEoKRMGntFKGzrt+j9u7eiPqSfEgwdWwjyRvqi/k6tU93o+R8nqSQ+Q==
X-Received: by 2002:a63:9a02:: with SMTP id o2-v6mr9650680pge.440.1536009038080;
        Mon, 03 Sep 2018 14:10:38 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id m20-v6sm61980247pfg.61.2018.09.03.14.10.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 14:10:37 -0700 (PDT)
Date:   Mon, 03 Sep 2018 14:10:37 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Sep 2018 21:10:23 GMT
Message-Id: <ab66060c579aebebccf88a63559207d584a24d38.1536009027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.git.gitgitgadget@gmail.com>
References: <pull.31.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 6/9] Add a build definition for VSTS
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

This commit adds a .vsts-ci.yml which is Visual Studio Team Services'
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
 .vsts-ci.yml          | 296 ++++++++++++++++++++++++++++++++++++++++++
 ci/mount-fileshare.sh |  26 ++++
 2 files changed, 322 insertions(+)
 create mode 100644 .vsts-ci.yml
 create mode 100755 ci/mount-fileshare.sh

diff --git a/.vsts-ci.yml b/.vsts-ci.yml
new file mode 100644
index 0000000000..ff1d952df9
--- /dev/null
+++ b/.vsts-ci.yml
@@ -0,0 +1,296 @@
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
+       ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/vsts-cache gitfileshare "$(gitfileshare.pwd)" "$HOME/vsts-cache" || exit 1
+
+       sudo apt-get update
+       sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2-bin
+
+       export CC=clang
+
+       ci/install-dependencies.sh
+       ci/run-build-and-tests.sh || {
+           ci/print-test-failures.sh
+           exit 1
+       }
+
+       sudo umount "$HOME/vsts-cache" || exit 1
+    displayName: 'ci/run-build-and-tests.sh'
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
+       ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/vsts-cache gitfileshare "$(gitfileshare.pwd)" "$HOME/vsts-cache" || exit 1
+
+       sudo apt-get update
+       sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2-bin
+
+       ci/install-dependencies.sh
+       ci/run-build-and-tests.sh || {
+           ci/print-test-failures.sh
+           exit 1
+       }
+
+       sudo umount "$HOME/vsts-cache" || exit 1
+    displayName: 'ci/run-build-and-tests.sh'
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
+       ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/vsts-cache gitfileshare "$(gitfileshare.pwd)" "$HOME/vsts-cache" || exit 1
+
+       export CC=clang
+
+       ci/install-dependencies.sh
+       ci/run-build-and-tests.sh || {
+           ci/print-test-failures.sh
+           exit 1
+       }
+
+       umount "$HOME/vsts-cache" || exit 1
+    displayName: 'ci/run-build-and-tests.sh'
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
+       ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/vsts-cache gitfileshare "$(gitfileshare.pwd)" "$HOME/vsts-cache" || exit 1
+
+       ci/install-dependencies.sh
+       ci/run-build-and-tests.sh || {
+           ci/print-test-failures.sh
+           exit 1
+       }
+
+       umount "$HOME/vsts-cache" || exit 1
+    displayName: 'ci/run-build-and-tests.sh'
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
+       ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/vsts-cache gitfileshare "$(gitfileshare.pwd)" "$HOME/vsts-cache" || exit 1
+
+       sudo apt-get update
+       sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev
+
+       export jobname=GETTEXT_POISON
+
+       ci/run-build-and-tests.sh || {
+           ci/print-test-failures.sh
+           exit 1
+       }
+
+       sudo umount "$HOME/vsts-cache" || exit 1
+    displayName: 'ci/run-build-and-tests.sh'
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
+       net use s: \\gitfileshare.file.core.windows.net\vsts-cache "$(gitfileshare.pwd)" /user:AZURE\gitfileshare /persistent:no; c
+       cmd /c mklink /d "$(Build.SourcesDirectory)\vsts-cache" S:\; c
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
+       init "$sdk_path" "https://git-for-windows.visualstudio.com/_git/git-sdk-64" 0
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
+           NO_PERL=1 NO_SVN_TESTS=1 GIT_TEST_OPTS=\"-i -v -x\" make -k failed; exit 1
+         }
+
+         save_good_tree
+       "@
+
+       cmd /c rmdir "$(Build.SourcesDirectory)\vsts-cache"
+    displayName: 'build & test'
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
+       ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/vsts-cache gitfileshare "$(gitfileshare.pwd)" "$HOME/vsts-cache" || exit 1
+
+       sudo apt-get update
+       sudo apt-get -y install \
+           apt-transport-https \
+           ca-certificates \
+           curl \
+           software-properties-common
+       curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
+       sudo add-apt-repository \
+          "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
+          $(lsb_release -cs) \
+          stable"
+       sudo apt-get update
+       sudo apt-get -y install docker-ce
+
+       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS=-j3 bash -lxc ci/run-linux32-docker.sh || exit 1
+
+       sudo chmod a+r t/out/TEST-*.xml
+
+       sudo umount "$HOME/vsts-cache" || exit 1
+    displayName: 'ci/run-linux32-docker.sh'
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
+       ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/vsts-cache gitfileshare "$(gitfileshare.pwd)" "$HOME/vsts-cache" || exit 1
+
+       sudo apt-get update
+       sudo apt-get install -y coccinelle
+
+       export jobname=StaticAnalysis
+
+       ci/run-static-analysis.sh || exit 1
+
+       sudo umount "$HOME/vsts-cache" || exit 1
+    displayName: 'ci/run-static-analysis.sh'
+
+- phase: documentation
+  displayName: Documentation
+  condition: succeeded()
+  queue:
+    name: Hosted Ubuntu 1604
+  steps:
+  - bash: |
+       ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/vsts-cache gitfileshare "$(gitfileshare.pwd)" "$HOME/vsts-cache" || exit 1
+
+       sudo apt-get update
+       sudo apt-get install -y asciidoc xmlto asciidoctor
+
+       export ALREADY_HAVE_ASCIIDOCTOR=yes.
+       export jobname=Documentation
+
+       ci/test-documentation.sh || exit 1
+
+       sudo umount "$HOME/vsts-cache" || exit 1
+    displayName: 'ci/test-documentation.sh'
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

