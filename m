Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D602F1F454
	for <e@80x24.org>; Tue, 16 Oct 2018 21:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeJQEzI (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 00:55:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36763 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQEzH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 00:55:07 -0400
Received: by mail-pl1-f193.google.com with SMTP id y11-v6so11585136plt.3
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 14:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IgwtKBxE28CYX6zEdezl6YM+t3YaWTQTEqV7cWdAc6M=;
        b=JmQKJjgCCyQRbuJ8Q45rVUgIeGmc0IMGxtAPTp9iPuBTnzCZQ4awX3sRcj/5kgR2NZ
         UGyEAeeYvi9mJE9kQlW4sW1V4td2Zb8VM0qaGSO9bpuMLoqhLFUBNlWYqYy2HvCug31h
         3p60unVyd+R9RFy8uyZpuvxUozm7pCfIjlLH/3hlG0n3jeLsA8sNEHGGUBEqErkOZL7L
         iOHn+ogodpKfQMpULGdPsNgzOLQbrarbV8rQtkUoqXwF23HIHnuuabJTIdHt2386u38e
         Eu+xKV6NdBvikCs1OY6irM92+RF1nW9QB7lp2J2+bl06eWDfzpvA++nU8xxHU1tYuVsl
         oTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IgwtKBxE28CYX6zEdezl6YM+t3YaWTQTEqV7cWdAc6M=;
        b=Vsd4qivz/3t4r+fwvGH/Lcuwe9o1Acgbt/7mrRPZvKZjeuf4Q1fF+8k/2Ny/c5q5QE
         ZYqGZR+cyEMGUW4OG3rEY2FJwzsGuOWeApLovzgdKiQoq5L4uUVL0A33Qo+ABYJ4XmIA
         nKlSiF0ht6GZqp7fAb0RNwFO0MhR2QXI3sArl7KqHdnxdSJJAa3kWQNmDy23KhfG/9CD
         aG3qP55HHXq6BgaJrN+dZEQGH+mdCe/s57p5RA4XijBwUWBiq7vWao7ioutNnza+15m/
         iwS6q/vTDrPUtoleDHpsRqYbiCbM/ayKGsbSq4aiRwG73f8pBaNkyA/9BPm5lWUWaJi4
         9Ubg==
X-Gm-Message-State: ABuFfogDDssZvExiSdHFNM23GD8t8QF79fSY353+luEshzDrqVbmxk3H
        JcFu0bJvZCZtR5zZyx9moOMNS6sD
X-Google-Smtp-Source: ACcGV63Ha+Jc+B/wCuwxzx7Ah9KiWRmCIIoTu4FuxBeeMWCGEvYk/UrsEUqBiB/GUyXA02DFVxogkg==
X-Received: by 2002:a17:902:66e6:: with SMTP id e93-v6mr23332998plk.128.1539723773296;
        Tue, 16 Oct 2018 14:02:53 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id k185-v6sm29145458pgd.2.2018.10.16.14.02.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 14:02:52 -0700 (PDT)
Date:   Tue, 16 Oct 2018 14:02:52 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Oct 2018 21:02:45 GMT
Message-Id: <8979693922364ef2e4a84a29298b081e86fa9ffa.1539723766.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.47.git.gitgitgadget@gmail.com>
References: <pull.47.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/3] pack-objects (mingw): initialize `packing_data` mutex in
 the correct spot
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 9ac3f0e5b3e4 (pack-objects: fix performance issues on packing large
deltas, 2018-07-22), a mutex was introduced that is used to guard the
call to set the delta size. This commit even added code to initialize
it, but at an incorrect spot: in `init_threaded_search()`, while the
call to `oe_set_delta_size()` (and hence to `packing_data_lock()`) can
happen in the call chain `check_object()` <- `get_object_details()` <-
`prepare_pack()` <- `cmd_pack_objects()`, which is long before the
`prepare_pack()` function calls `ll_find_deltas()` (which initializes
the threaded search).

Another tell-tale that the mutex was initialized in an incorrect spot is
that the function to initialize it lives in builtin/, while the code
that uses the mutex is defined in a libgit.a header file.

Let's use a more appropriate function: `prepare_packing_data()`, which
not only lives in libgit.a, but *has* to be called before the
`packing_data` struct is used that contains that mutex.

This fixes https://github.com/git-for-windows/git/issues/1839.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pack-objects.c        | 1 -
 pack-objects.c                | 3 +++
 t/t5321-pack-large-objects.sh | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e6316d294d..e752cf9c7a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2363,7 +2363,6 @@ static void init_threaded_search(void)
 	pthread_mutex_init(&cache_mutex, NULL);
 	pthread_mutex_init(&progress_mutex, NULL);
 	pthread_cond_init(&progress_cond, NULL);
-	pthread_mutex_init(&to_pack.lock, NULL);
 	old_try_to_free_routine = set_try_to_free_routine(try_to_free_from_threads);
 }
 
diff --git a/pack-objects.c b/pack-objects.c
index 7e624c30eb..b6cdbb0166 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -148,6 +148,9 @@ void prepare_packing_data(struct packing_data *pdata)
 					     1U << OE_SIZE_BITS);
 	pdata->oe_delta_size_limit = git_env_ulong("GIT_TEST_OE_DELTA_SIZE",
 						   1UL << OE_DELTA_SIZE_BITS);
+#ifndef NO_PTHREADS
+	pthread_mutex_init(&pdata->lock, NULL);
+#endif
 }
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
diff --git a/t/t5321-pack-large-objects.sh b/t/t5321-pack-large-objects.sh
index c36c66fbb4..a75eab87d3 100755
--- a/t/t5321-pack-large-objects.sh
+++ b/t/t5321-pack-large-objects.sh
@@ -24,7 +24,7 @@ test_expect_success 'setup' '
 	git index-pack --stdin <ab.pack
 '
 
-test_expect_failure 'repack large deltas' '
+test_expect_success 'repack large deltas' '
 	printf "%s\\n" $A $B |
 	GIT_TEST_OE_DELTA_SIZE=2 git pack-objects tmp-pack
 '
-- 
gitgitgadget
