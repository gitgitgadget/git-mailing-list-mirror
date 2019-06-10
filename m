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
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C981F462
	for <e@80x24.org>; Mon, 10 Jun 2019 23:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390568AbfFJXfY (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 19:35:24 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45413 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390523AbfFJXfY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 19:35:24 -0400
Received: by mail-ed1-f65.google.com with SMTP id a14so15095499edv.12
        for <git@vger.kernel.org>; Mon, 10 Jun 2019 16:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sJMrQDICL9b/toaSjuLa++uCWddhhIkBGXD/UJovQFU=;
        b=G5kuW6JHEI6sEENCgdVoMcIOyEePmJ6KN/NNEsDvMS/wTgk1+o/OLvbNM2lqOaNCpU
         wpbLaunbImccBvExXfdjj38oqjar2fYh51KaJeVX0t1JXgJBn6CCrARo5FW8PrdVjeLn
         dkapSvSdNpKqsKzXFt1luBZQI3BtT666++uAs388+s8rLTGT9R2Wv4j4+B3QRuUWNel5
         u3uKpvdKk1vwxptTgZkKUGRqbN0Xt4netvrQwAEw4COWXJ1FHWXz3uyqx6hMnmZcJfa2
         7YTaBYK/bspPyAcDVwak3Ix//8o4zrV5CnDwqMMpODUhsNBXURCFEmnhLlZg3KL9vicF
         9qbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sJMrQDICL9b/toaSjuLa++uCWddhhIkBGXD/UJovQFU=;
        b=hmq4vziGeDvWhUPwuy68yJdIqD0znOWZ1KuCjItgnj7EC66sdz0B8AZtm62qk0GuQc
         /5uzZi52gkDNWK+cJP0uJZRNIrmgkpjqw5JZOeUaqQD5SvuJahbnJb/K96DtD44Vi7F0
         Yv70CSyRPfN9S3vbHz6CzGw04yMw0NHMuGQxYj2oUkSg5atSo51lm8cIZ3e3dlH2HzsW
         yfvnkAzzqnASn08sVKpJeHPE2RbzeaF3ZnZAulAw9pzSljf4Gn1w2O9dUJSJY77pYRKW
         JXK/iZneN3zfX9+fuqKuA+UAyNJiHUhaaqWos/kzOOWSivqUOswFaJK7GIcjtCUP3rx3
         d4Tg==
X-Gm-Message-State: APjAAAVR4z+6WOVbsNYj9alvrcp6EH0UJ2jSxG6vZZdg8N5S+klU2vz8
        mlOPZMsdJz/iQfxdGK/kQ/cfO9lq
X-Google-Smtp-Source: APXvYqxO7e6fbY95F/D1DCi1X4LEx0AxiGVz6b3rc/lyLDGhmyDHruSwCpJmbRrHApbMJy+H4/Hulw==
X-Received: by 2002:a50:b3fb:: with SMTP id t56mr25317954edd.303.1560209722464;
        Mon, 10 Jun 2019 16:35:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z10sm3277747edl.35.2019.06.10.16.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 16:35:22 -0700 (PDT)
Date:   Mon, 10 Jun 2019 16:35:22 -0700 (PDT)
X-Google-Original-Date: Mon, 10 Jun 2019 23:35:10 GMT
Message-Id: <3b424f7c2acafb400284089b218d2fb57f3192f2.1560209720.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.261.git.gitgitgadget@gmail.com>
References: <pull.261.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 01/11] repack: refactor pack deletion for future use
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, jrnieder@gmail.com,
        avarab@gmail.com, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>,
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
index 67f8978043..1f9e6fad1b 100644
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
index 060de420d1..683ce5674c 100644
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
index 12baa6118a..09f5222113 100644
--- a/packfile.h
+++ b/packfile.h
@@ -94,6 +94,13 @@ void unuse_pack(struct pack_window **);
 void clear_delta_base_cache(void);
 struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
 
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

