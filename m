Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6B3C1F461
	for <e@80x24.org>; Thu, 18 Jul 2019 13:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390533AbfGRNTS (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jul 2019 09:19:18 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43613 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390386AbfGRNTP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jul 2019 09:19:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so28644452wru.10
        for <git@vger.kernel.org>; Thu, 18 Jul 2019 06:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GM/y04ajKEys86gTJ1hKFc0hqj5SVtYCPH4UF6OpRqg=;
        b=qEDOpGf83n0SZFX0Hnj59DOseoti6xRjhPifbhyyjzUePAeUtz5lQS8cFSRUz7FHGi
         lR2M5b9vFMUvoM1i8IgJflchsKm5xDNZQXSyfM/QBJt+GdSF9yTJjhq18HJXAZgItVmg
         chmTXI7l2wCaLGV++ZkO7Jg4cD4VoSXEUA1mfAErULpgxBJ811MGeACcpEMrKHtiZAPP
         hhQCch84/5ajo1jSZY5fC9sMsdS/Ptz5fMXXrQLrAXsfRLBxRhelpxVMkV0toBjaZ0rH
         SZMXlDCimviRrOi/BplRRk0yCExI0WR92UujrPsyYJzkvGO6wZHxifvFFr8pQNS2EwNo
         WMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GM/y04ajKEys86gTJ1hKFc0hqj5SVtYCPH4UF6OpRqg=;
        b=sAuO+QCXVYpSdITdlVtvqI+O4GLVO6jRAkwpIfUDBxMwwB6OS+AYu2dmnCdGCsHHFl
         5T/k8e2HHwkK3Hve3w5lCauPxkBxTpB3E0KJQ7O1LYkbD0JEKoJmkAZfvmbDNgEhJ28Q
         MCfRwLDTiSbbVUCY/gb19JsDiHpmGbGznnP2LkkBxOHYPgRx4MJEj3/OCTXEa2GCzd1a
         YZfdP7rBqfOjKtkfq6NogQQXEVa3GLO5CQeDiUOFgs/f4Kj4Ai8yFJ2Er8VinMK9Fw/4
         iLS5eBsoK4H0rXnJ+uVEwF8AgpWNabqePKzs9wX18fEB2IxX2fj1A4MFPz3WTFsBUlfx
         8dag==
X-Gm-Message-State: APjAAAXnottWZBRSNHdwaa14wstSNN5M1nKws1T1j0mhM6Kgn28ME4V6
        BPoQyuGzRHtFg45ILb4IaqEb68Ty
X-Google-Smtp-Source: APXvYqxsbvPbAE/u3XbL3Wmp3YACJawIZN0gmQYdP6ffPlSNTqLHmr015Ud2zEEzyRqtNxQhoXlTqg==
X-Received: by 2002:a5d:4309:: with SMTP id h9mr48362403wrq.221.1563455953177;
        Thu, 18 Jul 2019 06:19:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17sm23091353wmf.27.2019.07.18.06.19.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 06:19:12 -0700 (PDT)
Date:   Thu, 18 Jul 2019 06:19:12 -0700 (PDT)
X-Google-Original-Date: Thu, 18 Jul 2019 13:18:53 GMT
Message-Id: <23615bc8cfd6e3d12d769f99051916ca5b2641e8.1563455939.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.287.git.gitgitgadget@gmail.com>
References: <pull.287.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 18/24] msvc: add a Makefile target to pre-generate the Visual
 Studio solution
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

The entire idea of generating the VS solution makes only sense if we
generate it via Continuous Integration; otherwise potential users would
still have to download the entire Git for Windows SDK.

If we pre-generate the Visual Studio solution, Git can be built entirely
within Visual Studio, and the test scripts can be run in a regular Git
for Windows (e.g. the Portable Git flavor, which does not include a full
GCC toolchain and therefore weighs only about a tenth of Git for
Windows' SDK).

So let's just add a target in the Makefile that can be used to generate
said solution; The generated files will then be committed so that they
can be pushed to a branch ready to check out by Visual Studio users.

To make things even more useful, we also generate and commit other files
that are required to run the test suite, such as templates and
bin-wrappers: with this, developers can run the test suite in a regular
Git Bash after building the solution in Visual Studio.

Note: for this build target, we do not actually need to initialize the
`vcpkg` system, so we don't.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/vcbuild/README          | 23 +++++++++++++
 config.mak.uname               | 61 ++++++++++++++++++++++++++++++++++
 contrib/buildsystems/engine.pl |  3 +-
 3 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/compat/vcbuild/README b/compat/vcbuild/README
index b633e7db98..1b6dabf5a2 100644
--- a/compat/vcbuild/README
+++ b/compat/vcbuild/README
@@ -37,6 +37,29 @@ The Steps to Build Git with VS2015 or VS2017 from the command line.
 
 ================================================================
 
+Alternatively, run `make vcxproj` and then load the generated `git.sln` in
+Visual Studio. The initial build will install the vcpkg system and build the
+dependencies automatically. This will take a while.
+
+Instead of generating the `git.sln` file yourself (which requires a full Git
+for Windows SDK), you may want to consider fetching the `vs/master` branch of
+https://github.com/git-for-windows/git instead (which is updated automatically
+via CI running `make vcxproj`). The `vs/master` branch does not require a Git
+for Windows to build, but you can run the test scripts in a regular Git Bash.
+
+Note that `make vcxproj` will automatically add and commit the generated `.sln`
+and `.vcxproj` files to the repo. This is necessary to allow building a
+fully-testable Git in Visual Studio, where a regular Git Bash can be used to
+run the test scripts (as opposed to a full Git for Windows SDK): a number of
+build targets, such as Git commands implemented as Unix shell scripts (where
+`@@SHELL_PATH@@` and other placeholders are interpolated) require a full-blown
+Git for Windows SDK (which is about 10x the size of a regular Git for Windows
+installation).
+
+If your plan is to open a Pull Request with Git for Windows, it is a good idea
+to drop this commit before submitting.
+
+================================================================
 The Steps of Build Git with VS2008
 
 1. You need the build environment, which contains the Git dependencies
