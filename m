Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 179FE211B9
	for <e@80x24.org>; Wed, 26 Dec 2018 23:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeLZXFx (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Dec 2018 18:05:53 -0500
Received: from sonic312-24.consmr.mail.bf2.yahoo.com ([74.6.128.86]:41991 "EHLO
        sonic312-24.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727108AbeLZXFw (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Dec 2018 18:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1545865551; bh=C7+4e9vvLdtWht+g3X3jPNzAko6EeL4TIzuPDzCGhcM=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=XbmEvu4NgWhUJtUPYZMXigMdzOUBSiSE3WftpsEfDt5waY8XuYiUvX0TipSqlhYH6xKmsoyTk38n6mRfiHrh4EUNR0hjxCH9OPhBebcobWERXAcWtFPRxIOQF7kG2Ska78vmkNoUxcS14Zrh/X+j2cc4ALIdY/w7k594i8gLTHlxXpAu1Gmj3L0AosdQbbUYMYAJ6aACYx8ucsa+8hMLklVuGWf0RC3FWLlkXTr2aLRFNHnDGUGZ5ySf9JszLeWVY4sIRo6AcSfCZ6Afpm94ZgV1qXdZbPpkBfdqolg5dmg1EVNo3p7jlRO5WnkhJcmVujLWpRX7j1q5sNB9vLLgzg==
X-YMail-OSG: dCXl2VsVM1lPUmWbnV2kxBTn7v8sVvzHdaWKcUXO2QduJichDQT_hknJUz25aN_
 _DyhEN6x4QtHEOIiFVAkF7Dd7sDVbIooOOGAccoMrcjKh9IYM4gPGqgRnta7RGgf2pfMHDIRh6Xa
 SDgrgnTwrtg6YTTvTY2u.JeqAzv3FazmOvTbGh6bj_sj5Qh1oauxvrUu2ZweBxQB.Jzg9IQYvjq2
 H9PZ6HugtQiaeITxfl8cpzBS8DGycOaSUPPV3dCq2FmdhxLS0DsFw1rY9FZ1KSTjjCC8G5ijAmbz
 aG2R4gvozeYYb5760DnjMdWQW.KSpQ6Ne8qH7NTaAPOTaxxswPQzAINaHMcIfSYYpjD_A19qLGYJ
 y3xMm2VKff5GA8JdGx1AJKqAztvVB.kv_06O4FaB.1puPaYfGpyCDI5JYENBQqYxwb9DLhKNlgUt
 PWuzge4WzEPgNaWb664o_jROCeeACzntqoivD69A2mWknWeiCj..XuL5WiaZZgRZMPdB49bQ5eSC
 POotVbrac7251_ZWdwsgCvr8dvqHDxv2jmPfo8F0su7e8weaNTTsQ02H2FntTsdKPGp4E7UlbxrA
 7E8LyIbOLhMYeI0HDqGaa4d_FueLMWfCrG1HCAorjEH.BVW5m_CjNww_dfVT6GAKn3x_r09clbjU
 e5GRRXvOS3gvAcS3fcGjE_7qJYyIyCs_1UrbRkTcOrgeRSBm5gClG.WBlyx25SGOpGUaWrrBRekd
 mn_YVd5WxBYgFNpayeJwCLeo2dwE0HoCAom.0c6__pPc2LUxg1TzNMWaTfAbdHzNzcxSHAhyDrLV
 NWt6ccUdumVRzINJ0CVdC8w0OKOA1LcKu2u01pjkiWW1v4_IpQwpyn9.lvBgQ_aSFhJ3WehfQJiW
 OTOf7t5OajuteAclDAI4RCI5ckTNeU4JdjCr3qxzfmwCJSF8rBXnrE_5dj3_wq1X5tFrniNbqTq4
 JtQtjrKherpLYvn71JB8uBwjx0ZUK1kT657nabornxoRAbPnCDxwbNs72ffnkYnNH_I.ZE_atUSz
 FLAw0mxJsN0FpRYKLd3S0kTb_UQpysnvDZNZCSAYdyF.mYrjaCe1tOJTIGwxxrQSW_TCORpFeS_R
 DBmbTj7A6uWx08XGMsvykcCwLVg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Wed, 26 Dec 2018 23:05:51 +0000
Received: from 99.229.179.249 (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp429.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 98f6f8df7851f5cc32b027b3d2c09fa1;
          Wed, 26 Dec 2018 23:05:49 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v1 2/4] config.mak.uname: support for modern HPE NonStop config.
Date:   Wed, 26 Dec 2018 18:05:21 -0500
Message-Id: <20181226230523.16572-3-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20181226230523.16572-1-randall.s.becker@rogers.com>
References: <20181226230523.16572-1-randall.s.becker@rogers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

A number of configuration options are not automatically detected by
configure mechanisms, including the location of Perl and Python.

There was a problem at a specific set of operating system versions
that caused getopt to have compile errors. Accounted for this by
providing emulation defines for those versions.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 config.mak.uname | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index 3ee7da0e23..aa4432ac2f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -441,26 +441,45 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
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
+
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
+	# The current /usr/coreutils/rm at lowest support level does not work
+	# with the git test structure. Default to the older rm.
+	RM = /bin/rm -f
 	# As detected by './configure'.
 	# Missdetected, hence commented out, see below.
 	#NO_CURL = YesPlease
 	# Added manually, see above.
+	# Missdetected, hence commented out, see below.
+	#NO_CURL = YesPlease
+	# Added manually, see above.
+	# Not detected by ./configure. Add manually.
+	NEEDS_SSL_WITH_CURL = YesPlease
+	NEEDS_CRYPTO_WITH_SSL = YesPlease
+	HAVE_DEV_TTY = YesPlease
+
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
@@ -470,8 +489,13 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	NO_MKDTEMP = YesPlease
 	# Currently libiconv-1.9.1.
 	OLD_ICONV = UnfortunatelyYes
-	NO_REGEX = YesPlease
+	NO_REGEX=NeedsStartEnd
 	NO_PTHREADS = UnfortunatelyYes
+	ifdef NO_PTHREADS
+	else # WIP, use of Posix User Threads is planned but not working yet
+		PTHREAD_CFLAGS = -D_PUT_MODEL_ -I/usr/include
+		PTHREAD_LIBS = -lput
+	endif

 	# Not detected (nor checked for) by './configure'.
 	# We don't have SA_RESTART on NonStop, unfortunalety.
-- 
2.17.0.10.gb132f7033

