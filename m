Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 895EB20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 16:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeLJQmw (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 11:42:52 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33069 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbeLJQmt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 11:42:49 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so5222598pgu.0
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 08:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r+N7eCFap1b53l0din4UCUTcZynEwvWN2JuO5XRzObY=;
        b=b3T2cuV6ACxydL+tizUaGo6XOn8Ea7F0m5Pv8S5KuK19C5/YeMR+1y3zgVLSgGeEC2
         zCUvxRyg+u1XzVmM2OddfYKXv5v6QoAwVKStJFaGnuy9VsXUg5XR2wJ13yHrxO32jh9n
         k8XzWJTSuRq0k1cRPxjK06Q2n1NmHLAAQQpf+Rq5daXw04RP78nZhQ5gUFSwRmx2tdpj
         rnTStTH99KsGcxmFB2ErII3wT5nMGWCZELs3KHWpXPKrMo0hz4ZPgyyDFhMWAzUi2WnS
         W0HobvsSAh0caMrkgkjA4WuAGK80Ca2f0u9ZktpeSKCFjhnQ0NSmlU/GzhLNNWRgqyPJ
         87Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r+N7eCFap1b53l0din4UCUTcZynEwvWN2JuO5XRzObY=;
        b=dSTNZfuxdcGTTLyN8XZocEY2DI1IyJ6Cd2P+HGI3XIHgvVrJDPHwvouOU4xa9dhsQC
         njgFZ4kvZfnZ2qmaYVHMDjf0MJv17RpTLwiJt9Oce0hm8DwXCWpvPA2pCr+s53m3N9yz
         fk1Sg1/w2CasA5s5XnQpz4cXEd8QaQ22jYEu/rLZesYHoH3K5+QgqmZZv5XNONrOpZP7
         3qzewZlc/kNYLbJMRkOBpQdhjkT3BqtwB/xmYJ0B8MI6QDQcr9Fx81/O0FUXa7wUhe2m
         AVmDb/vy3zDPXspt/ROMb+p/6lM7VCQX/Fw7137U8byErAwDqWqXcVEwtmoPdu2P/M1h
         cDLw==
X-Gm-Message-State: AA+aEWaip6jih4BYDGKysFWG55lO1dGSXrdmfo0QrISxQ28Cd75FDqrh
        Ify03iGug/ILICumyStEUgwuEW3M
X-Google-Smtp-Source: AFSGD/UnG+98E1enVvkcjoY0wJIdCK6AhUxhiabwBKDUuYA146QZWX60MX4CfIFycTdAfiFcTAEeQQ==
X-Received: by 2002:a62:442:: with SMTP id 63mr12802690pfe.156.1544460168678;
        Mon, 10 Dec 2018 08:42:48 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id t29sm18912300pfa.158.2018.12.10.08.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:42:48 -0800 (PST)
Date:   Mon, 10 Dec 2018 08:42:48 -0800 (PST)
X-Google-Original-Date: Mon, 10 Dec 2018 16:42:38 GMT
Message-Id: <e4f29543ee3b03c55ecd99b624f06b9bdf96ef7e.1544460159.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.v3.git.gitgitgadget@gmail.com>
References: <pull.89.v2.git.gitgitgadget@gmail.com>
        <pull.89.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 6/6] pack-objects: create GIT_TEST_PACK_SPARSE
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
