Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A4A121F461
	for <e@80x24.org>; Tue, 27 Aug 2019 12:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbfH0M6E (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 08:58:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44293 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727086AbfH0M57 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 08:57:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so18690911wrf.11
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 05:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ddx1qp7yobgLQ1SEJr4onXZfVjSpKH9xoqGS2zK+XO0=;
        b=WsA0QQccC+wbMF2FNinefK459tmAct9Ox4TMX967HZgiCu31G8yxXSDERhlA7T7tL8
         j69K4Ol6fCYQpLU1RqMQ+nB2Dg6rZYwckVNvWS4shREQ35bwov6LCW5WWl43GprwL7Qs
         avZRDDT1RgGegs/Hs6CeSW/xh/aq8pqj1MI7cXdfua4aI3BdeO6YD3JKRlsjXRfNY8lC
         W0Knh0BFVjU4wtpqLMLT8ABs/2RGDBTWRyVsyAsXjqyrLdeEX2r8W77USi46O35pZXzB
         /Pu59z7VmON+lNQ1XHTUuoS3D7cq5HlI/4pCS6DfYB/cevRcJfJS1p9oJW57xB2zdZkt
         BO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ddx1qp7yobgLQ1SEJr4onXZfVjSpKH9xoqGS2zK+XO0=;
        b=lLt2mFGsOD/FbSl10ZB8/llbWyZyT6cKSi/Sy75ZUWp/OaDf7i41fUKt7HePi6X5/R
         MzOZCVWwBqt88D/I1WJdmNBr9Vf+I5nnfAm8AUM7fF8iFnjx7ddmVFAe4cD4cFmrKyFH
         1fCdVQckKxbP/Izmb95YIlqioXCdduug9qQ6AqGNr6Zy62rN86Xe8U0gJHyu1DC4UXuB
         2w3g1PVWn9F8bOy8wsGsjeKz1qKsZvbrjjixPJVrAymTXs95wPYlwhrMqBFTp3bqPhvP
         8pBGPbLqMASGehhZ9mI7h7SdDIYNgtDIbcUJ3GbGZSoFatcD+9RtoLew4Vi67yA862S4
         cF0g==
X-Gm-Message-State: APjAAAVJuzmC1kARNLMA54+hYZ/878eBY5JRQRfxy+d/NIuiiimQQQJI
        mc3PJResl3A59Kkeg9NzoZWf+RIjqSk=
X-Google-Smtp-Source: APXvYqyzB7uZQqce6iEHig6TWpS5YoBWBR4OBEHCglwCo5Rx7nepJ6MnhMoLfsEDDxvFVum6X5ERRQ==
X-Received: by 2002:adf:9222:: with SMTP id 31mr30162792wrj.93.1566910677142;
        Tue, 27 Aug 2019 05:57:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17sm3764108wmj.27.2019.08.27.05.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 05:57:56 -0700 (PDT)
Date:   Tue, 27 Aug 2019 05:57:56 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Aug 2019 12:57:45 GMT
Message-Id: <3c855d9fa563a288d7934e3cca29295fc929257a.1566910672.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v4.git.gitgitgadget@gmail.com>
References: <pull.170.v3.git.gitgitgadget@gmail.com>
        <pull.170.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 04/11] built-in add -i: refresh the index before running
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
index d64206ba1c..427abe505e 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -259,7 +259,9 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
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

