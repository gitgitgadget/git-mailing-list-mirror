Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6487E1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 18:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeIMXM4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 19:12:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46165 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeIMXMz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 19:12:55 -0400
Received: by mail-pf1-f194.google.com with SMTP id u24-v6so3008242pfn.13
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 11:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fKSvQdjUtWWxX7coJ2C4/0Pu3cG+W/VEg3VG0pvoWYE=;
        b=c6h9bMACJWN0/l6X9gurdZcnqvDJ79nOoK9kK+Z7q04yc8SnY0cjvfe7fLtKXl8gyW
         cwhKbHryBzBVUNVaRqb1UVS8wniOeyJcGVrYomYYQU4FntPuaYAApfnw3k79uylQVRxa
         Sn0Ln4R+YZYss2kutoaHfP200aQFKcx6dOKI82oDw/Ppg4sXdNNRWl3CfuzsC+EuQKKy
         iJ7EFdXoyJg38tluffP0nMUVUzQSWIKblRLX83OyzB6OfdMcB6UW1EoZ1kfDCgYspMzY
         xk2Yfr58owADoH4DFNBfX8d51J+sHP7nurZH36qdnGBFnLeD/itiPgAKMh5jYM3S14vS
         MGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fKSvQdjUtWWxX7coJ2C4/0Pu3cG+W/VEg3VG0pvoWYE=;
        b=hbb34G/lheAim8gAOOk7aesu0iKFNBGP0jRRGuJWNao3TRXDkVcY4T58P5Lo5hTq7Q
         xrPmhk3NjN3P6Og7qll3ZM5I3i6j76geypgiJYAxNU5s3QHVQX5+rmFn5sllMNZ6XlYD
         8HZYvhZ88jcSrUmxDK2BGDTgnWSpldHu9fuf1baYi/3FJFTGa6eYtqLBQcZowI8y1Du3
         yJa4T0tbxqNXSHHbSqi4DRKl7vBYYQ5Ycd8yJ8VEmH8g3GRmZ2NMZPMchpjF8BmqOKPB
         5CwgbO7uaZRoZc2ZkdXIhoy6pXlV8qAUn1xW77nL7ysZSdieVUkw9VwpDbfdPv+399p6
         ipdw==
X-Gm-Message-State: APzg51AFjZqT50i1qJosOb5cfUuSYrwswxc+6kR4BazyNm5A08rCzOhc
        +JdbJe4xBJxz1N3v7M5uO6/6YBca
X-Google-Smtp-Source: ANB0VdZe8w91swTYWncHvRWApos0Ud6zJvl4Exi+VUa0qnoESzLvvND4zKJ5zvSsadkyUscWcvgeYg==
X-Received: by 2002:a63:df4e:: with SMTP id h14-v6mr8118472pgj.300.1536861740297;
        Thu, 13 Sep 2018 11:02:20 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id o20-v6sm13844574pfj.35.2018.09.13.11.02.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 11:02:19 -0700 (PDT)
Date:   Thu, 13 Sep 2018 11:02:19 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Sep 2018 18:02:04 GMT
Message-Id: <405886738002e60b9f72d6edb10e4929c9493374.1536861730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.34.v2.git.gitgitgadget@gmail.com>
References: <pull.34.git.gitgitgadget@gmail.com>
        <pull.34.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 05/11] multi-pack-index: verify missing pack
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
 midx.c                      | 16 ++++++++++++++++
 t/t5319-multi-pack-index.sh |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/midx.c b/midx.c
index e655a15aed..a02b19efc1 100644
--- a/midx.c
+++ b/midx.c
@@ -926,13 +926,29 @@ void clear_midx_file(const char *object_dir)
 
 int verify_midx_error;
 
+static void midx_report(const char *fmt, ...)
+{
+	va_list ap;
+	verify_midx_error = 1;
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	fprintf(stderr, "\n");
+	va_end(ap);
+}
+
 int verify_midx_file(const char *object_dir)
 {
+	uint32_t i;
 	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
 	verify_midx_error = 0;
 
 	if (!m)
 		return 0;
 
+	for (i = 0; i < m->num_packs; i++) {
+		if (prepare_midx_pack(m, i))
+			midx_report("failed to load pack in position %d", i);
+	}
+
 	return verify_midx_error;
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 01a3cd6b00..0a566afb05 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -222,6 +222,11 @@ test_expect_success 'verify packnames out of order' '
 		"pack names out of order"
 '
 
+test_expect_success 'verify packnames out of order' '
+	corrupt_midx_and_verify $MIDX_BYTE_PACKNAME_ORDER "a" $objdir \
+		"failed to load pack"
+'
+
 test_expect_success 'repack removes multi-pack-index' '
 	test_path_is_file $objdir/pack/multi-pack-index &&
 	git repack -adf &&
-- 
gitgitgadget

