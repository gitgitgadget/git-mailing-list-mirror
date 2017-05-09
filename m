Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 469BC1FDEA
	for <e@80x24.org>; Tue,  9 May 2017 16:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754120AbdEIQpZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 12:45:25 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36683 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753824AbdEIQpY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 12:45:24 -0400
Received: by mail-pg0-f52.google.com with SMTP id 64so2462901pgb.3
        for <git@vger.kernel.org>; Tue, 09 May 2017 09:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G/TnPgb7mCalkzLP1wBjza7pMENf3cSfRVV5F4iDJxI=;
        b=g4898g+uXLMhis+rgkpKhv3Ng8gChrwYWktl7RAgUMm+BZ3qVnSpdRRIznpNBYYDye
         ZuVlOQTNgy/PXy5LhgiLfGXes22+4GqWFJiU93Yp6HeUNHMStW4oJrSRINf48/DRa5dI
         suWfD7fkyyqcmmALQ2FGbTnYyuy5sKGDApA1p0BOwyoTkrWXcfzIpNEtY5wcYCUxVX0D
         bfIBxFl4msMygfJz3lW6grhnD4Iqz088jqGikdxZ4wmqpaSjuL1BAsAvU6w0YcbJ1Dh/
         l3/UbtfeJZBQc3jvE1W9kKuX80xewGDHGcPsrJeXVTp7a2rfC+AXfCl/Uq2n55RoyQSb
         26OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G/TnPgb7mCalkzLP1wBjza7pMENf3cSfRVV5F4iDJxI=;
        b=kdwSHR1zY4l6ON6wvzsl1yB8nvliyF34qHxfYFThflwDRG/T54LurjcXHrpW3YPGUJ
         3SPcBN2PzdjhyZieQvTIKpSVPFJSxWRqL0Ur5PQyNnaxOB6uL3YxQaGDni/LxqnDIk3g
         luUlqqLyeWFBmXW6pDVK3L3wVlBgqi2bqF0bVXXyStPaAoRFPzRt8FYsno5+JNqifDg/
         qotTbrEW7QD07SbPufRhy5EKLoXJt6Fi4HkcoXtOBi5hknEx5g2306VmWuHj3/s0bkZT
         1O+JgvCRk07BqL6hHRNHX8zocaOGTFMk18KH3XiV0g/r0kKazPtaHxKuP2m/0g6B1aKp
         EseQ==
X-Gm-Message-State: AODbwcDtOmwkh/Y7z5sWOLxzBtwYalQA+jiUBo3Fz0u5U4ydnJDm3RoJ
        HAniy2X12ubEJPnM3Xzo/A==
X-Received: by 10.99.3.208 with SMTP id 199mr1167377pgd.43.1494348322958;
        Tue, 09 May 2017 09:45:22 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([100.96.218.24])
        by smtp.gmail.com with ESMTPSA id c196sm711150pga.23.2017.05.09.09.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 09 May 2017 09:45:21 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Subject: [PATCH] fixup! use perl instead of sed
Date:   Tue,  9 May 2017 09:45:15 -0700
Message-Id: <20170509164515.31942-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.13.0.rc2.291.g57267f2277-goog
In-Reply-To: <xmqqfuge4sak.fsf@gitster.mtv.corp.google.com>
References: <xmqqfuge4sak.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---

Thanks - I didn't realize the existence of the test lint. Here's a
fixup. Let me know if you prefer a full reroll.

I had to use perl because "push" is a binary file (the first line
contains a NUL).


 t/t5534-push-signed.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 0ef6f66b5..3ee58dafb 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -152,11 +152,11 @@ test_expect_success GPG 'inconsistent push options in signed push not allowed' '
 	# Tweak the push output to make the push option outside the cert
 	# different, then replay it on a fresh dst, checking that ff is not
 	# deleted.
-	sed -i "s/\\([^ ]\\)bar/\\1baz/" push &&
+	perl -pe "s/([^ ])bar/\\1baz/" push >push.tweak &&
 	prepare_dst &&
 	git -C dst config receive.certnonceseed sekrit &&
 	git -C dst config receive.advertisepushoptions 1 &&
-	git receive-pack dst <push >out &&
+	git receive-pack dst <push.tweak >out &&
 	git -C dst rev-parse ff &&
 	grep "inconsistent push options" out
 '
-- 
2.13.0.rc2.291.g57267f2277-goog

