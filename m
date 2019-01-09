Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7230211B4
	for <e@80x24.org>; Wed,  9 Jan 2019 15:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732224AbfAIPVQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Jan 2019 10:21:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33993 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730956AbfAIPVP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jan 2019 10:21:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so8098848wrw.1
        for <git@vger.kernel.org>; Wed, 09 Jan 2019 07:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cr7MdApjmJUktJ5Q5K3N1as5Z14llMEvJbtdmyAZi3g=;
        b=GmCQziWX92gtgt4dv98Me79QTMW6sq3WRA4lPtBHnI7ZR2ZZsKtzLj8CV/Fr9NZisC
         sg+UF5GMLtVlKE1Q/QeyTFjJ7TK3F9ZwnsyVIAxg/mKQAcOBlCPvNPTs9Wc3pjV13ASx
         PDNI7dD4JzSlmeGEklnqZiT1ZVymohs47TzftbSo1b/KQMgiFWTdUQoXS6rLfsN+YyW/
         JYS5wP/AiL8N41s2/TgTEc6lEUPku0CFQYmexLgPPOPbqYMQObS7qa0bKTToZcUCRQ2a
         huBRgX1ymE/RRvBkjpc4/QYSDRMbrt8ZO4V7dStpqjcDHgCU0K4SForuJEsg+oAA0iFM
         T/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cr7MdApjmJUktJ5Q5K3N1as5Z14llMEvJbtdmyAZi3g=;
        b=YBg3F2PPfUnZxne7x1GKMSqK2kDLoMEhe1pCjG+ARlxFtwAv4xU8qa76bTRfo/J98p
         ieboR5gVlwVYsY2aY1Vvxz52Eim5PrUhHm+B1xuHhpcUJ768wHUneii3hrVuwgC3smlo
         to0Xhz/yAerfC6aud/q9vJY9erB1C2OGWuUzw1Ja7I98IrNYwXYQCoX3l+WFaIGYtCbU
         ZBWsvtzra1J32qE+Y+HFqbLYRj2jit1GOqD5708J98OTCzz78s9rXYUqWCqAK2Lh13eh
         2bS0LJOh96sk1DgusevmocsZNKX1s4xHW0Y60dMo6FP472PS8bG+c8z5K0aRlnxsBBkE
         XCjA==
X-Gm-Message-State: AJcUuke8GZ5m/Xbyl8CfI9Inn0hVbGhJhyNI8oFwGWLoL0bdxSPSdkhF
        rwWWJY7sBnw6ru64XhtQlga85pFp
X-Google-Smtp-Source: ALg8bN4lNfvDbEG7E/kda+FgBTxDflHmyKW34EINPWRoEgrvG7gcOxGlg5dCWQpPwe0osyVMA69Zeg==
X-Received: by 2002:adf:b307:: with SMTP id j7mr5897078wrd.46.1547047272921;
        Wed, 09 Jan 2019 07:21:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y13sm46434286wrn.73.2019.01.09.07.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 07:21:12 -0800 (PST)
Date:   Wed, 09 Jan 2019 07:21:12 -0800 (PST)
X-Google-Original-Date: Wed, 09 Jan 2019 15:21:01 GMT
Message-Id: <62b393b816d65a578c7a0ff9b40f01e0637e4d67.1547047269.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.v3.git.gitgitgadget@gmail.com>
References: <pull.92.v2.git.gitgitgadget@gmail.com>
        <pull.92.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 1/9] repack: refactor pack deletion for future use
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The repack builtin deletes redundant pack-files and their
associated .idx, .promisor, .bitmap, and .keep files. We will want
to re-use this logic in the future for other types of repack, so
pull the logic into 'unlink_pack_path()' in packfile.c.

The 'ignore_keep' parameter is enabled for the use in repack, but
will be important for a future caller.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/repack.c | 14 ++------------
 packfile.c       | 28 ++++++++++++++++++++++++++++
 packfile.h       |  7 +++++++
 3 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 45583683ee..3d445b34b4 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -129,19 +129,9 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list,
 
 static void remove_redundant_pack(const char *dir_name, const char *base_name)
 {
-	const char *exts[] = {".pack", ".idx", ".keep", ".bitmap", ".promisor"};
-	int i;
 	struct strbuf buf = STRBUF_INIT;
-	size_t plen;
-
-	strbuf_addf(&buf, "%s/%s", dir_name, base_name);
-	plen = buf.len;
-
-	for (i = 0; i < ARRAY_SIZE(exts); i++) {
-		strbuf_setlen(&buf, plen);
-		strbuf_addstr(&buf, exts[i]);
-		unlink(buf.buf);
-	}
+	strbuf_addf(&buf, "%s/%s.pack", dir_name, base_name);
+	unlink_pack_path(buf.buf, 1);
 	strbuf_release(&buf);
 }
 
diff --git a/packfile.c b/packfile.c
index d1e6683ffe..bacecb4d0d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -352,6 +352,34 @@ void close_all_packs(struct raw_object_store *o)
 	}
 }
 
+void unlink_pack_path(const char *pack_name, int force_delete)
+{
+	static const char *exts[] = {".pack", ".idx", ".keep", ".bitmap", ".promisor"};
+	int i;
+	struct strbuf buf = STRBUF_INIT;
+	size_t plen;
+
+	strbuf_addstr(&buf, pack_name);
+	strip_suffix_mem(buf.buf, &buf.len, ".pack");
+	plen = buf.len;
+
+	if (!force_delete) {
+		strbuf_addstr(&buf, ".keep");
+		if (!access(buf.buf, F_OK)) {
+			strbuf_release(&buf);
+			return;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(exts); i++) {
+		strbuf_setlen(&buf, plen);
+		strbuf_addstr(&buf, exts[i]);
+		unlink(buf.buf);
+	}
+
+	strbuf_release(&buf);
+}
+
 /*
  * The LRU pack is the one with the oldest MRU window, preferring packs
  * with no used windows, or the oldest mtime if it has no windows allocated.
diff --git a/packfile.h b/packfile.h
index 6c4037605d..5b7bcdb1dd 100644
--- a/packfile.h
+++ b/packfile.h
@@ -86,6 +86,13 @@ extern void unuse_pack(struct pack_window **);
 extern void clear_delta_base_cache(void);
 extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
 
+/*
+ * Unlink the .pack and associated extension files.
+ * Does not unlink if 'force_delete' is false and the pack-file is
+ * marked as ".keep".
+ */
+extern void unlink_pack_path(const char *pack_name, int force_delete);
+
 /*
  * Make sure that a pointer access into an mmap'd index file is within bounds,
  * and can provide at least 8 bytes of data.
-- 
gitgitgadget

