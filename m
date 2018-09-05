Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81E451F404
	for <e@80x24.org>; Wed,  5 Sep 2018 14:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeIETRT (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 15:17:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37782 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727568AbeIETRS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 15:17:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id 2-v6so3561803pgo.4
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 07:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Or8AAC9vbSBoRUx0e9xkFt1GmCxv4zUk+gKpVwsj9fM=;
        b=cNNMpDS6wTODPhdLdqVBUFrYf3ARpGxvZybbbYEZy0jNG5bx4P+pbn4vjhUZKWFFrG
         OtUWMnUK8onzENopGnKah8R1rV6OmusJh0fJ4Qw2bSHObWXI1K94ITEdIedS8KEBEXp5
         lJ0iGqVtedV0oYthsNjVv+5yqy+oNWvnqZSuMJis/XKHo2P+oq/WvUqBJkZG+lMW8Bt8
         XZMzWgL8mBsHPausYyifSCqhvO0bMzd7ttVKcuSY86bfhLRAuKpvlQJsDlPtKRGhOG4M
         yc5w8vGIN19+n5rkgmep36d8qcucqVaDiOEOE8APIYrl4bpzMdPUjr/lT8O6QTxb6d7L
         YJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Or8AAC9vbSBoRUx0e9xkFt1GmCxv4zUk+gKpVwsj9fM=;
        b=UgoIWyZLS/UCF1NNzodQAjgrwXR/eRlW0RGHjJbZMQILSms2yXUiPTaUz3FthdD5Sz
         9QPjgUHf3YMKxrSsgpSS8lTRFK8NVOY4tkwvzVcJeRs4ALLWginWpRH0CJkQEkFGTzJS
         uX+TEXjmzp5zV5ENBv8Xn/iD4csfOVngKwZSv0toFP5ovGciE0csCSL6I0ITNLPHTAlL
         uV1sTaPHttc8kEe8APdxHQF3sDkiBU8FeZd8TlaWCfn1Z26nsw99NnVbU/Qhp9YEmnuD
         K9C5l7G1eZ5R+XhbfqMggOAZfi6YpqK/bkZQKrtyLE+3Yi8cL4r8rKUGiF/GlerlXvdv
         kYkA==
X-Gm-Message-State: APzg51AVQsoXv1/Qb1WRgQ7OVKwpMjFzE3Ru16PQ93Xya3nIsEAUaj/H
        ohFQYBbRiPdez+XMay/lvaacrYgF
X-Google-Smtp-Source: ANB0VdZ0tqaz1fdRqBKxSyVozalymcOsC4qf3NGYNcbYQl7odWKuhiz30P85ncSnSC3+f0ErdRQO8w==
X-Received: by 2002:a63:3741:: with SMTP id g1-v6mr13966677pgn.59.1536158806985;
        Wed, 05 Sep 2018 07:46:46 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id y3-v6sm6067482pfi.24.2018.09.05.07.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:46:46 -0700 (PDT)
Date:   Wed, 05 Sep 2018 07:46:46 -0700 (PDT)
X-Google-Original-Date: Wed, 05 Sep 2018 14:46:28 GMT
Message-Id: <acf8cfd6328deac07d1559c906505d3c0fd0b0c2.1536158789.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.34.git.gitgitgadget@gmail.com>
References: <pull.34.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 10/11] multi-pack-index: report progress during 'verify'
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

When verifying a multi-pack-index, the only action that takes
significant time is checking the object offsets. For example,
to verify a multi-pack-index containing 6.2 million objects in
the Linux kernel repository takes 1.3 seconds on my machine.
99% of that time is spent looking up object offsets in each of
the packfiles and comparing them to the multi-pack-index offset.

Add a progress indicator for that section of the 'verify' verb.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/midx.c b/midx.c
index 87708dc367..489180a599 100644
--- a/midx.c
+++ b/midx.c
@@ -7,6 +7,7 @@
 #include "object-store.h"
 #include "sha1-lookup.h"
 #include "midx.h"
+#include "progress.h"
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION 1
@@ -939,6 +940,7 @@ static void midx_report(const char *fmt, ...)
 int verify_midx_file(const char *object_dir)
 {
 	uint32_t i;
+	struct progress *progress = NULL;
 	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
 	verify_midx_error = 0;
 
@@ -970,6 +972,7 @@ int verify_midx_file(const char *object_dir)
 				    i, oid_to_hex(&oid1), oid_to_hex(&oid2), i + 1);
 	}
 
+	progress = start_progress(_("Verifying object offsets"), m->num_objects);
 	for (i = 0; i < m->num_objects; i++) {
 		struct object_id oid;
 		struct pack_entry e;
@@ -994,7 +997,10 @@ int verify_midx_file(const char *object_dir)
 		if (m_offset != p_offset)
 			midx_report(_("incorrect object offset for oid[%d] = %s: %"PRIx64" != %"PRIx64),
 				    i, oid_to_hex(&oid), m_offset, p_offset);
+
+		display_progress(progress, i + 1);
 	}
+	stop_progress(&progress);
 
 	return verify_midx_error;
 }
-- 
gitgitgadget

