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
	by dcvr.yhbt.net (Postfix) with ESMTP id F1A271F461
	for <e@80x24.org>; Tue, 27 Aug 2019 13:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfH0NqX (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 09:46:23 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36919 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730134AbfH0NqW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 09:46:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id d16so3117217wme.2
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 06:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BabGBa8giFY0ufD5Bg8Q+s3ZG/XP104vJ2pW22l31Uc=;
        b=TZ9ZbT5Gm4xiiyEO+lDLQ/NQ+odhxax57YL3SMkWP/9T2W5yj7tD900cvZ7IaefNC2
         9gHlk7H093Yeuh1QvKE0oKIDLtsRPMw1GgrlTa4sRv6C3uks4lKHBu43RdUtECn5WMWE
         J7uF233WeUK6lYZvbaF4zkCU1/0CPCYteOIbcNwAI2BhgIQ+rwib1yR0O3y7cLWMkQw3
         SyWMU0cxrvlAb0fyut2WJqsh7TnvIPuUpyBb10kZ7HA0bzu7GJAN8qHC1FkjM/144MZW
         l+DJb04qqz9KvpfxVLgSUqduu/+EhNDXNf0iRVSFq8mElZMVPn0xRuHr38T9aNoOKv4A
         FZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BabGBa8giFY0ufD5Bg8Q+s3ZG/XP104vJ2pW22l31Uc=;
        b=SzmCZwr3dC5jKH7U7c30yJZjsIzCq2Py4MNxOOgQeAHfXI7WaCq6n09xdQKT64NwwJ
         tmXzA8vQZSSDUw0ARCvXTvD0RLlbW1PoTts4CKDnVnuj8Fgh6iypxMFAoUP4FM0FtzaJ
         nky9WEQOEAjCX/1pWS8+bw0R7RDrHRzsdSBtrG9upuxSYd4pcUOyI9pPkIywl6B1gBPl
         yqqPYyQuvDTe2SfMCC3bFKUB9uqJePOjdnUv++kKjePVMuVj+xSoM9D6ODzeqM9+EHVF
         rI0ZjVRq/l/JOV9ny8ZclGo9Ft93v7fr2BjQ3hSnquUCLqQwZ4pSTDWYECdKNG6fndiO
         szGQ==
X-Gm-Message-State: APjAAAWpgHUpAaijeLNACIYwWBT1HliAORfU8t14gdiT5iu6FwBXmfpA
        /LQazqOXgwaJbX6QLhdUwh2riqBf4FU=
X-Google-Smtp-Source: APXvYqyATAJek+KquOljO9c9bI64jFiTm36ExwZd1ScVeKganq/hr8Hxf2rfrlJonpPJSEJvPQm/KQ==
X-Received: by 2002:a05:600c:254e:: with SMTP id e14mr30307470wma.150.1566913579505;
        Tue, 27 Aug 2019 06:46:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 25sm2134929wmi.40.2019.08.27.06.46.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 06:46:19 -0700 (PDT)
Date:   Tue, 27 Aug 2019 06:46:19 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Aug 2019 13:46:15 GMT
Message-Id: <7505e85fc5508edd65a67eb9f4a57ebf41e9074c.1566913575.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.305.v2.git.gitgitgadget@gmail.com>
References: <pull.305.git.gitgitgadget@gmail.com>
        <pull.305.v2.git.gitgitgadget@gmail.com>
From:   "lufia via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/3] Support Plan 9 dialect
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, lufia <lufia@lufia.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: lufia <lufia@lufia.org>

Plan 9 ANSI/POSIX environment is:
* No expr(1)
* sed(1) limits max length of label to 7 characters
* pcc ignores object files that has incorrect extension,
  so should use underlying loader directly.
* No ln(1). Instead use bind(1), but bind isn't persisted to the disk.
  However it isn't efficient to copy git to git subcommands such as git-add.
  Therefore Plan 9 needs exec-wrapper to switch behavior by executable name.
* tar(1) don't have -o option

Signed-off-by: lufia <lufia@lufia.org>
---
 GIT-VERSION-GEN     |  2 +-
 Makefile            | 41 ++++++++++++++-----
 config.mak.uname    | 99 +++++++++++++++++++++++++++++++++++++++++++++
 exec-wrapper.c      | 16 ++++++++
 generate-cmdlist.sh | 24 ++++++++---
 t/chainlint.sed     | 66 +++++++++++++++---------------
 templates/Makefile  | 12 +++++-
 7 files changed, 208 insertions(+), 52 deletions(-)
 create mode 100644 exec-wrapper.c

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 98f88a28d3..ec5635b120 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -26,7 +26,7 @@ else
 	VN="$DEF_VER"
 fi
 
-VN=$(expr "$VN" : v*'\(.*\)')
+VN=${VN#v}
 
 if test -r $GVF
 then
diff --git a/Makefile b/Makefile
index 04ff7df64a..a2729ba6d3 100644
--- a/Makefile
+++ b/Makefile
@@ -570,6 +570,7 @@ export prefix bindir sharedir sysconfdir gitwebdir perllibdir localedir
 
 # Set our default programs
 CC = cc
+LD = cc
 AR = ar
 RM = rm -f
 DIFF = diff
@@ -800,6 +801,10 @@ ALL_PROGRAMS = $(PROGRAMS) $(SCRIPTS)
 # what 'all' will build but not install in gitexecdir
 OTHER_PROGRAMS = git$X
 
+# what 'all' will build but not install in neither bindir and gitexecdir,
+COMPAT_PROGRAM_OBJS =
+COMPAT_PROGRAMS =
+
 # what test wrappers are needed and 'install' will install, in bindir
 BINDIR_PROGRAMS_NEED_X += git
 BINDIR_PROGRAMS_NEED_X += git-upload-pack
@@ -1863,6 +1868,11 @@ ifndef PAGER_ENV
 PAGER_ENV = LESS=FRX LV=-c
 endif
 
+ifdef USE_EXEC_WRAPPER
+	COMPAT_PROGRAM_OBJS += exec-wrapper.o
+	COMPAT_PROGRAMS += exec-wrapper$X
+endif
+
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
 QUIET_SUBDIR1  =
 
@@ -2062,7 +2072,7 @@ profile-fast: profile-clean
 	$(MAKE) PROFILE=USE all
 
 
-all:: $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) GIT-BUILD-OPTIONS
+all:: $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS) $(COMPAT_PROGRAMS) GIT-BUILD-OPTIONS
 ifneq (,$X)
 	$(QUIET_BUILT_IN)$(foreach p,$(patsubst %$X,%,$(filter %$X,$(ALL_PROGRAMS) $(BUILT_INS) git$X)), test -d '$p' -o '$p' -ef '$p$X' || $(RM) '$p';)
 endif
