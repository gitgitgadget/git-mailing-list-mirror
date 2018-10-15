Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 258AC1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 10:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeJOR4u (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 13:56:50 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:38603 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJOR4u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 13:56:50 -0400
Received: by mail-pl1-f169.google.com with SMTP id q19-v6so5993211pll.5
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 03:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mvvHsQO1GjK40FP4netT5PvH72cbiJBboalGZL/DDPQ=;
        b=vZg4RJ2Iv9iKNjRs6zZpRwCNz4Uk4vkA7eDG8jxdmxRDjo6fvaaTtuIfOtH85t4JqX
         xv0wsfKBrNRI/6ZNUUUMBjYLXfHtGjUJ8s6C39QCrllYO6wevVx0DuAQGwbp3+Bb389w
         1mIXApji1pJ2ygTcPqAO1ONRACIhGHVeJbCv32mM5SNL8K0S8f7yQu1OPkiCUVrOpofv
         wX+hND1TszI/Y317Nrlcc49y2zUMLpdittSloVgFpHobdBzEleBwpzZx8QmkemuYx0Jn
         N3HuHc+pALYlP+Pa+zpka6nE8rs3NCU3Ov/+CpWLCYO2LM5VS/an6xsa9/Sq2O0p1tPv
         uCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mvvHsQO1GjK40FP4netT5PvH72cbiJBboalGZL/DDPQ=;
        b=Ac7zRqYJCFeeyY2PapnoV49gdRna7bNVI/wOBPHPD/I3+LRqi/663QZ68urp5QEfiz
         /LX5pc1mYjCXkPbC30wGHSHevgBoq+0lX0fRfYJL7yD+cq8dYXY+nuPqkYUkFpBPMw2c
         Er5hw4jy/EG9l/MIO5+abnAbyDQ7tlk+uqa1Qa/OBHZNLRrhFycOgRK1QC//JB+DoRJm
         6inMGbJOSfeUyu3Vqu7fJL0x8IzO+q+rOSkLq7ZyRNybyGBQWExTRbfiN2WumdzwOj/x
         XoZwbBMBsFGObAOvwrWFOhVuiPnOXAnGr1019odRD0s8uqr/Z5+RKdK8+wW98qrLnfrY
         LHpQ==
X-Gm-Message-State: ABuFfohXBjcHr+onZmAVvtdGOoPZqHkRbRJgdT4RtRIgxub8Q+xv5XWg
        1ZfcEcL7hUsQhOTho2WE6p8FT3ln
X-Google-Smtp-Source: ACcGV63cE+zXoOeeQW+oqKZdL+XQZ28MnDgXNMFNcCx0p9tLH9rjwKAMFISIPWy3LZ5X7DAUscWGSg==
X-Received: by 2002:a17:902:9a98:: with SMTP id w24-v6mr16707713plp.109.1539598335090;
        Mon, 15 Oct 2018 03:12:15 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id y85-v6sm19534108pfa.120.2018.10.15.03.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 03:12:14 -0700 (PDT)
Date:   Mon, 15 Oct 2018 03:12:14 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 10:11:53 GMT
Message-Id: <2466a48aa3eedc703263c2b63c9c7b5f13f0194a.1539598316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v2.git.gitgitgadget@gmail.com>
References: <pull.31.git.gitgitgadget@gmail.com>
        <pull.31.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 11/13] tests: record more stderr with --write-junit-xml in
 case of failure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Sometimes, failures in a test case are actually caused by issues in
earlier test cases.

To make it easier to see those issues, let's attach the output from
before the failing test case (i.e. stdout/stderr since the previous
failing test case, or the start of the test script). This will be
visible in the "Attachments" of the details of the failed test.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8a60e39364..5f62418f9c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -479,6 +479,9 @@ test_failure_ () {
 			"$(cat "$GIT_TEST_TEE_OUTPUT_FILE")")"
 		>"$GIT_TEST_TEE_OUTPUT_FILE"
 		junit_insert="$junit_insert</failure>"
+		junit_insert="$junit_insert<system-err>$(xml_attr_encode \
+			"$(cat "$GIT_TEST_TEE_OUTPUT_FILE.err")")</system-err>"
+		>"$GIT_TEST_TEE_OUTPUT_FILE.err"
 		write_junit_xml_testcase "$1" "      $junit_insert"
 	fi
 	test_failure=$(($test_failure + 1))
@@ -763,9 +766,12 @@ test_start_ () {
 	then
 		junit_start=$(test-tool date getnanos)
 
-		# truncate output
-		test -z "$GIT_TEST_TEE_OUTPUT_FILE" ||
-		>"$GIT_TEST_TEE_OUTPUT_FILE"
+		# append to future <system-err>; truncate output
+		test -z "$GIT_TEST_TEE_OUTPUT_FILE" || {
+			cat "$GIT_TEST_TEE_OUTPUT_FILE" \
+				>>"$GIT_TEST_TEE_OUTPUT_FILE.err"
+			>"$GIT_TEST_TEE_OUTPUT_FILE"
+		}
 	fi
 }
 
-- 
gitgitgadget

