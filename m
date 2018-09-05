Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FB661F404
	for <e@80x24.org>; Wed,  5 Sep 2018 14:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbeIETRS (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 15:17:18 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:40942 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbeIETRR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 15:17:17 -0400
Received: by mail-pl1-f180.google.com with SMTP id s17-v6so3409401plp.7
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 07:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RJHvL/ZPY6ahKdLBGEWEK2RjzJf5PeKAiCRi3dgw92A=;
        b=YAZq+aViDmV4RfppzU83yt94swah7sBfQ6joHcJ8M+9rvoaNWtxS/1NFXZiWmFrJgQ
         Md3dHIVi1zsXd0moQ8iHBfJSH78edtBA/GjiW1qL/qKwxBWS9jELaPvqTxEAyCwk1TP4
         dDmQ9mlZhmtD+XB4j0RZwD9F9nPkztm3HMgVySKt8XKCFDDqlfG2YzuF/ThpCg7qZw48
         l0s1BEf6IDc1OJ3GTBjSsDpcW0JLYEiOnEwBa8Ou5FdLZDp1jSo3ELVx6PwkxWpx+yl8
         8TDWKs7aVu2F9hZDfT6u01FotAtr69vnVeLrT8O8YiCpiblGYGAAtF4zgOiaYFyxTJNH
         Hsig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RJHvL/ZPY6ahKdLBGEWEK2RjzJf5PeKAiCRi3dgw92A=;
        b=slP7WqnT3HnL9GDOGDinSCy2oNHJH5PztNUSZuXfAYKY/ILZB3/YkY6HWSuQkifKlc
         h4WA2LxYSke8OOEEpjj1kMIRFEUzcjE0zO5hWV4EEyr0JdNChiA9SMqFSSY2/EAlZclx
         6G4V4tzzJI8rrUgIKLwuKcqm+UR3KJn1M/vmq2Z1edsYi/9eE5dyD5peQHiwvjjXpXXa
         VmOIzVFr321cWQoDHbasOC3vX39E7gzekPzuuBOl4e9xljSe54R8qKMEGi03l6mpxhyZ
         KTgRdV3KVZd1sNrpDXSNnNCWLOINi3CSJ3u/vMkVOPnlwq6QzRg8FWehyJtXz7ObA2Td
         eFLQ==
X-Gm-Message-State: APzg51A22H0KK3Jld8NRl9VezTEGSc0xGlpUiUaSqLs2743SGdd9NClG
        LXGpVltZ/xpaHolBMQmSUs/vDqIp
X-Google-Smtp-Source: ANB0VdZDeLadxiqnQOCxbQBTNObWNbGrMOTe3cjUndxvdIgcsssXlLK+7+eWOzDfSuGpO02eOOb3zA==
X-Received: by 2002:a17:902:a504:: with SMTP id s4-v6mr33124936plq.101.1536158805388;
        Wed, 05 Sep 2018 07:46:45 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id o21-v6sm4688990pfa.54.2018.09.05.07.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:46:44 -0700 (PDT)
Date:   Wed, 05 Sep 2018 07:46:44 -0700 (PDT)
X-Google-Original-Date: Wed, 05 Sep 2018 14:46:27 GMT
Message-Id: <e1498aea45eb46feb3664413f49b70bdf048d284.1536158789.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.34.git.gitgitgadget@gmail.com>
References: <pull.34.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 09/11] multi-pack-index: verify object offsets
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

The 'git multi-pack-index verify' command must verify the object
offsets stored in the multi-pack-index are correct. There are two
ways the offset chunk can be incorrect: the pack-int-id and the
object offset.

Replace the BUG() statement with a die() statement, now that we
may hit a bad pack-int-id during a 'verify' command on a corrupt
multi-pack-index, and it is covered by a test.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 28 +++++++++++++++++++++++++++-
 t/t5319-multi-pack-index.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 80094c02a7..87708dc367 100644
--- a/midx.c
+++ b/midx.c
@@ -197,7 +197,7 @@ int prepare_midx_pack(struct multi_pack_index *m, uint32_t pack_int_id)
 	struct strbuf pack_name = STRBUF_INIT;
 
 	if (pack_int_id >= m->num_packs)
-		BUG("bad pack-int-id");
+		die(_("bad pack-int-id"));
 
 	if (m->packs[pack_int_id])
 		return 0;
@@ -970,5 +970,31 @@ int verify_midx_file(const char *object_dir)
 				    i, oid_to_hex(&oid1), oid_to_hex(&oid2), i + 1);
 	}
 
