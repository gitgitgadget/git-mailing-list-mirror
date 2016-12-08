Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ED71208AD
	for <e@80x24.org>; Thu,  8 Dec 2016 15:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932408AbcLHPg4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 10:36:56 -0500
Received: from mout.gmx.net ([212.227.15.19]:61091 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932393AbcLHPgz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 10:36:55 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MDQUP-1cQlvp1TS9-00Goxu; Thu, 08
 Dec 2016 16:36:48 +0100
Date:   Thu, 8 Dec 2016 16:36:33 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH/RFC 7/7] WIP: read_early_config(): add tests
In-Reply-To: <cover.1481211338.git.johannes.schindelin@gmx.de>
Message-ID: <62f04326163842ccfcffce5e5d6ffb48f8d3035e.1481211338.git.johannes.schindelin@gmx.de>
References: <cover.1481211338.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:qRADgDliNrTbWQ89phH2dstBkw1ECeg3Trj3J2MX2RCUvulZ4d/
 cOKWH5JcEqP0A1W6OCD/uiUK1p6CvFfaMGWEhn2R52McHYldLaydHXaazDcagF0+OxYuK0q
 vnDCqai//l+HzcauWaq3QLPbEo8U9c1JoKFriQQfdRbWYjCuqKihahfk+vl2k0FNnmULlbz
 msU4nitj8sGQIxayoZJyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5ZvDZbVMbgA=:tXZbsd9u/2o0VSQubpvRGv
 bC4ddLiJNFD2qo+K4UmND03TX/sX80P4aBhDwWYPKwx3C5UNKxeGBY/f8CXNovMaNIXnD4OYn
 3P5xgzFbtYRvFM5UO+Vh/PsyqEyUrTzja9yQMkX/OmGSpK3T61mRWpztM4SfgAllm2PsYBcya
 Tli/4LwtyM/+EVBq2LWROXBIHWJglS6Y5mTJJq9YG31jN1HZbLh9i9w4f3Nd1qFVAjVhTEInh
 m+hdfLH41CfLPLvOJbTWvgVEhEdixIZyXnphaWW3Ub+ctFXf/G57q4kkUyQUowa73IyPF5ml7
 ZHuhRzMLxy0h1bnHUEYnB3hLfjSr4H3L+zQJWqBDykGRn1+4MZwuwPR5XS1k5EyQSU9sp/DF7
 mZqBfYUNB6XvVOd6Qf4GjQqDMlkrFZicxV7D1PhpbhP9dVANlnFta4E0X8+6qibIIcH4TE/JF
 PZwQe/A7yXqU7KRnOmSJZuQsUN+Rz6Eg7QWETHK7oUeh2XgbBO8CKVhk0tbtqu8k5FEHSt4G+
 fTfV0J+Sycy4AM0UjwoB5Pv4Q4H0P9QTe5mxgSRkxO2CbCp2YVm3N6HT4S8aw4P/5IaCdW43U
 w6uleerFUuv85XlUx7HcxOy0hLw2U9uCCXHzxzCXmIuRTW7/Xm9SYu18+NRnAsHTR3mkIthkb
 FsAypvTAaVZBZLLk43UZsCdJd0XUtjvnRKAvUdGb6aKQFS4U3ThH0N36U3WI6ejy3i8pJnysI
 k24ib1nYgEfseWDxKBfcflNmRtaBw5qLlPtkG+Ixk/9aWCba+JodGhbdju5bjfp0r5a/i5NW7
 d/reOWo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-config.c  | 15 +++++++++++++++
 t/t1309-early-config.sh | 50 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100755 t/t1309-early-config.sh

diff --git a/t/helper/test-config.c b/t/helper/test-config.c
index 83a4f2ab86..5105069587 100644
--- a/t/helper/test-config.c
+++ b/t/helper/test-config.c
@@ -66,6 +66,16 @@ static int iterate_cb(const char *var, const char *value, void *data)
 	return 0;
 }
 
+static int early_config_cb(const char *var, const char *value, void *vdata)
+{
+	const char *key = vdata;
+
+	if (!strcmp(key, var))
+		printf("%s\n", value);
+
+	return 0;
+}
+
 int cmd_main(int argc, const char **argv)
 {
 	int i, val;
@@ -73,6 +83,11 @@ int cmd_main(int argc, const char **argv)
 	const struct string_list *strptr;
 	struct config_set cs;
 
+	if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
+		read_early_config(early_config_cb, (void *)argv[2], 1);
+		return 0;
+	}
+
 	setup_git_directory();
 
 	git_configset_init(&cs);
diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
new file mode 100755
index 0000000000..0c55dee514
--- /dev/null
+++ b/t/t1309-early-config.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+
+test_description='Test read_early_config()'
+
+. ./test-lib.sh
+
+test_expect_success 'read early config' '
+	test_config early.config correct &&
+	test-config read_early_config early.config >output &&
+	test correct = "$(cat output)"
+'
+
+test_expect_success 'in a sub-directory' '
+	test_config early.config sub &&
+	mkdir -p sub &&
+	(
+		cd sub &&
+		test-config read_early_config early.config
+	) >output &&
+	test sub = "$(cat output)"
+'
+
+test_expect_success 'ceiling' '
+	test_config early.config ceiling &&
+	mkdir -p sub &&
+	(
+		GIT_CEILING_DIRECTORIES="$PWD" &&
+		export GIT_CEILING_DIRECTORIES &&
+		cd sub &&
+		test-config read_early_config early.config
+	) >output &&
+	test -z "$(cat output)"
+'
+
+test_expect_success 'ceiling #2' '
+	mkdir -p xdg/git &&
+	git config -f xdg/git/config early.config xdg &&
+	test_config early.config ceiling &&
+	mkdir -p sub &&
+	(
+		XDG_CONFIG_HOME="$PWD"/xdg &&
+		GIT_CEILING_DIRECTORIES="$PWD" &&
+		export GIT_CEILING_DIRECTORIES XDG_CONFIG_HOME &&
+		cd sub &&
+		test-config read_early_config early.config
+	) >output &&
+	test xdg = "$(cat output)"
+'
+
+test_done
-- 
2.11.0.rc3.windows.1
