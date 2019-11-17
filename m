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
	by dcvr.yhbt.net (Postfix) with ESMTP id F1ED71F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 21:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfKQVFR (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 16:05:17 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:43149 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfKQVFP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 16:05:15 -0500
Received: by mail-wr1-f43.google.com with SMTP id n1so17072822wra.10
        for <git@vger.kernel.org>; Sun, 17 Nov 2019 13:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=giO2GU2kHEWuMdLCQf18nZDaZn/nf7zmDq7PVNroH0w=;
        b=boMxglaMT9iXE0aAPhALmENmqQD0eXlK0O1+Dty4Zav+FNupHacMc90DI/TgOFgvP1
         nyzuksyteaBBd5ynAGPbAAepU6AqqF/EscKXDpYliu/3Xx5BruNXBFGB2In3Saes4gDz
         6yv9u0YjCAwJT4SbpTM+mIRBv8mDUsAPL55aLwkkpe+phLYfoSHX7lrYJ78ulEmFpCI9
         qSLgHmLWsAgw0OKKAf9HbfUg43cdb5b42ug4USgmxYtR95kTQXmkG8m19Gm1A/trByuC
         rTOyyxjm1BLFcIskSjWPyeXt18OL3JnSweE+hcPa8mtrzCMJNRyxiQWYIAI1eBklMnrL
         Tg3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=giO2GU2kHEWuMdLCQf18nZDaZn/nf7zmDq7PVNroH0w=;
        b=DUEvEtLIjJfDbRrrgNV+s5e+wGhzpuW1nEceKfgn+HcWCMrLnjAnUV1g6gO3lKGquU
         Yfh+SEVIwp4yjUELeS3+iD5bCBOwe9NVxOMZ5J9fXbats7Bcp86bKE19oxW9jgbZOjPD
         tYe6hTSRZ89LlWbE8SYLZi2RyvqOBWZgZsRhrMzziwMv5bEhZIRwx5k19RKVinQLfBH1
         INIgb0PXus1gvs59OCo4myKzLk8yTQU5+JoHc2lDgimGQg9VAfdaIPc440SJh36iLokX
         kv+ryEDZ+2MfHESk7NAiC+EDixN1gMqp/qUP6EjQC2i4yGaxFZxuRFlj8Ky8/ovwSctv
         CXQQ==
X-Gm-Message-State: APjAAAXS3P7NH9s0YOAZMb9D0PR/+U64QdjfarE4IW+A3QNAEQu1dYsI
        ilDQ19gbkcT90iSLOX2YCxmvEsqi
X-Google-Smtp-Source: APXvYqx1cONQHE9YP4VEORMwTDVT1ERaJ02hFYaljyd02okgd+j1tfymZXhpDexjy98OhAEURVZJuw==
X-Received: by 2002:a5d:518c:: with SMTP id k12mr26541887wrv.104.1574024712091;
        Sun, 17 Nov 2019 13:05:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s17sm17139828wmh.41.2019.11.17.13.05.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2019 13:05:11 -0800 (PST)
Message-Id: <4f805c873759b5d95b546e95bad15aa818927b33.1574024701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
References: <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
        <pull.434.v5.git.1574024700.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 Nov 2019 21:04:52 +0000
Subject: [PATCH v5 13/21] argv-array: move doc to argv-array.h
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

Move the documentation from Documentation/technical/api-argv-array.txt
to argv-array.h as it's easier for the developers to find the usage
information beside the code instead of looking for it in another doc file.

Also documentation/technical/api-argv-array.txt is removed because the
information it has is now redundant and it'll be hard to keep it up to
date and synchronized with the documentation in the header file.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/technical/api-argv-array.txt | 65 ----------------------
 argv-array.h                               | 62 +++++++++++++++++++++
 2 files changed, 62 insertions(+), 65 deletions(-)
 delete mode 100644 Documentation/technical/api-argv-array.txt

diff --git a/Documentation/technical/api-argv-array.txt b/Documentation/technical/api-argv-array.txt
deleted file mode 100644
index 870c8edbfb..0000000000
--- a/Documentation/technical/api-argv-array.txt
+++ /dev/null
@@ -1,65 +0,0 @@
-argv-array API
-==============
-
-The argv-array API allows one to dynamically build and store
-NULL-terminated lists.  An argv-array maintains the invariant that the
-`argv` member always points to a non-NULL array, and that the array is
-always NULL-terminated at the element pointed to by `argv[argc]`. This
-makes the result suitable for passing to functions expecting to receive
-argv from main(), or the link:api-run-command.html[run-command API].
-
-The string-list API (documented in string-list.h) is similar, but cannot be
-used for these purposes; instead of storing a straight string pointer,
-it contains an item structure with a `util` field that is not compatible
-with the traditional argv interface.
-
-Each `argv_array` manages its own memory. Any strings pushed into the
-array are duplicated, and all memory is freed by argv_array_clear().
-
-Data Structures
----------------
-
-`struct argv_array`::
-
-	A single array. This should be initialized by assignment from
-	`ARGV_ARRAY_INIT`, or by calling `argv_array_init`. The `argv`
-	member contains the actual array; the `argc` member contains the
-	number of elements in the array, not including the terminating
-	NULL.
-
-Functions
----------
-
-`argv_array_init`::
-	Initialize an array. This is no different than assigning from
-	`ARGV_ARRAY_INIT`.
-
-`argv_array_push`::
-	Push a copy of a string onto the end of the array.
-
-`argv_array_pushl`::
-	Push a list of strings onto the end of the array. The arguments
-	should be a list of `const char *` strings, terminated by a NULL
-	argument.
-
-`argv_array_pushf`::
-	Format a string and push it onto the end of the array. This is a
-	convenience wrapper combining `strbuf_addf` and `argv_array_push`.
-
-`argv_array_pushv`::
-	Push a null-terminated array of strings onto the end of the array.
-
-`argv_array_pop`::
-	Remove the final element from the array. If there are no
-	elements in the array, do nothing.
-
-`argv_array_clear`::
-	Free all memory associated with the array and return it to the
-	initial, empty state.
-
-`argv_array_detach`::
-	Disconnect the `argv` member from the `argv_array` struct and
-	return it. The caller is responsible for freeing the memory used
-	by the array, and by the strings it references. After detaching,
-	the `argv_array` is in a reinitialized state and can be pushed
-	into again.
diff --git a/argv-array.h b/argv-array.h
index a39ba43f57..a7d3b10707 100644
--- a/argv-array.h
+++ b/argv-array.h
@@ -1,8 +1,32 @@
 #ifndef ARGV_ARRAY_H
 #define ARGV_ARRAY_H
 
+/**
+ * The argv-array API allows one to dynamically build and store
+ * NULL-terminated lists.  An argv-array maintains the invariant that the
+ * `argv` member always points to a non-NULL array, and that the array is
+ * always NULL-terminated at the element pointed to by `argv[argc]`. This
+ * makes the result suitable for passing to functions expecting to receive
+ * argv from main().
+ *
+ * The string-list API (documented in string-list.h) is similar, but cannot be
+ * used for these purposes; instead of storing a straight string pointer,
+ * it contains an item structure with a `util` field that is not compatible
+ * with the traditional argv interface.
+ *
+ * Each `argv_array` manages its own memory. Any strings pushed into the
+ * array are duplicated, and all memory is freed by argv_array_clear().
+ */
+
 extern const char *empty_argv[];
 
+/**
+ * A single array. This should be initialized by assignment from
+ * `ARGV_ARRAY_INIT`, or by calling `argv_array_init`. The `argv`
+ * member contains the actual array; the `argc` member contains the
+ * number of elements in the array, not including the terminating
+ * NULL.
+ */
 struct argv_array {
 	const char **argv;
 	int argc;
@@ -11,17 +35,55 @@ struct argv_array {
 
 #define ARGV_ARRAY_INIT { empty_argv, 0, 0 }
 
+/**
+ * Initialize an array. This is no different than assigning from
+ * `ARGV_ARRAY_INIT`.
+ */
 void argv_array_init(struct argv_array *);
+
+/* Push a copy of a string onto the end of the array. */
 const char *argv_array_push(struct argv_array *, const char *);
+
+/**
+ * Format a string and push it onto the end of the array. This is a
+ * convenience wrapper combining `strbuf_addf` and `argv_array_push`.
+ */
 __attribute__((format (printf,2,3)))
 const char *argv_array_pushf(struct argv_array *, const char *fmt, ...);
+
+/**
+ * Push a list of strings onto the end of the array. The arguments
+ * should be a list of `const char *` strings, terminated by a NULL
+ * argument.
+ */
 LAST_ARG_MUST_BE_NULL
 void argv_array_pushl(struct argv_array *, ...);
+
+/* Push a null-terminated array of strings onto the end of the array. */
 void argv_array_pushv(struct argv_array *, const char **);
+
+/**
+ * Remove the final element from the array. If there are no
+ * elements in the array, do nothing.
+ */
 void argv_array_pop(struct argv_array *);
+
 /* Splits by whitespace; does not handle quoted arguments! */
 void argv_array_split(struct argv_array *, const char *);
+
+/**
+ * Free all memory associated with the array and return it to the
+ * initial, empty state.
+ */
 void argv_array_clear(struct argv_array *);
+
+/**
+ * Disconnect the `argv` member from the `argv_array` struct and
+ * return it. The caller is responsible for freeing the memory used
+ * by the array, and by the strings it references. After detaching,
+ * the `argv_array` is in a reinitialized state and can be pushed
+ * into again.
+ */
 const char **argv_array_detach(struct argv_array *);
 
 #endif /* ARGV_ARRAY_H */
-- 
gitgitgadget

