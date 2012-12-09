From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: [PATCH] Makefile: whitespace style fixes in macro definitions
Date: Sun,  9 Dec 2012 11:36:17 +0100
Message-ID: <0544836357d56c05188941ef5a471605fa6d4881.1355049367.git.stefano.lattarini@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 09 11:36:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TheFe-00053K-UA
	for gcvg-git-2@plane.gmane.org; Sun, 09 Dec 2012 11:36:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758307Ab2LIKgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2012 05:36:31 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:37027 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab2LIKg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2012 05:36:28 -0500
Received: by mail-ee0-f46.google.com with SMTP id e53so1030867eek.19
        for <git@vger.kernel.org>; Sun, 09 Dec 2012 02:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=aASIPIulT4xFR3AvfPxvAc5bJ2V5GwP4YcoTNVWDmkc=;
        b=WfK6kq6UG7DjE2VzC+9WX045ByZDwAGlagPqzF+irrynV4iXJ3Xo3rtKEkfZoYMAGx
         QxjC0vqs4pYVoLqlreOeIIhtsJs+PRNTXrJqVhQltYU5cjXazNV44b2mVVInjQUD7N7U
         yihkrTiA14hAW19gTUqEayalGDqTVWVMPiymitYHAtZfKQaXCEyoe8bKGxptm3mw3XSF
         l8jZbPLX37MWLi4IbN4VBvT8+u0we+Nz6YEbWjIwsjWD1mYz5BA9HHomRpVnDF5YJvGy
         mV/T0QkOxiMKPf9NxhsydyrXyhMaFIB+yKrsALRWV3aHZYie1Sj/ETina/h5PDJXDnzk
         VvKQ==
Received: by 10.14.215.194 with SMTP id e42mr37144164eep.32.1355049387478;
        Sun, 09 Dec 2012 02:36:27 -0800 (PST)
Received: from localhost.localdomain (host137-94-dynamic.4-87-r.retail.telecomitalia.it. [87.4.94.137])
        by mx.google.com with ESMTPS id z8sm35653353eeo.11.2012.12.09.02.36.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 09 Dec 2012 02:36:26 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1.347.gf94c325
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211233>

Consistently use a single space before and after the "=" (or ":=", "+=",
etc.) in assignments to make macros.  Granted, this was not a big deal,
but I did find the needless inconsistency quite distracting.

Signed-off-by: Stefano Lattarini <stefano.lattarini@gmail.com>
---
 Makefile      | 56 ++++++++++++++++++++++++++++----------------------------
 config.mak.in |  2 +-
 t/Makefile    |  2 +-
 3 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/Makefile b/Makefile
index 4ad6fbd..736ecd4 100644
--- a/Makefile
+++ b/Makefile
@@ -374,7 +374,7 @@ htmldir = share/doc/git-doc
 ETC_GITCONFIG = $(sysconfdir)/gitconfig
 ETC_GITATTRIBUTES = $(sysconfdir)/gitattributes
 lib = lib
-# DESTDIR=
+# DESTDIR =
 pathsep = :
 
 export prefix bindir sharedir sysconfdir gitwebdir localedir
@@ -575,9 +575,9 @@ endif
 export PERL_PATH
 export PYTHON_PATH
 
-LIB_FILE=libgit.a
-XDIFF_LIB=xdiff/lib.a
-VCSSVN_LIB=vcs-svn/lib.a
+LIB_FILE = libgit.a
+XDIFF_LIB = xdiff/lib.a
+VCSSVN_LIB = vcs-svn/lib.a
 
 LIB_H += xdiff/xinclude.h
 LIB_H += xdiff/xmacros.h
@@ -1139,7 +1139,7 @@ ifeq ($(uname_S),NetBSD)
 endif
 ifeq ($(uname_S),AIX)
 	DEFAULT_PAGER = more
-	NO_STRCASESTR=YesPlease
+	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
 	NO_MKDTEMP = YesPlease
 	NO_MKSTEMPS = YesPlease
@@ -1147,7 +1147,7 @@ ifeq ($(uname_S),AIX)
 	NO_NSEC = YesPlease
 	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 	INTERNAL_QSORT = UnfortunatelyYes
-	NEEDS_LIBICONV=YesPlease
+	NEEDS_LIBICONV = YesPlease
 	BASIC_CFLAGS += -D_LARGE_FILES
 	ifeq ($(shell expr "$(uname_V)" : '[1234]'),1)
 		NO_PTHREADS = YesPlease
@@ -1155,13 +1155,13 @@ ifeq ($(uname_S),AIX)
 		PTHREAD_LIBS = -lpthread
 	endif
 	ifeq ($(shell expr "$(uname_V).$(uname_R)" : '5\.1'),3)
-		INLINE=''
+		INLINE = ''
 	endif
 	GIT_TEST_CMP = cmp
 endif
 ifeq ($(uname_S),GNU)
 	# GNU/Hurd
-	NO_STRLCPY=YesPlease
+	NO_STRLCPY = YesPlease
 	NO_MKSTEMPS = YesPlease
 	HAVE_PATHS_H = YesPlease
 	LIBC_CONTAINS_LIBINTL = YesPlease
@@ -1187,9 +1187,9 @@ ifeq ($(uname_S),IRIX)
 	NEEDS_LIBGEN = YesPlease
 endif
 ifeq ($(uname_S),IRIX64)
-	NO_SETENV=YesPlease
+	NO_SETENV = YesPlease
 	NO_UNSETENV = YesPlease
-	NO_STRCASESTR=YesPlease
+	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
 	NO_MKSTEMPS = YesPlease
 	NO_MKDTEMP = YesPlease
