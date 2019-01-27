Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 615EE1F453
	for <e@80x24.org>; Sun, 27 Jan 2019 23:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfA0X1S (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 18:27:18 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:35785 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbfA0X1A (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 18:27:00 -0500
Received: by mail-ed1-f45.google.com with SMTP id x30so11634151edx.2
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 15:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pFbplBFQUOIV1Nh4Mnv6OTr2Rj2NGgBQhiUPNzuNSoI=;
        b=TXoCGnSLs6JoiuM6Ahgw7wvlGsvXsrl9d1uvwbwWWvgXc/i9U0FoTQJnaq+KtXrdzs
         Xu+/WjfR59Y78OV5TIPV/wGASEjOkv6AU5gM3Pa0fWF0a05fhND+qXYwK7DYWvi4Mxbn
         7leRLKXfTmDqLuIv9B9Dqy7hnSGkB7aN8Dr6747RHmNuKLlTtFKY/TJVd/EsR5yw/UJ9
         iXCmPEXwEB5S1ZkTuSVUPtq0AQ0z/+fRymWeRRmDVPSork7VfjW1XlArsn1i97Jsejp6
         gW3tBFa0KPSoOSH4SovObPVUy1kz6Wz1zShvnUu9yHWhShYK9EkvEQIfL3xrvKyUXya+
         0XTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pFbplBFQUOIV1Nh4Mnv6OTr2Rj2NGgBQhiUPNzuNSoI=;
        b=RVBiEltFN5+OZ6803osUQAEbV7IANytQNLk7i/EBogGsyTR1CEmnHm9+Chz5yPA2TE
         58aS1WPOWAwxA46EVmKxmvZS94X6ezvGsNjiQN2Su0Y0uu3jDElbYjcxS+IHcUMIqJHf
         lqktJ/9OpMkWJYvwJt+Ia0Er2R+w5uxYStkZv1Rqxj4JaWXiQDMmhExno6D4vIXoKg3D
         RVkU2m7ON5bOFRRD7DVKiw95mhigFrh81rFv4u7cqzH5fjbyfgsRoOPoUPbf3XYyNWim
         7pmJW7PsEL7As/W00B0aDnOucCsEYk4rtoyGozXCLjKOdEfJBR0byUAuCHRbz9R2Ox0N
         RD2g==
X-Gm-Message-State: AJcUukeFZEIC5P8G4q/MoVY0tGVZn8ckIeme84TSVN+y+B0eA6qk7bBU
        kIofwd9IQeNkF1lRI9iyo0vWBgnk
X-Google-Smtp-Source: ALg8bN57z1U5rQA18tyu8tmzuBBVmpWaygUYlb5fvIKr/Qi0mbtUNTdYLTZ0d5dCeVugpgr+Pp5IxQ==
X-Received: by 2002:a50:8c04:: with SMTP id p4mr19332404edp.274.1548631616698;
        Sun, 27 Jan 2019 15:26:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r51sm13635859eda.64.2019.01.27.15.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 15:26:56 -0800 (PST)
Date:   Sun, 27 Jan 2019 15:26:56 -0800 (PST)
X-Google-Original-Date: Sun, 27 Jan 2019 23:26:35 GMT
Message-Id: <6044b919b0c186aa1f20b56b4235696a248983cf.1548631607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v5.git.gitgitgadget@gmail.com>
References: <pull.31.v4.git.gitgitgadget@gmail.com>
        <pull.31.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 09/21] Add a build definition for Azure DevOps
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

The main idea is to replicate the Travis configuration as faithfully as
possible, to make it easy to compare the Azure Pipeline builds to the
Travis ones (spoiler: some parts, especially the macOS jobs, are way
faster in Azure Pileines). Meaning: the number and the order of the jobs
added in this commit faithfully replicates what we have in .travis.yml.

Note: Our .travis.yml configuration has a Windows part that is *not*
replicated in the Azure Pipelines definition. The reason is easy to see:
As Travis cannot support our Windws needs (even with the preliminary
Windows support that was recently added to Travis after waiting for
*years* for that feature, our test suite would simply hit Travis'
timeout every single time).

To make things a bit easier to understand, we refrain from using the
`matrix` feature here because (while it is powerful) it can be a bit
confusing to users who are not familiar with CI setups. Therefore, we
use a separate phase even for similar configurations (such as GCC vs
Clang on Linux, GCC vs Clang on macOS).

Also, we make use of the shiny new feature we just introduced where the
test suite can output JUnit-style .xml files. This information is made
available in a nice UI that allows the viewer to filter by phase and/or
test number, and to see trends such as: number of (failing) tests, time
spent running the test suite, etc. (While this seemingly contradicts the
intention to replicate the Travis configuration as faithfully as
possible, it is just too nice to show off that capability here already.)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 azure-pipelines.yml   | 259 ++++++++++++++++++++++++++++++++++++++++++
 ci/mount-fileshare.sh |  25 ++++
 2 files changed, 284 insertions(+)
 create mode 100644 azure-pipelines.yml
 create mode 100755 ci/mount-fileshare.sh

diff --git a/azure-pipelines.yml b/azure-pipelines.yml
new file mode 100644
index 0000000000..8cdef105c6
--- /dev/null
+++ b/azure-pipelines.yml
@@ -0,0 +1,259 @@
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
+  - task: PublishBuildArtifacts@1
+    displayName: 'Publish trash directories of failed tests'
+    condition: failed()
+    inputs:
+      PathtoPublish: t/failed-test-artifacts
+      ArtifactName: failed-test-artifacts
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
+  - task: PublishBuildArtifacts@1
+    displayName: 'Publish trash directories of failed tests'
+    condition: failed()
+    inputs:
+      PathtoPublish: t/failed-test-artifacts
+      ArtifactName: failed-test-artifacts
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
+  - task: PublishBuildArtifacts@1
+    displayName: 'Publish trash directories of failed tests'
+    condition: failed()
+    inputs:
+      PathtoPublish: t/failed-test-artifacts
+      ArtifactName: failed-test-artifacts
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
+  - task: PublishBuildArtifacts@1
+    displayName: 'Publish trash directories of failed tests'
+    condition: failed()
+    inputs:
+      PathtoPublish: t/failed-test-artifacts
+      ArtifactName: failed-test-artifacts
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
+  - task: PublishBuildArtifacts@1
+    displayName: 'Publish trash directories of failed tests'
+    condition: failed()
+    inputs:
+      PathtoPublish: t/failed-test-artifacts
+      ArtifactName: failed-test-artifacts
+
+- job: linux32
+  displayName: Linux32
+  condition: succeeded()
+  pool: Hosted Ubuntu 1604
+  steps:
+  - bash: |
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
+
+       res=0
+       sudo AGENT_OS="$AGENT_OS" BUILD_BUILDNUMBER="$BUILD_BUILDNUMBER" BUILD_REPOSITORY_URI="$BUILD_REPOSITORY_URI" BUILD_SOURCEBRANCH="$BUILD_SOURCEBRANCH" BUILD_SOURCEVERSION="$BUILD_SOURCEVERSION" SYSTEM_PHASENAME="$SYSTEM_PHASENAME" SYSTEM_TASKDEFINITIONSURI="$SYSTEM_TASKDEFINITIONSURI" SYSTEM_TEAMPROJECT="$SYSTEM_TEAMPROJECT" CC=$CC MAKEFLAGS="$MAKEFLAGS" bash -lxc ci/run-linux32-docker.sh || res=1
+
+       sudo chmod a+r t/out/TEST-*.xml
+       test ! -d t/failed-test-artifacts || sudo chmod a+r t/failed-test-artifacts
+
+       test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || sudo umount "$HOME/test-cache" || res=1
+       exit $res
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
+  - task: PublishBuildArtifacts@1
+    displayName: 'Publish trash directories of failed tests'
+    condition: failed()
+    inputs:
+      PathtoPublish: t/failed-test-artifacts
+      ArtifactName: failed-test-artifacts
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

