Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC04820A21
	for <e@80x24.org>; Fri, 15 Sep 2017 04:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750866AbdIOEup (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Sep 2017 00:50:45 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36669 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750787AbdIOEup (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Sep 2017 00:50:45 -0400
Received: by mail-pf0-f195.google.com with SMTP id f84so698331pfj.3
        for <git@vger.kernel.org>; Thu, 14 Sep 2017 21:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vtCyJJLBqqDpaoVboqR8AeKOc9UxA++7wwBoMHriAGA=;
        b=HK3rNjvJ8g/czo9+y/BaUaZwyZrf+dvkpt61rtAJPJbwR2N/qnUn40LcrWrmS/aPyL
         XTVRiL2DjFZYuobFIL2WcDJ6mLzu6tMPRaoD42QlGR3F1w9xCUZUFKMljTChv/JcSZoS
         s68XZcfV4pPebDkxkk70Q9Sj5EIwKO1elWy3mUEqPER2znDajR3TnLSHQqJXzjGFFZ7S
         LMePmyoBjDX29uEA2GwlrM2QvJPRJhdpy9pR2oGCgdbrJ+AKqiMPrE9ChtLKrPlsosxw
         Exu7zKBwDR035Z9zNO/9quJ7VYNEPkygEQ86DLm2VJH6+Y/OewocmDcosFUmmmSqrvK+
         CnJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vtCyJJLBqqDpaoVboqR8AeKOc9UxA++7wwBoMHriAGA=;
        b=bqe3c5KUCrkroLCygRMgaoozyP/Ro0DztOysYLlHSab/wHF0JjRD6dRYD/sprxhQe8
         lyTfCWP/FfCC+O5qsXQh6Gn8iILCVtrHlGPECO0aCBnMpCisAcpGPYKpxLfEYL7JRJT5
         kOXBT79DTQv9nAyQOHeh7ui8jWI9LJ66Feujgj9LhLaz6yOAhiE0LcDC8mQqm0dbvzTJ
         W+HleJfFrrGRVmGlR5+a3juUsa/3iXFxihl7k4eYJyTQnSeerxxJcMueKUHUaZm40WwJ
         Leb5mk9nQSKRjYKBpldvlIcTi81Oby42Rx6oZEsG2R8arL08gJ3CYKqbqzHosOKACeDC
         YUzA==
X-Gm-Message-State: AHPjjUhOTVYisW3dnCeBaj/3r7ep8Vldrqg77ov18sMdjWIJ0d0sxLbg
        1TryuLOJBRymLOPjrS09dQ==
X-Google-Smtp-Source: AOwi7QDfzBB/Y1/g5F4VwrQYAfj6kmL77iN4WvVx2AOxQ5ySGRIJfViua0CwJXsEgDN1bRWKh0k33A==
X-Received: by 10.99.161.17 with SMTP id b17mr9742021pgf.292.1505451044655;
        Thu, 14 Sep 2017 21:50:44 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:700c:2522:26be:510e:ef32:8edc])
        by smtp.gmail.com with ESMTPSA id 184sm166516pfg.18.2017.09.14.21.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Sep 2017 21:50:44 -0700 (PDT)
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Michael J Gruber <git@grubix.eu>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3] commit-template: change a message to be more intuitive
Date:   Fri, 15 Sep 2017 10:20:25 +0530
Message-Id: <20170915045025.4272-1-kaarticsivaraam91196@gmail.com>
X-Mailer: git-send-email 2.14.1.1006.g90ad9a07c
In-Reply-To: <xmqqefr8zouy.fsf@gitster.mtv.corp.google.com>
References: <xmqqefr8zouy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not good to use the phrase 'do not touch' to convey the information
that the cut-line should not be modified or removed as it could possibly
be mis-interpreted by a person who doesn't know that the word 'touch' has
the meaning of 'tamper with'. Further, it could make translations a little
difficult as it might not have the intended meaning in a few languages (for
which translations don't exist yet) when translated as such.

So, use intuitive terms in the sentence. Replacing the word 'touch' with
other terms has introduced the possibility of the following sentence to be
mis-interpreted, so change the terms in that too.

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 Changes in v3:
 
    - changed the wordings of the second sentence as there seemed to be a
      magical 'or else' connecting the two lines.
 
 I didn't expect the least that this would go upto v3. In case anyboy finds
 something wrong with this change too, it's a lot better to drop this altogether
 than going for a v4.

 wt-status.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/wt-status.c b/wt-status.c
index 77c27c511..23e87e74d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -934,7 +934,7 @@ size_t wt_status_locate_end(const char *s, size_t len)
 
 void wt_status_add_cut_line(FILE *fp)
 {
-	const char *explanation = _("Do not touch the line above.\nEverything below will be removed.");
+	const char *explanation = _("Do not modify or remove the line above.\nEverything below it will be ignored.");
 	struct strbuf buf = STRBUF_INIT;
 
 	fprintf(fp, "%c %s", comment_line_char, cut_line);
-- 
2.14.1.1006.g90ad9a07c

