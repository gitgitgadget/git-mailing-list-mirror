Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5802A1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 14:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeIETRO (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 15:17:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43050 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbeIETRO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 15:17:14 -0400
Received: by mail-pg1-f196.google.com with SMTP id v66-v6so3541572pgb.10
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 07:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ajscyTOVaw8YZXTLAGJgfFct4TdZTfjpgKzBpwv2f2k=;
        b=WTraOVRVwQuMdV+Dd+ZTd/fkBqXaOtOOfAQvpl4VW8EvdU5nHMLyKpJd8OsBGrU+sX
         /teiKcF+aDK54AuAd1Y3D7J6CPKcbS7a5a8kEHmNrdGpLUowtiTQ3yugkvJZTGflq6Da
         LAofP9p4ltneiQXCnGx4zP6O5+puFyhQ+cWaLMvRmge7W5exRY0QK+CD1XrD9SN6m1qC
         BEhc1Jg81VNotu0HUH7nvotHlsUgkqZkgKutUPRWL5umJYi+HDh6SEhchR1DB3mSKYyP
         I8cFcm32BB3YqLTrK9W+bhBxTEzzxaOHG/YeouthBOzVxacQ8Hb8o0JkJie718OSvrD4
         Dy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ajscyTOVaw8YZXTLAGJgfFct4TdZTfjpgKzBpwv2f2k=;
        b=KhefzG6gaDAPrXnCitoYluSSCHRNCN/+7zGnGNvuOUEBPXKfgAXdyR0IkgVpyJgaD8
         PBDfG62Kc3VRAI7hhIjMs97UpbqyEcRZkQ663RK2ownYB5jPZDyHvdQ04aV1xL9ZftCq
         WAgDgD+Wt7Y0M6+Tljdz+ci2McZ/P8eB3wLY71SHyqpOldX5FGjHRUM0t6lE8ujY3Hz7
         ypMMEEmsZ69W+knfCYmbLZk3rJMcBavh2rAIm3oXeiDhMc2Yuz2K9jxqRttSRR8GXdGw
         ozqZGwSfRIV0kIOWCZXn78faVenWI6cBgtFt5xyM4DGJlO59vMsus5vbCBYPHDnjmzuW
         iL6w==
X-Gm-Message-State: APzg51A9Hc6uW0VuuzV6HmK0dwxdi9wi3P67s+8IjbKNGVZh9W0l5PHZ
        6TILw/gi18SM7AGnyVo+iUiCM9WK
X-Google-Smtp-Source: ANB0Vdb7Z7lxNkoJolnGt3O6pjcFqYSwgC6Zpc7K2XoXJe/TMgapB3DbzPKw2gnG9XvcHy0lzVEW/g==
X-Received: by 2002:a63:d806:: with SMTP id b6-v6mr34118976pgh.347.1536158796631;
        Wed, 05 Sep 2018 07:46:36 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id y3-v6sm6066958pfi.24.2018.09.05.07.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:46:35 -0700 (PDT)
Date:   Wed, 05 Sep 2018 07:46:35 -0700 (PDT)
X-Google-Original-Date: Wed, 05 Sep 2018 14:46:21 GMT
Message-Id: <b385aa2abfc0fd6ceba670d197e1d1d702b1c387.1536158789.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.34.git.gitgitgadget@gmail.com>
References: <pull.34.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 03/11] multi-pack-index: verify corrupt chunk lookup table
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
 midx.c                      |  3 +++
 t/t5319-multi-pack-index.sh | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/midx.c b/midx.c
index ec78254bb6..8b054b39ab 100644
--- a/midx.c
+++ b/midx.c
@@ -100,6 +100,9 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 		uint64_t chunk_offset = get_be64(m->data + MIDX_HEADER_SIZE + 4 +
 						 MIDX_CHUNKLOOKUP_WIDTH * i);
 
+		if (chunk_offset >= m->data_len)
+			die(_("invalid chunk offset (too large)"));
+
 		switch (chunk_id) {
 			case MIDX_CHUNKID_PACKNAMES:
 				m->chunk_pack_names = m->data + chunk_offset;
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 836d2bdb53..5c9c499aa6 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -178,6 +178,9 @@ test_expect_success 'verify bad signature' '
 MIDX_BYTE_VERSION=4
 MIDX_BYTE_OID_VERSION=5
 MIDX_BYTE_CHUNK_COUNT=6
+MIDX_HEADER_SIZE=12
+MIDX_BYTE_CHUNK_ID=$MIDX_HEADER_SIZE
+MIDX_BYTE_CHUNK_OFFSET=$(($MIDX_HEADER_SIZE + 4))
 
 test_expect_success 'verify bad version' '
 	corrupt_midx_and_verify $MIDX_BYTE_VERSION "\00" $objdir \
@@ -199,6 +202,16 @@ test_expect_success 'verify extended chunk count' '
 		"terminating multi-pack-index chunk id appears earlier than expected"
 '
 
+test_expect_success 'verify missing required chunk' '
+	corrupt_midx_and_verify $MIDX_BYTE_CHUNK_ID "\01" $objdir \
+		"missing required"
+'
+
+test_expect_success 'verify invalid chunk offset' '
+	corrupt_midx_and_verify $MIDX_BYTE_CHUNK_OFFSET "\01" $objdir \
+		"invalid chunk offset (too large)"
+'
+
 test_expect_success 'repack removes multi-pack-index' '
 	test_path_is_file $objdir/pack/multi-pack-index &&
 	git repack -adf &&
-- 
gitgitgadget

