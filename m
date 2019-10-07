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
	by dcvr.yhbt.net (Postfix) with ESMTP id 06A001F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 20:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbfJGUIv (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 16:08:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42734 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729279AbfJGUIp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 16:08:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id n14so16725064wrw.9
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 13:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2le2HrJzlVlLNlbW3JTEbjclAZ9reByey/HQksMGVdw=;
        b=X8XZL615X9vCoQ55Y2IE4QjcvTJRsbLTc5AfuZwPoa1LaDKiX04JjTphk8ozGSBMm7
         d4masw4wwepsiM4/a82G78rHuL7m6ChRJDo6EudHGh2yy9UIjzOdeuD2s6W3kBXOKwHr
         YSVi7uEGABS+M+2kpVJD67GiP7EnykBHYXd3ejVyo48jV9BrL34IiN/TPWwSR7B3h54x
         QLekSZdDB6zZEX3DhlnGJlhy64XB4slNiZUOqg9wkFgJKhdZ/aisMAG6tspx7cOYfghy
         AEouN5di/6hYt3dgk6xamjwy4U4jP6nXBmRyj5kCuKwtdc/zcuBWtzz8JgtbWO3JyjNP
         mjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2le2HrJzlVlLNlbW3JTEbjclAZ9reByey/HQksMGVdw=;
        b=MWtFuSVOnyvH2Nz2Qd08/4VHqqwuHr6BtJ9oY6/giEw1/uxv/GTaGinE1j8/frouHu
         est7I5D7LncvvbGHHo9k3Ti2909tqGHZVmb/ydzVXMKLtUumAr8E0gEhHsgfpshNrZBx
         pdgwTDEO06SoWH8NtwG5UT+UVs4F9wr9OV2nr5Tzp+yYXG3ZDlLMZGl2YKQ9ZTH7JYW4
         /B1hzosPIrdgdTdOw8EZv54Ev1n+oyKdWMI83A3ZCyqbwlIUfHKvxhDl2wuBM7yz79lT
         KKgVjqXvF0c29s2jycT9x8ooQ+zwrjDSkb6gcoycrALzY5Z5CGlVf+mCtuyqt5lKH4Y5
         6DDA==
X-Gm-Message-State: APjAAAV0nM2dHnvflIQqMUIA04mha5LZMTvAKu3YTLlQmPqulYdFiYS9
        uPzfGvL5jg44412knZyOXr3m7KmK
X-Google-Smtp-Source: APXvYqw+2PrwuDY9uIsTDdj4KsrQ3g3twEpFzmmkVGD8pEg/wmy+hf7dJ9+DhTnMrSClenGHE6TpGg==
X-Received: by 2002:adf:9d88:: with SMTP id p8mr22983406wre.391.1570478923219;
        Mon, 07 Oct 2019 13:08:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a9sm1223928wmf.14.2019.10.07.13.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Oct 2019 13:08:42 -0700 (PDT)
Date:   Mon, 07 Oct 2019 13:08:42 -0700 (PDT)
X-Google-Original-Date: Mon, 07 Oct 2019 20:08:24 GMT
Message-Id: <8927494b8c418e43f5bbd6e1eb108be5a0a263fc.1570478905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v3.git.gitgitgadget@gmail.com>
References: <pull.316.v2.git.gitgitgadget@gmail.com>
        <pull.316.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 16/17] sparse-checkout: write using lockfile
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
index 542d57fac6..9b313093cd 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -308,6 +308,8 @@ static int write_patterns_and_update(struct pattern_list *pl)
 {
 	char *sparse_filename;
 	FILE *fp;
+	int fd;
+	struct lock_file lk = LOCK_INIT;
 	int result;
 	
 	if (!core_apply_sparse_checkout) {
@@ -317,21 +319,28 @@ static int write_patterns_and_update(struct pattern_list *pl)
 
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
index 82eb5fb2f8..f22a4afbea 100755
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

