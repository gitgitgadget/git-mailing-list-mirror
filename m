Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4566A1F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 20:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbfJGUIu (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 16:08:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38543 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbfJGUIp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 16:08:45 -0400
Received: by mail-wr1-f65.google.com with SMTP id w12so16789784wro.5
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 13:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2/RiKsLEZuFAOBKmD6Jycsmp4Qyoqc0WA9U5nvYCt4U=;
        b=p8BDWCA0W3kTHh/u1WqKWQQTzuc+qFM8qSGVSkQTsp6HOWylEVYufgO4g3xUNB3NX3
         lETvthKtCE+3vALiEjii5/3CSR3APmXjaN7YM6EabKd2azlKb7bkP0KDQY2IZmkTOUtL
         +DSpCpQcpUgppyxNoImAU6kAMjq/chTBYVR5D80kEeNpMV6LPKJ189QhdqYbxr/L62sV
         QXYbPwXn/yhfkuOKpmDQgZ/IMkl2m8C7jALZig5jJRfM6+gPuWCd1X4/QZCGNv3uaGjB
         UKVURPQ6cyxFCwQp8iIO2dbB++Epu1xI15N70tvq7GsgDdNsXUq/Rp0UUcN88WF6gRGj
         6U/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2/RiKsLEZuFAOBKmD6Jycsmp4Qyoqc0WA9U5nvYCt4U=;
        b=otCyvXf9s2ykzYrJhs8sMUQ6R6/pEvUKHLROw7fK0Kb1vMU022+R4U5Fy1kYg4kSeq
         GBVkIiP6DlAeoex3WTPpijFrnncoGNtk8a3HPcb5POBY0Nq7NxB+51ijCj1sS1D2y7a/
         sP1ap5T8fZbffUmcp6Mdqp9og59lsyt+ga11soog8kVLrfqkztTIGmC8A8qHnuOujF0Y
         RcoH6v643ZFrVtLQuQ6ksrGnz/YZGtq5vVkFSkZcINLFnXOFlMRU1TyX2qBqjvcn1nR+
         QiJe0LxH6lPGK+36MxOLwpDbpMou71i06gEjwQGkzjRsJad87U82fA+WPZZ3LyQqeSFj
         DcyQ==
X-Gm-Message-State: APjAAAVPmwYmEDj5FgZxsXTMk/1YLxH+B3OspudankbsqXyoYVqkVU5B
        ksJUjtVk0OrNLgiOsZPaPh0jb5bE
X-Google-Smtp-Source: APXvYqwH5sWkfuvo7kRs4ItFj9R4ZkF9fxjAB4MHasvolduqVsPVGUfVZFMZTOoi2oA36xkDpAHn4w==
X-Received: by 2002:adf:f112:: with SMTP id r18mr23493467wro.88.1570478921491;
        Mon, 07 Oct 2019 13:08:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5sm28905433wrs.54.2019.10.07.13.08.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 13:08:40 -0700 (PDT)
Date:   Mon, 07 Oct 2019 13:08:40 -0700 (PDT)
X-Google-Original-Date: Mon, 07 Oct 2019 20:08:22 GMT
Message-Id: <56444a5498c8194186d294b3128d0ffdb3678296.1570478905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v3.git.gitgitgadget@gmail.com>
References: <pull.316.v2.git.gitgitgadget@gmail.com>
        <pull.316.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 14/17] sparse-checkout: sanitize for nested folders
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If a user provides folders A/ and A/B/ for inclusion in a cone-mode
sparse-checkout file, the parsing logic will notice that A/ appears
both as a "parent" type pattern and as a "recursive" type pattern.
This is unexpected and hence will complain via a warning and revert
to the old logic for checking sparse-checkout patterns.

Prevent this from happening accidentally by sanitizing the folders
for this type of inclusion in the 'git sparse-checkout' builtin.
This happens in two ways:

1. Do not include any parent patterns that also appear as recursive
   patterns.

2. Do not include any recursive patterns deeper than other recursive
   patterns.

In order to minimize duplicate code for scanning parents, create
hashmap_contains_parent() method. It takes a strbuf buffer to
avoid reallocating a buffer when calling in a tight loop.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 22 ++++++++++++++++++----
 t/t1091-sparse-checkout-builtin.sh | 11 +++++++++++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index b220f15741..25786f8bb0 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -212,10 +212,18 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 	struct pattern_entry *entry;
 	struct hashmap_iter iter;
 	struct string_list sl = STRING_LIST_INIT_DUP;
+	struct strbuf parent_pattern = STRBUF_INIT;
 
 	hashmap_iter_init(&pl->parent_hashmap, &iter);
-	while ((entry = hashmap_iter_next(&iter)))
-		string_list_insert(&sl, entry->pattern);
+	while ((entry = hashmap_iter_next(&iter))) {
+		if (hashmap_get(&pl->recursive_hashmap, entry, NULL))
+			continue;
+
+		if (!hashmap_contains_parent(&pl->recursive_hashmap,
+					     entry->pattern,
+					     &parent_pattern))
+			string_list_insert(&sl, entry->pattern);
+	}
 
 	string_list_sort(&sl);
 	string_list_remove_duplicates(&sl, 0);
@@ -232,8 +240,14 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 	string_list_clear(&sl, 0);
 
 	hashmap_iter_init(&pl->recursive_hashmap, &iter);
-	while ((entry = hashmap_iter_next(&iter)))
-		string_list_insert(&sl, entry->pattern);
+	while ((entry = hashmap_iter_next(&iter))) {
+		if (!hashmap_contains_parent(&pl->recursive_hashmap,
+					     entry->pattern,
+					     &parent_pattern))
+			string_list_insert(&sl, entry->pattern);
+	}
+
+	strbuf_release(&parent_pattern);
 
 	string_list_sort(&sl);
 	string_list_remove_duplicates(&sl, 0);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index db6371b079..ee4d361787 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -234,4 +234,15 @@ test_expect_success 'cone mode: init and set' '
 	test_cmp expect dir
 '
 
+test_expect_success 'cone mode: set with nested folders' '
+	git -C repo sparse-checkout set deep deep/deeper1/deepest 2>err &&
+	test_line_count = 0 err &&
+	cat >expect <<-EOF &&
+		/*
+		!/*/
+		/deep/
+	EOF
+	test_cmp repo/.git/info/sparse-checkout expect
+'
+
 test_done
-- 
gitgitgadget

