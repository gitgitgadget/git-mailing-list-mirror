Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50EEE1F462
	for <e@80x24.org>; Mon, 27 May 2019 19:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfE0T7Q (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 May 2019 15:59:16 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35615 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfE0T7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 May 2019 15:59:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id p26so28187104edr.2
        for <git@vger.kernel.org>; Mon, 27 May 2019 12:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L1IjQTFy7ZzHINfyJUe5ydazwvqCey6ZgEqslqdy2MA=;
        b=dfz1fkwg6V8aTXMzSS9U67hm6XnkssH0vvEsiW4xAAWnQ9vjo+3QEehSWQ9cZQ/8+I
         DNoe3n/EepyI9ZNovHKtwkV4wnmlNcUHtiSXvj9y+fE0dwaQMWf3vKtmcDHpROfkluSG
         e76BVVZESfD7sVJJwz/KyNJJ2sbc33XHYJYlJoVNGTLLP7v6m/BU8p4JZh8L98A8VKVl
         1I3AV3VlMitOSmJ5l07tdw112jHSwYyHaAVi+3TPD7DH9fbq3EVkX884fdHuZwbrkzDr
         GVNq4b0zb1Mt8/ZjpTU+6d3+SvxXal6grkNoIDTSD+YI70yxu7ALf1GgSfiaJKONyAc6
         1Fig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L1IjQTFy7ZzHINfyJUe5ydazwvqCey6ZgEqslqdy2MA=;
        b=jJ1fpWS+84jHlF6On38gPbRHScR9EDEno1VLwm/CwrxkeTm3oNvEqFmY9CVB2LKHey
         cNb85I+a9Ms1Y2MoJfFyrnK5m7lvyRmVBB54nrcpTH0MxJZhnXM54sO1BkVFQ3fp1Kg7
         qkJtaPfYqWyurdIrO/v5VWk2oaso2H7sDSQKbIDYVOPTqM+kVTnfM5d4mWduL55NNtmm
         lbAzajSkql3c4GoSsbMRQOo1e1BOhFTQW7IQm9VrzSYNGIczqzhAC0CZWeWURGKlJT1q
         mmDDt4oIkHai6icdeiUUyKS71A7OBKUEyzDYrT7wy+pT+j0rhCS9bfbb8iyJYtw5Gpeo
         Nyng==
X-Gm-Message-State: APjAAAViIELwfV/62JFCjh5uucaaiZiQ/Jz2AK93Nq6D41wLo0caeRs6
        iX0J8FQ0aeLC8HeQ1UT6qXma/Q59
X-Google-Smtp-Source: APXvYqyUZ6vr9SkLSkjlBD9TUj7CGBTkFR8piZFRqEz4qTWkZXnMAGLu267Z4IhRwj+nC+Te88n1mw==
X-Received: by 2002:a17:906:f84c:: with SMTP id ks12mr86065231ejb.270.1558987154802;
        Mon, 27 May 2019 12:59:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n14sm1869570ejb.14.2019.05.27.12.59.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 12:59:14 -0700 (PDT)
Date:   Mon, 27 May 2019 12:59:14 -0700 (PDT)
X-Google-Original-Date: Mon, 27 May 2019 19:59:12 GMT
Message-Id: <f0545e872344dd25e11db7fe095cde1578b26748.1558987152.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.226.git.gitgitgadget@gmail.com>
References: <pull.226.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] bundle verify: error out if called without an object
 database
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The deal with bundles is: they really are thin packs, with very little
sugar on top. So we really need a repository (or more appropriately, an
object database) to work with, when asked to verify a bundle.

Let's error out with a useful error message if `git bundle verify` is
called without such an object database to work with.

Reported by Konstantin Ryabitsev.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 bundle.c                | 3 +++
 t/t5607-clone-bundle.sh | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/bundle.c b/bundle.c
index b45666c49b..b5d21cd80f 100644
--- a/bundle.c
+++ b/bundle.c
@@ -142,6 +142,9 @@ int verify_bundle(struct repository *r,
 	int i, ret = 0, req_nr;
 	const char *message = _("Repository lacks these prerequisite commits:");
 
+	if (!r || !r->objects || !r->objects->odb)
+		return error(_("need a repository to verify a bundle"));
+
 	repo_init_revisions(r, &revs, NULL);
 	for (i = 0; i < p->nr; i++) {
 		struct ref_list_entry *e = p->list + i;
diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
index cf39e9e243..2a0fb15cf1 100755
--- a/t/t5607-clone-bundle.sh
+++ b/t/t5607-clone-bundle.sh
@@ -14,6 +14,12 @@ test_expect_success 'setup' '
 	git tag -d third
 '
 
+test_expect_success '"verify" needs a worktree' '
+	git bundle create tip.bundle -1 master &&
+	test_must_fail nongit git bundle verify ../tip.bundle 2>err &&
+	test_i18ngrep "need a repository" err
+'
+
 test_expect_success 'annotated tags can be excluded by rev-list options' '
 	git bundle create bundle --all --since=7.Apr.2005.15:14:00.-0700 &&
 	git ls-remote bundle > output &&
-- 
gitgitgadget
