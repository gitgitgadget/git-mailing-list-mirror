Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7BB41F406
	for <e@80x24.org>; Sat, 16 Dec 2017 12:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753035AbdLPMcF (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 07:32:05 -0500
Received: from zucker2.schokokeks.org ([178.63.68.90]:57029 "EHLO
        zucker2.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752388AbdLPMcF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 07:32:05 -0500
Received: from localhost ([::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1/SSLv3,256bits,ECDHE-RSA-AES256-GCM-SHA384)
  by zucker.schokokeks.org with ESMTPSA; Sat, 16 Dec 2017 13:32:14 +0100
  id 000000000000002C.000000005A35124E.0000271A
Date:   Sat, 16 Dec 2017 13:32:02 +0100
From:   Simon Ruderich <simon@ruderich.org>
To:     Git List <git@vger.kernel.org>
Subject: [PATCH] config: document default value of http.sslVerify
Message-ID: <ebbf93327b44e2533b9f7fee9d624d0eb03f1bc3.1513427145.git.simon@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove any doubt that certificates might not be verified by
default.

Signed-off-by: Simon Ruderich <simon@ruderich.org>
---
 Documentation/config.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3a1304874..0d49bcd70 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1968,8 +1968,8 @@ empty string.
 
 http.sslVerify::
 	Whether to verify the SSL certificate when fetching or pushing
-	over HTTPS. Can be overridden by the `GIT_SSL_NO_VERIFY` environment
-	variable.
+	over HTTPS. Defaults to true. Can be overridden by the
+	`GIT_SSL_NO_VERIFY` environment variable.
 
 http.sslCert::
 	File containing the SSL certificate when fetching or pushing
-- 
2.15.1

-- 
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9
