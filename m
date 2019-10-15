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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6945D1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 13:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732322AbfJON41 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 09:56:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43052 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732125AbfJON4W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 09:56:22 -0400
Received: by mail-wr1-f66.google.com with SMTP id j18so23982885wrq.10
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 06:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SafVaLm3Tyik1Mh8IyCFRfcdVKLouLbF+3rKqE5WNg4=;
        b=MAbmHRjsAjtex50d25kzu/TgPDuBmS2XHkSXFxGNhAM4T5RDKr8nCcbVJtyaIdPhF9
         lUVQ/HwF1FkTOtpECllFbIP5x52uOT30mWXFA8rT6/6w6nEl9ztZIcqMZUQLPL6J2TTk
         5ZnS+l9L+qS2ESJnJhFnKRjDeo8bGhHLEKryos4+3wHpawVg21WO0f+mC64U58qLBNNi
         TEdDv0XIEyzNt2JZtmTyIPWgpV5I1VurZoCq0G0I/KivATK/9+84CMomH84Cz/yVw18K
         o8FiZmSNCXykDp17xWJMRUjsV4rUAPBg4q4/IJmToE4fe9n735m3iI7ZQdL6DGbgycos
         N3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SafVaLm3Tyik1Mh8IyCFRfcdVKLouLbF+3rKqE5WNg4=;
        b=Pi3clnTxHGS5iuBU1WFtVPyXtxqMrIn1A55jtDV25vWdylvctv9SM06XBNe7odnz+t
         eX89A5QWplamNrYDnimomF5YGvxchtEWe0fs6bet9e6+FF+3jJZDbJxb/KugAVynphH9
         m+XIGObX4/0/sBAo/i6K7UoD355OhIAYRXZUoVEXTyjaDutNF+1rHW630r9azXC5jxoU
         8M/ZR2rnEMrXX6GiGtkARM1gCYijcHlX3PI7YIhIPddg4Mn2uolXqnryJ8aP5MLwKNut
         WY8sG6+UDwXpfO7WYhCuNXGhNa0hWK4lfoDOv+hsNX6uF68CTwFGmpV5fsLeSwO8i1iu
         Jmcw==
X-Gm-Message-State: APjAAAXnOm6gug1zRxHfW6kckuDNsy4+yj3KJ/h0s4+EtxMA3dfds5E3
        IFDOvaQIa/L0ozlK2PTlhAt4Wa+p
X-Google-Smtp-Source: APXvYqyDJyg0tmw127RgMsXSPqDP+kUtiUzd+emOidlOFcaHlsq8x0zRH1dzQFwdAYLduDIkEvg59Q==
X-Received: by 2002:adf:ee82:: with SMTP id b2mr30613625wro.285.1571147780952;
        Tue, 15 Oct 2019 06:56:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p23sm7485472wmg.42.2019.10.15.06.56.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 06:56:20 -0700 (PDT)
Message-Id: <d0421ef7b2b9c9c511dc72eacfc0b366fda5e38d.1571147765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
References: <pull.316.v3.git.gitgitgadget@gmail.com>
        <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 15 Oct 2019 13:56:03 +0000
Subject: [PATCH v4 16/17] sparse-checkout: write using lockfile
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If two 'git sparse-checkout set' subcommands are launched at the
same time, the behavior can be unexpected as they compete to write
the sparse-checkout file and update the working directory.

Take a lockfile around the writes to the sparse-checkout file. In
addition, acquire this lock around the working directory update
to avoid two commands updating the working directory in different
ways.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 15 ++++++++++++---
 t/t1091-sparse-checkout-builtin.sh |  7 +++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 595955d4fc..b319966a79 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -305,6 +305,8 @@ static int write_patterns_and_update(struct pattern_list *pl)
 {
 	char *sparse_filename;
 	FILE *fp;
+	int fd;
+	struct lock_file lk = LOCK_INIT;
 	int result;
 
 	if (!core_apply_sparse_checkout) {
@@ -314,21 +316,28 @@ static int write_patterns_and_update(struct pattern_list *pl)
 
 	result = update_working_directory(pl);
 
+	sparse_filename = get_sparse_checkout_filename();
+	fd = hold_lock_file_for_update(&lk, sparse_filename,
+				      LOCK_DIE_ON_ERROR);
+
+	result = update_working_directory(pl);
 	if (result) {
+		rollback_lock_file(&lk);
+		free(sparse_filename);
 		clear_pattern_list(pl);
 		update_working_directory(NULL);
 		return result;
 	}
 
-	sparse_filename = get_sparse_checkout_filename();
-	fp = fopen(sparse_filename, "w");
+	fp = fdopen(fd, "w");
 
 	if (core_sparse_checkout_cone)
 		write_cone_to_file(fp, pl);
 	else
 		write_patterns_to_file(fp, pl);
 
-	fclose(fp);
+	fflush(fp);
+	commit_lock_file(&lk);
 
 	free(sparse_filename);
 	clear_pattern_list(pl);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index ecb5a63671..48493e1012 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -262,4 +262,11 @@ test_expect_success 'revert to old sparse-checkout on bad update' '
 	test_cmp dir expect
 '
 
+test_expect_success 'fail when lock is taken' '
+	test_when_finished rm -rf repo/.git/info/sparse-checkout.lock &&
+	touch repo/.git/info/sparse-checkout.lock &&
+	test_must_fail git -C repo sparse-checkout set deep 2>err &&
+	test_i18ngrep "File exists" err
+'
+
 test_done
-- 
gitgitgadget