+	for (i = 0; i < m->num_objects; i++) {
+		struct object_id oid;
+		struct pack_entry e;
+		off_t m_offset, p_offset;
+
+		nth_midxed_object_oid(&oid, m, i);
+		if (!fill_midx_entry(&oid, &e, m)) {
+			midx_report(_("failed to load pack entry for oid[%d] = %s"),
+				    i, oid_to_hex(&oid));
+			continue;
+		}
+
+		if (open_pack_index(e.p)) {
+			midx_report(_("failed to load pack-index for packfile %s"),
+				    e.p->pack_name);
+			break;
+		}
+
+		m_offset = e.offset;
+		p_offset = find_pack_entry_one(oid.hash, e.p);
+
+		if (m_offset != p_offset)
+			midx_report(_("incorrect object offset for oid[%d] = %s: %"PRIx64" != %"PRIx64),
+				    i, oid_to_hex(&oid), m_offset, p_offset);
+	}
+
 	return verify_midx_error;
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 072b1d1a74..b6c34631d3 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -176,6 +176,7 @@ test_expect_success 'verify bad signature' '
 '
 
 HASH_LEN=20
+NUM_OBJECTS=74
 MIDX_BYTE_VERSION=4
 MIDX_BYTE_OID_VERSION=5
 MIDX_BYTE_CHUNK_COUNT=6
@@ -192,6 +193,10 @@ MIDX_OID_FANOUT_WIDTH=4
 MIDX_BYTE_OID_FANOUT_ORDER=$((MIDX_OFFSET_OID_FANOUT + 250 * $MIDX_OID_FANOUT_WIDTH + 1))
 MIDX_OFFSET_OID_LOOKUP=$(($MIDX_OFFSET_OID_FANOUT + 256 * $MIDX_OID_FANOUT_WIDTH))
 MIDX_BYTE_OID_LOOKUP=$(($MIDX_OFFSET_OID_LOOKUP + 16 * $HASH_LEN))
+MIDX_OFFSET_OBJECT_OFFSETS=$(($MIDX_OFFSET_OID_LOOKUP + $NUM_OBJECTS * $HASH_LEN))
+MIDX_OFFSET_WIDTH=8
+MIDX_BYTE_PACK_INT_ID=$(($MIDX_OFFSET_OBJECT_OFFSETS + 16 * $MIDX_OFFSET_WIDTH + 2))
+MIDX_BYTE_OFFSET=$(($MIDX_OFFSET_OBJECT_OFFSETS + 16 * $MIDX_OFFSET_WIDTH + 6))
 
 test_expect_success 'verify bad version' '
 	corrupt_midx_and_verify $MIDX_BYTE_VERSION "\00" $objdir \
@@ -243,6 +248,16 @@ test_expect_success 'verify oid lookup out of order' '
 		"oid lookup out of order"
 '
 
+test_expect_success 'verify incorrect pack-int-id' '
+	corrupt_midx_and_verify $MIDX_BYTE_PACK_INT_ID "\07" $objdir \
+		"bad pack-int-id"
+'
+
+test_expect_success 'verify incorrect offset' '
+	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\07" $objdir \
+		"incorrect object offset"
+'
+
 test_expect_success 'repack removes multi-pack-index' '
 	test_path_is_file $objdir/pack/multi-pack-index &&
 	git repack -adf &&
@@ -310,4 +325,16 @@ test_expect_success 'verify multi-pack-index with 64-bit offsets' '
 	git multi-pack-index verify --object-dir=objects64
 '
 
+NUM_OBJECTS=63
+MIDX_OFFSET_OID_FANOUT=$((MIDX_OFFSET_PACKNAMES + 54))
+MIDX_OFFSET_OID_LOOKUP=$((MIDX_OFFSET_OID_FANOUT + 256 * $MIDX_OID_FANOUT_WIDTH))
+MIDX_OFFSET_OBJECT_OFFSETS=$(($MIDX_OFFSET_OID_LOOKUP + $NUM_OBJECTS * $HASH_LEN))
+MIDX_OFFSET_LARGE_OFFSETS=$(($MIDX_OFFSET_OBJECT_OFFSETS + $NUM_OBJECTS * $MIDX_OFFSET_WIDTH))
+MIDX_BYTE_LARGE_OFFSET=$(($MIDX_OFFSET_LARGE_OFFSETS + 3))
+
+test_expect_success 'verify incorrect 64-bit offset' '
+	corrupt_midx_and_verify $MIDX_BYTE_LARGE_OFFSET "\07" objects64 \
+		"incorrect object offset"
+'
+
 test_done
-- 
gitgitgadget

