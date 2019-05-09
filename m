Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 334C51F45F
	for <e@80x24.org>; Thu,  9 May 2019 14:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfEIOWl (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 10:22:41 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40642 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfEIOWi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 10:22:38 -0400
Received: by mail-ed1-f68.google.com with SMTP id j12so1456520eds.7
        for <git@vger.kernel.org>; Thu, 09 May 2019 07:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0ay1OwqMXDNzHrxRUO+Eyr9+cg6irR7gpIuycBbKZLI=;
        b=ceD25EIsGaz3ItbwTrT+a3MYTwNRstO05hNBBeDiFHVyteTtSQG6bSQuQJx4BTOiLj
         4HasZXQHrI+hyww7mYSatO39Ebs/xRHcXry4f7HgZYzB+a/Rt3UGOfR8vjxFl15ksBG8
         TMG4mQ1K3fhy1VnpT7oqqkiDf9NBb/IHKFtDE/MOTnVzZX/uiixvtuDg/l/BhitWtlwC
         6yKGPT7UpHIcbQdDqVLenoyvXeONt6rrlkqL4dvcPQMD+8SLa7JmcrytFe6MfSb+tu2G
         AeCuxFYZ1awRvctGleYiWf2alTt0SzGmvE46rdxhkfbiwH9HLtQ+oWOV4IiLTTftZr2P
         F72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0ay1OwqMXDNzHrxRUO+Eyr9+cg6irR7gpIuycBbKZLI=;
        b=gEcyITrkZQr+wVO0h5hMJx/v4jxapw8qkZwPp55Izl0LW5FXd+xfW7vBsmCS17JSAi
         203zDONI/Qa9YJDhAs6D6j1GQ7h0+5TV51vLQQAaL8bolb2zP+PUvqyQU4X9BIuj+sf5
         /GZqMPprioxoUV31MF1TKNEysSTouH6U+V5CnNHZfsoSzwoN3nwITGBQsC9hEJBRYzCp
         L6KtcX49jud9YK2Ypk6IGNazipOnlcZ2mtKI8Se3UBCGLUquIdjKz58xr1aTtzjBqzJT
         OLTmLXirYvOLM3McunlC7cXJdeJw2cJ3tsXImE4V88nevJ8iAP7qCJa59nR6UrsW0GfQ
         OV5Q==
X-Gm-Message-State: APjAAAWtNuVAsuOEGXz1JvLo5/ofdl9L4xRMCvqFKkgcIXeyJmQiBxPe
        WaEFR+GdfYxcBflyTXjITLp3K9jj
X-Google-Smtp-Source: APXvYqwbwY/tRHNeMlVyOMhUfPQ/K9ToFzmME5XRnlVpsAljmIqsLcyYWwH8dgnVTfmT/peu5xsNwg==
X-Received: by 2002:a05:6402:6d2:: with SMTP id n18mr4440693edy.122.1557411756638;
        Thu, 09 May 2019 07:22:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9sm588021edh.95.2019.05.09.07.22.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2019 07:22:36 -0700 (PDT)
Date:   Thu, 09 May 2019 07:22:36 -0700 (PDT)
X-Google-Original-Date: Thu, 09 May 2019 14:22:24 GMT
Message-Id: <30c1b618b139e637122d9476f54d5eb8ce8e0d57.1557411749.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v4.git.gitgitgadget@gmail.com>
References: <pull.112.v3.git.gitgitgadget@gmail.com>
        <pull.112.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 06/11] commit-graph: extract fill_oids_from_packs()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, avarab@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The write_commit_graph() method is too complex, so we are
extracting methods one by one.

This extracts fill_oids_from_packs() that reads the given
pack-file list and fills the oid list in the context.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 83 ++++++++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 58f0f0ae34..80c7069aaa 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -867,6 +867,51 @@ int write_commit_graph_reachable(const char *obj_dir, unsigned int flags)
 	return result;
 }
 
+static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
+				struct string_list *pack_indexes)
+{
+	uint32_t i;
+	struct strbuf progress_title = STRBUF_INIT;
+	struct strbuf packname = STRBUF_INIT;
+	int dirlen;
+
+	strbuf_addf(&packname, "%s/pack/", ctx->obj_dir);
+	dirlen = packname.len;
+	if (ctx->report_progress) {
+		strbuf_addf(&progress_title,
+			    Q_("Finding commits for commit graph in %d pack",
+			       "Finding commits for commit graph in %d packs",
+			       pack_indexes->nr),
+			    pack_indexes->nr);
+		ctx->progress = start_delayed_progress(progress_title.buf, 0);
+		ctx->progress_done = 0;
+	}
+	for (i = 0; i < pack_indexes->nr; i++) {
+		struct packed_git *p;
+		strbuf_setlen(&packname, dirlen);
+		strbuf_addstr(&packname, pack_indexes->items[i].string);
+		p = add_packed_git(packname.buf, packname.len, 1);
+		if (!p) {
+			error(_("error adding pack %s"), packname.buf);
+			return 1;
+		}
+		if (open_pack_index(p)) {
+			error(_("error opening index for %s"), packname.buf);
+			return 1;
+		}
+		for_each_object_in_pack(p, add_packed_commits, ctx,
+					FOR_EACH_OBJECT_PACK_ORDER);
+		close_pack(p);
+		free(p);
+	}
+
+	stop_progress(&ctx->progress);
+	strbuf_reset(&progress_title);
+	strbuf_release(&packname);
+
+	return 0;
+}
+
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
@@ -916,42 +961,8 @@ int write_commit_graph(const char *obj_dir,
 	}
 
 	if (pack_indexes) {
-		struct strbuf packname = STRBUF_INIT;
-		int dirlen;
-		strbuf_addf(&packname, "%s/pack/", obj_dir);
-		dirlen = packname.len;
-		if (ctx->report_progress) {
-			strbuf_addf(&progress_title,
-				    Q_("Finding commits for commit graph in %d pack",
-				       "Finding commits for commit graph in %d packs",
-				       pack_indexes->nr),
-				    pack_indexes->nr);
-			ctx->progress = start_delayed_progress(progress_title.buf, 0);
-			ctx->progress_done = 0;
-		}
-		for (i = 0; i < pack_indexes->nr; i++) {
-			struct packed_git *p;
-			strbuf_setlen(&packname, dirlen);
-			strbuf_addstr(&packname, pack_indexes->items[i].string);
-			p = add_packed_git(packname.buf, packname.len, 1);
-			if (!p) {
-				error(_("error adding pack %s"), packname.buf);
-				res = 1;
-				goto cleanup;
-			}
-			if (open_pack_index(p)) {
-				error(_("error opening index for %s"), packname.buf);
-				res = 1;
-				goto cleanup;
-			}
-			for_each_object_in_pack(p, add_packed_commits, ctx,
-						FOR_EACH_OBJECT_PACK_ORDER);
-			close_pack(p);
-			free(p);
-		}
-		stop_progress(&ctx->progress);
-		strbuf_reset(&progress_title);
-		strbuf_release(&packname);
+		if ((res = fill_oids_from_packs(ctx, pack_indexes)))
+			goto cleanup;
 	}
 
 	if (commit_hex) {
-- 
gitgitgadget

