Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 708E01F453
	for <e@80x24.org>; Wed, 30 Jan 2019 20:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731848AbfA3U5F (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 15:57:05 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42037 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387939AbfA3U4d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 15:56:33 -0500
Received: by mail-ed1-f65.google.com with SMTP id y20so773745edw.9
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 12:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=K7XMEqacsNErwgjvmp6bzVQzRfa2GXAzEYSNV9LuXmU=;
        b=gz+ArfKexIPcWfdaj8KQpY4QS/b3iWtFtqicbaBpymNe3IJgmVVN/kAdrTfZSJgEuG
         U8KPJBUVVJrwnJZCrFxk1zxrH0z762sABKogY82s+1VD+DzlNdjxvPM1d6iJhVFZmQRX
         QMpMkCDYjLL6y4d8QhRYXZKwOUytEImvnQaGi1rNjRQaURyPZsV+EhAFSTpv8YktCPcs
         odQTFSKS3XvqcJxm/yZK1ieXtparhzamB25KJSZ1tUonNL7r8XckiVUEySl6N8CWG7ic
         y+pKW165hRYKPC10vKaM+BoqbXoput5Br+YVn+1GFmBmRx9aUiu1+WSN6RlrQt2hlIzY
         z/Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=K7XMEqacsNErwgjvmp6bzVQzRfa2GXAzEYSNV9LuXmU=;
        b=nVelMeTzK880CU4dQ9Iz6ntiPRozMuDyu/gKQPMC6xRGw9tJGllO2B4fW6aNrGzqgN
         O8nk/5fjYrkgUCM8PY4jnhAjgzih/kjCOF52iTjpAf2IsvJkCCEJQPKgyP5UmylAb8K/
         gJzNGa4IGItYPtahMIsPu+4jWZ0KTvJlT0BNpa5KisoKYiWv52Xs4cxzNjQgwiBb31Sm
         e+sKyK9X7sNyAsz+xmCpKmB2t4WxZnZcuOvMGtt4UVvka8mBHKJe0YpVhx6KQkPmVfHP
         LZxACsTdq+3ngWLzyQRoJI5R2ZWbfLJjuGD0iFWLITXal8bmWzM6OkylvqIDlfAdSaJQ
         9Qng==
X-Gm-Message-State: AJcUukfD5jFbBQHMnzntM7nSyoPa00+FrMvcBRKTXXU0QFBL+WRqYn3h
        0ttl02c/IP5SvxxaRz4eDpPw4oXD
X-Google-Smtp-Source: ALg8bN7ke2G/xADYy2HRtVtFkTHMaBO/EmLo0u5SdhOTeOVtirRpLAre0EyRi9g5kCmJTliXIs5sCw==
X-Received: by 2002:a17:906:d29b:: with SMTP id ay27mr18371836ejb.119.1548881790913;
        Wed, 30 Jan 2019 12:56:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8-v6sm471357ejy.34.2019.01.30.12.56.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 12:56:30 -0800 (PST)
Date:   Wed, 30 Jan 2019 12:56:30 -0800 (PST)
X-Google-Original-Date: Wed, 30 Jan 2019 20:56:15 GMT
Message-Id: <be707ea9600a86d349471be00829c924ce99b035.1548881779.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v4.git.gitgitgadget@gmail.com>
References: <pull.108.v3.git.gitgitgadget@gmail.com>
        <pull.108.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 10/14] pack-objects: add trace2 regions
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

