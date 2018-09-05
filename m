Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C87CD1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 14:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeIETRG (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 15:17:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44308 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727625AbeIETRF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 15:17:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so3585431pff.11
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 07:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TcPf1JpCxqEKDoJhwyPbSLoFWGQvN6s2QpUSt8Q+3GA=;
        b=tqiMJhgGI17K59jJrhtFta6ew4rJDgRg2iX6WAH7iu45GevNehqkclseH20L/sssEm
         iq6IYdtOmWod6PbU/Ve0IcWrMA9X5XDHjMv8r7aJART8uAv5Z7Si8OtgttQ3IqUCxqUv
         8B81HZdUaHu8HNe8oDl9RGypidVi7C3YTLAUjB/wyTryCGQdnsWXP7MqXI471DUVYSFA
         vFxvTA6JwhAHzFGylpoxcvIRiHZaesCGNfI2CXATZhChYY6u2zi9dHAK2pSJj3e1DlMc
         cH/kyUyxJs0te67t6kNs0SdJuHXWVVqXu42JQrWb+OPonpVtWgwGNotfAhg73DsdtRpv
         L11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TcPf1JpCxqEKDoJhwyPbSLoFWGQvN6s2QpUSt8Q+3GA=;
        b=UbDM1B3P0C7hRiS6DlKa+DWX4k3lgeHU32rFu+epy2W6fCNbQxhrQGe7flZrCfW77Y
         yIZjmxAWd9NXmz0672OQgG7KCIMYUaqbv5gluZKayk8CCOCzOqMxfKiDSNqq5B33tw+h
         RK7bI8zJk4ukouWR5ULJ+GgLZikCH0DMK9e55OnZ+n8Ew0m2W4zKxx8kgyA2lkStdvlx
         im1NvCEzzaA/f1kSvynNmCO2UYhTUfOp0yVp1gy4t1Yb9Nf0LvCKW8Pj7m1H2g5+qssr
         i5KXLligk6gZr1a2xDtG3rnMTg1OXy3EhvIBXMTTEmXFyyIzOtxMec88jUWh1CZPDEN+
         vQNg==
X-Gm-Message-State: APzg51CiM0gi6/q9O0c2sPDC83LR0utD5sZqoXRQtaksnp9EBu6XRakH
        u053UEzmQeEjML663dKbL8wu/lv9
X-Google-Smtp-Source: ANB0Vdbs0UVKcycNYCkDZTvmBkViRez8WY74f3x0UwbkmMcmPgLGBoYZ93mQvOIGuRf8C5S+k6NE2Q==
X-Received: by 2002:a63:fb07:: with SMTP id o7-v6mr36714826pgh.333.1536158793899;
        Wed, 05 Sep 2018 07:46:33 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id i25-v6sm4902277pfi.150.2018.09.05.07.46.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:46:33 -0700 (PDT)
Date:   Wed, 05 Sep 2018 07:46:33 -0700 (PDT)
X-Google-Original-Date: Wed, 05 Sep 2018 14:46:19 GMT
Message-Id: <8dc38afe2b4d73e940daf9a0ff7f9c0a38802d95.1536158789.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.34.git.gitgitgadget@gmail.com>
References: <pull.34.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 01/11] multi-pack-index: add 'verify' verb
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

The multi-pack-index builtin writes multi-pack-index files, and
uses a 'write' verb to do so. Add a 'verify' verb that checks this
file matches the contents of the pack-indexes it replaces.

The current implementation is a no-op, but will be extended in
small increments in later commits.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-multi-pack-index.txt | 10 ++++++++++
 builtin/multi-pack-index.c             |  4 +++-
 midx.c                                 | 13 +++++++++++++
 midx.h                                 |  1 +
 t/t5319-multi-pack-index.sh            |  8 ++++++++
 5 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index 1f97e79912..f7778a2c85 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -27,6 +27,10 @@ write::
 	When given as the verb, write a new MIDX file to
 	`<dir>/packs/multi-pack-index`.
 
+verify::
+	When given as the verb, verify the contents of the MIDX file
+	at `<dir>/packs/multi-pack-index`.
+
 
 EXAMPLES
 --------
@@ -43,6 +47,12 @@ $ git multi-pack-index write
 $ git multi-pack-index --object-dir <alt> write
 -----------------------------------------------
 
+* Verify the MIDX file for the packfiles in the current .git folder.
++
+-----------------------------------------------
+$ git multi-pack-index verify
+-----------------------------------------------
+
 
 SEE ALSO
 --------
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 2633efd95d..7d567dafbc 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -5,7 +5,7 @@
 #include "midx.h"
 
 static char const * const builtin_multi_pack_index_usage[] = {
-	N_("git multi-pack-index [--object-dir=<dir>] write"),
+	N_("git multi-pack-index [--object-dir=<dir>] [write|verify]"),
 	NULL
 };
 
@@ -42,6 +42,8 @@ int cmd_multi_pack_index(int argc, const char **argv,
 
 	if (!strcmp(argv[0], "write"))
 		return write_midx_file(opts.object_dir);
+	if (!strcmp(argv[0], "verify"))
+		return verify_midx_file(opts.object_dir);
 
 	die(_("unrecognized verb: %s"), argv[0]);
 }
diff --git a/midx.c b/midx.c
index f3e8dbc108..b253bed517 100644
--- a/midx.c
+++ b/midx.c
@@ -928,3 +928,16 @@ void clear_midx_file(const char *object_dir)
 
 	free(midx);
 }
+
+int verify_midx_error;
+
+int verify_midx_file(const char *object_dir)
+{
+	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
+	verify_midx_error = 0;
+
+	if (!m)
+		return 0;
+
+	return verify_midx_error;
+}
diff --git a/midx.h b/midx.h
index a210f1af2a..ce80b91c68 100644
--- a/midx.h
+++ b/midx.h
@@ -43,5 +43,6 @@ int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, i
 
 int write_midx_file(const char *object_dir);
 void clear_midx_file(const char *object_dir);
+int verify_midx_file(const char *object_dir);
 
 #endif
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 6f56b38674..1c4e0e6d31 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -150,6 +150,10 @@ test_expect_success 'write midx with twelve packs' '
 
 compare_results_with_midx "twelve packs"
 
+test_expect_success 'verify multi-pack-index success' '
+	git multi-pack-index verify --object-dir=$objdir
+'
+
 test_expect_success 'repack removes multi-pack-index' '
 	test_path_is_file $objdir/pack/multi-pack-index &&
 	git repack -adf &&
@@ -214,4 +218,8 @@ test_expect_success 'force some 64-bit offsets with pack-objects' '
 	midx_read_expect 1 63 5 objects64 " large-offsets"
 '
 
+test_expect_success 'verify multi-pack-index with 64-bit offsets' '
+	git multi-pack-index verify --object-dir=objects64
+'
+
 test_done
-- 
gitgitgadget

