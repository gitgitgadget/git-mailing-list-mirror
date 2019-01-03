Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 860671F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 21:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfACVEK (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 16:04:10 -0500
Received: from sonic309-24.consmr.mail.ne1.yahoo.com ([66.163.184.150]:42095
        "EHLO sonic309-24.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726878AbfACVEK (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 3 Jan 2019 16:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1546549449; bh=vtvpRUHdxklFoBH8lrp2AXy2UE28TBL2Plb9+zCSLiA=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=MXB7XDKDXr+qnrrszn/GrSh9jSUPoRzuCx/W3FI9MPc9ubJiVnYPlQGxP4xcCV9/J99LAcToQWW0w2E2c3CiENVOdzhtBSPFrKAxVl02vMHVLtMdlJuCNmOA9pHL/jB3O4bPnbblnwb5GBMY8TrWstufwsift4ZGu69tD1YlCROoOY7pg3jJ8zB+gAILzf6v4GLSQKkdJnj9TL3KI+mLZ9CWpeiw9qN/jzGdJc93nzHG+//DNdb2M4fgiNmZQhset3GwjHlXB4G/qFQjzJFaGawZJD8A37fZMOo4/KqVxh4h1Zc16d+EXsBArRk+zKH5Hb98QCh8AT1Pz9n7V2CO+w==
X-YMail-OSG: ar.NF54VM1mBKJxCGxcK3.wzP1K3OYj3Sp9QJKaovLlXYYpgzKGq42mvFGqrMq9
 CZn.VD9YRA3FoFApuOepwOPjgWh.SJX9YX3vJvv4aQ5WBCBQ6w75nsxiLM8PkBoOynNVQLoFdQt0
 fkfjfdm3Wn4j9lEHq6K9kMsxE_zP.wyDiwaR8NX.d530hSGu4fMwj6wbcbcn0zcS6pEwJ8Pim9.s
 ZlFm67hAoLoVu1232pSMBFRPusqc4mPy2O_AJWRNyAkTPQ97IcV0ELm17jGPZ3_EKXlJJvraHkVv
 3lBNtHdPrDYu6W48dhHiFARWWJgF2DbW7GC2E_CCiB7eBFpaBCUx72rvPzCVN9yLH0_JIdlIusNI
 9WTAT_8uV2HZzeNbHWVREX6v82YGCMgHyGQXJ9BV67TODy4.GyxClGUGVZgO7Kg1Zb8Kf8hkwEbK
 MpktncZ8KyS8bCGGM71ABvfCvu22O3LRp9hBDs7LGUHeCIvJqRATNu8P2bWu2CzeI4nowuLN2GJN
 1YlfA25SUjURi9LyyMELtD6ppn.JKh4eHqGSVsZwC1IxjkszDqwWw1eN9GETGbYhybT8LgowU2e_
 xj2JmvmdoKOFSinwOKSEkKctUEoXFRLRiJZMdnTsiGaVuNTR2flxLqHl3TQ2xZ1TY_C2ti23boIz
 gSOoY6Mt5PU1tb9CV3lWSLom5tSMO_Z7wBdtEretS.hwhBOkkHS5XBCx3V7gAwXroc2em_EB9EBv
 kkQPzslgF2sZdh4wB7dtWU17VxrWOW7yqmzfhRCEJoizZGq4AZ6CL0In22mg66JZYs12PExPwFW2
 QEmrofh.wCHVQr2lJKqU1rZpYaFmkwP7ZF_OvcMu3m4rIvo70aFs.m4YhaOaTQVgFO5sWCk.mDiA
 6cs1ZaSJuD4ppOBtAXrMVD8lYWPP1a_gsjKXGV4EOsYZre_kuDgOi_I0FAieMhnY8Oj6CAAT4QP5
 Ojm3zp29oJmeu6u8ExMzwHoysyIlTR2TT831wVdNClIAxxbTm7v6e7fZkvD_M9j2IHbTpxQRbYyg
 7rZLn5ZqQHdvcbQNAOrrN7rKl2KJ6WrYuNaNIQUIANb6WLc1XVkZ4U1KbakM.U4vnBltJV18fzi.
 bW9Jsr5ZZ0XgVZuds6U425_Fi2e5.2Axd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 3 Jan 2019 21:04:09 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp403.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID be612531d29230a92e273a46c8c0f700;
          Thu, 03 Jan 2019 21:04:06 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <randall.becker@nexbridge.ca>,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: [Patch v5 2/4] config.mak.uname: support for modern HPE NonStop config.
Date:   Thu,  3 Jan 2019 16:03:49 -0500
Message-Id: <20190103210351.13920-3-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190103210351.13920-1-randall.s.becker@rogers.com>
References: <20190103210351.13920-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <randall.becker@nexbridge.ca>

A number of configuration options are not automatically detected by
configure mechanisms, including the location of Perl and Python.

There was a problem at a specific set of operating system versions
that caused getopt to have compile errors. Account for this by
providing emulation defines for those versions.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 config.mak.uname | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 3ee7da0e2..686156d53 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -441,26 +441,43 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
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
-	# Our's are in ${prefix}/bin (perl might also be in /usr/bin/perl).
-	PERL_PATH = ${prefix}/bin/perl
-	PYTHON_PATH = ${prefix}/bin/python
-
+	# perl and python must be in /usr/bin on NonStop - supplied by HPE
+	# with operating system in that managed directory.
+	PERL_PATH = /usr/bin/perl
+	PYTHON_PATH = /usr/bin/python
+	# The current /usr/coreutils/rm at lowest support level does not work
+	# with the git test structure. Long paths as in
+	# 'trash directory...' cause rm to terminate prematurely without fully
+	# removing the directory at OS releases J06.21 and L17.02.
+	# Default to the older rm until those two releases are deprecated.
+	RM = /bin/rm -f
 	# As detected by './configure'.
 	# Missdetected, hence commented out, see below.
 	#NO_CURL = YesPlease
 	# Added manually, see above.
+	NEEDS_SSL_WITH_CURL = YesPlease
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
@@ -470,7 +487,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	NO_MKDTEMP = YesPlease
 	# Currently libiconv-1.9.1.
 	OLD_ICONV = UnfortunatelyYes
-	NO_REGEX = YesPlease
+	NO_REGEX=NeedsStartEnd
 	NO_PTHREADS = UnfortunatelyYes
 
 	# Not detected (nor checked for) by './configure'.
-- 
2.12.3

