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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F27C1F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 21:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfKQVFL (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 16:05:11 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:35005 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbfKQVFL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 16:05:11 -0500
Received: by mail-wm1-f47.google.com with SMTP id 8so16585006wmo.0
        for <git@vger.kernel.org>; Sun, 17 Nov 2019 13:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=bIQFN7Giyzj0Cp3ZhrwOhNDIUw+bJ062AZKqqcec2l0=;
        b=LlY2sEfu77i6IX6YHAp1gXGAgb/yixWgpmCDEBy6ZFnz1TduHR1mELraZv+lSRHbtB
         xJlWDzXkvwjAteHxGf00aOkj4EL/b0JDbSxxGVoDZXAMgeLeRMMJK8ueZKuiRNiVqLou
         cGPKNboJP3mhxC5eLUWVP8hAX/sB4RMQ3WXDlYUGhBm2Kayd4T4etBpkr1t3QLy/YDuO
         ntAceHdjJqSoClJv1YK1T7GafIM1zKmjIA/3IkyMO7H8qk8MfjZcFYr9YGH48SSaUJHw
         yIFiSUM/o/iHUewi1V8jhhWyrnihLcc8oEEUWodVW9UJpEFybfk1izahLTWUBhzl1sxw
         /z/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=bIQFN7Giyzj0Cp3ZhrwOhNDIUw+bJ062AZKqqcec2l0=;
        b=WkRdTeXOUjPAw6Btc4DG36Ilrrs6+xFv+ccff3tepNzYljXkKmG4koGqvZvO4BWZqF
         SRC5NsVmK5r+62cE0s+22ho/q8aurJOGx35/bCrCjn2n9rMavwLuyr++ZJV6nqF2aOPt
         6T86VbjQw7b8eEBtSH20r4/mW41flOSaakOxR60MXqeOqlOGGjxpWkz7tPZostMUZ5hz
         fnAM3cxyaFpIbzlZQCwgIPfMWTpfuG94gWcXN0YUznDU9b6D+hYms6rjM0aQVwVYDS/c
         5664uzRAjnXUBXJ9TQnutZNvI3QY2QVbfi3nJQkpRCvxXP5juHV3jqlhto7gHGy1O3Ih
         mTVA==
X-Gm-Message-State: APjAAAXh3HifvLH9T9q+49vIjjuCxILSMUQmSUUQyoY6Qc44C9/zQlHC
        NUFUxl1drq7mNUut7D33q/ND5/XF
X-Google-Smtp-Source: APXvYqybq8qwaiYHwcroQo8EVxmtBVjhqsZkjsRywj/47uit9kp2KZN/Bdbu2XgypXA3orNr8McY6w==
X-Received: by 2002:a1c:1fca:: with SMTP id f193mr24122931wmf.173.1574024707869;
        Sun, 17 Nov 2019 13:05:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t134sm18921838wmt.24.2019.11.17.13.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2019 13:05:07 -0800 (PST)
Message-Id: <f84c1338faec73c75f422583f5b1d93d79295506.1574024700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
References: <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
        <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 Nov 2019 21:04:46 +0000
Subject: [PATCH v5 07/21] refs: move doc to refs.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Move the documentation from Documentation/technical/api-ref-iteration.txt
to refs.h as it's easier for the developers to find the usage
information beside the code instead of looking for it in another doc file.

Also documentation/technical/api-ref-iteration.txt is removed because the
information it has is now redundant and it'll be hard to keep it up to
date and synchronized with the documentation in the header file.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/technical/api-ref-iteration.txt | 78 -------------------
 refs.h                                        | 51 ++++++++++++
 2 files changed, 51 insertions(+), 78 deletions(-)
 delete mode 100644 Documentation/technical/api-ref-iteration.txt

diff --git a/Documentation/technical/api-ref-iteration.txt b/Documentation/technical/api-ref-iteration.txt
deleted file mode 100644
index ad9d019ff9..0000000000
--- a/Documentation/technical/api-ref-iteration.txt
+++ /dev/null
@@ -1,78 +0,0 @@
-ref iteration API
-=================
-
-
-Iteration of refs is done by using an iterate function which will call a
-callback function for every ref. The callback function has this
-signature:
-
-	int handle_one_ref(const char *refname, const struct object_id *oid,
-			   int flags, void *cb_data);
-
-There are different kinds of iterate functions which all take a
-callback of this type. The callback is then called for each found ref
-until the callback returns nonzero. The returned value is then also
-returned by the iterate function.
-
-Iteration functions
--------------------
-
-* `head_ref()` just iterates the head ref.
-
-* `for_each_ref()` iterates all refs.
-
-* `for_each_ref_in()` iterates all refs which have a defined prefix and
-  strips that prefix from the passed variable refname.
-
-* `for_each_tag_ref()`, `for_each_branch_ref()`, `for_each_remote_ref()`,
-  `for_each_replace_ref()` iterate refs from the respective area.
-
-* `for_each_glob_ref()` iterates all refs that match the specified glob
-  pattern.
-
-* `for_each_glob_ref_in()` the previous and `for_each_ref_in()` combined.
-
-* Use `refs_` API for accessing submodules. The submodule ref store could
-  be obtained with `get_submodule_ref_store()`.
-
-* `for_each_rawref()` can be used to learn about broken ref and symref.
-
-* `for_each_reflog()` iterates each reflog file.
-
-Submodules
-----------
-
-If you want to iterate the refs of a submodule you first need to add the
-submodules object database. You can do this by a code-snippet like
-this:
-
-	const char *path = "path/to/submodule"
-	if (add_submodule_odb(path))
-		die("Error submodule '%s' not populated.", path);
-
-`add_submodule_odb()` will return zero on success. If you
-do not do this you will get an error for each ref that it does not point
-to a valid object.
-
-Note: As a side-effect of this you cannot safely assume that all
-objects you lookup are available in superproject. All submodule objects
-will be available the same way as the superprojects objects.
-
-Example:
---------
-
-----
-static int handle_remote_ref(const char *refname,
-		const unsigned char *sha1, int flags, void *cb_data)
-{
-	struct strbuf *output = cb_data;
-	strbuf_addf(output, "%s\n", refname);
-	return 0;
-}
-
-...
-
-	struct strbuf output = STRBUF_INIT;
-	for_each_remote_ref(handle_remote_ref, &output);
-	printf("%s", output.buf);
-----
diff --git a/refs.h b/refs.h
index 730d05ad91..545029c6d8 100644
--- a/refs.h
+++ b/refs.h
@@ -310,19 +310,35 @@ int refs_for_each_branch_ref(struct ref_store *refs,
 int refs_for_each_remote_ref(struct ref_store *refs,
 			     each_ref_fn fn, void *cb_data);
 
+/* just iterates the head ref. */
 int head_ref(each_ref_fn fn, void *cb_data);
+
+/* iterates all refs. */
 int for_each_ref(each_ref_fn fn, void *cb_data);
+
+/**
+ * iterates all refs which have a defined prefix and strips that prefix from
+ * the passed variable refname.
+ */
 int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data);
+
 int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
 			     each_ref_fn fn, void *cb_data,
 			     unsigned int broken);
 int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data,
 			unsigned int broken);