@@ -2122,7 +2132,7 @@ git.sp git.s git.o: EXTRA_CPPFLAGS = \
 	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
 
 git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
+	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(LIBS)
 
 help.sp help.s help.o: command-list.h
@@ -2141,10 +2151,11 @@ version.sp version.s version.o: EXTRA_CPPFLAGS = \
 		GIT_CEILING_DIRECTORIES="$(CURDIR)/.." \
 		git rev-parse -q --verify HEAD 2>/dev/null)"'
 
-$(BUILT_INS): git$X
+$(BUILT_INS): git$X $(COMPAT_PROGRAMS)
 	$(QUIET_BUILT_IN)$(RM) $@ && \
 	ln $< $@ 2>/dev/null || \
 	ln -s $< $@ 2>/dev/null || \
+	cp exec-wrapper$X $@ 2>/dev/null || \
 	cp $< $@
 
 command-list.h: generate-cmdlist.sh command-list.txt
@@ -2344,6 +2355,7 @@ VCSSVN_OBJS += vcs-svn/svndump.o
 
 TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
+	$(COMPAT_PROGRAM_OBJS) \
 	$(XDIFF_OBJS) \
 	$(VCSSVN_OBJS) \
 	$(FUZZ_OBJS) \
@@ -2464,22 +2476,29 @@ compat/nedmalloc/nedmalloc.sp compat/nedmalloc/nedmalloc.o: EXTRA_CPPFLAGS = \
 compat/nedmalloc/nedmalloc.sp: SP_EXTRA_FLAGS += -Wno-non-pointer-null
 endif
 
+exec-wrapper.sp exec-wrapper.s exec-wrapper.o: EXTRA_CPPFLAGS = \
+	'-DGIT_EXEC_PATH="$(gitexecdir_SQ)"' \
+	'-DBINDIR="$(bindir_relative_SQ)"'
+
+exec-wrapper$X: exec-wrapper.o GIT-LDFLAGS
+	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^)
+
 git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
 git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(IMAP_SEND_LDFLAGS) $(LIBS)
 
 git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(LIBS)
 git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
 git-remote-testsvn$X: remote-testsvn.o GIT-LDFLAGS $(GITLIBS) $(VCSSVN_LIB)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS) \
