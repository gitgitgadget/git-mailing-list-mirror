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
	by dcvr.yhbt.net (Postfix) with ESMTP id 20C171F454
	for <e@80x24.org>; Wed,  6 Nov 2019 10:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731764AbfKFKAE (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 05:00:04 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:43648 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731633AbfKFKAB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 05:00:01 -0500
Received: by mail-wr1-f54.google.com with SMTP id n1so24961983wra.10
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 01:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=giO2GU2kHEWuMdLCQf18nZDaZn/nf7zmDq7PVNroH0w=;
        b=d+TRUvNLzYWPiKE4v+UHyzcLL7ec1jbUIAqIVFu0IGDkdRBkSPTVAVZkSNnpCJOgrF
         pdf7sHPwP0j4LQrdIdoPJlcpZtz4Sk7opDnCuFRgQvbMQpwn4lnxZj+6AmvvZjPgmfe7
         043k2FpzXew9eMw469ApCBrFy0OEmTndoPsHQ6g+DXBqiINP02nBRWbI7q2sMScuZKhz
         SghaR6rvKYtVpCuM2Mpr0ZpsOhXNIjVz/s1estRTJXL5+JyhzRKlJsAuOGJui7JjosHn
         cAqS1hO3tFgBvkJHHgzItP6Vi35H+3hPCJP08EBtcP1IShKMIBOG6VuMPC4pravaEQUZ
         3zcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=giO2GU2kHEWuMdLCQf18nZDaZn/nf7zmDq7PVNroH0w=;
        b=rbJmYK/SwR6qg6Gch/rxS+5kjFiKLP2w7X4J4575RvfcyMk2CkAHZYUj14n29EgUsS
         eLe10TAinE6mqR+xJTYU0Y6YybdzdzbmL6MjnwxZK+MpxyGFE0zzP6xgneF2Uw3wz2Vd
         pHGlAnUE+/Yq7OYs51f+0IeKv8JgtMrYSjdFXdVejlNDKjpJ53Z40S7+gQNeZMinWEDI
         W6r/RiNtiueShZOvnezWbbmxqeShoG/IhJbRsci3klvL6+GYnR6DyxHP966eo3rJXZBf
         vA4g/TM7M9+f2+hSEJ6M8jSmTRFicKuLB0zx2AJUkvmzQnR3e3qWIA5mS0h2gy+MCU79
         ckQQ==
X-Gm-Message-State: APjAAAUP5vsd4o5Y31Sb7VAj23IW/BVV8unF7wJIAPbxquPDHqbolIMa
        +DWR/PGJrn7I2lKC++EdDDmHhnGG
X-Google-Smtp-Source: APXvYqw+O8GPfoleIszf6F4KogKZDpRWxmT1hpgSK20VmP8NqhPm6iqoVTV0U7JOipn+Y2bXsfg5hw==
X-Received: by 2002:a5d:4a50:: with SMTP id v16mr1695103wrs.85.1573034398111;
        Wed, 06 Nov 2019 01:59:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g184sm2949350wma.8.2019.11.06.01.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 01:59:57 -0800 (PST)
Message-Id: <314864e42c10c64097090d10c42dfba0e407b97d.1573034387.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
        <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 09:59:40 +0000
Subject: [PATCH v2 13/20] argv-array: move doc to argv-array.h
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

