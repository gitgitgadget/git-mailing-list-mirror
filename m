Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 439531F770
	for <e@80x24.org>; Fri, 28 Dec 2018 20:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732109AbeL1UDH (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 15:03:07 -0500
Received: from sonic317-23.consmr.mail.gq1.yahoo.com ([98.137.66.149]:34903
        "EHLO sonic317-23.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726466AbeL1UDH (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 28 Dec 2018 15:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1546027385; bh=Kaw1dEcfr58KFpj91F7qbwpHYrHHngsVw/kCn7fRxR4=; h=From:To:Cc:Subject:Date:From:Subject; b=AgdBPlp+IEjOIR5QP+/HTdSVaidePZkAdhRdrVGaqzt0DDPoAsIQSgOJsxdYVjC2+RRzSdshKhHq5vjHNQnJByZn0R6IGQhQ7C6NfGzPT8rhMEDU7gA0HyLFG+BXiwy9VNbZR4OvOBGJWr2WwjIEKwWRA/fJDJzDdI0fpq7juz+eir/ZvY7j6X25sWCdinoSt+dEAS0fE2uF4cgi+XNjZfUEzDU/lijtOugx93xNM7xudKZ6QOQuSsNvGpKkCPcUyFjLSK88AUnnYN5QjiO/M1aeBIaEOVU4J5IbwzmSzMfZidJPprCtH2mXzLIATslgjTHSBVrO/5c8quR3AgNswQ==
X-YMail-OSG: t9cerc4VM1nnvDWG_T8uWjEWxFD5nmZiZi96PWsRhiJWF2lLEtDMs.l8qxjZKzF
 v9.GNNLMgayx5DcjvV2HZe5VaiTNNF7UICUj9FidLsmi7BgBQ8VU2FrI7.yXhk_FKXTHPE7d8sd4
 NBUURtESU4fZ1w7D39ipz9nt9kXPI7ZK7ucSZfnRXvh0Zt1IX9y4Qu9xVOns6LKqih0YOCRmPdww
 .ZPC_ww.TmPXi04wLs3t63fvVpv0yL8hRB_06i0a_E_M93nnMdgUt5uAsBCzig_67lau8xAIpqA4
 5FseSlTeKLEhuWJqihmqIlk3xid_LIY9KpTM1FqqDVWXC2oRY2LAtbb0B2tFm3rU9k310vGgT.d1
 u3eNvW2rleCszQb5JR9I.FG.lcmyAyF9ko1ww.GI9im4QqGa0.EWmYKlNY7rDaUgCcFAAaTEanrP
 h1pjkE1M5cK0qu7GZDnTJFCpQ29enGY5nI37WNoIUO.f43iBpBhFK7RLZI6f92XvdOOCHUuX0mGX
 OL32CNIn7s4vxRneJHeyN8REKB6UlrCJLE8cxQWc_M5q23oj1n9ffwyPufMcultHsekXuZjIfvL.
 ir.T2KpRu1UQ9g.mex6kymMGEX8dEcn2tvNj8QvgR3EN09wBft7fqUkm.7TOBdqwefqxkuVUl11o
 1KXJdm351KnciTnx5k.nI9gnVEAnOrBedXs3Q2dgAP5rNiYtabG4Qez0fpbKJrtuHUit5v7LPJN3
 j_d64ioU_aEPSSuF5D3cl3bm.1DAYUrd6PdQuXJfOoMNHFfVQ6_iDWwrz5FbGA.FxT5.EwWZZUgI
 pttTOSa6AijYhJJQybO8VKpOPW.9DWfP5bkZiL3_FAYudvDA9AqvEeSD9cR54vGw4yt7FzmTEe9Y
 Xp174nPWqjdFmVcSL67GPRtjTaGXEsNHGDKPJOxs4CfqO_0.jFIcgQQEU6R7OJVJg68wKI4izR5C
 D_btDVi03TAbFoaRQ11nLJHiOnJl5I1xVSryZA07Rq5TwIA4iTkuCEj2mEfLk6AEwzb5jAfDytNr
 D7i4FuXX4rh1Vbg6rUK2U3MGG1ahFA4I7TNLDBXl3jHhwi7fVXE8lMZtYk9Pr4FJeAW3cAeLFMmB
 Z2sUFXM9Mk_pcjzbPVLrGIQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Fri, 28 Dec 2018 20:03:05 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp420.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a4ce82d15cf7a4987bdd044b96c25073;
          Fri, 28 Dec 2018 20:03:00 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v4 2/4] config.mak.uname: support for modern HPE NonStop config.
Date:   Fri, 28 Dec 2018 15:02:43 -0500
Message-Id: <20181228200243.19728-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

A number of configuration options are not automatically detected by
configure mechanisms, including the location of Perl and Python.

There was a problem at a specific set of operating system versions
that caused getopt to have compile errors. Account for this by
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
- 	# Our's are in ${prefix}/bin (perl might also be in /usr/bin/perl).
+	# perl and python must be in /usr/bin on NonStop - supplied by HPE
+	# with operating system in that managed directory.
-	PERL_PATH = ${prefix}/bin/perl
-	PYTHON_PATH = ${prefix}/bin/python
-
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
@@ -470,8 +489,13 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
 	NO_MKDTEMP = YesPlease
 	# Currently libiconv-1.9.1.
 	OLD_ICONV = UnfortunatelyYes
-	NO_REGEX = YesPlease
+	NO_REGEX=NeedsStartEnd
 	NO_PTHREADS = UnfortunatelyYes

 	# Not detected (nor checked for) by './configure'.
 	# We don't have SA_RESTART on NonStop, unfortunalety.
-- 
2.17.0.10.gb132f7033

