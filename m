Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3A571F404
	for <e@80x24.org>; Thu, 13 Sep 2018 18:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbeIMXMx (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 19:12:53 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46336 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbeIMXMw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 19:12:52 -0400
Received: by mail-pl1-f196.google.com with SMTP id t19-v6so2929261ply.13
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 11:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o3OAjBe90g2czbSgAa3sycpVXfAWdcSWAqf+wUf4GBo=;
        b=ILyacLPdLw44UeDzIprXBSt60HgFjRWyu0BxtsjqJ3VNHnNRBilscGfTW0+MJdC6Yr
         NyRGXMGZhbx++/LzY0VSq1XQFtUcPnIj5oeqIWrrisDNP/pVUMkXZX/c0FluZ9vqYsQU
         RBcw7ZSri6pncFMLgbmTEF0PHe1psyFwVR23hLv1iO2hsmXScKDwtY6XQh4+UurY78IB
         RpVp4yll6kOicD0oo2mhRuUldXr9BeW8nSkacclov+vBOeDz0MEN8iZXCYV9i++7+qsw
         sfteSrU40ITsWG0OyqLM906ZWwstgptXGLKqpxX4iCAlEAucLbq3wFFtmF8j0WV5RSDV
         ZptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o3OAjBe90g2czbSgAa3sycpVXfAWdcSWAqf+wUf4GBo=;
        b=fl33ARt5SHF2WTEPsMc+OUaCgZbE+wMWTlkYXJ89hA+uM4809/HMC/RhB8NwcBYm8V
         pj4N75D65ZJFO355YPuI59ga0WbmhOaFZmgvjmVM3D5zMw09ALM8nM3UTIiFrjwKZjHA
         VT5Yhg+2jiXC3hGkeSFPmwSIoHgRwOxTizq6yN3s78TJ7WGYMxl1uj/+cRoduXVRa+Xy
         ncwiAKdqwtlovD363sgd8TdljZtLwnuPvzMjuqTR12QfMSwnezAhRIkGnU4Kr53Yao31
         zK8lyHqGJjzD3uEahFNiVIeUDNbs2ycBiBJahJ8RuOCDZoNh9nnGnX6q0iYdCw0dcsJo
         oe9w==
X-Gm-Message-State: APzg51DoUtn6BMolBST0twCKpdkVLRQ7nziXaGhfUxHGmKWjCknVmYpU
        WlxRy1Bv1H66QdsbKZO+agbpPUf/
X-Google-Smtp-Source: ANB0VdYuxXuTx/JqhFx5281GQW8X9bR9tSWibLn1Pkm7At0TPvty2vhY/9EMQxZ3UqvdCNNwj8gyrA==
X-Received: by 2002:a17:902:c6:: with SMTP id a64-v6mr8386673pla.180.1536861737507;
        Thu, 13 Sep 2018 11:02:17 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id g11-v6sm6492316pgi.90.2018.09.13.11.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 11:02:16 -0700 (PDT)
Date:   Thu, 13 Sep 2018 11:02:16 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Sep 2018 18:02:02 GMT
Message-Id: <24481738444bf7da90dddff700dc69d653c440fb.1536861730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.34.v2.git.gitgitgadget@gmail.com>
References: <pull.34.git.gitgitgadget@gmail.com>
        <pull.34.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 03/11] multi-pack-index: verify corrupt chunk lookup table
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
index e04b5f43a2..c54b6e7188 100755
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