+	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS) \
 	$(VCSSVN_LIB)
 
 $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
@@ -2489,7 +2508,7 @@ $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
 	cp $< $@
 
 $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
 
 $(LIB_FILE): $(LIB_OBJS)
@@ -2783,7 +2802,7 @@ t/helper/test-svn-fe$X: $(VCSSVN_LIB)
 t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
 
 t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
-	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
+	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
 check-sha1:: t/helper/test-tool$X
 	t/helper/test-sha1.sh
@@ -2966,6 +2985,7 @@ endif
 		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
 		  ln "$$bindir/git$X" "$$bindir/$$p" 2>/dev/null || \
 		  ln -s "git$X" "$$bindir/$$p" 2>/dev/null || \
+		  cp "exec-wrapper$X" "$$execdir/$$p" 2>/dev/null || \
 		  cp "$$bindir/git$X" "$$bindir/$$p" || exit; } \
 	done && \
 	for p in $(BUILT_INS); do \
@@ -2975,6 +2995,7 @@ endif
 		{ test -z "$(NO_INSTALL_HARDLINKS)" && \
 		  ln "$$execdir/git$X" "$$execdir/$$p" 2>/dev/null || \
 		  ln -s "git$X" "$$execdir/$$p" 2>/dev/null || \
+		  cp "exec-wrapper$X" "$$execdir/$$p" 2>/dev/null || \
 		  cp "$$execdir/git$X" "$$execdir/$$p" || exit; } \
 	done && \
 	remote_curl_aliases="$(REMOTE_CURL_ALIASES)" && \
diff --git a/config.mak.uname b/config.mak.uname
index db7f06b95f..77dc661107 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -427,6 +427,7 @@ ifeq ($(uname_S),Windows)
 
 	CC = compat/vcbuild/scripts/clink.pl
 	AR = compat/vcbuild/scripts/lib.pl
+	LD = $(CC)
 	CFLAGS =
 	BASIC_CFLAGS = -nologo -I. -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
 	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
@@ -510,6 +511,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	# INLINE='' would just replace one set of warnings with another and
 	# still not compile in c89 mode, due to non-const array initializations.
 	CC = cc -c99
+	LD = $(CC)
 	# Build down-rev compatible objects that don't use our new getopt_long.
 	ifeq ($(uname_R).$(uname_V),J06.21)
 		CC += -WRVU=J06.20
@@ -657,8 +659,10 @@ else
 			BASIC_LDFLAGS += -Wl,--large-address-aware
 		endif
 		CC = gcc
+		LD = $(CC)
 		COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
 			-fstack-protector-strong
+		BASIC_LDFLAGS += -fstack-protector-strong
 		EXTLIBS += -lntdll
 		INSTALL = /bin/install
 		NO_R_TO_GCC_LINKER = YesPlease
@@ -691,6 +695,101 @@ ifeq ($(uname_S),QNX)
 	NO_STRCASESTR = YesPlease
 	NO_STRLCPY = YesPlease
 endif
