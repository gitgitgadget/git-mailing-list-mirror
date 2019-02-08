Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0016C1F453
	for <e@80x24.org>; Fri,  8 Feb 2019 22:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfBHWIR (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 17:08:17 -0500
Received: from sonic307-7.consmr.mail.bf2.yahoo.com ([74.6.134.46]:43173 "EHLO
        sonic307-7.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726788AbfBHWIQ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 Feb 2019 17:08:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1549663695; bh=vl0t8Z8NZ/G7wdqaHej+dFGjzcBZ4QmanUH/0GpV0jE=; h=From:To:Cc:Subject:Date:From:Subject; b=eiupxFBDX29tiXfNLslqL9NXQH7f028pYlvH5w2y0r4GXMom7g73uRMH5LT2Mmx5hSVBZijhHklCn+N4UqaKJUHvZnTEz8YmqdGHUc8oOyPzFmDnVRjTiKpORrQqTE9QOQ2p33TeqbhdiAdmzcNVgOLcWZiRL7Bb21TyANrJHixCUsvzFYK4hTwYRIfRzRrDC61AVH5NT2j/R5lOb1ef/QCDf2Ph95JUZeGD8tWbeQ4qukNbtS5zrrRXTUnC305LD5eJAskn3SngnPTI/eDzcYYAH7hI+kWMe6UF5caY5Yrh8nf+ElgCufNYY/YadbQpaf68G/nI3P64Chr4QUnhvA==
X-YMail-OSG: fYL7dnUVM1k6oRUrBt2Z0aJvtqBwiZKYLevlT_Hybd4ccccJyIeN8LbMYQt6WTx
 TTNj6Wp8bWqHyeJS66nGmVL_nvM_UanvmRaSeBIgTZaJvBin2FxDhmpm5Ob2TLS0JIa26I7sPBZd
 rAZFLsd36rV068d.dM3gQKG70YkV8pVVJhFKIRXoaqXZQsQBhLp8GJKz8VhGaqyccdNO14ElJv6A
 E_ytsFjw6HEYofFyU0Wh34eTxZqSlklmANKo06F2gts2Bycba6VvB0YPVGvRtFsJ1hScr_Jsye9U
 S8JXTeKyjdTfmun7BrbGSJhR4H4vJEYq.oOkS3APqrBj2N9VWcHrOp2yXwXa3fkaLfipK062deQ_
 YlJ2bUUomzxmZAgno5iUeMsLmK4RHoh0ugwiKz.uKVI0aymi2u4IDQ5whrdLGTqyOosCnUgt2KwR
 3Vtel_JXv6h9lQwFKImAQzNcxiBXWot9kXBWSb_LyIO24JCBWu5oGFvmRvg_rHIlDXOn6vqX4VZZ
 fuMbgsZxPGY__UXcCarWnuY7hGP5YDnAb751gQL4uSF7kDczZQ0Zh8JwIKlaPkYNq7wR5EOVaG.V
 DMYNvUVxULgeyPamv63l8VzfKOBgA64agcJCW.OW7rbmH93mhiIdCWvM45sG_1hdx7bdrkeqJsqa
 5rAUy82KQaQvg9e3Z4KsWgX.q2PRm5P5j.WxNXUhZFBy7WO6z1AhbpefDImyvy7UE2QDhGoVTVaH
 cwDd6HevYQIP0Xk9vWDJInz8uzYxyfCXsi62SJ664B1Mp1f4u_2r4kapIjVTA523mvI6E304Ljl_
 xrQVMYToQHyPIeKNCax3_HZrUoDWJcEf_tvEz_E18UBeJhpRQtIXbsGTNqy.mwOJQfDRnZCwQmLw
 5eFyk4X6leyWcqUDCwfXnr6I.NmaTrBxkr9oLgDD5rVK08D2cIA2q319k3BlH45o7pwVMJEqwU4B
 ALkm2Pqzgxr99JReHFpkPxaMud6xto6mvAUaHCYR2SXLOf5J4MTqPTpfZd3PvNHXEDaq1tXNLI5V
 _u3IPWmlniag2aFnE1bswsVobsEq2s608Vva70H8KxiBRC7B3z7QKmaMtZkm2tSb9tlvxg_w1nD5
 RvOa9eFsJKY2PS.SA6nBOcyqs
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Fri, 8 Feb 2019 22:08:15 +0000
Received: from CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com (EHLO localhost.localdomain) ([99.229.179.249])
          by smtp410.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID e6c67a19d1d5d60d1db04db6aa9079fd;
          Fri, 08 Feb 2019 22:08:12 +0000 (UTC)
From:   randall.s.becker@rogers.com
To:     git@vger.kernel.org
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: [Fix v2] t5562: remove dependency on /dev/zero
Date:   Fri,  8 Feb 2019 17:07:51 -0500
Message-Id: <20190208220751.9936-1-randall.s.becker@rogers.com>
X-Mailer: git-send-email 2.12.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Randall S. Becker" <rsbecker@nexbridge.com>

Replaced subtest 15 (CONTENT_LENGTH overflow ssite_t) use of /dev/zero
with yes and a translation of its result to a stream of NULL. This is
a more portable solution.

Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
---
 t/t5562-http-backend-content-length.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index 90d890d02..b8d1913e5 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -143,14 +143,14 @@ test_expect_success GZIP 'push gzipped empty' '
 
 test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
 	NOT_FIT_IN_SSIZE=$(ssize_b100dots) &&
-	env \
+	yes | tr "y" "\\0" | env \
 		CONTENT_TYPE=application/x-git-upload-pack-request \
 		QUERY_STRING=/repo.git/git-upload-pack \
 		PATH_TRANSLATED="$PWD"/.git/git-upload-pack \
 		GIT_HTTP_EXPORT_ALL=TRUE \
 		REQUEST_METHOD=POST \
 		CONTENT_LENGTH="$NOT_FIT_IN_SSIZE" \
-		git http-backend </dev/zero >/dev/null 2>err &&
+		git http-backend >/dev/null 2>err &&
 	grep "fatal:.*CONTENT_LENGTH" err
 '
 
-- 
2.12.3

