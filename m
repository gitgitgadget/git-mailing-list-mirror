From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: [PATCH 15/17] Add MSVC to Makefile
Date: Mon, 14 Sep 2009 15:11:28 +0200
Message-ID: <abaa803c30801c570f4b8e1baf6648a482bf295d.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com> <1b36d8e041c9c1a6dc68f9cc3919fcf91b7a9ac6.1252925290.git.mstormo@gmail.com> <7786dfa1b74b5c4974bcf2018d3991c215a9466f.1252925290.git.mstormo@gmail.com> <e2eff51e8d956e7cf854bea9fb9f10491f6d6543.1252925290.git.mstormo@gmail.com> <baa73a58d459d9cd29227b1f0fb02306c14db807.1252925290.git.mstormo@gmail.com> <54b586ed58d1e9b4204658871f6f34453b48758b.1252925290.git.mstormo@gmail.com> <160ceafba5f58cfcadb13380e3d8ef724009b700.1252925290.git.mstormo@gmail.com> <1d699897d4163224ce22db9400569fab20547e9d.1252925290.git.mstormo@gmail.com> <8da5dcea21ce49b3a57fd224c088785a9f98e867.1252925290.git.mstormo@gmail.com> <a48108513bf13247ba9b42fd703ba679804e8d8a.1252925290.git.mstormo@gmail.com> <aed24a7f9524c9872f8a2455cfc5dd8baf6c3c0b.1252925290.git.mstorm
 o@gmail.com> <4931b7ac3102ee259353fe6b3c5ceeb2a67c53ba.1252925290.git.mstormo@gmail.com> <1b5c5e90392e813ffab4fd510b70e57903a451cc.1252925290.git.mstormo@gmail.com> <9c5670f92cd0b3b8b74dd2204698e9c45ad03c90.1252925290.git.mstormo@gmail.com> <c95a367520435feec0833d2d0edc33d86cf939a8.1252925290.git.mstormo@gmail.com>
Cc: msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com, Marius Storm-Olsen <mstormo@gmail.com>
To: Johannes.Schindelin@gmx.de
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Mon Sep 14 15:13:27 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f158.google.com ([209.85.221.158])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnBN1-0004O6-0b
	for gcvm-msysgit@m.gmane.org; Mon, 14 Sep 2009 15:13:27 +0200
Received: by mail-qy0-f158.google.com with SMTP id 30so3477056qyk.15
        for <gcvm-msysgit@m.gmane.org>; Mon, 14 Sep 2009 06:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references
         :sender:precedence:x-google-loop:mailing-list:list-id:list-post
         :list-help:list-unsubscribe:x-beenthere-env:x-beenthere;
        bh=8uhXdVF09L81k9iAf0ir4AE6GJff8xxN1wx3g9wFbFA=;
        b=NbvynGY8CfEr6/lZe/Gwjqn1qbjFYOz+11B/skD1lxjWeX0bz0MTqqpedN4uurT3xF
         1MLpVp6Lo9qBV9EbwPZ2S12H/LJv4R5kmiP8X+Ni8ENpRFWkVIivIMz+fVJAGvToBrMR
         3kEegGe20cQ3AiLdpGJgqGOzqtqB+3bmiDINk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:sender:precedence
         :x-google-loop:mailing-list:list-id:list-post:list-help
         :list-unsubscribe:x-beenthere-env:x-beenthere;
        b=QuyqNnnOGJsHyeJmz02crPJPOSeTXA5FBX4ofN/64zM8lbqzl/sjYg2Akk1dvmgN1H
         dHFHlv+xFV03iO2clnAAoAbyxUqS3+EK6+B7hsihG3vH8cqD9KmRZJQL3JdkVkyM6zc9
         1lUS+TdeXa0QsGNe15HV7CLBVghM7+30BpryQ=
Received: by 10.224.95.75 with SMTP id c11mr541687qan.7.1252934000750;
        Mon, 14 Sep 2009 06:13:20 -0700 (PDT)
Received: by 10.177.125.36 with SMTP id c36gr6972yqn.0;
	Mon, 14 Sep 2009 06:13:10 -0700 (PDT)