+ifeq ($(uname_S),Plan9)
+	CC = pcc
+	CFLAGS = -FVB+
+	ARFLAGS = uv
+	# pcc don't use mismatched objfiles
+	ifeq ($(objtype),386)
+		LD = 8l
+	endif
+	ifeq ($(objtype),amd64)
+		LD = 6l
+	endif
+	ifeq ($(objtype),arm)
+		LD = 5l
+	endif
+	ifeq ($(objtype),mips)
+		LD = vl
+	endif
+	ifeq ($(objtype),mips64)
+		LD = 4l
+	endif
+	ifeq ($(objtype),power)
+		LD = ql
+	endif
+	ifeq ($(objtype),sparc)
+		LD = kl
+	endif
+	ifeq ($(objtype),spim)
+		LD = 0l
+	endif
+	ifeq ($(objtype),spim64)
+		LD = xl
+	endif
+	BASIC_CFLAGS += -Icompat/plan9
+	BASIC_CFLAGS += -D__PLAN9__
+	BASIC_CFLAGS += -D_POSIX_SOURCE
+	BASIC_CFLAGS += -D_BSD_EXTENSION
+	BASIC_CFLAGS += -D_SUSV2_SOURCE
+	BASIC_CFLAGS += -D_PLAN9_SOURCE
+	BASIC_CFLAGS += -D_RESEARCH_SOURCE
+	BASIC_CFLAGS += -D_REENTRANT_SOURCE
+	BASIC_CFLAGS += -DHAVE_SOCK_OPTS
+	BASIC_CFLAGS += -Dsockaddr_storage=sockaddr_in6
+	BASIC_CFLAGS += -DHOME_ENVIRONMENT=\"home\"
+	BASIC_CFLAGS += -DPATH_ENVIRONMENT=\"path\"
+	BASIC_CFLAGS += -D_PATH_SEP=1
+	BASIC_CFLAGS += -D_PATH_DEFPATH=\"/bin\\x01.\\x01/bin/ape\"
+	COMPAT_CFLAGS += -DHAVE_STDINT_H
+	COMPAT_CFLAGS += -DHAVE_LOCALE_H
+	LDFLAGS = -L/$(objtype)/lib/ape
+
+	NEEDS_CRYPTO_WITH_SSL = YesPlease
+	NEEDS_SYS_PARAM_H = YesPlease
+	NO_NSEC = YesPlease
+	NO_SYMLINK_HEAD = YesPlease
+	NO_GECOS_IN_PWENT = YesPlease
+	NO_GETTEXT = YesPlease
+	NO_SETENV = YesPlease
+	NO_STRCASESTR = YesPlease
+	NO_STRLCPY = YesPlease
+	NO_STRTOUMAX = YesPlease
+	NO_REGEX = YesPlease
+	NO_MKDTEMP = YesPlease
+	NO_UNSETENV = YesPlease
+	NO_INITGROUPS = YesPlease
+	NO_MMAP = YesPlease
+	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
+	NO_STRUCT_ITIMERVAL = YesPlease
+	NO_SETITIMER = YesPlease
+	NO_ICONV = YesPlease
+	NO_SYMLINK_HEAD = YesPlease
+	OPENSSL_SHA1 = YesPlease
+	OPENSSL_SHA256 = YesPlease
+	NO_MEMMEM = YesPlease
+	HAVE_CLOCK_GETTIME = YesPlease
+
+	NO_SVN_TESTS = YesPlease
+	NO_PERL = YesPlease
+	NO_PYTHON = YesPlease
+	NO_TCLTK = YesPlease
+	NO_INSTALL_HARDLINKS = YesPlease
+
+	ETC_GITCONFIG = /sys/lib/git/config
+	ETC_GITATTRIBUTES = /sys/lib/git/attributes
+	USER_GITCONFIG = ~/lib/git/config
+	USER_GITCREDENTIALS = ~/lib/git/credentials
+	USER_GITCREDENTIAL_CACHE = ~/lib/git/credential-cache
+
+	DEFAULT_PAGER = /bin/p
+	PAGER_ENV = terminal=
+	SHELL_PATH = /bin/ape/sh
+	DEFAULT_EDITOR = /bin/ed
+
+	CURL_LDFLAGS = -lcurl -lssl -lcrypto
+	USE_EXEC_WRAPPER = YesPlease
+endif
 
 vcxproj:
 	# Require clean work tree
diff --git a/exec-wrapper.c b/exec-wrapper.c
new file mode 100644
index 0000000000..b56e871d02
--- /dev/null
+++ b/exec-wrapper.c
@@ -0,0 +1,16 @@
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#include <unistd.h>
+
+int main(int argc, char **argv)
+{
+	/* we should detect git-core path */
+
+	USED(argc);
+	if (execv("/bin/git", argv) < 0) {
+		fprintf(stderr, "%s: %s\n", argv[0], strerror(errno));
+		return 1;
+	}
+	return 0; /* can't happen */
+}
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 71158f7d8b..e4fe3ea608 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -1,5 +1,10 @@
 #!/bin/sh
 
