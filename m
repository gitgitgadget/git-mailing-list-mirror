Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 034E11F405
	for <e@80x24.org>; Fri, 21 Dec 2018 16:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389215AbeLUQ2k (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Dec 2018 11:28:40 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45602 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389175AbeLUQ2k (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Dec 2018 11:28:40 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so5106341edb.12
        for <git@vger.kernel.org>; Fri, 21 Dec 2018 08:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=cr7MdApjmJUktJ5Q5K3N1as5Z14llMEvJbtdmyAZi3g=;
        b=UYHbFTEYaMi5AjjJZrKJ6OTNeIOPe691W+o7wPDoNQd4uOBIHOiSYph+h6VXZ+7pMb
         9oLojTizjl9pd/eqstkTpJjGPqo1W1TKLWf8o34oxbHfnTzJYMFEse3QxFsRXeLbJVEw
         p9cPdnwSVmamER5vCSeBS08Hnx4cVbLQ0c4aGL7jMC3tGXBklD0usD9n2/4/mvG24ZbH
         nAbyWIwn+BVLR354szEocxQmwQvwa/kHR+IfnfUI4/+j8zLN216mG7sRxcmeNXgVFEt+
         TV0hOhTyUqLbvyK37BG2L++EQTNwiV6d9irdQr/b/eH+ATCg3T+0hnjzGstQz2Iz8veL
         +LXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=cr7MdApjmJUktJ5Q5K3N1as5Z14llMEvJbtdmyAZi3g=;
        b=V0WYVTlAGZj8j3fsJf9bqk4/+NGVGSGSeeIlS6Q9xAWlcIK3G4kjuOQpz386SuhyfF
         ThFyOHE188LewmvvMSR+lW7W5+iN8XUKZPG/VoivI/kEWY9kCRGaTfn1OuOybxuDPSYQ
         j4wY1W/bfwoiXcP51q3o0sNPYIER3gDQ72SMvLV6xkhdJf7iAVdtQ4Nkbzy81nS/ud4t
         teTBo+92cOfIFHRF3eebVR4oamZRYQnlQh4jO39VydHdAPt8BR1ndMrR7zPI41DRO9jy
         4kxjtVpyoQAPF1Op2eeHKFgKlhqq7jw3TL/bsxxFYDhbA55yTOJ8EcivBzZ2Da6NhI2x
         uNhA==
X-Gm-Message-State: AA+aEWb00+yBDide9fuNJthqwZ5fWlAy7zwgssOJj98pGIdN2C4/xRRe
        7nqjUL1EiBxtij/yQFlqqRqxYQKDuF2/vA==
X-Google-Smtp-Source: AFSGD/W0bWmhzxFfR7TDfZPzBBkj3roJMyPE7QsIh9HJIO4bnyA9nbETLKVS/PWPxMzLv9IOei+2sg==
X-Received: by 2002:a17:906:738b:: with SMTP id f11-v6mr2571543ejl.234.1545409718324;
        Fri, 21 Dec 2018 08:28:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g13-v6sm3700831ejr.1.2018.12.21.08.28.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 08:28:37 -0800 (PST)
Date:   Fri, 21 Dec 2018 08:28:37 -0800 (PST)
X-Google-Original-Date: Fri, 21 Dec 2018 16:28:30 GMT
Message-Id: <a697df120c9a4b5bc39fb9a028d4d19ff0559cf3.1545409716.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.92.v2.git.gitgitgadget@gmail.com>
References: <pull.92.git.gitgitgadget@gmail.com>
        <pull.92.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/7] repack: refactor pack deletion for future use
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

