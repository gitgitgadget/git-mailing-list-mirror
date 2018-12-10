Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B91CD20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 16:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbeLJQmw (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 11:42:52 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44126 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeLJQms (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 11:42:48 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so5642468pfh.11
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 08:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FuZVL9hdiTQCX6h/o0mlC4gtZhGcmN7duYVS+utGygg=;
        b=kDTW6bUEffP44VPHq/eS4Lgn1C47Z31uQu8dN7zxI5ePTqT0pMokCTElTC6HqAh34i
         m1yfa7Nv4QSGDAviiVrV0tBSwLpqwNeZI7sKFdGS1GUDt9Y9kGBQRnPHl75Rug5AzJd9
         pK2ZVM0RObnDgNgkWQLadejIQEDKepvVASzdTdNW98SGbAB51JHxKnVTUulHhnz/08gi
         mGlvOwniVZHhQsoUeTekCMnss79qdwQkOmilKDv/fNwZMl8L0YKsh30adeaaTXBt9338
         mbEvgP4Z/mNof2HB7RTz4lOWyUTLU8FG1CcbJhEbBucDHyUCKMUFn25VasD2GWIW6i0t
         lBeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FuZVL9hdiTQCX6h/o0mlC4gtZhGcmN7duYVS+utGygg=;
        b=HEGCvWETdPAdM3LEsyf4sCX5rbwwyLNznJGg+gAJuzhzxTOHhrhx+mFISWIHQjCUQY
         1/0s+Bhubons58jzXAbnpNIwkjEuuYPSW9ZrRQ3ZVNokiV8j/czDLjdHoixpoZbBkpSn
         T2I66PW5df+7motYmnoeJ8TCGjrl+/1OFMe8g5aLZ1pUM4pSZB9MXvE7jeerKmN/hMVL
         IE5TQKNj4D6mPcEnJvm3JxagFr9SLsBMgXINRRM8Stk89vCJaod72IJpZI4LdHe9mC5m
         N9c6612PW5IxIy1OnC+ljcJT3S449cJpqnXt+vqY+ipwZdQgArhSmXeCitDOfjjXq/U+
         UHcg==
X-Gm-Message-State: AA+aEWYHw+KlANDOdvNiLHe3ZjWuS4JrWMA2fh0xV+gOu708Uk577Wdn
        Dsidt+8FPKUsvz9NqnrvcwIdGt1j
X-Google-Smtp-Source: AFSGD/VEmAyYVMZK/yV9FeJ/ES4nQlNfniSQ9O8yBzepkwi4OXa/htoYb+X30qmQY2iBgL3OYIRz+A==
X-Received: by 2002:a63:374e:: with SMTP id g14mr11698494pgn.59.1544460167451;
        Mon, 10 Dec 2018 08:42:47 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id d21sm12927009pgv.37.2018.12.10.08.42.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:42:46 -0800 (PST)
Date:   Mon, 10 Dec 2018 08:42:46 -0800 (PST)
X-Google-Original-Date: Mon, 10 Dec 2018 16:42:37 GMT
Message-Id: <33d2c04dd696d4a7f648343f3da5e48a9e1f1b5b.1544460159.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.v3.git.gitgitgadget@gmail.com>
References: <pull.89.v2.git.gitgitgadget@gmail.com>
        <pull.89.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 5/6] pack-objects: create pack.useSparse setting
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

