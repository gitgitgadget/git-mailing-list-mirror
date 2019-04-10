Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 228D220248
	for <e@80x24.org>; Wed, 10 Apr 2019 17:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbfDJRh5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 13:37:57 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34752 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729655AbfDJRh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 13:37:56 -0400
Received: by mail-ed1-f67.google.com with SMTP id x14so2814746eds.1
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 10:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xlQ44cEW8g8+h+YkNNfpEFl7iqnx2b9UReJ1Qvue5RU=;
        b=S/VCnW8sFUNafj6NR+dBEliVFJdcn+jBhSVQ9258rFthx7fU3TEgShwyPIQYrUDWev
         QvLfIA/1C+Zdf+UYDkT+Nwv8ixNpHycfyWRx3MgYKSnQbCf5viRgUWt1XZVmUDp5wqQ3
         g5fRsA890Jjj9zvRE06+Tgo3m93ZC+pGMGgF7vIpylGHXRenwYzosPK4rW0HLno2R7/e
         bLgClieKTPoFLpzdiZL7QRGERpR0hmDvOPCOgMb/eiJI9AySbDgGnFjojeSrEhz6Zdrl
         o550AnIRJlkdcruqBcmswwnOKgGKAvNZqVAS6r2kg46M6SDsw9QGTXG+9AfdXSUL4MCC
         0xIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xlQ44cEW8g8+h+YkNNfpEFl7iqnx2b9UReJ1Qvue5RU=;
        b=Hum2Emq55k1PX+TQHDudkoBmQCZuSSf7EXEm+oGgxQ6RGdOI1ZN+aZbJlbHk7A8p3A
         NsxgGrs2mgBHeQRFtb3tEP8+RZZqeUUSCU9RLJdz+C85q1YLKX9IcNlvS+zlFX/u20VC
         qOhCd0hkuiCztg3pSnrfbC+YaldxursyenDgnJryWcjmnduiVQmw3lCB8GWM4kooKtew
         ViDSPpLczSlRLa0ePGRNYHBRnBHiF+WBcW6cqCWjjFQ0b+WRqsJ/SXBeA29EkHElSe7t
         kywLebzR8HVQpF2q6gF0mSo6NOShrDkXLgVCvHYDAxpsfFcflmM3HJiRP2CYhZ8fZlNp
         1rrg==
X-Gm-Message-State: APjAAAUwZJ4DNkkRVP+UA/55CZP3q2iFa+3HfndPhKx1480pNWwZHDYf
        U3EbyCjIM4fPzeqMNDc5zxNSpd8X
X-Google-Smtp-Source: APXvYqx5D5CJFxW9YTFuRPrhfUDAXvHzG27aRgq75tFD/o5crbQUkBNcpWRf+amt62JicmgEpicsBQ==
X-Received: by 2002:a17:906:37cb:: with SMTP id o11mr25049464ejc.199.1554917873793;
        Wed, 10 Apr 2019 10:37:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l63sm1278456ede.22.2019.04.10.10.37.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:37:53 -0700 (PDT)
Date:   Wed, 10 Apr 2019 10:37:53 -0700 (PDT)
X-Google-Original-Date: Wed, 10 Apr 2019 17:37:41 GMT
Message-Id: <a512e14609e27e483f79c9e6cda007f88ec7a6dc.1554917868.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.git.gitgitgadget@gmail.com>
References: <pull.170.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 04/11] built-in add -i: refresh the index before running
 `status`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
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
index f627a56eeb..d971b58552 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -264,7 +264,9 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
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

