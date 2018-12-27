Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DB9C211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 22:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbeL0WjL (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 17:39:11 -0500
Received: from sonic317-31.consmr.mail.bf2.yahoo.com ([74.6.129.86]:33051 "EHLO
        sonic317-31.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730228AbeL0WjK (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Dec 2018 17:39:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1545950348; bh=WGyqlEr2m9uxlKLA7x702aAhBbwlmScoXOiUxY6sXtE=; h=From:To:Cc:Subject:Date:From:Subject; b=TiWIf3vS6nGVYuSZWUVBtqp6U+4r5hShDTu9HRItMGhE9m3RYYeOYkv8QSRaYgP0tP+lkoYg0tysrZJdBwhH1V0/5cKBB4zyN8X0i8tPTdyUsAMs6CnoSWvgeEdUgAHZQBoGqYOb1bsyy879xUXIolW4/4yMEZONwgtopz12cbdEpJxj2hulIbdwDBm8f9AopXyV8L/IWWqqH+FhnVe6vcrek+Y3c45J5uIssz8UR1NGaHZa1UHTkp8Z7Kluyfm+m58tsokKcOtsZZEh5r7gMY8M48sc45DHJRNLzI+h/+oVkyRP1xkBAP4jF7zeRi4mhdxjj9O93lOIbEg9g1XqVA==
X-YMail-OSG: feujMHkVM1kUQsVpIYvKbXtsE40hRqO3ElOkgkuizAjgr.YX79fw48.SvAQIXOh
 RU1rQM9v97o68hBqwk2ujc.NbJ_Q2XdCS6FfbuuB4bqT06f1z2qnrxU3eaztlcviGVhV_0HXiF_D
 sYtDELn4ox85ayCkjxh72lenog3Md6IP1P2P9XUmzwuRiA8lGDhduEZLnphfJCxTAPPrOepk6teE
 jP2QVxDES0oPK1_ttln.iI.9I7rFCdttkNzLEMiFCjVU01OrPhRFG9uJE_4hMzMelaoSfXVRF37w
 uu.ZldSwtPkJ03gl_KpLgh4KisLNfccz8zCdKx5NRSHjRy5qSMwZmIjZhp4K_tv55S2jTabv3LZT
 KPIvPxYIbmQExqdDw34iBqXxaEsNuH3qEzNpMGF9xQc.RtX4Vpv5OaB5NRr0bPd7NoLvbZ0qYLtn
 hRtdGnKTGVIXyWg13k5iaKiAdeUWQdkHmYCMp.DRQ3rqKYukAK6q3cVysvE1FWFAWuIPoP.Bp1nv
 s5Y3DYn6.NEh483QOnmPdJ1Pem3wOFHN2lFeimB7bJOom_0p5bqKEM2KtVFCibTmHjBVZ7EAi3EM
 gIdaTlQjDHrII45aRj0tHuEmlvhmjVA1whSetLnufw.5_VJHDmTtPgxdh.N469qK8zscNO6MeAxe
 oG8sYybD19tTFkdRK5VrVEFRUhOD..6l3uzF5hYcMZzF4sGrnBQDdszXZ4OoW9Gjx8x.jJq.w7e7
 aRTHQdHm4VedmKNAps_CYJvdrQ5484sqWRNvc9n4I11YJkeSggaxnIxDDFUqQFG3tH046.B3gJ4t
 fFWh3KqcaTdR5G9aVe8ANsTRGWX6qnnXsWf0MjzjNRoAK_aMS54uxBoTEO5ATwdJn.olBeNOuLWg
 FgL9pGvC5ZQAvDVU1tX26ZO0zBhnfV2rlczaWrCg7W49SlGElB50A9YGvE.crwt2q3gyJ3u7x5i2
 8F_jiWI4CoD9aEfC_TjSftTVUnZNCPu4EJNw.piTRvy0QkISLnfq_lzxLHuRl1vQ4BqPFXmtYV62
 5Y1ajHavdH6nvNcBwgGdTSkFv8aRgVSWxAEe8MsC5DoDeXn7kEAFOlus6q8H_JSG8JbpjwTTQcst
 CPNKGBv7PUMvu9eJnFtR_9LKW
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Thu, 27 Dec 2018 22:39:08 +0000
Received: from 99.229.179.249 (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp427.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 93d7c91e653e0f247c927b1d3eaf1dc0;
          Thu, 27 Dec 2018 22:39:07 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v3 2/4] config.mak.uname: support for modern HPE NonStop config.
Date:   Thu, 27 Dec 2018 17:38:56 -0500
Message-Id: <20181227223856.18768-1-randall.s.becker@rogers.com>
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
+	# with the git test structure. Long paths cause nftw as in
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