X-Sender: mstormo@gmail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.211.144.19 with SMTP id w19mr565887ebn.2.1252933989989; Mon, 14 Sep 2009 06:13:09 -0700 (PDT)
Received: by 10.211.144.19 with SMTP id w19mr565886ebn.2.1252933989938; Mon, 14 Sep 2009 06:13:09 -0700 (PDT)
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com [209.85.219.223]) by gmr-mx.google.com with ESMTP id 16si1288173ewy.3.2009.09.14.06.13.08; Mon, 14 Sep 2009 06:13:08 -0700 (PDT)
Received-SPF: pass (google.com: domain of mstormo@gmail.com designates 209.85.219.223 as permitted sender) client-ip=209.85.219.223;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of mstormo@gmail.com designates 209.85.219.223 as permitted sender) smtp.mail=mstormo@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Received: by mail-ew0-f223.google.com with SMTP id 23so2670990ewy.2 for <msysgit@googlegroups.com>; Mon, 14 Sep 2009 06:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma; h=domainkey-signature:received:received:from:to:cc:subject:date :message-id:x-mailer:in-reply-to:references:in-reply-to:references; bh=tXlcS7rt0kM459bkJf+drQFt8M9pr+n+VHRcidev58M=; b=sbZd+krU4LTBVzT2Fu0IESv/nVYZHZzsY4HXTUoDU9F06kzFE9Kl3fNvQUPGg9W2Se qy0K2D25GC27/0hh/ip01NLTAgYaeb3w+5M5/eMkdzjpyOEIoG6KYT1frzzJ9r0SN3mJ y9P1FkWP/VQjHIOx2SN2y9GtL7a68ApKrUy3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma; h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references; b=FiiCB5C1q7UnirvLS5pA60/TWkHBGSvjwHr9aGVmQaLb1ZSw5MnKIuALDy7990xbVJ Z9CWeUgtuy0qWRYu3ZkzNAEILIlMsNfjeVf1KyDMxVToVJdNWUnHZaytk2JN8FZcP6hE obYDNNfc+iiRALiCw8xQCnpmoVuCBsRBx7KzU=
Received: by 10.211.184.8 with SMTP id l8mr6886629ebp.16.1252933988762; Mon, 14 Sep 2009 06:13:08 -0700 (PDT)
Received: from localhost.localdomain ([62.70.27.104]) by mx.google.com with ESMTPS id 10sm2690277eyz.2.2009.09.14.06.13.07 (version=SSLv3 cipher=RC4-MD5); Mon, 14 Sep 2009 06:13:08 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.1.418.g33d56.dirty
In-Reply-To: <c95a367520435feec0833d2d0edc33d86cf939a8.1252925290.git.mstormo@gmail.com>
In-Reply-To: <cover.1252925290.git.mstormo@gmail.com>
References: <cover.1252925290.git.mstormo@gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128471>


Enable MSVC builds with GNU Make by simply calling
    make MSVC=1
(Debug build possible by adding DEBUG=1 as well)

Two scripts, clink.pl and lib.pl, are used to convert certain GCC
specific command line options into something MSVC understands.
By building for MSVC with GNU Make, we can ensure that the MSVC
port always follows the latest code, and does not lag behind due
to unmaintained NMake Makefile or IDE projects.

Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
---
 Makefile                        |   54 ++++++++++++++++++++++++++++++++++++++-
 compat/vcbuild/scripts/clink.pl |   48 ++++++++++++++++++++++++++++++++++
 compat/vcbuild/scripts/lib.pl   |   26 ++++++++++++++++++
 3 files changed, 127 insertions(+), 1 deletions(-)
 create mode 100644 compat/vcbuild/scripts/clink.pl
 create mode 100644 compat/vcbuild/scripts/lib.pl

diff --git a/Makefile b/Makefile
index bde2acd..3bdd749 100644
--- a/Makefile
+++ b/Makefile
@@ -877,6 +877,57 @@ ifneq (,$(findstring CYGWIN,$(uname_S)))
 	COMPAT_OBJS += compat/cygwin.o
 	UNRELIABLE_FSTAT = UnfortunatelyYes
 endif
+ifdef MSVC
+	pathsep = ;
+	NO_PREAD = YesPlease
+	NO_OPENSSL = YesPlease
+	NO_LIBGEN_H = YesPlease
+	NO_SYMLINK_HEAD = YesPlease
+	NO_IPV6 = YesPlease
+	NO_SETENV = YesPlease
+	NO_UNSETENV = YesPlease
+	NO_STRCASESTR = YesPlease
+	NO_STRLCPY = YesPlease
+	NO_MEMMEM = YesPlease
+	# NEEDS_LIBICONV = YesPlease
+	NO_ICONV = YesPlease
+	NO_C99_FORMAT = YesPlease
+	NO_STRTOUMAX = YesPlease
+	NO_STRTOULL = YesPlease
+	NO_MKDTEMP = YesPlease
+	NO_MKSTEMPS = YesPlease
+	SNPRINTF_RETURNS_BOGUS = YesPlease
+	NO_SVN_TESTS = YesPlease
+	NO_PERL_MAKEMAKER = YesPlease
+	RUNTIME_PREFIX = YesPlease
+	NO_POSIX_ONLY_PROGRAMS = YesPlease
+	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
+	NO_NSEC = YesPlease
+	USE_WIN32_MMAP = YesPlease
+	# USE_NED_ALLOCATOR = YesPlease
+	UNRELIABLE_FSTAT = UnfortunatelyYes
+	OBJECT_CREATION_USES_RENAMES = UnfortunatelyNeedsTo
+	NO_REGEX = YesPlease
+	NO_CURL = YesPlease
+	NO_PTHREADS = YesPlease
+
+	CC = compat/vcbuild/scripts/clink.pl
+	AR = compat/vcbuild/scripts/lib.pl
+	CFLAGS =
+	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32-D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
+	COMPAT_OBJS = compat/msvc.o compat/fnmatch/fnmatch.o compat/winansi.o
+	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/fnmatch -Icompat/regex -Icompat/fnmatch -DSTRIP_EXTENSION=\".exe\"
+	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
+	EXTLIBS = advapi32.lib shell32.lib wininet.lib ws2_32.lib
+	lib =
+ifndef DEBUG
+	BASIC_CFLAGS += -GL -Os -MT
+	BASIC_LDFLAGS += -LTCG
+else
+	BASIC_CFLAGS += -Zi -MTd
+endif
+	X = .exe
+else
 ifneq (,$(findstring MINGW,$(uname_S)))
 	pathsep = ;
 	NO_PREAD = YesPlease
