Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C9AF211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 14:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732559AbeK3B3m (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 20:29:42 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34704 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731861AbeK3B3l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 20:29:41 -0500
Received: by mail-pg1-f195.google.com with SMTP id 17so1018475pgg.1
        for <git@vger.kernel.org>; Thu, 29 Nov 2018 06:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r+N7eCFap1b53l0din4UCUTcZynEwvWN2JuO5XRzObY=;
        b=VD9KPqqQA9l0LY8OrswwUBNijBscdOD7Tq6Za+8x8wlX2pec17ukNDOtnjqD5aPwWz
         q5+SZmL7JCVgkkFo7hjZQEfa5JK1IQ+25WcrIG7KMSlG0DHcPuHapHNwcYN1UBl9e5O7
         9HTt/5DH+TeE6vyEuqyIKKvUMmuK79e0J3NVfOcrbtw+CAwKkYImMxS5pxV8Ohv/qpqU
         0Ivh+vcOJfWWL6V8lFP9GaYPjxwmg7q8hv3M+19yaTJc6YpmbtktQ9kcK/QTjP9JGnE7
         eb7wL6HW78s6+ZouwJyCpFYlB49OjqzGNEZclZwbgc+ytCTicZfR8re2qMYDRdshoQL1
         BcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r+N7eCFap1b53l0din4UCUTcZynEwvWN2JuO5XRzObY=;
        b=tgc+LkwYXwNRgiIO83gKOBXP93WUbL3fKrMUXaY/ipQStYK8lA5HXmFpYp+61gRWe4
         Y4OB59bAITbxcqd80VZmZtXr8Z8MqxJrkLaLmXv6L2fFKRii/EIsH/VNamS3lvXvpOaB
         wkWg2GCTx41zgH+i1mZ+LgqSXOLb/m03+845hUSEdXaWsivI5JBdrfyYqLn3d9K5hz6N
         jklnl5Maz7hVB218U3PAvS34coaMbWozQx8Aksmd/gYdBZtDbh2bYXfKLJB4hWsKazSc
         z3aeXXZKL/x/AEIaJAdAC7ZDKsp+S14C09JURnH9hJPzoe2C7oWyznVapMqwNXEdyJXO
         UKsQ==
X-Gm-Message-State: AA+aEWYqpxufLoEo8cSDDTKU9Q8yXBH78m8k7voxH1DH+78iCjjtXybi
        xYuOymDdTt9KVI5LEwX4VV+8Pv9o
X-Google-Smtp-Source: AFSGD/URLRjw/qEj80ZIYlTMXjXDriSoWum2xwHZrxVON7nFfi024gaWc+sN1u7xoopOIvDGoxqnAQ==
X-Received: by 2002:a63:8c0d:: with SMTP id m13mr1425738pgd.422.1543501449455;
        Thu, 29 Nov 2018 06:24:09 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id r12sm2173544pgv.83.2018.11.29.06.24.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 06:24:08 -0800 (PST)
Date:   Thu, 29 Nov 2018 06:24:08 -0800 (PST)
X-Google-Original-Date: Thu, 29 Nov 2018 14:23:58 GMT
Message-Id: <3d394a91367698c1c9bf7a0fccacc56446f39c74.1543501438.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.v2.git.gitgitgadget@gmail.com>
References: <pull.89.git.gitgitgadget@gmail.com>
        <pull.89.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 6/6] pack-objects: create GIT_TEST_PACK_SPARSE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, jrnieder@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Create a test variable GIT_TEST_PACK_SPARSE to enable the sparse
object walk algorithm by default during the test suite. Enabling
this variable ensures coverage in many interesting cases, such as
shallow clones, partial clones, and missing objects.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/pack-objects.c         | 1 +
 t/README                       | 4 ++++
 t/t5322-pack-objects-sparse.sh | 6 +++---
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 124b1bafc4..507d381153 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3331,6 +3331,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 
 	read_replace_refs = 0;
 
+	sparse = git_env_bool("GIT_TEST_PACK_SPARSE", 0);
 	reset_pack_idx_option(&pack_idx_opts);
 	git_config(git_pack_config, NULL);
 
diff --git a/t/README b/t/README
index 28711cc508..8b6dfe1864 100644
--- a/t/README
+++ b/t/README
@@ -342,6 +342,10 @@ GIT_TEST_INDEX_VERSION=<n> exercises the index read/write code path
 for the index version specified.  Can be set to any valid version
 (currently 2, 3, or 4).
 
+GIT_TEST_PACK_SPARSE=<boolean> if enabled will default the pack-objects
+builtin to use the sparse object walk. This can still be overridden by
+the --no-sparse command-line argument.
+
 GIT_TEST_PRELOAD_INDEX=<boolean> exercises the preload-index code path
 by overriding the minimum number of cache entries required per thread.
 
diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
index 8f5699bd91..e8cf41d1c6 100755
--- a/t/t5322-pack-objects-sparse.sh
+++ b/t/t5322-pack-objects-sparse.sh
@@ -36,7 +36,7 @@ test_expect_success 'setup repo' '
 '
 
 test_expect_success 'non-sparse pack-objects' '
-	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
+	git pack-objects --stdout --revs --no-sparse <packinput.txt >nonsparse.pack &&
 	git index-pack -o nonsparse.idx nonsparse.pack &&
 	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
 	test_cmp expect_objects.txt nonsparse_objects.txt
@@ -70,7 +70,7 @@ test_expect_success 'duplicate a folder from f3 and commit to topic1' '
 '
 
 test_expect_success 'non-sparse pack-objects' '
-	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
+	git pack-objects --stdout --revs --no-sparse <packinput.txt >nonsparse.pack &&
 	git index-pack -o nonsparse.idx nonsparse.pack &&
 	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
 	test_cmp expect_objects.txt nonsparse_objects.txt
@@ -102,7 +102,7 @@ test_expect_success 'non-sparse pack-objects' '
 		topic1			\
 		topic1^{tree}		\
 		topic1:f3 | sort >expect_objects.txt &&
-	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
+	git pack-objects --stdout --revs --no-sparse <packinput.txt >nonsparse.pack &&
 	git index-pack -o nonsparse.idx nonsparse.pack &&
 	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
 	test_cmp expect_objects.txt nonsparse_objects.txt
-- 
gitgitgadget
