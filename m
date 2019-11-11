Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 267F81F454
	for <e@80x24.org>; Mon, 11 Nov 2019 21:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfKKV2Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 16:28:24 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:36770 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbfKKV2S (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 16:28:18 -0500
Received: by mail-wm1-f52.google.com with SMTP id c22so807119wmd.1
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 13:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=giO2GU2kHEWuMdLCQf18nZDaZn/nf7zmDq7PVNroH0w=;
        b=FtB2w75NsVTjdanA3LIOHaCr7WoOENlcmtt3JiX1O/sWkXm7et5UdVNSg1cxYJEAnC
         jwDv8orUM35AnjQ/mkcdEV59C3rp7kf/hQ3i/Wf2CANMj3P7ZR8FCLmqne4DnHTRO2Pg
         3o30jtIm61e+f8lSomV/NVQDMDsgW/OtKCel/w0Uolja/0RBdlzw3Y6Ek0iV2xHEORrt
         /9CkTuSLUUuLBlU1mZ9YoEaoPlAR08srBRRwPeOrlxGMp8iNBti3r1H2WibuA36KeVXS
         N65B/izwHilI+oDIvaRvMmM7wFkCI5NUjRCBn7p+qYUYaqAHl+iy/LYLEb1k0xxTXZ1i
         gjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=giO2GU2kHEWuMdLCQf18nZDaZn/nf7zmDq7PVNroH0w=;
        b=ui2YQp4NNMvMcgK7jaU7Nb+h/pSqgAvRwUw0dkSocugXFg/tywKpmdJ0AEcsZCtTTi
         U7vXdY7zRa8Ol6a6fbUVAGxQPBbdZ7ptB9zccdBmOiC47YzTsHeqpuFVACOSNlaHRqYK
         fYxu7/m6T9oYk+SSO8HIXakSWi3aaTTEAyyhFHx6MDY1wxx68lKBO7hufu481fGR0Jwi
         JwPBOrKH8GW3x+TWLV19DqtUMyDmYnz+ZWd2jCURxcPuJ143hYgzxxxNfUGRlxabwx1u
         mSLmWY0tB6TaEAUiBUNQXu3bxYPMkW4zI/ecljwp0OdPl7sJ7lsIMErb5/G+Z8KBhyA5
         z7Aw==
X-Gm-Message-State: APjAAAVqkPzT9r36XHcfQmnqy5bjr3LoAjdN1H115RGXHqlE2+Zv99Q+
        Y+MOhjCf+FoxN936sSxQBvQuYvli
X-Google-Smtp-Source: APXvYqzG41WijPC0NzJudxv+bfiTEWtH/4aFTdsxGRu63QQL8IfGmRSC+6W8hFP/Ii+3vK8Nj6ohag==
X-Received: by 2002:a1c:9646:: with SMTP id y67mr844183wmd.79.1573507696592;
        Mon, 11 Nov 2019 13:28:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w18sm23350697wrp.31.2019.11.11.13.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 13:28:16 -0800 (PST)
Message-Id: <debc035d403158bd741db7923feb5f9875496733.1573507684.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
References: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
        <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 Nov 2019 21:27:56 +0000
Subject: [PATCH v3 13/21] argv-array: move doc to argv-array.h
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