@@ -925,6 +976,7 @@ else
 	NO_PTHREADS = YesPlease
 endif
 endif
+endif
 
 -include config.mak.autogen
 -include config.mak
@@ -1327,7 +1379,7 @@ strip: $(PROGRAMS) git$X
 git.o: git.c common-cmds.h GIT-CFLAGS
 	$(QUIET_CC)$(CC) -DGIT_VERSION='"$(GIT_VERSION)"' \
 		'-DGIT_HTML_PATH="$(htmldir_SQ)"' \
-		$(ALL_CFLAGS) -c $(filter %.c,$^)
+		$(ALL_CFLAGS) -o git.o -c $(filter %.c,$^)
 
 git$X: git.o $(BUILTIN_OBJS) $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ git.o \
diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
new file mode 100644
index 0000000..0ffd59f
--- /dev/null
+++ b/compat/vcbuild/scripts/clink.pl
@@ -0,0 +1,48 @@
+#!/usr/bin/perl -w
+######################################################################
+# Compiles or links files
+#
+# This is a wrapper to facilitate the compilation of Git with MSVC
+# using GNU Make as the build system. So, instead of manipulating the
+# Makefile into something nasty, just to support non-space arguments
+# etc, we use this wrapper to fix the command line options
+#
+# Copyright (C) 2009 Marius Storm-Olsen <mstormo@gmail.com>
+######################################################################
+use strict;
+my @args = ();
+my @cflags = ();
+my $is_linking = 0;
+while (@ARGV) {
+	my $arg = shift @ARGV;
+	if ("$arg" =~ /^-[DIMGO]/) {
+		push(@cflags, $arg);
+	} elsif ("$arg" eq "-o") {
+		my $file_out = shift @ARGV;
+		if ("$file_out" =~ /exe$/) {
+			$is_linking = 1;
+			push(@args, "-OUT:$file_out");
+		} else {
+			push(@args, "-Fo$file_out");
+		}
+	} elsif ("$arg" eq "-lz") {
+		push(@args, "zlib.lib");
+	} elsif ("$arg" eq "-liconv") {
+		push(@args, "iconv.lib");
+	} elsif ("$arg" =~ /^-L/ && "$arg" ne "-LTCG") {
+		$arg =~ s/^-L/-LIBPATH:/;
+		push(@args, $arg);
+	} elsif ("$arg" =~ /^-R/) {
+		# eat
+	} else {
+		push(@args, $arg);
+	}
+}
+if ($is_linking) {
+	unshift(@args, "link.exe");
+} else {
+	unshift(@args, "cl.exe");
+	push(@args, @cflags);
+}
+#printf("**** @args\n");
+exit system(@args);
diff --git a/compat/vcbuild/scripts/lib.pl b/compat/vcbuild/scripts/lib.pl
new file mode 100644
index 0000000..68f6644
--- /dev/null
+++ b/compat/vcbuild/scripts/lib.pl
@@ -0,0 +1,26 @@
+#!/usr/bin/perl -w
+######################################################################
+# Libifies files on Windows
+#
+# This is a wrapper to facilitate the compilation of Git with MSVC
+# using GNU Make as the build system. So, instead of manipulating the
+# Makefile into something nasty, just to support non-space arguments
+# etc, we use this wrapper to fix the command line options
+#
+# Copyright (C) 2009 Marius Storm-Olsen <mstormo@gmail.com>
+######################################################################
+use strict;
+my @args = ();
+while (@ARGV) {
+	my $arg = shift @ARGV;
+	if ("$arg" eq "rcs") {
+		# Consume the rcs option
+	} elsif ("$arg" =~ /\.a$/) {
+		push(@args, "-OUT:$arg");
+	} else {
+		push(@args, $arg);
+	}
+}
+unshift(@args, "lib.exe");
+# printf("**** @args\n");
+exit system(@args);
-- 
1.6.2.1.418.g33d56.dirty
