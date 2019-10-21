Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1B4B1F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 13:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbfJUN4q (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 09:56:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37656 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbfJUN4l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 09:56:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id e11so5406259wrv.4
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 06:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zGyp46UQWdWdiI/hNLogBj37uH09PvgL7pOdg2I30Lo=;
        b=J02uGhlGqGObAx9bjy0oBbuC6oqyQk/E1jzF5edvMswZhfzsSMDRnU3PlwXRjXdZrh
         Ko4/3GcvWSkC85AS2VPfHK2nTtZY72+aw6u2VG4NguG8Ka65sVBR2XXyzgEKc+KowADl
         YNjMlz0TGvj0cu15ZGfSkVyWYbx5ba4IGIYVImZOQ5fq/Zb10eewQw4dEpK4ZChNU0+X
         rZnbRHGWC6/EG8TuJkphKODBHaHXyPdDcdEJ9DNunEGMXYAvOdDpnDOfRhoyiX6n+e5i
         4+uSKpLKdnHRKiNoA0c0IXp42ozVBitEVuvvKviPstN1BIXL0IQ5q7Tmb9gIv1Ewz0br
         ablQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zGyp46UQWdWdiI/hNLogBj37uH09PvgL7pOdg2I30Lo=;
        b=MXUWKzs8wlDKCAGBHl0YyTwILJWujUVD/jVydrGT/AyayJ2hPtGr/8xSTS3Z8bAEmA
         XnKH9QrjzJiXEqWUyRrQqZxLiMtxGm8EX05c8GO48515yAZJQHD2eA6HGMoFiKx4baUr
         zboClAgFZDrgoXGsIxXCd55wUtcB2Xfb86Qs6TsgaFcnbMkGndagoSteHzGwJ1vcjICf
         lSnLWMv2dA7snF+org34vb9khPi92ETsas2fpMUKOJTBkkOcAGDPeRq0TqE0nMEFRhEX
         09CUS0bg83qvmzEc0AEOwD3KvdTPytfVtvwrjtgerVygHUbAAamEmNsREEhu9HtIZttR
         Lukw==
X-Gm-Message-State: APjAAAWPkqzxBLq3Idsv1Bnd/7hKsEZKb3sf14/u6kXy6V+Kb1QsYOwk
        TjFGqaWPga2WmNPPt/ZC40tcB70d
X-Google-Smtp-Source: APXvYqyuFB35Cz5GXSje3B7kFFz4fuh1qV+lkTbLM3O8G0unSohPnVmNmkmuf5B4tUGzN4cQkKCLLw==
X-Received: by 2002:adf:8295:: with SMTP id 21mr19438479wrc.14.1571666199846;
        Mon, 21 Oct 2019 06:56:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm20577163wmf.14.2019.10.21.06.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 06:56:39 -0700 (PDT)
Message-Id: <f03bb23305c01ddb7387b44add549bf22539002b.1571666187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
        <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 13:56:23 +0000
Subject: [PATCH v5 14/17] sparse-checkout: sanitize for nested folders
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
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

Helped-by: Eric Wong <e@80x24.org>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 22 ++++++++++++++++++----
 t/t1091-sparse-checkout-builtin.sh | 11 +++++++++++
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 6c3bf68c89..b02e085495 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -212,9 +212,17 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 	struct pattern_entry *pe;
 	struct hashmap_iter iter;
 	struct string_list sl = STRING_LIST_INIT_DUP;
+	struct strbuf parent_pattern = STRBUF_INIT;
 
-	hashmap_for_each_entry(&pl->parent_hashmap, &iter, pe, ent)
-		string_list_insert(&sl, pe->pattern);
+	hashmap_for_each_entry(&pl->parent_hashmap, &iter, pe, ent) {
+		if (hashmap_get_entry(&pl->recursive_hashmap, pe, ent, NULL))
+			continue;
+
+		if (!hashmap_contains_parent(&pl->recursive_hashmap,
+					     pe->pattern,
+					     &parent_pattern))
+			string_list_insert(&sl, pe->pattern);
+	}
 
 	string_list_sort(&sl);
 	string_list_remove_duplicates(&sl, 0);
@@ -230,8 +238,14 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 
 	string_list_clear(&sl, 0);
 
-	hashmap_for_each_entry(&pl->recursive_hashmap, &iter, pe, ent)
-		string_list_insert(&sl, pe->pattern);
+	hashmap_for_each_entry(&pl->recursive_hashmap, &iter, pe, ent) {
+		if (!hashmap_contains_parent(&pl->recursive_hashmap,
+					     pe->pattern,
+					     &parent_pattern))
+			string_list_insert(&sl, pe->pattern);
+	}
+
+	strbuf_release(&parent_pattern);
 
 	string_list_sort(&sl);
 	string_list_remove_duplicates(&sl, 0);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index ae99803d40..0792caeb7e 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -237,4 +237,15 @@ test_expect_success 'cone mode: init and set' '
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

