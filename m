Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 245161F453
	for <e@80x24.org>; Wed, 23 Jan 2019 14:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfAWOkg (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 09:40:36 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37298 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbfAWOke (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 09:40:34 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so1880817edb.4
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 06:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fSYfsCglrTsPvdE/rLHEBuZDG7QQbq1p8mnMzRUaygE=;
        b=i3hL+JQWGnbwP32XuI/sTydpZpm9xy0/vQgtxZP4zQyB1ULbOzLHXEmCtCcv4y6uFF
         W1kmjKc21bjRJzix+RuMqqGahjyTXU9WNS5ucP6tP6RrMHUkcamFg7oWwdatWiYMiqHW
         Tym2z5sc1WXCz9YrtxWN13gH337a4AxULCLFdMLRcyG+6xEBor/7TDm/Ti9oG62i85OE
         Xf8zx63lBmIfPEc83hMucam1lCva7RBWXF7JGc7c5y2diJYKqSYBi6Ms767VqqW69vim
         NNhhrCJTZF+iZ27vHwUNU1pWI5AqFZhzevYa3dM2fA212wmbMzdee32r6ZGP4kMddOsS
         Yl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fSYfsCglrTsPvdE/rLHEBuZDG7QQbq1p8mnMzRUaygE=;
        b=WQIeez5e15+Gjt48/eXsxPlfQjBnJoo+OVbo0S9IR1+OsonB81uYUjmXAzf3AYJCAa
         eCb4RIHJdJevldTCqvqnQNpZZBHPxgbFduS8kWI9C3WyaAF/DARwwwu7beA05gYSAFIk
         cOj44pl/GXnH/dCbyyZK0kndMtXER3Vf2pSivqgcBiGUxoOAsPQlAOJ2H3LVNF9MgrBe
         VARyGItGG6HZ3+kmgWN19dgwmpQRpaijeIEyqet/mc28fqICjxcV8jUCbnl2COzS+eKr
         BHI2GYNY9ZYJpMrtIeWMHYnoGMmmgszo0dCKA8wFlOLRc7t5/OLkJ5XKyg4IsgCZybB3
         lU7Q==
X-Gm-Message-State: AJcUukerPcLES2DPV4HiDQaPTTIngPLqi+vlHJBYE5U+S8P+epCmjXH1
        weUeQXGKFUQpQsEPIpYLij0dh2qt
X-Google-Smtp-Source: ALg8bN5/D1kYG1hbDpPKIrtxU4B8Dv8kCKaGqWKcc7e/T32J0er8HTveskvp/jnGS5uL527ZmoKGJg==
X-Received: by 2002:a50:ac81:: with SMTP id x1mr3017302edc.71.1548254432157;
        Wed, 23 Jan 2019 06:40:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b45sm10405974eda.34.2019.01.23.06.40.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:40:31 -0800 (PST)
Date:   Wed, 23 Jan 2019 06:40:31 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 14:40:12 GMT
Message-Id: <8bdd9804a1a7751c9646c585022ab4d043eb2168.1548254412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v4.git.gitgitgadget@gmail.com>
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 21/21] ci: parallelize testing on Windows
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

The fact that Git's test suite is implemented in Unix shell script that
is as portable as we can muster, combined with the fact that Unix shell
scripting is foreign to Windows (and therefore has to be emulated),
results in pretty abysmal speed of the test suite on that platform, for
pretty much no other reason than that language choice.

For comparison: while the Linux build & test is typically done within
about 8 minutes, the Windows build & test typically lasts about 80
minutes in Azure Pipelines.

To help with that, let's use the Azure Pipeline feature where you can
parallelize jobs, make jobs depend on each other, and pass artifacts
between them.

The tests are distributed using the following heuristic: listing all
test scripts ordered by size in descending order (as a cheap way to
estimate the overall run time), every Nth script is run (where N is the
total number of parallel jobs), starting at the index corresponding to
the parallel job. This slicing is performed by a new function that is
added to the `test-tool`.

To optimize the overall runtime of the entire Pipeline, we need to move
the Windows jobs to the beginning (otherwise there would be a very
decent chance for the Pipeline to be run only the Windows build, while
all the parallel Windows test jobs wait for this single one).

We use Azure Pipelines Artifacts for both the minimal Git for Windows
SDK as well as the built executables, as deduplication and caching close
to the agents makes that really fast. For comparison: while downloading
and unpacking the minimal Git for Windows SDK via PowerShell takes only
one minute (down from anywhere between 2.5 to 7 when using a shallow
clone), uploading it as Pipeline Artifact takes less than 30s and
downloading and unpacking less than 20s (sometimes even as little as
only twelve seconds).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                   | 10 +++++
 azure-pipelines.yml        | 82 +++++++++++++++++++++++++++++++++-----
 ci/make-test-artifacts.sh  | 12 ++++++
 ci/run-test-slice.sh       | 17 ++++++++
 t/helper/test-path-utils.c | 31 ++++++++++++++
 5 files changed, 143 insertions(+), 9 deletions(-)
 create mode 100755 ci/make-test-artifacts.sh
 create mode 100755 ci/run-test-slice.sh

diff --git a/Makefile b/Makefile
index 044b4f77bd..daa318fe17 100644
--- a/Makefile
+++ b/Makefile
@@ -2927,6 +2927,16 @@ rpm::
 	@false
 .PHONY: rpm
 
+artifacts-tar:: $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) \
+		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
+		$(NO_INSTALL) $(MOFILES)
+	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
+		SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
+	test -n "$(ARTIFACTS_DIRECTORY)"
+	mkdir -p "$(ARTIFACTS_DIRECTORY)"
+	$(TAR) czf "$(ARTIFACTS_DIRECTORY)/artifacts.tar.gz" $^ templates/blt/
+.PHONY: artifacts-tar
+
 htmldocs = git-htmldocs-$(GIT_VERSION)
 manpages = git-manpages-$(GIT_VERSION)
 .PHONY: dist-doc distclean
