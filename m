Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D23FF1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 17:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbfBAR7W (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 12:59:22 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34362 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730936AbfBAR7J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 12:59:09 -0500
Received: by mail-ed1-f67.google.com with SMTP id b3so6198065ede.1
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 09:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K7XMEqacsNErwgjvmp6bzVQzRfa2GXAzEYSNV9LuXmU=;
        b=dVuQMEehB8N6uStck9mS7lIHBabsS0lA4KJ1Z34ln0wjI+eeIknKc1ODd1kzYIfxtj
         vdJvoi9xBpE6+dANAhXsXegNg6ovl+n08Q6hv0SHF8qJXb3OspAK3rKBw32+LerN/ICX
         6LkCrhzoo7AisIMnnmYruentJRoFIlmQu1NEMxhSbdwe4sdV0w3kFk0xtiMd6V90Lj0N
         F3YU2j0dD5GszIyCnPw7kS1yYDWQFodLpge+FfD/LmkOqi39YGbDxNrPR5zUdIXH8Oj1
         6E9+tFNnmxAqK+JPLIVI+3C1b00O4TqUd/Dk5r76FvPvu57w8Jv7Hv8Ps/D+a2Cv035b
         pYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K7XMEqacsNErwgjvmp6bzVQzRfa2GXAzEYSNV9LuXmU=;
        b=BKW7Nh1mJUL5HWLM9S4TjTwuT69vO9QngCpm9sdfgiDPeutHd17cOZp1Fepv/DiJyN
         Y8+yz5Tslyso2ssoJvedwGpxxcI6QxJpEF9aF8RT5yGCaJRc0c0AJ9l/m/OEHsD8Qyqm
         OF87Q202tJVTEbdfJCwR/lYEkgA+4dkOq885O9Fd4kKScWDnZBDhJl2l9whoPo1SDJ6Q
         OE1cUy8fiIUB5oInzYQOf+1/FJda/6gj7+9dkprQ3YxLVRPzhSMxw+2xNMTcuu2i8vus
         fHSi9+N/N+tZ5p3gKEMWsIlGnhwWmSxg1lBZPJPpE23mOnPBiH1l6Wxlw8hU0r3Y71bE
         Q+SA==
X-Gm-Message-State: AJcUukf4YSOw5MZ3A4Bg2giK9uZF8NtF4Sr8vCn/WwWkBor//qF5pKN9
        +knb8GpY4EUySbFGKPiqQFxuK5j5
X-Google-Smtp-Source: ALg8bN4ruZrKUYGpJyzp8wtrd8lGqJLzFQdNEG3HH+ferg7GSjNP+jche5LCnPyyg19Mt+GHr/cqfg==
X-Received: by 2002:a50:8bc9:: with SMTP id n9mr40145300edn.41.1549043947798;
        Fri, 01 Feb 2019 09:59:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 24sm2240857eds.97.2019.02.01.09.59.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 09:59:07 -0800 (PST)
Date:   Fri, 01 Feb 2019 09:59:07 -0800 (PST)
X-Google-Original-Date: Fri, 01 Feb 2019 17:58:51 GMT
Message-Id: <ab74ef5f23676e48db29f08cb9e864fb3afb408c.1549043936.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v5.git.gitgitgadget@gmail.com>
References: <pull.108.v4.git.gitgitgadget@gmail.com>
        <pull.108.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 10/15] trace2:data: pack-objects: add trace2 regions
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When studying the performance of 'git push' we would like to know
how much time is spent at various parts of the command. One area
that could cause performance trouble is 'git pack-objects'.

Add trace2 regions around the three main actions taken in this
command:

1. Enumerate objects.
2. Prepare pack.
3. Write pack-file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 builtin/pack-objects.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 0a70d04604..8a64c2868e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -33,6 +33,7 @@
 #include "object-store.h"
 #include "dir.h"
 #include "midx.h"
+#include "trace2.h"
 
 #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
 #define SIZE(obj) oe_size(&to_pack, obj)
@@ -3472,6 +3473,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	trace2_region_enter("pack-objects", "enumerate-objects",
+			    the_repository);
 	prepare_packing_data(the_repository, &to_pack);
 
 	if (progress)
@@ -3486,12 +3489,23 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (include_tag && nr_result)
 		for_each_ref(add_ref_tag, NULL);
 	stop_progress(&progress_state);
+	trace2_region_leave("pack-objects", "enumerate-objects",
+			    the_repository);
 
 	if (non_empty && !nr_result)
 		return 0;
-	if (nr_result)
+	if (nr_result) {
+		trace2_region_enter("pack-objects", "prepare-pack",
+				    the_repository);
 		prepare_pack(window, depth);
+		trace2_region_leave("pack-objects", "prepare-pack",
+				    the_repository);
+	}
+
+	trace2_region_enter("pack-objects", "write-pack-file", the_repository);
 	write_pack_file();
+	trace2_region_leave("pack-objects", "write-pack-file", the_repository);
+
 	if (progress)
 		fprintf_ln(stderr,
 			   _("Total %"PRIu32" (delta %"PRIu32"),"
-- 
gitgitgadget

