Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B69681F461
	for <e@80x24.org>; Mon, 13 May 2019 17:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbfEMR2A (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 13:28:00 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37973 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731611AbfEMR16 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 13:27:58 -0400
Received: by mail-ed1-f65.google.com with SMTP id w11so18667207edl.5
        for <git@vger.kernel.org>; Mon, 13 May 2019 10:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5tkP3s+etw0mmFiWQbYcMBfdwMBsUExKQnfIBiodjuw=;
        b=jF87NWeRd4/nlTs9ECPWFDYUIn17ehVSUpPLS02fBl3htVcpYIuEAfdiIxOJy6aQ0U
         nzL/MMXnnImdMtfoCGVjVr+zNYLOFspILr2L1fmOEY7qYtmaLLh+07WTKpenNua5AhCr
         kQ+Bi57du7asWhTjZ6TR9KXWkw6vg7kR6XQ3Xedf+HzPdM9QC7M0nzE7xiXlmJdNzTRb
         yzqPJl12iFIVg6BFN2r4K9IPtsPtCrRsTmMyvcXJyni/2JkW80OQP0ATXD3TinTIDiHn
         Tzdh+S1m7/Kv3n9/RKTUYfQ5/c2UVq815clB6a+vwVsL4hVua/s9kLGg/hjYT+lD/hfd
         Fa6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5tkP3s+etw0mmFiWQbYcMBfdwMBsUExKQnfIBiodjuw=;
        b=KLeWqhHYASxBIRQgkAamIIcdfVxG4NPqtWmyh2CpgFwsScxYMBMHkR0Pk9+5BAGyZ4
         bKWcXoMNAILxLcJhIo6xo2hutmsSSpezavCwtmpSzPVjsfu+QQqLuyE3+rJVTMOaK9QH
         e01qpx5HVtcNxbg9si8lwoqqOD7yduIiwKQWPs4DNYik2aP3hm2JhzrBiEoWd8zIQqXZ
         l1L/Jd+avIahhSu9a4hC9E69aPKBAhUxKeCRRWq2yWVuoIeio+qDtOWpOfbJ7Rwc19gs
         304DA73vF6H1npBz4xOUeP1hoxwATI9KDPZfdyPnTRHmFQrdHhbiszmEvUX5xVwkphpx
         4D8g==
X-Gm-Message-State: APjAAAVuI+yMx/r0ftaT38l7uXwzOWRNsfufrE+RCcZZ90iS25g+TW7l
        opBt5i8wDVUl9mFhYcIlbYliWDu/
X-Google-Smtp-Source: APXvYqx+WJsh/PN22lCSKlSI56FHhC+/xMOY8ePpgv3wv2uREBPWWbwr6opZxvPpV0PyAxhfDikyVA==
X-Received: by 2002:a50:ad6e:: with SMTP id z43mr29656733edc.136.1557768476907;
        Mon, 13 May 2019 10:27:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s15sm3907298edm.6.2019.05.13.10.27.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:27:56 -0700 (PDT)
Date:   Mon, 13 May 2019 10:27:56 -0700 (PDT)
X-Google-Original-Date: Mon, 13 May 2019 17:27:44 GMT
Message-Id: <8cafc6ae8d2dd434f46751874074940f13412b9f.1557768471.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v2.git.gitgitgadget@gmail.com>
References: <pull.170.git.gitgitgadget@gmail.com>
        <pull.170.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 04/11] built-in add -i: refresh the index before running
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
index 65e6f8b8fd..c90f310093 100644
--- a/repository.c
+++ b/repository.c
@@ -272,3 +272,22 @@ int repo_hold_locked_index(struct repository *repo,
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
index 8981649d43..fb49e0e328 100644
--- a/repository.h
+++ b/repository.h
@@ -154,5 +154,12 @@ int repo_read_index_unmerged(struct repository *);
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