diff --git a/azure-pipelines.yml b/azure-pipelines.yml
index 3085ff6ace..6cd27b3483 100644
--- a/azure-pipelines.yml
+++ b/azure-pipelines.yml
@@ -3,8 +3,8 @@ resources:
   fetchDepth: 1
 
 jobs:
-- job: windows
-  displayName: Windows
+- job: windows_build
+  displayName: Windows Build
   condition: succeeded()
   pool: Hosted
   timeoutInMinutes: 240
@@ -30,22 +30,86 @@ jobs:
     displayName: 'Download git-sdk-64-minimal'
   - powershell: |
       & git-sdk-64-minimal\usr\bin\bash.exe -lc @"
-        export MAKEFLAGS=-j10
-        export DEVELOPER=1
-        export NO_PERL=1
-        export NO_SVN_TESTS=1
-        export GIT_TEST_SKIP_REBASE_P=1
+        ci/make-test-artifacts.sh artifacts
+      "@
+      if (!$?) { exit(1) }
+    displayName: Build
+    env:
+      HOME: $(Build.SourcesDirectory)
+      MSYSTEM: MINGW64
+      MAKEFLAGS: -j10
+      DEVELOPER: 1
+      NO_PERL: 1
+  - task: PublishPipelineArtifact@0
+    displayName: 'Publish Pipeline Artifact: test artifacts'
+    inputs:
+      artifactName: 'windows-artifacts'
+      targetPath: '$(Build.SourcesDirectory)\artifacts'
+  - task: PublishPipelineArtifact@0
+    displayName: 'Publish Pipeline Artifact: git-sdk-64-minimal'
+    inputs:
+      artifactName: 'git-sdk-64-minimal'
+      targetPath: '$(Build.SourcesDirectory)\git-sdk-64-minimal'
+  - powershell: |
+      if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
+        cmd /c rmdir "$(Build.SourcesDirectory)\test-cache"
+      }
+    displayName: 'Unmount test-cache'
+    condition: true
+    env:
+      GITFILESHAREPWD: $(gitfileshare.pwd)
+
+- job: windows_test
+  displayName: Windows Test
+  dependsOn: windows_build
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
+    displayName: 'Download Pipeline Artifact: test artifacts'
+    inputs:
+      artifactName: 'windows-artifacts'
+      targetPath: '$(Build.SourcesDirectory)'
+  - task: DownloadPipelineArtifact@0
+    displayName: 'Download Pipeline Artifact: git-sdk-64-minimal'
+    inputs:
+      artifactName: 'git-sdk-64-minimal'
+      targetPath: '$(Build.SourcesDirectory)\git-sdk-64-minimal'
+  - powershell: |
+      & git-sdk-64-minimal\usr\bin\bash.exe -lc @"
+        test -f artifacts.tar.gz || {
+          echo No test artifacts found\; skipping >&2
+          exit 0
+        }
+        tar xf artifacts.tar.gz || exit 1
+
+        # Let Git ignore the SDK and the test-cache
+        printf '%s\n' /git-sdk-64-minimal/ /test-cache/ >>.git/info/exclude
 
