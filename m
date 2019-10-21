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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7795A1F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 13:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbfJUN4o (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 09:56:44 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38944 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbfJUN4n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 09:56:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id r141so3327606wme.4
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 06:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ODUGrtgS3butVwd0ur5USwIQx48hIHS2pkvBQPyGujg=;
        b=doTK1PP1ZxDcSYkHbINb2C7r/Bth6xwBYcVFCBTH+aDZypzFbvMCAa128cVdkmG7Wc
         To6Y+L02O8E7UXCML9wPfMH4qrV2ope+pmwcZ/ZWyBOf4F8rElWTXwKQKp2mdGh4ojrp
         GrG74eifaZV1warjlA8XcqRcnmqscjRlj1LtFxka+JTeyBhdgrOR5+I25cUA6EIUh6zo
         Bulk5f+gl3iJZ3A1IvR/8OtV87YrpHds3I8t+TFsUBi1Y0eqHqLJRoSkax6hAHizN7t5
         CZzkrFb8jZE8jmPDG6IvrjiOxWnzdVoL1OY1V470/E9OJJk0s6FKN4nEyGW1n3EJWk8K
         tvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ODUGrtgS3butVwd0ur5USwIQx48hIHS2pkvBQPyGujg=;
        b=GjDeopLM/jEHKwKBS/DJcd/3PfcdR8GZbNCXpG7NwQzG0IA1AVkpKvgqR8tPkhGHtC
         phJbjTVKkVQTEUgm8KzUaeNPWaJn8WwAfrieyXRmvItUmpbRFnYDu65W8Dzd85U+V5m3
         2G7cR40kZhmW8jRiY5449P1Aaswwy2u6oI4LPH1DzAX4fpmw4dhAi1jwCpKkeB3A6pXx
         MOI2xxwjuOER2BcsfBO/2TUFUAAtE07XY0LwTHEsh1DbnFlZKhX4WgNJYFPqUwlwjq+a
         jdGSMO5HMpoDx1X/b+Kz8BEnE/60NE2QSSJXRoY90l+nyfrIbbUWMy17V7drMuD7JRnL
         OpTw==
X-Gm-Message-State: APjAAAWGkzLMYvtB8r2Zs1Pr6bK5InhLoCK8/By8thkXaeGMgVuz4Z81
        MVYNtUgiJJReJzc/EBBcJVRcKRrn
X-Google-Smtp-Source: APXvYqxRl+1oh7Wo61iiAaMxLiVKPmmjemcAIMs6AwIMgp1ak+GQVzi5NyjRDl5OoZ30qyg/WKnKWA==
X-Received: by 2002:a7b:c24a:: with SMTP id b10mr6023399wmj.124.1571666201296;
        Mon, 21 Oct 2019 06:56:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d199sm5649557wmd.35.2019.10.21.06.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 06:56:40 -0700 (PDT)
Message-Id: <88eff318e04165e23406098bfdd61d52bdc604cb.1571666187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
        <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 13:56:25 +0000
Subject: [PATCH v5 16/17] sparse-checkout: write using lockfile
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
index ea2e7ee51b..76f65d8edd 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -306,25 +306,34 @@ static int write_patterns_and_update(struct pattern_list *pl)
 {
 	char *sparse_filename;
 	FILE *fp;
+	int fd;
+	struct lock_file lk = LOCK_INIT;
 	int result;
 
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
+	fp = xfdopen(fd, "w");
 
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
index a580b79595..2db706a9e4 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -276,4 +276,11 @@ test_expect_success 'revert to old sparse-checkout on empty update' '
 	)
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

