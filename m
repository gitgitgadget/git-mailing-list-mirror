Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B6DB1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 18:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeIMXM6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 19:12:58 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42844 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbeIMXM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 19:12:58 -0400
Received: by mail-pl1-f195.google.com with SMTP id g23-v6so2937475plq.9
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 11:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=vHUkBRtBqXGfNO9a1LGkAuldc5o3Moxr27e8xRcaDms=;
        b=mmRT8jTpvypkhq7ptwq2K7n0gq6tyg5T0he1hhCOqIIhcrMhPWXJ11raM8qgr9U+fX
         e1Li0fyNAN3l5bw1Tv9Opzh+6G7LZCEaHHSrPuIJdmm5zbrDVPL24PXAk9cwLJBijOXY
         3KRmj88Ax9v0Kf9yn+Br0U8MlhoP+XxHo5obyZmrYBq0F53z5F4OovmoeWprHoEdJpve
         qFGiPrpkqpdS4HCYu31g8PJ7XVJ1n8wzbBQKgl9J5mcEl3VSRQmnTTW3nXnuH9zvoGlx
         bFhPtMfq4bplE3ygB6qhAzDJnPQ+DAm0BivJtw55T/F6yZk0DTy9gysiX3AYPMkiPXKX
         XfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=vHUkBRtBqXGfNO9a1LGkAuldc5o3Moxr27e8xRcaDms=;
        b=DMaXoXmHmyGe9Qq6ecb/nQ/2Z6iptpeToL+BI1iomsPX98plUMjpcEd1HNO2gS3p3b
         /K2SJrejvHEu/CtzUSr20J9mJtu4It9JjxJ4AV/q8WRDz6uMQPFELiJJmCx5wEEHeGE6
         ghiG5KjOHM2LBAY1rGTReRStsmvcWpnej+91xIOi+3WDYwhc8XUQZ4XuDRSm6/5qj3TC
         SjgGDKJvUcgoxN/kheyPZqXmFgPCvDiPtvKFe8KiTCWOoLzm8ENYNfX4YspCwdrSyKW4
         mGCiolz1F42OeHWYfgPALqrNp+iP0JhBe1NlFv/PSB8JekCVAR+df1GGGY6IYapr9cS6
         laIQ==
X-Gm-Message-State: APzg51AxpxfvkcCdOAaicxxOcvfg28/F3dWnxcSgHmFZPACjw5MFdq7n
        2QhYSZ3fjLneCvWpOzdp+CKnu9B9
X-Google-Smtp-Source: ANB0Vdbi3eJqYniD4X8DGR6s9zoDAZMdFmo2MOqW0j2lkYuOO3n8T76U+57zSiH7jKUBlufVc6SZxw==
X-Received: by 2002:a17:902:8ec8:: with SMTP id x8-v6mr8379579plo.308.1536861743103;
        Thu, 13 Sep 2018 11:02:23 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id d132-v6sm9206879pgc.93.2018.09.13.11.02.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 11:02:22 -0700 (PDT)
Date:   Thu, 13 Sep 2018 11:02:22 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Sep 2018 18:02:06 GMT
Message-Id: <511791de91115e0d51c1635f8ec3d337ca009971.1536861730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.34.v2.git.gitgitgadget@gmail.com>
References: <pull.34.git.gitgitgadget@gmail.com>
        <pull.34.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 07/11] multi-pack-index: verify oid lookup order
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
 midx.c                      | 11 +++++++++++
 t/t5319-multi-pack-index.sh |  8 ++++++++
 2 files changed, 19 insertions(+)

diff --git a/midx.c b/midx.c
index dfd26b4d74..06d5cfc826 100644
--- a/midx.c
+++ b/midx.c
@@ -959,5 +959,16 @@ int verify_midx_file(const char *object_dir)
 				    i, oid_fanout1, oid_fanout2, i + 1);
 	}
 
+	for (i = 0; i < m->num_objects - 1; i++) {
+		struct object_id oid1, oid2;
+
+		nth_midxed_object_oid(&oid1, m, i);
+		nth_midxed_object_oid(&oid2, m, i + 1);
+
+		if (oidcmp(&oid1, &oid2) >= 0)
+			midx_report(_("oid lookup out of order: oid[%d] = %s >= %s = oid[%d]"),
+				    i, oid_to_hex(&oid1), oid_to_hex(&oid2), i + 1);
+	}
+
 	return verify_midx_error;
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 47a54e138d..a968b9a959 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -175,6 +175,7 @@ test_expect_success 'verify bad signature' '
 		"multi-pack-index signature"
 '
 
+HASH_LEN=20
 MIDX_BYTE_VERSION=4
 MIDX_BYTE_OID_VERSION=5
 MIDX_BYTE_CHUNK_COUNT=6
@@ -189,6 +190,8 @@ MIDX_BYTE_PACKNAME_ORDER=$(($MIDX_OFFSET_PACKNAMES + 2))
 MIDX_OFFSET_OID_FANOUT=$(($MIDX_OFFSET_PACKNAMES + 652))
 MIDX_OID_FANOUT_WIDTH=4
 MIDX_BYTE_OID_FANOUT_ORDER=$((MIDX_OFFSET_OID_FANOUT + 250 * $MIDX_OID_FANOUT_WIDTH + 1))
+MIDX_OFFSET_OID_LOOKUP=$(($MIDX_OFFSET_OID_FANOUT + 256 * $MIDX_OID_FANOUT_WIDTH))
+MIDX_BYTE_OID_LOOKUP=$(($MIDX_OFFSET_OID_LOOKUP + 16 * $HASH_LEN))
 
 test_expect_success 'verify bad version' '
 	corrupt_midx_and_verify $MIDX_BYTE_VERSION "\00" $objdir \
@@ -235,6 +238,11 @@ test_expect_success 'verify oid fanout out of order' '
 		"oid fanout out of order"
 '
 
+test_expect_success 'verify oid lookup out of order' '
+	corrupt_midx_and_verify $MIDX_BYTE_OID_LOOKUP "\00" $objdir \
+		"oid lookup out of order"
+'
+
 test_expect_success 'repack removes multi-pack-index' '
 	test_path_is_file $objdir/pack/multi-pack-index &&
 	git repack -adf &&
-- 
gitgitgadget

