Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC71C54FCB
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 20:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 346DF2073A
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 20:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgDWU7J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:59:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:37812 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725877AbgDWU7I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 16:59:08 -0400
Received: (qmail 17797 invoked by uid 109); 23 Apr 2020 20:59:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Apr 2020 20:59:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13386 invoked by uid 111); 23 Apr 2020 21:10:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Apr 2020 17:10:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Apr 2020 16:59:07 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Garima Singh <garima.singh@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH 1/2] test-bloom: fix some whitespace issues
Message-ID: <20200423205907.GA1634224@coredump.intra.peff.net>
References: <20200423205851.GA1633985@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200423205851.GA1633985@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-bloom.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/helper/test-bloom.c b/t/helper/test-bloom.c
index ce412664ba..f9c0ce2bae 100644
--- a/t/helper/test-bloom.c
+++ b/t/helper/test-bloom.c
@@ -27,7 +27,7 @@ static void print_bloom_filter(struct bloom_filter *filter) {
 	}
 	printf("Filter_Length:%d\n", (int)filter->len);
 	printf("Filter_Data:");
-	for (i = 0; i < filter->len; i++){
+	for (i = 0; i < filter->len; i++) {
 		printf("%02x|", filter->data[i]);
 	}
 	printf("\n");
@@ -50,13 +50,13 @@ int cmd__bloom(int argc, const char **argv)
 		printf("Murmur3 Hash with seed=0:0x%08x\n", hashed);
 	}
 
-    if (!strcmp(argv[1], "generate_filter")) {
+	if (!strcmp(argv[1], "generate_filter")) {
 		struct bloom_filter filter;
 		int i = 2;
 		filter.len =  (settings.bits_per_entry + BITS_PER_WORD - 1) / BITS_PER_WORD;
 		filter.data = xcalloc(filter.len, sizeof(unsigned char));
 
-		if (!argv[2]){
+		if (!argv[2]) {
 			die("at least one input string expected");
 		}
 
@@ -68,7 +68,7 @@ int cmd__bloom(int argc, const char **argv)
 		print_bloom_filter(&filter);
 	}
 
-    if (!strcmp(argv[1], "get_filter_for_commit")) {
+	if (!strcmp(argv[1], "get_filter_for_commit")) {
 		struct object_id oid;
 		const char *end;
 		if (parse_oid_hex(argv[2], &oid, &end))
@@ -78,4 +78,4 @@ int cmd__bloom(int argc, const char **argv)
 	}
 
 	return 0;
-}
\ No newline at end of file
+}
-- 
2.26.2.827.g3c1233342b

