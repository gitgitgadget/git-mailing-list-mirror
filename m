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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A93C1F461
	for <e@80x24.org>; Tue, 16 Jul 2019 14:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387986AbfGPO6p (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 10:58:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39443 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387892AbfGPO6m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 10:58:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id u25so8669656wmc.4
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 07:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P7jQhWPXBPxz68xc689tXGFF0a+aNHSo6WXuMRQbPO0=;
        b=i/kjGYXKtTyMG7EJ8DJGWxB1fvCvTdkn+7MvH9EwJvNK5WiSD6rNRLiujCBDWKl0Mp
         oYQoQstFphleaJ1jIEGfa3MtfIHb+Kgrh5CgOZWRXbxaiNx/9gilKGs8J3FzCwAe4RJI
         vNDiFSmQjGkSl1nFqXfWhS8njDAmmQyyIfT+b2qO1lXGzIjnRD5DlL0h2SxHUr8TEkhm
         LFSFRis4XSFMSFYAbVudggRiAO7fpSAZedgGcLRTxDdF863ktgs+2mUmKYkcjRsmTKUU
         TTniISEYwxgV1OeXA0YP+hcIV2wg7t9KZAdstdutggCxtAKZHjXfk8PNGfzHkFLKGtUl
         5tVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=P7jQhWPXBPxz68xc689tXGFF0a+aNHSo6WXuMRQbPO0=;
        b=juF5XM/7DOKlfxatEvEdRipmsD107bCXWBSZ6Ew0FEXSvK0w6Bf5Zi5lPg9Y5ueNie
         bwcP9MnPMrtpR/PvtYyT9AYXMCVqb7EYKnBAoI4TxnHDr/bnT5WzPgUi8h6tncqZYNZ4
         eJwUh5fxsFftIoW4g44qwX2juIWhRKy6PhcmC0V7iJPO5G+CI61E4xvjhkA1wJOCP5e/
         oKU4aXTM7PuX0PVsD9kteOSDgPfrVPrKu1FT0iP2XWFxVDqTQwvfx0cadlWNdU3yHEJo
         3Ozu3PACNZ6j8ErkEq4oMjjygl7rXxDmQ0EqP4S2+lrq2c/1buAsnnd/zHdXKS+re2uJ
         MInw==
X-Gm-Message-State: APjAAAWXxA7g2d9+1kn652p1oiANphUvM6ezmW6D6LYdiPCUZhghdbdc
        56vcn1kZxcyZL1KgQ7ItFGssTJsr
X-Google-Smtp-Source: APXvYqyAWQtXKjpdqsfRlSm+jtHjJX3wOO+/uAHRTVbI0kRgwfuzNN4YAIYpfRpz8GwGAVMhoh715g==
X-Received: by 2002:a1c:6882:: with SMTP id d124mr30404803wmc.40.1563289120330;
        Tue, 16 Jul 2019 07:58:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t63sm16683898wmt.6.2019.07.16.07.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 07:58:39 -0700 (PDT)
Date:   Tue, 16 Jul 2019 07:58:39 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Jul 2019 14:58:28 GMT
Message-Id: <daff24074a604271d66e6a854ea44546b951f489.1563289115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v3.git.gitgitgadget@gmail.com>
References: <pull.170.v2.git.gitgitgadget@gmail.com>
        <pull.170.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 04/11] built-in add -i: refresh the index before running
 `status`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This is what the Perl version does, and therefore it is what the
built-in version should do, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c |  4 +++-
 repository.c      | 19 +++++++++++++++++++
 repository.h      |  7 +++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index 59b28011f7..2dbf29dee2 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -258,7 +258,9 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 		    _("staged"), _("unstaged"), _("path"));
 	opts.header = header.buf;
 
-	res = run_status(r, ps, &files, &opts);
+	repo_refresh_and_write_index(r, REFRESH_QUIET, 1);
+	if (run_status(r, ps, &files, &opts) < 0)
+		res = -1;
 
 	release_file_list(&files);
 	strbuf_release(&print_file_item_data.buf);
diff --git a/repository.c b/repository.c
index 682c239fe3..def35c40fc 100644
--- a/repository.c
+++ b/repository.c
@@ -275,3 +275,22 @@ int repo_hold_locked_index(struct repository *repo,
 		BUG("the repo hasn't been setup");
 	return hold_lock_file_for_update(lf, repo->index_file, flags);
 }
+
+int repo_refresh_and_write_index(struct repository *r,
+				 unsigned int flags, int gentle)
+{
+	struct lock_file lock_file = LOCK_INIT;
+	int fd;
+
+	if (repo_read_index_preload(r, NULL, 0) < 0)
+		return error(_("could not read index"));
+	fd = repo_hold_locked_index(r, &lock_file, 0);
+	if (!gentle && fd < 0)
+		return error(_("could not lock index for writing"));
+	refresh_index(r->index, flags, NULL, NULL, NULL);
+	if (0 <= fd)
+		repo_update_index_if_able(r, &lock_file);
+	rollback_lock_file(&lock_file);
+
+	return 0;
+}
diff --git a/repository.h b/repository.h
index 4fb6a5885f..cf5d5bab48 100644
--- a/repository.h
+++ b/repository.h
@@ -157,5 +157,12 @@ int repo_read_index_unmerged(struct repository *);
  */
 void repo_update_index_if_able(struct repository *, struct lock_file *);
 
+/*
+ * Refresh the index and write it out. If the index file could not be
+ * locked, error out, except in gentle mode. The flags will be passed
+ * through to refresh_index().
+ */
+int repo_refresh_and_write_index(struct repository *r,
+				 unsigned int flags, int gentle);
 
 #endif /* REPOSITORY_H */
-- 
gitgitgadget

