Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 670FD1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 18:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbfAPS0F (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 13:26:05 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44804 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbfAPS0D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 13:26:03 -0500
Received: by mail-ed1-f66.google.com with SMTP id y56so6195163edd.11
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 10:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fhp1k8T4sC4D8PaL+Aj/KK9zEePmV0M7fhZ9a0FD+wI=;
        b=AtxPdaBFVa9ooLrg26FCI4e/iDjHj09qRYAg+nfSUOyAHHZD8pGfb4JHhERpBNKM4j
         NGKahYfhYQ7GnJsW6l3O11+jDuzCur5h6C25DoE8e2jmE3Iw6ejUpSTQ7zr/xyWsovUC
         enx0ooctbmRFPJ5b1Doz9VZzRL4u1Ws7eAMak3p8394QVl+Nw4tASSPsxNnEyj1wYnCe
         IqpAjECIkXO+XNLc1j2urBxGeT71Zyr37oW9sAQHnmZfwqGDxE3aC81S5+4l5kpzT63W
         ZlBEpKC4Tisf7UttmWX8FQ9tz93yUgKI7uh9l563dfBFFVztBmQEfYlsJmoD8GH5Z+/t
         L3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fhp1k8T4sC4D8PaL+Aj/KK9zEePmV0M7fhZ9a0FD+wI=;
        b=c1aqbzedovgzw4COEc9amwjPFIr32vmiNZMmuhJjoGjBOD3KhFkdUHjZsHvhE6tmgT
         nudx2tWTHyUV3cnomlSBIo743EYrZB5aXHiWZKPGLDVrSkGie48NvK7gh2lmoWfTjqck
         FACQeTkygWdyl7aNAkVmi/XDFCZPkzcUH8OST2USbfBt94CxqgOMFKu6UUF5KDfpDMqH
         atkyVGUGsR43FIjYr0/tWfkSXVkXgPfAi9ngmcCjiPZdl8wy9UrpswNR2lnIrBXvWBvU
         JoBHs686OvjBniDmaDrsuNOEzMvOk6BDA4G7ix7w5z6ew9jW0NgWMwB0qgSIRF9pGf/u
         soIw==
X-Gm-Message-State: AJcUukfWZElds5FG5deYLpC22Ft0Ufq+fW0DOLcvNzvZVaXd+QVwwfRh
        S8dgPy5IoYaI9u7cGgssndPBYhWc
X-Google-Smtp-Source: ALg8bN4jLg1xzuI5BobvOVzryCLPj8Of04nrOETqAdkYLumpHolNmCVD66l7b6F1Olcpv/QbFRkQHQ==
X-Received: by 2002:a50:a8c3:: with SMTP id k61mr8388122edc.296.1547663161405;
        Wed, 16 Jan 2019 10:26:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j8sm5673410ede.55.2019.01.16.10.26.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 10:26:00 -0800 (PST)
Date:   Wed, 16 Jan 2019 10:26:00 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 18:25:54 GMT
Message-Id: <28111d70d448a8220ad080de3932691a8be35505.1547663156.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.v5.git.gitgitgadget@gmail.com>
References: <pull.89.v4.git.gitgitgadget@gmail.com>
        <pull.89.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 4/5] pack-objects: create pack.useSparse setting
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
index 9f2a6e5d31..3233fafc90 100755
--- a/t/t5322-pack-objects-sparse.sh
+++ b/t/t5322-pack-objects-sparse.sh
@@ -118,4 +118,19 @@ test_expect_success 'sparse pack-objects' '
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
+	test_cmp required_objects.txt sparse_objects.txt
+'
+
 test_done
-- 
gitgitgadget

