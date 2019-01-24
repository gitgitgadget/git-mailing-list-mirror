Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E86E91F453
	for <e@80x24.org>; Thu, 24 Jan 2019 21:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfAXVv5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 16:51:57 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45955 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbfAXVv5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 16:51:57 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so5799799edb.12
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 13:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cr7MdApjmJUktJ5Q5K3N1as5Z14llMEvJbtdmyAZi3g=;
        b=tPhReTX4yiYlvaQJlsOBzrVvtCh4Es6Hy6SkZMcc64jt6Jq5WNilwlqnMDpVhkIDRo
         2rQnXA4cYI/rQF2i/bXJV9P8fNXJFpCd5xaAaiPM7gIsq/5pDrAVI77EHrWQIUEHAsl8
         I5SitWiHGHm7KZvMQ3Nocj8Q74tVMHT3OhOVkP0yAJVPOClRej/XKBrDH8xQ3xsEI9va
         x+U0zYMACk8f9AnCq22q9K6qzXy647TBALuGW+lqBtwxojgBm5vXtd5XQlXtRHBlg1E+
         hYfFYzqE+pjL8fpYnxEltGi1vi8v/xniveabL4PwiVwus07JYSt+5aknES6cdjaUkYsJ
         LjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cr7MdApjmJUktJ5Q5K3N1as5Z14llMEvJbtdmyAZi3g=;
        b=DwutKVrkawy+/YfGLHWKyNr88+PJItn/vjM47v6zNj4ivVElUtAPm6Nm9p5dg27XK6
         IVUHirRIiuF6kNNNrmEa/Zo2RERLpM5Pj1jI4qIcUtxCFF5c4pdRguQGip8noyS41i1p
         wS5HBCRTkb6DmlL5aJarcGGd2JUQbTjfvRYCIIPsYyCnZmNwwcUBVqrXrz08o2aFOORG
         I+KwLKDLtNRN6fZeiOpCEt9JQ/9QFQK9s1T7ZGCRACvIz00+1AcsBfElqldf8oI+yOU9
         fnoYA+3X9exKrBHEpJXVmjaXTULmJZhy9IPGMUevbebTOb9HV5Eny/xftiMICz5RbPrv
         IPVQ==
X-Gm-Message-State: AJcUukc7JJudEzkXDYf6hZ8nIEwV2XmxXen5TUfcdLZ+ZiYUVN0OJa1Y
        LJ9M8A6BUkbehCHm0hSK3s9ODo/E
X-Google-Smtp-Source: ALg8bN5lio8rSQNQ4zb96OXxnxwlt2nrS4vQz3uMFQxG2SkxMxb3MtabNbNLCfkSPzLRZOsXwHRwIQ==
X-Received: by 2002:a50:ce0f:: with SMTP id y15mr7906950edi.207.1548366715323;
        Thu, 24 Jan 2019 13:51:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v11sm11074861edy.49.2019.01.24.13.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 13:51:54 -0800 (PST)
Date:   Thu, 24 Jan 2019 13:51:54 -0800 (PST)
X-Google-Original-Date: Thu, 24 Jan 2019 21:51:44 GMT
Message-Id: <62b393b816d65a578c7a0ff9b40f01e0637e4d67.1548366713.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.v4.git.gitgitgadget@gmail.com>
References: <pull.92.v3.git.gitgitgadget@gmail.com>
        <pull.92.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 01/10] repack: refactor pack deletion for future use
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