+if ! echo abc | sed 's/(ab)c/\1/' >/dev/null 2>&1
+then
+	alias sed='sed -E'
+fi
+
 die () {
 	echo "$@" >&2
 	exit 1
@@ -10,7 +15,7 @@ command_list () {
 }
 
 get_categories () {
-	tr ' ' '\n'|
+	tr ' ' '\012'|
 	grep -v '^$' |
 	sort |
 	uniq
@@ -18,16 +23,16 @@ get_categories () {
 
 category_list () {
 	command_list "$1" |
-	cut -c 40- |
+	awk '{ print substr($0, 40) }' |
 	get_categories
 }
 
 get_synopsis () {
 	sed -n '
-		/^NAME/,/'"$1"'/H
+		/^NAME/,/'"$1"'/h
 		${
 			x
-			s/.*'"$1"' - \(.*\)/N_("\1")/
+			s/.*'"$1"' - (.*)/N_("\1")/
 			p
 		}' "Documentation/$1.txt"
 }
@@ -60,16 +65,23 @@ define_category_names () {
 	echo "};"
 }
 
+if test -z "$(echo -n)"
+then
+	alias print='echo -n'
+else
+	alias print='printf %s'
+fi
+
 print_command_list () {
 	echo "static struct cmdname_help command_list[] = {"
 
 	command_list "$1" |
 	while read cmd rest
 	do
-		printf "	{ \"$cmd\", $(get_synopsis $cmd), 0"
+		print "	{ \"$cmd\", $(get_synopsis $cmd), 0"
 		for cat in $(echo "$rest" | get_categories)
 		do
-			printf " | CAT_$cat"
+			print " | CAT_$cat"
 		done
 		echo " },"
 	done
diff --git a/t/chainlint.sed b/t/chainlint.sed
index 70df40e34b..7282e7b426 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -117,7 +117,7 @@
 /^[ 	]*!*[ 	]*(..*)[ 	]*[0-9]*[<>|&]/boneline
 
 # multi-line "(...\n...)"
-/^[ 	]*(/bsubshell
+/^[ 	]*(/bsubsh
 
 # innocuous line -- print it and advance to next line
 b
@@ -130,11 +130,11 @@ b
 }
 b
 
-:subshell
+:subsh
 # bare "(" line? -- stash for later printing
 /^[ 	]*([	]*$/ {
 	h
-	bnextline
+	bnextln
 }
 # "(..." line -- split off and stash "(", then process "..." as its own line
 x
@@ -143,7 +143,7 @@ x
 s/(//
 bslurp
 
-:nextline
+:nextln
 N
 s/.*\n//
 
@@ -151,10 +151,10 @@ s/.*\n//
 # incomplete line "...\"
 /\\$/bicmplte
 # multi-line quoted string "...\n..."?
-/"/bdqstring
+/"/bdqstr
 # multi-line quoted string '...\n...'? (but not contraction in string "it's")
 /'/{
-	/"[^'"]*'[^'"]*"/!bsqstring
+	/"[^'"]*'[^'"]*"/!bsqstr
 }
 :folded
 # here-doc -- swallow it
@@ -163,8 +163,8 @@ s/.*\n//
 # before closing ")", "done", "elsif", "else", or "fi" will need to be
 # re-visited to drop "suspect" marking since final line of those constructs
 # legitimately lacks "&&", so "suspect" mark must be removed
-/^[ 	]*#/bnextline
-/^[ 	]*$/bnextline
+/^[ 	]*#/bnextln
+/^[ 	]*$/bnextln
 # in-line comment -- strip it (but not "#" in a string, Bash ${#...} array
 # length, or Perforce "//depot/path#42" revision in filespec)
 /[ 	]#/{
@@ -175,22 +175,22 @@ s/.*\n//
 # multi-line "case ... esac"
 /^[ 	]*case[ 	]..*[ 	]in/bcase
 # multi-line "for ... done" or "while ... done"
-/^[ 	]*for[ 	]..*[ 	]in/bcontinue
-/^[ 	]*while[ 	]/bcontinue
-/^[ 	]*do[ 	]/bcontinue
-/^[ 	]*do[ 	]*$/bcontinue
-/;[ 	]*do/bcontinue
+/^[ 	]*for[ 	]..*[ 	]in/bcnt
+/^[ 	]*while[ 	]/bcnt
+/^[ 	]*do[ 	]/bcnt
+/^[ 	]*do[ 	]*$/bcnt
+/;[ 	]*do/bcnt
 /^[ 	]*done[ 	]*&&[ 	]*$/bdone
 /^[ 	]*done[ 	]*$/bdone
 /^[ 	]*done[ 	]*[<>|]/bdone
 /^[ 	]*done[ 	]*)/bdone
-/||[ 	]*exit[ 	]/bcontinue
-/||[ 	]*exit[ 	]*$/bcontinue
+/||[ 	]*exit[ 	]/bcnt
+/||[ 	]*exit[ 	]*$/bcnt
 # multi-line "if...elsif...else...fi"
-/^[ 	]*if[ 	]/bcontinue
-/^[ 	]*then[ 	]/bcontinue
-/^[ 	]*then[ 	]*$/bcontinue
-/;[ 	]*then/bcontinue
+/^[ 	]*if[ 	]/bcnt
+/^[ 	]*then[ 	]/bcnt
+/^[ 	]*then[ 	]*$/bcnt
+/;[ 	]*then/bcnt
 /^[ 	]*elif[ 	]/belse
 /^[ 	]*elif[ 	]*$/belse
 /^[ 	]*else[ 	]/belse
@@ -234,10 +234,10 @@ s/.*\n//
 	}
 }
 # line ends with pipe "...|" -- valid; not missing "&&"
-/|[ 	]*$/bcontinue
+/|[ 	]*$/bcnt
 # missing end-of-line "&&" -- mark suspect
 /&&[ 	]*$/!s/^/?!AMP?!/
-:continue
+:cnt
 # retrieve and print previous line
 x
 n
@@ -250,7 +250,7 @@ s/\\\n//
 bslurp
 
 # check for multi-line double-quoted string "...\n..." -- fold to one line
-:dqstring
+:dqstr
 # remove all quote pairs
 s/"\([^"]*\)"/@!\1@!/g
 # done if no dangling quote
