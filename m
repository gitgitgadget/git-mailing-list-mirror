Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A009B20A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 21:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbeLNVWZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 16:22:25 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39641 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730962AbeLNVWY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 16:22:24 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so3238992pgl.6
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 13:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FuZVL9hdiTQCX6h/o0mlC4gtZhGcmN7duYVS+utGygg=;
        b=sL6nLQ/dSLLhyoEH7Wwa67M0yRYqlFS4wuED0J3dsQXYD9tYSKlLPa6RtTOhNIKrzS
         7NER/aqpQfFfs9z5SqZ4jXVWVufHJ/yKrFFNZwAijE0rZVae/hY9GC4XGGmyl0fX9FAA
         /JhT2WYtIZiqRkDLLvtgDGkgPtE9vyD3K9hyfBv9oROk7a1Ju01QaAwLkxIHs4OrhJBI
         Iq9wzQqYqREQzzi1i16PQUHJ84pcJh5Svu2YFmkazd78+1c5C5o7vZdW7IkF33+sgiHV
         ZojMS+1uXYghNvIr25Hr16wXSj6uMZ34OwchLE4XWmEqkyq/hgiXZCGt18HQsGEeQoQx
         84JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FuZVL9hdiTQCX6h/o0mlC4gtZhGcmN7duYVS+utGygg=;
        b=fWn2mNEWiTC13L4pHZH/KTpSMU4GuRsCvGXfjK66irbfSeITC+CS3ZhChnqSh8ydHP
         igwxjx+NSknZf5yzLFockWMfPixb2qLXNKLLS7ImnaMsvXgyycTKsOTzRWlgv2zZqYBu
         0b/xxsStl3j8DtV3Q+ETmAAObvE6yomR9nUo+X+entWuJyPGLnGUD0TbRq5pTaN3pMLM
         BObL5U8cOSZjeewpw12tAxm5sanmtueY2Qm9wAqwWAzn2rV8Ns5eoKCRcOqlK/h8OmZB
         e8CHx68UNC4jAzVQSNxd1bvHMtAx/aWV6BYcHnDKogJIrQvn1243yJkyJJ8l4L2SsROU
         HBLw==
X-Gm-Message-State: AA+aEWYC1SayL+OodNf7n1mcSBK9iuLl0Ee4iW445Ewo1kN+9jmh40la
        KrnWQsBUhqfxzDQdpnpvSm8woBKa
X-Google-Smtp-Source: AFSGD/UX21gob6g6lSycrev3prgsccA9tX3TnZ1ikGzZ9GRQfcfqE2X0h8aH5fB2LUTE2Yxg/sNfvQ==
X-Received: by 2002:a62:6303:: with SMTP id x3mr4488001pfb.110.1544822542996;
        Fri, 14 Dec 2018 13:22:22 -0800 (PST)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id v62sm12244393pfd.163.2018.12.14.13.22.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 13:22:22 -0800 (PST)
Date:   Fri, 14 Dec 2018 13:22:22 -0800 (PST)
X-Google-Original-Date: Fri, 14 Dec 2018 21:22:11 GMT
Message-Id: <f386f6c3c9dba2ef699a6605e4214aa723ec405f.1544822533.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.v4.git.gitgitgadget@gmail.com>
References: <pull.89.v3.git.gitgitgadget@gmail.com>
        <pull.89.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 5/6] pack-objects: create pack.useSparse setting
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

The '--sparse' flag in 'git pack-objects' changes the algorithm
used to enumerate objects to one that is faster for individual
users pushing new objects that change only a small cone of the
working directory. The sparse algorithm is not recommended for a
server, which likely sends new objects that appear across the
entire working directory.

Create a 'pack.useSparse' setting that enables this new algorithm.
This allows 'git push' to use this algorithm without passing a
'--sparse' flag all the way through four levels of run_command()
calls.

If the '--no-sparse' flag is set, then this config setting is
overridden.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/pack.txt  |  9 +++++++++
 builtin/pack-objects.c         |  4 ++++
 t/t5322-pack-objects-sparse.sh | 15 +++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index edac75c83f..425c73aa52 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -105,6 +105,15 @@ pack.useBitmaps::
 	true. You should not generally need to turn this off unless
 	you are debugging pack bitmaps.
 
+pack.useSparse::
+	When true, git will default to using the '--sparse' option in
+	'git pack-objects' when the '--revs' option is present. This
+	algorithm only walks trees that appear in paths that introduce new
+	objects. This can have significant performance benefits when
+	computing a pack to send a small change. However, it is possible
+	that extra objects are added to the pack-file if the included
+	commits contain certain types of direct renames.
+
 pack.writeBitmaps (deprecated)::
 	This is a deprecated synonym for `repack.writeBitmaps`.
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7d5b0735e3..124b1bafc4 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2711,6 +2711,10 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		use_bitmap_index_default = git_config_bool(k, v);
 		return 0;
 	}
+	if (!strcmp(k, "pack.usesparse")) {
+		sparse = git_config_bool(k, v);
+		return 0;
+	}
 	if (!strcmp(k, "pack.threads")) {
 		delta_search_threads = git_config_int(k, v);
 		if (delta_search_threads < 0)
diff --git a/t/t5322-pack-objects-sparse.sh b/t/t5322-pack-objects-sparse.sh
index 45dba6e014..8f5699bd91 100755
--- a/t/t5322-pack-objects-sparse.sh
+++ b/t/t5322-pack-objects-sparse.sh
@@ -121,4 +121,19 @@ test_expect_success 'sparse pack-objects' '
 	test_cmp expect_sparse_objects.txt sparse_objects.txt
 '
 
+test_expect_success 'pack.useSparse enables algorithm' '
+	git config pack.useSparse true &&
+	git pack-objects --stdout --revs <packinput.txt >sparse.pack &&
+	git index-pack -o sparse.idx sparse.pack &&
+	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
+	test_cmp expect_sparse_objects.txt sparse_objects.txt
+'
+
+test_expect_success 'pack.useSparse overridden' '
+	git pack-objects --stdout --revs --no-sparse <packinput.txt >sparse.pack &&
+	git index-pack -o sparse.idx sparse.pack &&
+	git show-index <sparse.idx | awk "{print \$2}" >sparse_objects.txt &&
+	test_cmp expect_objects.txt sparse_objects.txt
+'
+
 test_done
-- 
gitgitgadget

