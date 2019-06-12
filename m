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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C4F41F462
	for <e@80x24.org>; Wed, 12 Jun 2019 13:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732451AbfFLN3s (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 09:29:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35307 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732426AbfFLN3n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 09:29:43 -0400
Received: by mail-ed1-f65.google.com with SMTP id p26so21743288edr.2
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 06:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=88zRa7ePmRWb9DNg5pht1AXctiNP/zlvbBsCWYBkYmw=;
        b=s4MrOWssQwHJwc9qm6P97B3Wg3nP9hT06dQLK6ICs2CVF9tNGGHK77HZnZbdrr3Arp
         u782ZrnvY83fqMBVqVzrcThWnmVOWBACCVxmVtBHGyRPxdTVUEqNaP65QCSEWigqwv13
         qW4k2immClGzwhWpLdYavh5sRiE/rS9zCcJPQLTwIjHEjCfKrk6Nha+GX1ufkG19CpK3
         7PEH+NMEn+eW9DrMMh1Eku3q49aWvIhiUSvRXtwlVQh4l4b8jK2ui2u1VxTYv+huk/XO
         OtctyzdgVVnMiZTSPdBHsmJDwASDJfespAIfRbfWB+e6aqQn3GsvZTFTRZn3eP3okDdk
         dtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=88zRa7ePmRWb9DNg5pht1AXctiNP/zlvbBsCWYBkYmw=;
        b=hKAOzAwcG3OBLYtLsHi7Ie+tfs+yY4NXED6l2qQZW3kJl/b0Gq45+0opxjNuoLVstW
         URAI75UQHngcHJ2Hrfcnsj6zduXBEdgrcbfjNgwkjwnpsjl+Ywugp9LUXLwTtDH1Ghc8
         ulJVUI23T0Kq5wNnwzeSgaNZLNIV74/WO6bRy7jt7toMyX8UKiIBx0fjqRVF92QvfWba
         V8MMDajrOeu27QSQHmd/9vrYX9nCKEyK/UjI/V18PWGXwhAbTavVLsUuIeUrjNuzBVmO
         XEwvNKsWQyuOWqUO9Bl8it3/jnl2zbT1wT7HYm9Gsa10sNllIp8V2bfmRe7B7iih0YYC
         PYkQ==
X-Gm-Message-State: APjAAAU10FkpfH+mTZlqGCb4XD1sjSo/B6pQzawqKmCfNM3LZT51WC8Y
        BB78t9mqEUO1kUBChJWH9Zkajfp8
X-Google-Smtp-Source: APXvYqyWSei3hJyY06Ql+xXrvYiNJIpiKhpMQzooZzEKFrgMgHsg1RcfEp+5hLyCxTRdqA3igL3LZw==
X-Received: by 2002:aa7:c810:: with SMTP id a16mr44812268edt.188.1560346181830;
        Wed, 12 Jun 2019 06:29:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4sm4546622edc.24.2019.06.12.06.29.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 06:29:41 -0700 (PDT)
Date:   Wed, 12 Jun 2019 06:29:41 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jun 2019 13:29:28 GMT
Message-Id: <98e243be673f9a29fb855d02845c7642e6375c8f.1560346174.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.112.v5.git.gitgitgadget@gmail.com>
References: <pull.112.v4.git.gitgitgadget@gmail.com>
        <pull.112.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 06/11] commit-graph: extract fill_oids_from_packs()
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
extracting helper functions one by one.

This extracts fill_oids_from_packs() that reads the given
pack-file list and fills the oid list in the context.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c | 83 ++++++++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 6d7e83cfe8..02e5f8c651 100644
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
+			return -1;
+		}
+		if (open_pack_index(p)) {
+			error(_("error opening index for %s"), packname.buf);
+			return -1;
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
-				res = -1;
-				goto cleanup;
-			}
-			if (open_pack_index(p)) {
-				error(_("error opening index for %s"), packname.buf);
-				res = -1;
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

