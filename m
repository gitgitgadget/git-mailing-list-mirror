Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D27B41F453
	for <e@80x24.org>; Sun, 27 Jan 2019 23:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfA0X1W (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 18:27:22 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38168 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbfA0X1J (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 18:27:09 -0500
Received: by mail-ed1-f65.google.com with SMTP id h50so11588936ede.5
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 15:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=b7cW3NQWvBmpQlrQPIMNuGX0tGz65l91wYYGw5modhg=;
        b=BHQnXyBoMOuSkWC5CcsWzwthXjAYHua6N66XfJmbZV3R35fDXTfGszih70rDzD9QC6
         WZ0vI+vEv1g6j1VAtCgGhORk5OY05YseYTcWP4yywSckcaprvzfCZcMMQqvO+MIVQdcu
         bNEyy46cLMxrE4/dwnvLQNYDkYKGtIH30WPqUhvJyMO/kQAyOncakxGGEdK+SwYk0rMu
         ir+Y606+4UJtFvebm/hwdHWmk5/cFVgclMb/j64Xp7BiAPPC3H4fZDbP59I0kTVRe8QO
         bj+3sORE8qZqQf0au6Yg6lX4+6DYacuMizu3K6Uo9OEsgwKNywuq26Jo/QKzcHjlUVZa
         KMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=b7cW3NQWvBmpQlrQPIMNuGX0tGz65l91wYYGw5modhg=;
        b=WAVZ0maAFcJO6PxP1yi1diozrgsPF8XEh9dzTu1EDCrF3SpZ4c/kNZLS+S56XG/sYc
         Fcjw+1vsd/aqTWyRQbywKovBqEDDpwCmxDJxECDy+l3IfUEkZsJKe2qbmsqntXkScjfx
         XonnWzOjkiiH0GRH0WZwdyazxRuvkZP1+9UzEJ92pSDtjrm3RQOrH6B/ZpW/QnJWngO1
         Y3/7jCfgYiJVzCdql+e8nZ9pnR/WYEcyCIwdDJwu/fNF5LPtjrwNYL6zw94TcffA9VEe
         V3rl8sHcBrgri9f86UuZIRdjRB2Oqtui9UGQpdfYnTD20ZiQsebzL8lKpA7D9vL4sR5M
         J/8A==
X-Gm-Message-State: AJcUukfPQwEjyjG5k3eaE6chpHD43yTSyEMclGt0C6MLeHTpTFIyQbD3
        OTscOm/KgL+3HvLyvJ9Ks5tvgK1j
X-Google-Smtp-Source: ALg8bN4ANTkWm1UOpqA7KFpLqL3ftAJUsmv1hb+ajgOBZ5xJQrgZxQX7kkaHS/WjUsDjaZPMszCP0w==
X-Received: by 2002:a50:9315:: with SMTP id m21mr19019001eda.58.1548631626664;
        Sun, 27 Jan 2019 15:27:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k20sm13208109eda.71.2019.01.27.15.27.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 15:27:06 -0800 (PST)
Date:   Sun, 27 Jan 2019 15:27:06 -0800 (PST)
X-Google-Original-Date: Sun, 27 Jan 2019 23:26:47 GMT
Message-Id: <6ff87d17729db3dca73e74162cd8f148ce63efdd.1548631608.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v5.git.gitgitgadget@gmail.com>
References: <pull.31.v4.git.gitgitgadget@gmail.com>
        <pull.31.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 21/21] ci: parallelize testing on Windows
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
 azure-pipelines.yml        | 79 ++++++++++++++++++++++++++++++++++----
 ci/make-test-artifacts.sh  | 12 ++++++
 ci/run-test-slice.sh       | 17 ++++++++
 t/helper/test-path-utils.c | 31 +++++++++++++++
 5 files changed, 141 insertions(+), 8 deletions(-)
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
index 480e841a85..c329b7218b 100644
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
@@ -30,21 +30,84 @@ jobs:
     displayName: 'Download git-sdk-64-minimal'
   - powershell: |
       & git-sdk-64-minimal\usr\bin\bash.exe -lc @"
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