diff --git a/config.mak.uname b/config.mak.uname
index 48a6723222..6d0ed923b8 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -25,10 +25,12 @@ include compat/vcbuild/MSVC-DEFS-GEN
 	# See if vcpkg and the vcpkg-build versions of the third-party
 	# libraries that we use are installed.  We include the result
 	# to get $(vcpkg_*) variables defined for the Makefile.
+ifeq (,$(SKIP_VCPKG))
 compat/vcbuild/VCPKG-DEFS: compat/vcbuild/vcpkg_install.bat
 	@"$<"
 include compat/vcbuild/VCPKG-DEFS
 endif
+endif
 
 # We choose to avoid "if .. else if .. else .. endif endif"
 # because maintaining the nesting to match is a pain.  If
@@ -689,3 +691,62 @@ ifeq ($(uname_S),QNX)
 	NO_STRCASESTR = YesPlease
 	NO_STRLCPY = YesPlease
 endif
+
+vcxproj:
+	# Require clean work tree
+	git update-index -q --refresh && \
+	git diff-files --quiet && \
+	git diff-index --cached --quiet HEAD --
+
+	# Make .vcxproj files and add them
+	unset QUIET_GEN QUIET_BUILT_IN; \
+	perl contrib/buildsystems/generate -g Vcxproj
+	git add -f git.sln {*,*/lib,t/helper/*}/*.vcxproj
+
+	# Add command-list.h
+	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 command-list.h
+	git add -f command-list.h
+
+	# Add scripts
+	rm -f perl/perl.mak
+	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 \
+		$(SCRIPT_LIB) $(SCRIPT_SH_GEN) $(SCRIPT_PERL_GEN)
+	# Strip out the sane tool path, needed only for building
+	sed -i '/^git_broken_path_fix ".*/d' git-sh-setup
+	git add -f $(SCRIPT_LIB) $(SCRIPT_SH_GEN) $(SCRIPT_PERL_GEN)
+
+	# Add Perl module
+	$(MAKE) $(LIB_PERL_GEN)
+	git add -f perl/build
+
+	# Add bin-wrappers, for testing
+	rm -rf bin-wrappers/
+	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 $(test_bindir_programs)
+	# Ensure that the GIT_EXEC_PATH is a Unix-y one, and that the absolute
+	# path of the repository is not hard-coded (GIT_EXEC_PATH will be set
+	# by test-lib.sh according to the current setup)
+	sed -i -e 's/^\(GIT_EXEC_PATH\)=.*/test -n "$${\1##*:*}" ||\
+			\1="$$(cygpath -u "$$\1")"/' \
+		-e "s|'$$(pwd)|\"\$$GIT_EXEC_PATH\"'|g" bin-wrappers/*
+	# Ensure that test-* helpers find the .dll files copied to top-level
+	sed -i 's|^PATH=.*|&:"$$GIT_EXEC_PATH"|' bin-wrappers/test-*
+	# We do not want to force hard-linking builtins
+	sed -i 's|\(git\)-\([-a-z]*\)\.exe"|\1.exe" \2|g' \
+		bin-wrappers/git-{receive-pack,upload-archive}
+	git add -f $(test_bindir_programs)
+	# remote-ext is a builtin, but invoked as if it were external
+	sed 's|receive-pack|remote-ext|g' \
+		<bin-wrappers/git-receive-pack >bin-wrappers/git-remote-ext
+	git add -f bin-wrappers/git-remote-ext
+
+	# Add templates
+	$(MAKE) -C templates
+	git add -f templates/boilerplates.made templates/blt/
+
+	# Add build options
+	$(MAKE) MSVC=1 SKIP_VCPKG=1 prefix=/mingw64 GIT-BUILD-OPTIONS
+	git add -f GIT-BUILD-OPTIONS
+
+	# Commit the whole shebang
+	git commit -m "Generate Visual Studio solution" \
+		-m "Auto-generated by \`$(MAKE)$(MAKEFLAGS) $@\`"
diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 8bb07e8e25..fba8a3f056 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -82,7 +82,8 @@ sub showUsage
 # Capture the make dry stderr to file for review (will be empty for a release build).
 
 my $ErrsFile = "msvc-build-makedryerrors.txt";
-@makedry = `make -C $git_dir -n MSVC=1 V=1 2>$ErrsFile` if !@makedry;
+@makedry = `make -C $git_dir -n MSVC=1 SKIP_VCPKG=1 V=1 2>$ErrsFile`
+if !@makedry;
 # test for an empty Errors file and remove it
 unlink $ErrsFile if -f -z $ErrsFile;
 
-- 
gitgitgadget