+
+/**
+ * iterate refs from the respective area.
+ */
 int for_each_tag_ref(each_ref_fn fn, void *cb_data);
 int for_each_branch_ref(each_ref_fn fn, void *cb_data);
 int for_each_remote_ref(each_ref_fn fn, void *cb_data);
 int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data);
+
+/* iterates all refs that match the specified glob pattern. */
 int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
+
 int for_each_glob_ref_in(each_ref_fn fn, const char *pattern,
 			 const char *prefix, void *cb_data);
 
@@ -791,6 +807,41 @@ int reflog_expire(const char *refname, const struct object_id *oid,
 int ref_storage_backend_exists(const char *name);
 
 struct ref_store *get_main_ref_store(struct repository *r);
+
+/**
+ * Submodules
+ * ----------
+ *
+ * If you want to iterate the refs of a submodule you first need to add the
+ * submodules object database. You can do this by a code-snippet like
+ * this:
+ *
+ * 	const char *path = "path/to/submodule"
+ * 	if (add_submodule_odb(path))
+ * 		die("Error submodule '%s' not populated.", path);
+ *
+ * `add_submodule_odb()` will return zero on success. If you
+ * do not do this you will get an error for each ref that it does not point
+ * to a valid object.
+ *
+ * Note: As a side-effect of this you cannot safely assume that all
+ * objects you lookup are available in superproject. All submodule objects
+ * will be available the same way as the superprojects objects.
+ *
+ * Example:
+ * --------
+ *
+ * ----
+ * static int handle_remote_ref(const char *refname,
+ * 		const unsigned char *sha1, int flags, void *cb_data)
+ * {
+ * 	struct strbuf *output = cb_data;
+ * 	strbuf_addf(output, "%s\n", refname);
+ * 	return 0;
+ * }
+ *
+ */
+
 /*
  * Return the ref_store instance for the specified submodule. For the
  * main repository, use submodule==NULL; such a call cannot fail. For
-- 
gitgitgadget

