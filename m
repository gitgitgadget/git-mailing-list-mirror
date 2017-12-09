Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C44131F406
	for <e@80x24.org>; Sat,  9 Dec 2017 20:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbdLIUko (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 15:40:44 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:45868 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751379AbdLIUki (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 15:40:38 -0500
Received: by mail-wm0-f68.google.com with SMTP id 9so8219621wme.4
        for <git@vger.kernel.org>; Sat, 09 Dec 2017 12:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BQbGOqeD8+ow6lRVynICbAFW0+2LOnSvylWlKJmPJRc=;
        b=Gy4/GR1unz2qRdkghSe9yHMpDCZ9Kt7Y4p+c7G6MdnynQCS5VoY6nkp1nBE+vc6FkQ
         GJM8NvsnzC69sHgLrzw2kzPN6PCQpIuHzZ3sMnqywqbh0eXZ4ovZpWTBYRu0ycjPCuJe
         Xxhat/sd5PzjfU7L8lLLdXYe0E2mM3G6K3sqBk+kydk9srwbV5CtOKmgPoeqtgUUnq3j
         xzI80NYHrKM3a41betaUcG3XIixV1TTYru7BB1NonYvEWFTMFJJ2gyZoOrKwFxwbQqFr
         oyr4VbkMSXTDFy3qGvcWQmr17QNUIRFav+B99yDd0cCw2cR/dvbac2QBWB36U4MxtFNB
         A34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BQbGOqeD8+ow6lRVynICbAFW0+2LOnSvylWlKJmPJRc=;
        b=HrfeIK7DooeLOJksEkV3RInU2DeWt3xrKWsfCrph1KYxSuvsW3acM+6HgCjnZicu9E
         AywHHak+9aOZf6cqDgwpkvIr27V23+7PNTFXHyTZ8Uq6np8669O4NPcWk9bmHNo2koHE
         DAEPCq2qzWPmL5lvJfGWutqgBVlzbun69UQXB7UZCY6yW+sLZKuJZmHSA3Se41ibLf9g
         q/uj9t/KjeerkKG/BzmhgMUOsbm+Gu0XPwksiCUouEk1kaWMlomq7bgoQgXy+rXAW/TL
         MZCqIYEgQpr6HHF/7zqnvxSPO0raB98JiTRJgCNfdey2q25RBMpuzTnlYo0JNwUqOup/
         k3TQ==
X-Gm-Message-State: AKGB3mKggQWZ9+38FabngR/1arNEdnmYkev8S4z4KgG4vQv8/WXuMbKi
        OmdUb9RadUAWuV9m25c6RovU4azi
X-Google-Smtp-Source: AGs4zMay9bEuSjXDIcZbxwfvTf1rH6DQzG8f32btTmMcEBO7eZtwjTNhk3pXrdprSUfAg88FxtoU+Q==
X-Received: by 10.28.1.196 with SMTP id 187mr6981648wmb.151.1512852036627;
        Sat, 09 Dec 2017 12:40:36 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id v18sm12491283wrv.37.2017.12.09.12.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Dec 2017 12:40:35 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Donald R Laster Jr <laster@dlaster.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3 7/7] t4045: reindent to make helpers readable
Date:   Sat,  9 Dec 2017 21:40:13 +0100
Message-Id: <20171209204013.10997-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.1.361.g8b07d831d0
In-Reply-To: <20171209204013.10997-1-chriscool@tuxfamily.org>
References: <20171209204013.10997-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4045-diff-relative.sh | 104 +++++++++++++++++++++++++----------------------
 1 file changed, 56 insertions(+), 48 deletions(-)

diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
index 7d68a6e2a5..4df55884c4 100755
--- a/t/t4045-diff-relative.sh
+++ b/t/t4045-diff-relative.sh
@@ -12,60 +12,68 @@ test_expect_success 'setup' '
 	git commit -m one
 '
 
-check_diff() {
-dir=$1; shift
-expect=$1; shift
-cat >expected <<EOF
-diff --git a/$expect b/$expect
-new file mode 100644
-index 0000000..25c05ef
---- /dev/null
-+++ b/$expect
-@@ -0,0 +1 @@
-+other content
-EOF
-test_expect_success "-p $*" "
-	git -C '$dir' diff -p $* HEAD^ >actual &&
-	test_cmp expected actual
-"
+check_diff () {
+	dir=$1
+	shift
+	expect=$1
+	shift
+	cat >expected <<-EOF
+	diff --git a/$expect b/$expect
+	new file mode 100644
+	index 0000000..25c05ef
+	--- /dev/null
+	+++ b/$expect
+	@@ -0,0 +1 @@
+	+other content
+	EOF
+	test_expect_success "-p $*" "
+		git -C '$dir' diff -p $* HEAD^ >actual &&
+		test_cmp expected actual
+	"
 }
 
-check_numstat() {
-dir=$1; shift
-expect=$1; shift
-cat >expected <<EOF
-1	0	$expect
-EOF
-test_expect_success "--numstat $*" "
-	echo '1	0	$expect' >expected &&
-	git -C '$dir' diff --numstat $* HEAD^ >actual &&
-	test_cmp expected actual
-"
+check_numstat () {
+	dir=$1
+	shift
+	expect=$1
+	shift
+	cat >expected <<-EOF
+	1	0	$expect
+	EOF
+	test_expect_success "--numstat $*" "
+		echo '1	0	$expect' >expected &&
+		git -C '$dir' diff --numstat $* HEAD^ >actual &&
+		test_cmp expected actual
+	"
 }
 
-check_stat() {
-dir=$1; shift
-expect=$1; shift
-cat >expected <<EOF
- $expect | 1 +
- 1 file changed, 1 insertion(+)
-EOF
-test_expect_success "--stat $*" "
-	git -C '$dir' diff --stat $* HEAD^ >actual &&
-	test_i18ncmp expected actual
-"
+check_stat () {
+	dir=$1
+	shift
+	expect=$1
+	shift
+	cat >expected <<-EOF
+	 $expect | 1 +
+	 1 file changed, 1 insertion(+)
+	EOF
+	test_expect_success "--stat $*" "
+		git -C '$dir' diff --stat $* HEAD^ >actual &&
+		test_i18ncmp expected actual
+	"
 }
 
-check_raw() {
-dir=$1; shift
-expect=$1; shift
-cat >expected <<EOF
-:000000 100644 0000000000000000000000000000000000000000 25c05ef3639d2d270e7fe765a67668f098092bc5 A	$expect
-EOF
-test_expect_success "--raw $*" "
-	git -C '$dir' diff --no-abbrev --raw $* HEAD^ >actual &&
-	test_cmp expected actual
-"
+check_raw () {
+	dir=$1
+	shift
+	expect=$1
+	shift
+	cat >expected <<-EOF
+	:000000 100644 0000000000000000000000000000000000000000 25c05ef3639d2d270e7fe765a67668f098092bc5 A	$expect
+	EOF
+	test_expect_success "--raw $*" "
+		git -C '$dir' diff --no-abbrev --raw $* HEAD^ >actual &&
+		test_cmp expected actual
+	"
 }
 
 for type in diff numstat stat raw; do
-- 
2.15.1.361.g8b07d831d0

