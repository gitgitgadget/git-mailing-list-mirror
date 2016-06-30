Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 770D62018A
	for <e@80x24.org>; Thu, 30 Jun 2016 10:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbcF3Ktw (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 06:49:52 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:35385 "EHLO
	host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbcF3Ktn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 06:49:43 -0400
Received: from hashpling.plus.com ([212.159.69.125]:46418)
	by host02.zombieandprude.com with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA256:128)
	(Exim 4.80)
	(envelope-from <charles@hashpling.org>)
	id 1bIYyo-0007aJ-66; Thu, 30 Jun 2016 11:13:54 +0100
From:	Charles Bailey <charles@hashpling.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 2/3] t7810-grep.sh: fix a whitespace inconsistency
Date:	Thu, 30 Jun 2016 11:13:47 +0100
Message-Id: <20160630101348.15665-3-charles@hashpling.org>
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
index c4302ed..6e6eaa4 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -175,7 +175,7 @@ do
 
 	test_expect_success "grep -c $L (no /dev/null)" '
 		! git grep -c test $H | grep /dev/null
-        '
+	'
 
 	test_expect_success "grep --max-depth -1 $L" '
 		{
-- 
2.8.2.311.gee88674