-        ci/run-build-and-tests.sh || {
+        ci/run-test-slice.sh `$SYSTEM_JOBPOSITIONINPHASE `$SYSTEM_TOTALJOBSINPHASE || {
           ci/print-test-failures.sh
           exit 1
         }
       "@
       if (!$?) { exit(1) }
-    displayName: 'Build & Test'
+    displayName: 'Test (parallel)'
     env:
       HOME: $(Build.SourcesDirectory)
       MSYSTEM: MINGW64
+      MAKEFLAGS: -j10
+      NO_SVN_TESTS: 1
+      GIT_TEST_SKIP_REBASE_P: 1
   - powershell: |
       if ("$GITFILESHAREPWD" -ne "" -and "$GITFILESHAREPWD" -ne "`$`(gitfileshare.pwd)") {
         cmd /c rmdir "$(Build.SourcesDirectory)\test-cache"
diff --git a/ci/make-test-artifacts.sh b/ci/make-test-artifacts.sh
new file mode 100755
index 0000000000..646967481f
--- /dev/null
+++ b/ci/make-test-artifacts.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+#
+# Build Git and store artifacts for testing
+#
+
+mkdir -p "$1" # in case ci/lib.sh decides to quit early
+
+. ${0%/*}/lib.sh
+
+make artifacts-tar ARTIFACTS_DIRECTORY="$1"
+
+check_unignored_build_artifacts
diff --git a/ci/run-test-slice.sh b/ci/run-test-slice.sh
new file mode 100755
index 0000000000..f8c2c3106a
--- /dev/null
+++ b/ci/run-test-slice.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+#
+# Test Git in parallel
+#
+
+. ${0%/*}/lib.sh
+
+case "$CI_OS_NAME" in
+windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
+*) ln -s "$cache_dir/.prove" t/.prove;;
+esac
+
+make --quiet -C t T="$(cd t &&
+	./helper/test-tool path-utils slice-tests "$1" "$2" t[0-9]*.sh |
+	tr '\n' ' ')"
+
+check_unignored_build_artifacts
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 6efde6f5ba..5d543ad21f 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -177,6 +177,14 @@ static int is_dotgitmodules(const char *path)
 	return is_hfs_dotgitmodules(path) || is_ntfs_dotgitmodules(path);
 }
 
+static int cmp_by_st_size(const void *a, const void *b)
+{
+	intptr_t x = (intptr_t)((struct string_list_item *)a)->util;
+	intptr_t y = (intptr_t)((struct string_list_item *)b)->util;
+
+	return x > y ? -1 : (x < y ? +1 : 0);
+}
+
 int cmd__path_utils(int argc, const char **argv)
 {
 	if (argc == 3 && !strcmp(argv[1], "normalize_path_copy")) {
@@ -324,6 +332,29 @@ int cmd__path_utils(int argc, const char **argv)
 		return 0;
 	}
 
+	if (argc > 5 && !strcmp(argv[1], "slice-tests")) {
+		int res = 0;
+		long offset, stride, i;
+		struct string_list list = STRING_LIST_INIT_NODUP;
+		struct stat st;
+
+		offset = strtol(argv[2], NULL, 10);
+		stride = strtol(argv[3], NULL, 10);
+		if (stride < 1)
+			stride = 1;
+		for (i = 4; i < argc; i++)
+			if (stat(argv[i], &st))
+				res = error_errno("Cannot stat '%s'", argv[i]);
+			else
+				string_list_append(&list, argv[i])->util =
+					(void *)(intptr_t)st.st_size;
+		QSORT(list.items, list.nr, cmp_by_st_size);
+		for (i = offset; i < list.nr; i+= stride)
+			printf("%s\n", list.items[i].string);
+
+		return !!res;
+	}
+
 	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
 		argv[1] ? argv[1] : "(there was none)");
 	return 1;
-- 
gitgitgadget
