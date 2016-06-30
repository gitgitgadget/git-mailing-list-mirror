Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE01B1F744
	for <e@80x24.org>; Thu, 30 Jun 2016 11:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbcF3LSj (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 07:18:39 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:52769 "EHLO
	host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbcF3LSi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 07:18:38 -0400
Received: from hashpling.plus.com ([212.159.69.125]:46418)
	by host02.zombieandprude.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
	(Exim 4.80)
	(envelope-from <charles@hashpling.org>)
	id 1bIYyn-0007aJ-VP; Thu, 30 Jun 2016 11:13:54 +0100
From:	Charles Bailey <charles@hashpling.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 1/3] t7810-grep.sh: fix duplicated test name
Date:	Thu, 30 Jun 2016 11:13:46 +0100
Message-Id: <20160630101348.15665-2-charles@hashpling.org>
X-Mailer: git-send-email 2.8.2.311.gee88674
In-Reply-To: <20160630101348.15665-1-charles@hashpling.org>
References: <20160630101348.15665-1-charles@hashpling.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 t/t7810-grep.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 1e72971..c4302ed 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -353,7 +353,7 @@ test_expect_success 'grep -l -C' '
 cat >expected <<EOF
 file:5
 EOF
-test_expect_success 'grep -l -C' '
+test_expect_success 'grep -c -C' '
 	git grep -c -C1 foo >actual &&
 	test_cmp expected actual
 '
-- 
2.8.2.311.gee88674

