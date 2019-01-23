Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 621E11F453
	for <e@80x24.org>; Wed, 23 Jan 2019 14:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfAWOk0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 09:40:26 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:36230 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfAWOkY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 09:40:24 -0500
Received: by mail-ed1-f47.google.com with SMTP id f23so1889083edb.3
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 06:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xTVONC8LZDYxfgUme8ZkdxX0vuhf8/Re4Um+ykWIxds=;
        b=k3chW0GSzYozBN0ZVF/WBRD7WTi5UHLEMYzzM3aJ1Lgd6OPnUMA/0NSnXAFtJsH/l3
         chaxnUt6y7DgOiDDQ/kP2WxR4/O86R9nVilVdIFvIUR6MiLhdZP6+/rhIzbgcJSOK3Er
         QLVKenm2jZqHiSVDTuaCjlE0sfoixlNSKeqml0J2ifuctW/fhSaGx1pw3f3qWNtk3l4d
         8UH+XVYPHAERZdU7dBZaL35JkYCKE4MkegAEyVFsdH2go46m9kfkdElzhEX8yh5CnQ23
         KDPhS6etNCDjuoTDOVzSA3HKu/XEIF4dMhlipDHo4nWAnHcFjN70eem0LrK9+al24vZt
         lIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xTVONC8LZDYxfgUme8ZkdxX0vuhf8/Re4Um+ykWIxds=;
        b=ZFVJd/m3YIuvLNmnwIWf05qZFPjTuuBTLNH28y08cnCRF1nGkwoSW152fkipP+bdWK
         ZMoILDD4YdweZm4iR76eQNpPaCME0TWM+FyeZikZ4e4lhswg2DCfJY7apRC1d/smLzgL
         H7oO2rZYRTAfSahgnM3qT4QQewiCuTnhjEfh2AWl6moxWX4p7tgg1xyogBtfBhnXHxIo
         wK1tESXAQLOTDFxjwM1IylPZDNWQ2FWiVBF2r67ELHm1o1sRz1lCqlt7+QJLjQCSV+bz
         VzZAQ8PhtlU86t5Q1Cgqa//JuPqQYAHnpSdACAyrYdHgJL6RluRVPxLLcxTDULCFbivp
         PJwQ==
X-Gm-Message-State: AJcUukfj3QHJlFhJcpj/v/f3Ge/9VNlZ31FZQrDGdR/TPO3ov5WtrxSN
        QijcO/jS3JbsSAlk2bdPDYGDzfSC
X-Google-Smtp-Source: ALg8bN7x1HLAp4WX0N0WSep75+CyIu2j5chxugEyS8WccES6WJST3nQyds4wveZqgeSU2TKhPesnyg==
X-Received: by 2002:a50:b6d2:: with SMTP id f18mr2949859ede.263.1548254421474;
        Wed, 23 Jan 2019 06:40:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r8sm9876238edo.11.2019.01.23.06.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:40:20 -0800 (PST)
Date:   Wed, 23 Jan 2019 06:40:20 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 14:40:00 GMT
Message-Id: <eaba471b89976b51ea19fc6772890304135ab539.1548254412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v4.git.gitgitgadget@gmail.com>
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 09/21] Add a build definition for Azure DevOps
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
 azure-pipelines.yml   | 306 ++++++++++++++++++++++++++++++++++++++++++
 ci/lib.sh             |   2 +-
 ci/mount-fileshare.sh |  25 ++++
 3 files changed, 332 insertions(+), 1 deletion(-)
 create mode 100644 azure-pipelines.yml
 create mode 100755 ci/mount-fileshare.sh

diff --git a/azure-pipelines.yml b/azure-pipelines.yml
new file mode 100644
index 0000000000..f3cabb0dd0
--- /dev/null
+++ b/azure-pipelines.yml
@@ -0,0 +1,306 @@
+resources:
+- repo: self
+  fetchDepth: 1
+
+jobs:
+- job: linux_clang
+  displayName: linux-clang
+  condition: succeeded()
+  pool: Hosted Ubuntu 1604
+  steps:
+  - bash: |
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
+
+       sudo apt-get update &&
+       sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2-bin &&
+
+       export CC=clang || exit 1
+
+       ci/install-dependencies.sh || exit 1
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
+- job: linux_gcc
+  displayName: linux-gcc
+  condition: succeeded()
+  pool: Hosted Ubuntu 1604
+  steps:
+  - bash: |
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
+
+       sudo add-apt-repository ppa:ubuntu-toolchain-r/test &&
+       sudo apt-get update &&
+       sudo apt-get -y install git gcc make libssl-dev libcurl4-openssl-dev libexpat-dev tcl tk gettext git-email zlib1g-dev apache2 language-pack-is git-svn gcc-8 || exit 1
+
+       ci/install-dependencies.sh || exit 1
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
+- job: osx_clang
+  displayName: osx-clang
+  condition: succeeded()
+  pool: Hosted macOS
+  steps:
+  - bash: |
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
+
+       export CC=clang
+
+       ci/install-dependencies.sh || exit 1
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
+- job: osx_gcc
+  displayName: osx-gcc
+  condition: succeeded()
+  pool: Hosted macOS
+  steps:
+  - bash: |
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
+
+       ci/install-dependencies.sh || exit 1
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
+- job: gettext_poison
+  displayName: GETTEXT_POISON
+  condition: succeeded()
+  pool: Hosted Ubuntu 1604
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
+- job: linux32
+  displayName: Linux32
+  condition: succeeded()
+  pool: Hosted Ubuntu 1604
+  steps:
+  - bash: |
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
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
+- job: static_analysis
+  displayName: StaticAnalysis
+  condition: succeeded()
+  pool: Hosted Ubuntu 1604
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
+- job: documentation
+  displayName: Documentation
+  condition: succeeded()
+  pool: Hosted Ubuntu 1604
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
diff --git a/ci/lib.sh b/ci/lib.sh
index a9eb4f4eae..91cf1402bf 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -42,7 +42,7 @@ then
 
 	BREW_INSTALL_PACKAGES=
 	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
-	export GIT_TEST_OPTS="--quiet --write-junit-xml"
+	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
 fi
 
 skip_branch_tip_with_tag () {
diff --git a/ci/mount-fileshare.sh b/ci/mount-fileshare.sh
new file mode 100755
index 0000000000..26b58a8096
--- /dev/null
+++ b/ci/mount-fileshare.sh
@@ -0,0 +1,25 @@
+#!/bin/sh
+
+die () {
+	echo "$*" >&2
+	exit 1
+}
+
+test $# = 4 ||
+die "Usage: $0 <share> <username> <password> <mountpoint>"
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
-- 
gitgitgadget