@@ -1203,14 +1203,14 @@ ifeq ($(uname_S),IRIX64)
 	NO_REGEX = YesPlease
 	NO_FNMATCH_CASEFOLD = YesPlease
 	SNPRINTF_RETURNS_BOGUS = YesPlease
-	SHELL_PATH=/usr/gnu/bin/bash
+	SHELL_PATH = /usr/gnu/bin/bash
 	NEEDS_LIBGEN = YesPlease
 endif
 ifeq ($(uname_S),HP-UX)
 	INLINE = __inline
-	NO_IPV6=YesPlease
-	NO_SETENV=YesPlease
-	NO_STRCASESTR=YesPlease
+	NO_IPV6 = YesPlease
+	NO_SETENV = YesPlease
+	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
 	NO_MKSTEMPS = YesPlease
 	NO_STRLCPY = YesPlease
@@ -1386,10 +1386,10 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	MKDIR_WO_TRAILING_SLASH = YesPlease
 	# RFE 10-120912-4693 submitted to HP NonStop development.
 	NO_SETITIMER = UnfortunatelyYes
-	SANE_TOOL_PATH=/usr/coreutils/bin:/usr/local/bin
-	SHELL_PATH=/usr/local/bin/bash
+	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
+	SHELL_PATH = /usr/local/bin/bash
 	# as of H06.25/J06.14, we might better use this
-	#SHELL_PATH=/usr/coreutils/bin/bash
+	#SHELL_PATH = /usr/coreutils/bin/bash
 endif
 ifneq (,$(findstring MINGW,$(uname_S)))
 	pathsep = ;
@@ -1437,7 +1437,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	X = .exe
 	SPARSE_FLAGS = -Wno-one-bit-signed-bitfield
 ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
-	htmldir=doc/git/html/
+	htmldir = doc/git/html/
 	prefix =
 	INSTALL = /bin/install
 	EXTLIBS += /mingw/lib/libz.a
@@ -1559,7 +1559,7 @@ else
 		CURL_LIBCURL = -lcurl
 	endif
 	ifdef NEEDS_SSL_WITH_CURL
-		CURL_LIBCURL +=	-lssl
+		CURL_LIBCURL += -lssl
 		ifdef NEEDS_CRYPTO_WITH_SSL
 			CURL_LIBCURL += -lcrypto
 		endif
@@ -1768,7 +1768,7 @@ ifdef OBJECT_CREATION_USES_RENAMES
 endif
 ifdef NO_STRUCT_ITIMERVAL
 	COMPAT_CFLAGS += -DNO_STRUCT_ITIMERVAL
-	NO_SETITIMER=YesPlease
+	NO_SETITIMER = YesPlease
 endif
 ifdef NO_SETITIMER
 	COMPAT_CFLAGS += -DNO_SETITIMER
@@ -1920,15 +1920,15 @@ ifneq (,$(XDL_FAST_HASH))
 endif
 
 ifeq ($(TCLTK_PATH),)
-NO_TCLTK=NoThanks
+NO_TCLTK = NoThanks
 endif
 
 ifeq ($(PERL_PATH),)
-NO_PERL=NoThanks
+NO_PERL = NoThanks
 endif
 
 ifeq ($(PYTHON_PATH),)
-NO_PYTHON=NoThanks
+NO_PYTHON = NoThanks
 endif
 
 QUIET_SUBDIR0  = +$(MAKE) -C # space to separate -C and subdir
@@ -1975,13 +1975,13 @@ PROFILE_DIR := $(CURDIR)
 ifeq ("$(PROFILE)","GEN")
 	CFLAGS += -fprofile-generate=$(PROFILE_DIR) -DNO_NORETURN=1
 	EXTLIBS += -lgcov
-	export CCACHE_DISABLE=t
-	V=1
+	export CCACHE_DISABLE = t
+	V = 1
 else
 ifneq ("$(PROFILE)","")
 	CFLAGS += -fprofile-use=$(PROFILE_DIR) -fprofile-correction -DNO_NORETURN=1
-	export CCACHE_DISABLE=t
-	V=1
+	export CCACHE_DISABLE = t
+	V = 1
 endif
 endif
 
@@ -2830,7 +2830,7 @@ git.spec: git.spec.in GIT-VERSION-FILE
 	sed -e 's/@@VERSION@@/$(GIT_VERSION)/g' < $< > $@+
 	mv $@+ $@
 
-GIT_TARNAME=git-$(GIT_VERSION)
+GIT_TARNAME = git-$(GIT_VERSION)
 dist: git.spec git-archive$(X) configure
 	./git-archive --format=tar \
 		--prefix=$(GIT_TARNAME)/ HEAD^{tree} > $(GIT_TARNAME).tar
diff --git a/config.mak.in b/config.mak.in
index 69d4838..e8a9bb4 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -18,7 +18,7 @@ datarootdir = @datarootdir@
 template_dir = @datadir@/git-core/templates
 sysconfdir = @sysconfdir@
 
-mandir=@mandir@
+mandir = @mandir@
 
 srcdir = @srcdir@
 VPATH = @srcdir@
diff --git a/t/Makefile b/t/Makefile
index 88e289f..3025418 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -6,7 +6,7 @@
 -include ../config.mak.autogen
 -include ../config.mak
 
-#GIT_TEST_OPTS=--verbose --debug
+#GIT_TEST_OPTS = --verbose --debug
 SHELL_PATH ?= $(SHELL)
 PERL_PATH ?= /usr/bin/perl
 TAR ?= $(TAR)
-- 
1.8.0.1.347.gf94c325
