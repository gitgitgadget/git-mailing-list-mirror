Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03D311F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 18:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfAPS0F (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 13:26:05 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36716 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728703AbfAPS0E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 13:26:04 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so6244578edb.3
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 10:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6GgFDx9hOsN360eMe2J+Y2gcVJumziVh389IgdvoVIs=;
        b=MC8PkTyzTZgCvU2im+UZp/9kUHnzur/Mv2o8hqWrUwe0EdrcNoSrKNSnAyzKZhr3o5
         KZ+XspxKpfpDvp5YbUUSsiPXrXeWdqpQWDwvvGpsT/4t1mmFuMB5v+zKB2jCajdynxiq
         vZpfxz/+xmmPBrOdXMK0id96iLrofRCgvUyohX/DAmnQp+xSuh6Af7O9arYS1K4CLYXG
         VubyveEp50XVzldyWeZYISfaO6eAirYvNnkEM64yvfoaVRw6YI8i6JJDueML4gz01RO3
         cY/4tZYReIOWKbctE2mqN5+DoSlX8CZU0+jE95UzxabCyoxesFaxOu6mPgJ8vAeV922w
         IYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6GgFDx9hOsN360eMe2J+Y2gcVJumziVh389IgdvoVIs=;
        b=aIfcGQj2Us06lOwWE7lQsQCeVV3CCsq1FP2/vDKabThIHrQsLRP5Yqa5VzL++vwZ9C
         bMJueI5Xt/tRVKKl0Ot+eU2TfvIZ0GuJLnzrvtwu/VTFOuMSkcZbNDMbDpQ9svEfecYE
         +Xzlu0h3yySA6pkHJUKKsD8kTBCvWT6UDu5dZbNqL2VkQiq21C7fP75/uNBeB/axv9WH
         oX98JAbTTxVW3TZWCmcLb+mopo5I46eVfcYP3ti94MiZeJaVSQjo78dHbCPKRjpUWwrY
         YGnJ0XiLhUa4+Hw9Iz6E4MQqMP4xCT1CKhxnd81NZEWD4YahAhWtmqbZKTnqT2vtLEzV
         uu3Q==
X-Gm-Message-State: AJcUukc8q36iUhZ+MuGvAelJX6uiIhFZDWJIxYLOkzuLe29rpQDLX8ju
        dKz8RLOzW38VFkui2l6DXA2uXXC9
X-Google-Smtp-Source: ALg8bN7VmjJ9YRvJKBcdRRPTP4jqEHzkWTo2KuwpeWniFede0lMARHIbG/MkWDRAAhN2tQ1jVF54Eg==
X-Received: by 2002:a17:906:2452:: with SMTP id a18-v6mr7831096ejb.17.1547663162295;
        Wed, 16 Jan 2019 10:26:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i24sm5533565edq.0.2019.01.16.10.26.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 10:26:01 -0800 (PST)
Date:   Wed, 16 Jan 2019 10:26:01 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 18:25:55 GMT
Message-Id: <ae046e85254d2a23cefca42b111695e6db28791c.1547663156.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.v5.git.gitgitgadget@gmail.com>
References: <pull.89.v4.git.gitgitgadget@gmail.com>
        <pull.89.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 5/5] pack-objects: create GIT_TEST_PACK_SPARSE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, jrnieder@gmail.com,
        ramsay@ramsayjones.plus.com, Junio C Hamano <gitster@pobox.com>,
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
 t/t5322-pack-objects-sparse.sh | 4 ++--
 3 files changed, 7 insertions(+), 2 deletions(-)

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
index 3233fafc90..7124b5581a 100755
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
@@ -64,7 +64,7 @@ test_expect_success 'duplicate a folder from f3 and commit to topic1' '
 '
 
 test_expect_success 'non-sparse pack-objects' '
-	git pack-objects --stdout --revs <packinput.txt >nonsparse.pack &&
+	git pack-objects --stdout --revs --no-sparse <packinput.txt >nonsparse.pack &&
 	git index-pack -o nonsparse.idx nonsparse.pack &&
 	git show-index <nonsparse.idx | awk "{print \$2}" >nonsparse_objects.txt &&
 	comm -1 -2 required_objects.txt nonsparse_objects.txt >nonsparse_required_objects.txt &&
-- 
gitgitgadget