@@ -258,13 +258,13 @@ s/"\([^"]*\)"/@!\1@!/g
 # otherwise, slurp next line and try again
 N
 s/\n//
-bdqstring
+bdqstr
 :dqdone
 s/@!/"/g
 bfolded
 
 # check for multi-line single-quoted string '...\n...' -- fold to one line
-:sqstring
+:sqstr
 # remove all quote pairs
 s/'\([^']*\)'/@!\1@!/g
 # done if no dangling quote
@@ -272,7 +272,7 @@ s/'\([^']*\)'/@!\1@!/g
 # otherwise, slurp next line and try again
 N
 s/\n//
-bsqstring
+bsqstr
 :sqdone
 s/@!/'/g
 bfolded
@@ -282,11 +282,11 @@ bfolded
 :heredoc
 s/^\(.*\)<<[ 	]*[-\\'"]*\([A-Za-z0-9_][A-Za-z0-9_]*\)['"]*/<\2>\1<</
 s/[ 	]*<<//
-:heredsub
+:heresub
 N
 /^<\([^>]*\)>.*\n[ 	]*\1[ 	]*$/!{
 	s/\n.*$//
-	bheredsub
+	bheresub
 }
 s/^<[^>]*>//
 s/\n.*$//
@@ -305,7 +305,7 @@ bcase
 x
 s/?!AMP?!//
 x
-bcontinue
+bcnt
 
 # found "done" closing for-loop or while-loop, or "fi" closing if-then -- drop
 # "suspect" from final contained line since that line legitimately lacks "&&"
@@ -321,10 +321,10 @@ bchkchn
 # found nested multi-line "(...\n...)" -- pass through untouched
 :nest
 x
-:nstslurp
+:nstslrp
 n
 # closing ")" on own line -- stop nested slurp
-/^[ 	]*)/bnstclose
+/^[ 	]*)/bnstclos
 # comment -- not closing ")" if in comment
 /^[ 	]*#/bnstcnt
 # "$((...))" -- arithmetic expansion; not closing ")"
@@ -332,11 +332,11 @@ n
 # "$(...)" -- command substitution; not closing ")"
 /\$([^)][^)]*)[^)]*$/bnstcnt
 # closing "...)" -- stop nested slurp
-/)/bnstclose
+/)/bnstclos
 :nstcnt
 x
-bnstslurp
-:nstclose
+bnstslrp
+:nstclos
 s/^/>>/
 # is it "))" which closes nested and parent subshells?
 /)[ 	]*)/bslurp
diff --git a/templates/Makefile b/templates/Makefile
index d22a71a399..19216a924a 100644
--- a/templates/Makefile
+++ b/templates/Makefile
@@ -4,8 +4,16 @@ ifndef V
 	QUIET = @
 endif
 
+uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
+
 INSTALL ?= install
 TAR ?= tar
+TAR_CF = $(TAR) cf
+TAR_XF = $(TAR) xof
+ifeq ($(uname_S),Plan9)
+	TAR_CF = $(TAR) cf
+	TAR_XF = $(TAR) xf
+endif
 RM ?= rm -f
 prefix ?= $(HOME)
 template_instdir ?= $(prefix)/share/git-core/templates
@@ -62,5 +70,5 @@ clean:
 
 install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(template_instdir_SQ)'
-	(cd blt && $(TAR) cf - .) | \
-	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR) xof -)
+	(cd blt && $(TAR_CF) - .) | \
+	(cd '$(DESTDIR_SQ)$(template_instdir_SQ)' && umask 022 && $(TAR_XF) -)
-- 
gitgitgadget
