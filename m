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
	by dcvr.yhbt.net (Postfix) with ESMTP id 365D21F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 09:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727510AbfKOJyD (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 04:54:03 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:39184 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfKOJyC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 04:54:02 -0500
Received: by mail-wm1-f52.google.com with SMTP id t26so9668567wmi.4
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 01:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=giO2GU2kHEWuMdLCQf18nZDaZn/nf7zmDq7PVNroH0w=;
        b=lETkoQhRuGwjV7lMHK9X7CbAooAXzqe9qM+9tembHIMKWR0VzSOUJXCY4te2XMsjGg
         sgpyHdQmp4w/lzZRTQR20/pxgURqmvLc8ynrInEaB7RJNEM0MLVQLp9Nx7oU4TrJ1HXZ
         2Px+IOjKyPmJ6sm1h6NB2NouSR/o1VTbOfY08vC+8NDVZVhZ7R1I1evX+QaksuO3cUdu
         Na0y7Q3pTDZ0FY3a4SN1trXIgx3mrQkhosr2oYq6T6fDU4ngC3dEuoDVYMmV5FsHy5vD
         XLKrfDDtP2er7Vo6EN20zapgSPLljecgB6bX5LnKPj9KLINLENY22VQ0hMOUI6qZNIdE
         7ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=giO2GU2kHEWuMdLCQf18nZDaZn/nf7zmDq7PVNroH0w=;
        b=OBOV3O1P7J9bV/TvElXeGeAfRcNKWI35wXtM4QjuvKnUa3O87NhZQioOfdKXorlVjH
         whvOj4m3iOh/sqLLifNPq9LtcsY2gEy9NIo5x1xTq4n92z9bzdYMaTP1p2hysLgC0N0G
         xjTqtZFM7QV5NZQPxqR2rVdqlI0DI4JNAPF2WAyKXtaeVQJEp6acvKTIlw5KlZW3HcOP
         JdeI9934cLQkbgdFd9DIhK7GlYzNlIQzvRUXuNpYQFgqiuXVNsGuzkqZpCyq7hohxlbC
         4CqGIsYJwk73wT5v3YL7s/qga0DJ5+8mVtSTQa8RaoFnCXSVs+NgnmDD8vCjlTHSNaFC
         FMaw==
X-Gm-Message-State: APjAAAVuAao7jNwitzNXMC+JI38OuUTG3UrVlxuy854q8inhbcjHPDNe
        c9f6BVy6lIu5WXCh+bWleaGJWjwC
X-Google-Smtp-Source: APXvYqzVa/GU6zkmKtf+FVtv4hdS/134M84EWXw6TT2dV9QFidJag6dZk+amikB00u2m4yN8bj41RA==
X-Received: by 2002:a1c:650b:: with SMTP id z11mr13408906wmb.149.1573811638653;
        Fri, 15 Nov 2019 01:53:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 19sm12829685wrc.47.2019.11.15.01.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 01:53:58 -0800 (PST)
Message-Id: <4f805c873759b5d95b546e95bad15aa818927b33.1573811627.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
References: <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
        <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 09:53:38 +0000
Subject: [PATCH v4 13/21] argv-array: move doc to argv-array.h
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

