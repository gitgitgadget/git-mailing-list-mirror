Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03B571FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 23:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755539AbdCXXZ3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 19:25:29 -0400
Received: from mout.gmx.net ([212.227.15.15]:51301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755487AbdCXXZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 19:25:27 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LbdE3-1cTS2n3Hxr-00lBlA; Sat, 25
 Mar 2017 00:25:18 +0100
Date:   Sat, 25 Mar 2017 00:25:04 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/7] t0013: test DC_AND_OPENSSL_SHA1, too
In-Reply-To: <cover.1490397869.git.johannes.schindelin@gmx.de>
Message-ID: <2187bcec8b1e2c61b801a04e05f58d87f683cbcf.1490397869.git.johannes.schindelin@gmx.de>
References: <cover.1490397869.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ggzw+Qg7SgfYiF2W+rrw4eWEE7YCmT9RQFJrglRc0N2OlG9Utgr
 T8Co7JaaI/Dws0BTSK0+Alda/HYBfAsIBjbTPIqPz16RtQhfp4EKI3xNo6hlrV4vuAxsxEz
 mXTHTQmp1yiRUbvY/00Z3FVYBazR4LgVXmIKom3Rs/ZrMth5397REqGYOIqD++vN5RYbuy4
 pyp0PNU8t35pBtOJaZh5w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d7Srbzfrdnc=:sAinPt/4RpaL3DjUvzB51d
 mqW/QXKS3dI6gMKB+JgMB7kIMIcHx1PB9ctVdJxKBvfOldtQy3wEDykEA5DKfAmqko8AF1KMf
 r2ufgp2XAzqkAnj9a+oldPcEraQRGjznZzhEGHmVpFvv5ZrsL6CA/Vo/XeUfEK6Z9vaMm6n+r
 IcHyAVy3IMZZQFwkLAZRXj46JH6PDkLuNODGCYCR+93yR90id6xNVuY4HVpTdewqgx/p/7yXN
 KSyT2jVlYqijBzNseUbUOvjYJfeb0INQhz+9omAGa1p0glGpohbnUebKbGaZPKu3w2Air9IO7
 wOf9VX/sqvnSUEAfwoXHLK4lNQUB4srrEnbn/G/TIhedz47NEXm2xteFI08IctQvLEUjFDvvt
 0rTmBtPGfpOXNqpSx3nWe0JAHgBfFak8S3LIcGdA7MrNDZo4LJ2GKdjYukG54k9A0dhhgcGZ0
 Di+VolAoeUYHcx3ehgrra9KvCpulA8u28cc+DtaayXHGynRV0C/tbAWskWpcmIALRHmsh3T3Q
 0hfMZKyMKbMtlPAXQbLgSs7wbhwoqdLVKpflJDMTsYAu8HIvdJG+rEhHOg5TUUKoo9qfGcEMw
 mV5flfylhMn13axBvd81oBWijUBFfIY0IGqjl0ndjeYG4slGI2qnGQkmYRHaPdWPzlbbg64T8
 U3FoWbsYE5QAl/3sWU0ZcTnWfrJhlkN+F5KXZJnTc+TIFQoew7tOKI6LzlRIqiJbW+xF97btB
 cX2BiwPMALWMzvxq6jrXPnnU0M9MNB8lVBMYpPTwm5GLnqSkOiiP14npHqj6pSOyIWxgVY5tu
 2dMILeJYz54iMxW9zy5QZFGAV5fVA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile             |  1 +
 t/helper/test-sha1.c | 10 ++++++++++
 t/t0013-sha1dc.sh    | 10 ++++++++++
 3 files changed, 21 insertions(+)

diff --git a/Makefile b/Makefile
index 3e181d2f0e2..0b581357625 100644
--- a/Makefile
+++ b/Makefile
@@ -2251,6 +2251,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
 	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
 	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+
+	@echo DC_AND_OPENSSL_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_AND_OPENSSL_SHA1)))'\' >>$@+
 ifdef TEST_OUTPUT_DIRECTORY
 	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
 endif
diff --git a/t/helper/test-sha1.c b/t/helper/test-sha1.c
index a1c13f54eca..27ce8869e51 100644
--- a/t/helper/test-sha1.c
+++ b/t/helper/test-sha1.c
@@ -8,6 +8,16 @@ int cmd_main(int ac, const char **av)
 	int binary = 0;
 	char *buffer;
 
+	if (ac > 1 && !strcmp(av[1], "--disable-sha1dc")) {
+#ifdef SHA1_DC_AND_OPENSSL
+		toggle_sha1dc(0);
+#else
+		die("Not compiled with DC_AND_OPENSSL_SHA1");
+#endif
+		ac--;
+		av++;
+	}
+
 	if (ac == 2) {
 		if (!strcmp(av[1], "-b"))
 			binary = 1;
diff --git a/t/t0013-sha1dc.sh b/t/t0013-sha1dc.sh
index 435a96d6108..2b529b31b4e 100755
--- a/t/t0013-sha1dc.sh
+++ b/t/t0013-sha1dc.sh
@@ -5,6 +5,10 @@ test_description='test sha1 collision detection'
 TEST_DATA="$TEST_DIRECTORY/t0013"
 
 test -z "$DC_SHA1" || test_set_prereq DC_SHA1
+test -z "$DC_AND_OPENSSL_SHA1" || {
+	test_set_prereq DC_AND_OPENSSL_SHA1
+	test_set_prereq DC_SHA1
+}
 
 test_expect_success DC_SHA1 'test-sha1 detects shattered pdf' '
 	test_must_fail test-sha1 <"$TEST_DATA/shattered-1.pdf" 2>err &&
@@ -12,4 +16,10 @@ test_expect_success DC_SHA1 'test-sha1 detects shattered pdf' '
 	grep 38762cf7f55934b34d179ae6a4c80cadccbb7f0a err
 '
 
+test_expect_success DC_AND_OPENSSL_SHA1 'sha1dc can be turned off' '
+	test-sha1 --disable-sha1dc <"$TEST_DATA/shattered-1.pdf" 2>err &&
+	! test_i18ngrep collision err &&
+	! grep 38762cf7f55934b34d179ae6a4c80cadccbb7f0a err
+'
+
 test_done
-- 
2.12.1.windows.1


