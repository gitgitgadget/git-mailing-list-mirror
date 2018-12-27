Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC695211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 18:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbeL0Sff (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 13:35:35 -0500
Received: from sonic303-25.consmr.mail.ne1.yahoo.com ([66.163.188.151]:36265
        "EHLO sonic303-25.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726663AbeL0Sff (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 27 Dec 2018 13:35:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1545935733; bh=3Ezmx20KShDsKQsIMFmrLm+YHKKj490oaoAYWt2HAPc=; h=From:To:Cc:Subject:Date:From:Subject; b=I5ixpX5+lhnOoe1Wom5lPgl4dnjk0DME9vNWN9Y163myHvBPrJibe76TGLNwEzosIzEfYEG30Cn8bqHnnp3uHj7a9q0OUryg2NSz8Hs702VAUOTRZelGwh3T1hzkP4RCiu/fd4S6QcPaKx2SzGRWw4awy2utKbIsCt/5mvBK8OOdtUx/NlUqzP6HUypXi3ZsVlcwNQgS/XtDOirx6oCdlqLcx2LBCn3hK/JT/A+TiI6eIfUcdV+cnpiaCkric8KXVCwu6bVisGiijJQpKUvtVq86DGi1DhTX5l5eCmaIDOki9g5nGarwfhadgLwtUn0xlRgnPXzG3AQ1MslnJddhIw==
X-YMail-OSG: FLy2W2gVM1nIcRuyAfBeqkuAlRFwtZ23x_Y1t3j4dWCUzqP6KvD70Fdc40b99kl
 VJqKcLcyP459hmedLteIgpWwpByTDs6j3Ife7xtGlaQAvXL6fhPgzTZJ6EUgUkWRJfSsL_VadDgE
 zA1nT9CUndFBxlhNVQR3.ADYH5FwX8JsLc8cVOPW.SlFRTH617khkcRE4iKHrBibutDnhfyK9_GP
 wvvMmnYc9OO7a3sD9RQQELQULc2vQt0KBBsdINM5h7ptJCdr2C9WgkXTwbZ_zZ9lsMzCDZVWLPMT
 YtbR3s7.KbqFtkQGWkiPBR3TnxIX5KO.oSyhSfVKF_JQAi6mOgAve4IbnSC0eU6Jxz2PozIYDlrA
 bPHJyr5IbmwXcSdJbOiGWnSLoQz3klOKA1nW7uPqrjHwYtheg3gD.2m8yBKgDfNO6IfAQYkzFZcN
 C7z76d4W8Mlko3IeSLdbQ24lW2SfnrVLKLDKHOphvM7lBUBRY.7.b0S_etw5tnJK6A7tGFqkznYG
 BgsP3WZqOYg2djCQdwY15JOiCJmFk6mZGg4u9NBaOMo3I7h0WowscBJgnmiLyrUdzFl0DDUlmfWR
 SVX7b3s5ji5Fu.IlZXlymK5bpXAV3Rpu07.Pt1h2TAyvb7OpcuJ_ejIlo63bpFzBEDCBwed4hS8R
 Irvx0sTnyBSiEHNHDvlkXqjj_6It.p_2yufBEQMUhetcbQucsFCaT1CScAaGEbc3O5SYvHJS6Tc2
 vssdaYTsVjmd11PMPy.3f0XzZgQ1g6vM_CVDlPNtcKNOESs6TN1GgkBfTCit7gF08br.czzVaF5v
 iDClhd76ApvcT3HqGiHSfnl7GWs1cwiheh3B2GQST02eB2DAG1ZJrSHNYQQsaf_pwVPuoENyEfgX
 pHkdxU94zBsDXJmQ_QMtfJh3Uuo2x1qWz_I_0brOnesjWgx99sf3Jn74FcvYHezm4nNk9Js843ZI
 kogfmyQkHy5xgtQhgmlxp.gLGTRtV_W8KS0zeK9ZeqLQOpFuCOm8A1Q_OUpmcXWPuXkHdXCd1YNs
 06gHuAWLdWCUI0z6Yi6mwgc0LY_actRwW8AYeuLWvJrEcHg_TowdqIOfzaY9CeAqqJaJpnWlhChP
 _x.SJoat0zBASzGNWBl.r3Ywg6gA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Thu, 27 Dec 2018 18:35:33 +0000
Received: from 99.229.179.249 (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp432.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 722ff1111ff35cac2cc8267ff735dd3a;
          Thu, 27 Dec 2018 18:35:29 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [PATCH v2 2/4] config.mak.uname: support for modern HPE NonStop config.
Date:   Thu, 27 Dec 2018 13:35:13 -0500
Message-Id: <20181227183513.2860-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
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
+	# with the git test structure. Long paths cause nftw as in
+	# 'trash directory...' break at OS releases J06.21 and L17.02.
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

