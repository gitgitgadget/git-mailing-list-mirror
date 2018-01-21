Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1D531F576
	for <e@80x24.org>; Sun, 21 Jan 2018 23:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751101AbeAUXmb (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jan 2018 18:42:31 -0500
Received: from sonic304-15.consmr.mail.bf2.yahoo.com ([74.6.128.38]:37184 "EHLO
        sonic304-15.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750930AbeAUXmT (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 21 Jan 2018 18:42:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1516578138; bh=eWunbmNjQRtf/1/XVq1N7xqXxHLXq0USAYhJQ9v7odU=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=lao5H2DGK+PAdbESGJkUH+Xid0Hwz9iEkX7gvAABAM/4GMxMp4GrwS6IVErhhLtcqQlO9F8Pc09ymRxSQvZj+4SRQUT9zp2BrnzxnYkkK/DNIQ8gHZ4Zm/6F8yYRQOhQ6lqtimW36AKhJUW4Voj5vP/uoar4EZ3yaNCNWKa8JNqeb9UcKIQ6WRTIolscET3e3Kwa+1NIyoxl0pLYl5Hqx68UYrr5VAZcCDiyaW3OhYRRN0ll0lzvB4wr2uYLLtIwUJnmSfqjaopAYqYIZGr7j69xHeEvq3AxVVVQZD3eFMmzSfZwwHLScafE6IZXhlV4d8KOL8L+bL4sqAbJkYqocw==
X-YMail-OSG: r0VTcL8VM1lKNW2RduE6AkDl0_eH9Ey..AZlCD9cBgJj0d0vcEMtu7m3.QOyqKI
 eMfXf8eW488uYJ9tG6k7.FY8CC0t49DlNDlUSV23XHKiA5IGktc8VY1TBbipXdilaPiEfSgH9qdG
 KYvy0VlEm.m1EZo3trq5MMepZ2RxCj.Oc.NbGjeCskuL7dnjozNpuX3DYJ1SvWDphdhAVQMSxnXd
 yQ9fC7Zk3xj5L3amdL0d8E2YS8YGDHJRbuN9TMeXEHsdJqTx4viSt8wULkf8TQfwZLPtLyIr3iID
 f6fp9mE0dx9yHpuT864bSG_G0Ix0dKKa_jYwYCrDLMyOwO.N0Lbppa5CIs97Gn1hB0QR3rm6qMgl
 n7V_94g99bS3TtB3SqDkJhr4U3r6p4pk4v8ZbwDYvyD.9RzaXnbRa6vh4VvoE0_tManpWNYLg8Xc
 Oejz2Z7MX0EPgJ9HRNpw7jpCgQmF1Bspy7wiWPnFAup8NwbihCUgtt5oSPJi8lEOBHLeEHPIjeRb
 Zi.5PER6qJVoLEgSQZjMWEvQy5Oz2755dKTeEO6BsHpLFqSLqSw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Sun, 21 Jan 2018 23:42:18 +0000
Received: from smtp106.rhel.mail.bf1.yahoo.com (EHLO localhost.localdomain) ([98.139.231.40])
          by smtp404.mail.bf1.yahoo.com (JAMES SMTP Server ) with ESMTPA ID 658003e76b47aa0b456f7039861b9699;
          Sun, 21 Jan 2018 23:42:16 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v4 2/4] Define config options required for the HPE NonStop NSX and NSE platforms
Date:   Sun, 21 Jan 2018 18:42:01 -0500
Message-Id: <20180121234203.13764-3-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20180121234203.13764-1-randall.s.becker@rogers.com>
References: <20180121234203.13764-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

Upgrade old options in config.mak.uname to currently supported
NonStop operating system versions (J06.21 and L17.xx).

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 config.mak.uname | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 685a80d13..d9f8d57e3 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -428,27 +428,37 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	# INLINE='' would just replace one set of warnings with another and
 	# still not compile in c89 mode, due to non-const array initializations.
 	CC = cc -c99
+	# Build down-rev compatible objects that don't use our new getopt_long.
+	ifeq ($(uname_R).$(uname_V),J06.21)
+		CC += -WRVU=J06.20
+	endif
+	ifeq ($(uname_R).$(uname_V),L17.02)
+		CC += -WRVU=L16.05
+	endif
 	# Disable all optimization, seems to result in bad code, with -O or -O2
 	# or even -O1 (default), /usr/local/libexec/git-core/git-pack-objects
 	# abends on "git push". Needs more investigation.
-	CFLAGS = -g -O0
+	CFLAGS = -g -O0 -Winline
 	# We'd want it to be here.
 	prefix = /usr/local
 	# Our's are in ${prefix}/bin (perl might also be in /usr/bin/perl).
-	PERL_PATH = ${prefix}/bin/perl
-	PYTHON_PATH = ${prefix}/bin/python
-
+	PERL_PATH = /usr/bin/perl
+	PYTHON_PATH = /usr/bin/python
+	RM = /bin/rm -f
 	# As detected by './configure'.
 	# Missdetected, hence commented out, see below.
 	#NO_CURL = YesPlease
 	# Added manually, see above.
 	NEEDS_SSL_WITH_CURL = YesPlease
+	NEEDS_CRYPTO_WITH_SSL = YesPlease
+	HAVE_DEV_TTY = YesPlease
 	HAVE_LIBCHARSET_H = YesPlease
 	HAVE_STRINGS_H = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NEEDS_LIBINTL_BEFORE_LIBICONV = YesPlease
 	NO_SYS_SELECT_H = UnfortunatelyYes
 	NO_D_TYPE_IN_DIRENT = YesPlease
+	NO_GETTEXT = YesPlease
 	NO_HSTRERROR = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
@@ -458,8 +468,13 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	NO_MKDTEMP = YesPlease
 	# Currently libiconv-1.9.1.
 	OLD_ICONV = UnfortunatelyYes
-	NO_REGEX = YesPlease
+	NO_REGEX=NeedsStartEnd
 	NO_PTHREADS = UnfortunatelyYes
+	ifdef NO_PTHREADS
+	else # WIP, use Posix User Threads
+		PTHREAD_CFLAGS = -D_PUT_MODEL_ -I/usr/include
+		PTHREAD_LIBS = -lput
+	endif
 
 	# Not detected (nor checked for) by './configure'.
 	# We don't have SA_RESTART on NonStop, unfortunalety.
@@ -477,9 +492,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	# RFE 10-120912-4693 submitted to HP NonStop development.
 	NO_SETITIMER = UnfortunatelyYes
 	SANE_TOOL_PATH = /usr/coreutils/bin:/usr/local/bin
-	SHELL_PATH = /usr/local/bin/bash
-	# as of H06.25/J06.14, we might better use this
-	#SHELL_PATH = /usr/coreutils/bin/bash
+	SHELL_PATH = /usr/coreutils/bin/bash
 endif
 ifneq (,$(findstring MINGW,$(uname_S)))
 	pathsep = ;
-- 
2.16.0.31.gf1a482c

