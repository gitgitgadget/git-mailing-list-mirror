Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCDC72018E
	for <e@80x24.org>; Fri,  5 Aug 2016 22:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1428017AbcHEWDf (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 18:03:35 -0400
Received: from siwi.pair.com ([209.68.5.199]:64394 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1427987AbcHEWDW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 18:03:22 -0400
Received: from jeffhost-linux1.corp.microsoft.com (unknown [167.220.148.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 53A0D8460D;
	Fri,  5 Aug 2016 18:03:19 -0400 (EDT)
From:	Jeff Hostetler <git@jeffhostetler.com>
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v5 8/9] test-lib-functions.sh: Add lf_to_nul
Date:	Fri,  5 Aug 2016 18:00:33 -0400
Message-Id: <1470434434-64283-9-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.8.0.rc4.17.gac42084.dirty
In-Reply-To: <1470434434-64283-1-git-send-email-git@jeffhostetler.com>
References: <1470434434-64283-1-git-send-email-git@jeffhostetler.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add lf_to_nul() function to test-lib-functions.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/test-lib-functions.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 4f7eadb..fdaeb3a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -81,6 +81,10 @@ test_decode_color () {
 	'
 }
 
+lf_to_nul () {
+	perl -pe 'y/\012/\000/'
+}
+
 nul_to_q () {
 	perl -pe 'y/\000/Q/'
 }
-- 
2.8.0.rc4.17.gac42084.dirty

