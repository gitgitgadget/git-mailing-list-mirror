Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02AB81F404
	for <e@80x24.org>; Thu, 13 Sep 2018 18:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeIMXM5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 19:12:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37970 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeIMXM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 19:12:56 -0400
Received: by mail-pg1-f195.google.com with SMTP id t84-v6so3107797pgb.5
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eeQI1Q4p3rVCBb3hKEdqdhHNQAtcxpOxE5nRJZ8n2jc=;
        b=HKQXPuduWmsb5o+ta8K+V7qdpLLkU5z/hSk7mR+NrbCFeCaBLn+ij5FdUKE2656XgK
         9tG0K8Znx0HD0GT7mUz+Di/hJWGF1j5kNuQrCnRW/GqCDB9OE5ip3e+xi1VNw6IrYynq
         tVEpPpZOm8YbOwgv5t/S+gb+S3+6hdVLhxLbqeRCk7GKEBC1ov/kRLTYdmQrfJtZEjgK
         W7V02FlLTZ2XF3IcOsD/pKZwaK0knjcAfLO5IfXEn1M40I6ggVz+AGZrq4Bufptas/nW
         c7YgJm56ZDU2yWpbFjixNQeoFDA0bX9CvqMV4khiwwgQu9AqlORGGedIIVsBS5/pD4Jj
         cjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eeQI1Q4p3rVCBb3hKEdqdhHNQAtcxpOxE5nRJZ8n2jc=;
        b=o17O7ksGoWpbokUaL/CpWx44u+9oSzIOEMkMmnxJMX/SmEL2BiiNykfA+fElhxOQXi
         4AjGvkFHC6+vnVkYMGkRYPgnj0FFQNCV0eLnsYhtXiUH3wMknTTEMvBW4ubBmRnc0upC
         kn7GAs3vpcGziJrBB6llVT2UDc365Q2OlaNAUMnFGz8cyzuFCsCHt599smJ0npSj3auO
         0iO9g8zT54ufEO4PQOGfLikxBPe6IL+pMZqjluf1TXrNP8KSuYG3+AiD7rVSMpbkIxDC
         eK0sKjYEZnSDKgsOKq1SVfNKwioIoyffRrlxxSdPhWmfsxJgG7QI6ccdGgt5Mi3qU3yC
         6BXQ==
X-Gm-Message-State: APzg51D1KNjYJTuMGSmkRAwKOowD40qwrBTbI//iXiTu0s5mbyU2od4n
        UBrAldZyFwkGXM+1vrgOJsSgVhsY
X-Google-Smtp-Source: ANB0VdYyXFGWnxCPPAh5RZh4gj4jU2Qvs5PfugNe3XpMKSiu30UxP9igx2tw4AD7TmRpm2/7r4j3Tg==
X-Received: by 2002:a62:4808:: with SMTP id v8-v6mr8571205pfa.89.1536861741713;
        Thu, 13 Sep 2018 11:02:21 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id p73-v6sm7504912pfk.186.2018.09.13.11.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 11:02:20 -0700 (PDT)
Date:   Thu, 13 Sep 2018 11:02:20 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Sep 2018 18:02:05 GMT
Message-Id: <ea1c522702822e65e962cf3b5178437549ee7a2d.1536861730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.34.v2.git.gitgitgadget@gmail.com>
References: <pull.34.git.gitgitgadget@gmail.com>
        <pull.34.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 06/11] multi-pack-index: verify oid fanout order
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 9 +++++++++
 t/t5319-multi-pack-index.sh | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/midx.c b/midx.c
index a02b19efc1..dfd26b4d74 100644
--- a/midx.c
+++ b/midx.c
@@ -950,5 +950,14 @@ int verify_midx_file(const char *object_dir)
 			midx_report("failed to load pack in position %d", i);
 	}
 
+	for (i = 0; i < 255; i++) {
+		uint32_t oid_fanout1 = ntohl(m->chunk_oid_fanout[i]);
+		uint32_t oid_fanout2 = ntohl(m->chunk_oid_fanout[i + 1]);
+
+		if (oid_fanout1 > oid_fanout2)
+			midx_report(_("oid fanout out of order: fanout[%d] = %"PRIx32" > %"PRIx32" = fanout[%d]"),
+				    i, oid_fanout1, oid_fanout2, i + 1);
+	}
+
 	return verify_midx_error;
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 0a566afb05..47a54e138d 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -186,6 +186,9 @@ MIDX_CHUNK_LOOKUP_WIDTH=12
 MIDX_OFFSET_PACKNAMES=$(($MIDX_HEADER_SIZE + \
 			 $MIDX_NUM_CHUNKS * $MIDX_CHUNK_LOOKUP_WIDTH))
 MIDX_BYTE_PACKNAME_ORDER=$(($MIDX_OFFSET_PACKNAMES + 2))
+MIDX_OFFSET_OID_FANOUT=$(($MIDX_OFFSET_PACKNAMES + 652))
+MIDX_OID_FANOUT_WIDTH=4
+MIDX_BYTE_OID_FANOUT_ORDER=$((MIDX_OFFSET_OID_FANOUT + 250 * $MIDX_OID_FANOUT_WIDTH + 1))
 
 test_expect_success 'verify bad version' '
 	corrupt_midx_and_verify $MIDX_BYTE_VERSION "\00" $objdir \
@@ -227,6 +230,11 @@ test_expect_success 'verify packnames out of order' '
 		"failed to load pack"
 '
 
+test_expect_success 'verify oid fanout out of order' '
+	corrupt_midx_and_verify $MIDX_BYTE_OID_FANOUT_ORDER "\01" $objdir \
+		"oid fanout out of order"
+'
+
 test_expect_success 'repack removes multi-pack-index' '
 	test_path_is_file $objdir/pack/multi-pack-index &&
 	git repack -adf &&
-- 
gitgitgadget

