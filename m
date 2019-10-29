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
	by dcvr.yhbt.net (Postfix) with ESMTP id BC7BE1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 10:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfJ2KA5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 06:00:57 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:36053 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfJ2KA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 06:00:56 -0400
Received: by mail-wr1-f51.google.com with SMTP id w18so12932961wrt.3
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 03:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CIlb7vhgvVx3vjpkNksrPt/9jqhoDqOBOGxQUnA8eKA=;
        b=D+jva+FFTWN3YcvjtGIc4AijeoBGopfzoM3/Y/ikCrDcXW8h0n1VAlvqtEsmaOl5ug
         gILpFI+fIVbdbsLfYoQ1SzGA6EOnwIgtmBFBo+hNxFeBtgCevTK9W3fmU5CBkdh9tgG3
         jzmV4gfo0EzZ2qRMlIwfKoTcjrGrAouLynd6GLVHgV4MGw2nFqRA2bPZubTcn3TQXEo8
         Xx3UCem/v8WZS9xMYFES+gwU3Gn7IHMLjrl39F0gOH4zIs8Qf6HChu6M1RZxXvIj3SAm
         DWNqfvFMCMKOy9bgcIwE+VzBvrjJaG2V+vmW8GF0UxxS4ANono+M7er3lUN+umkcCwNa
         SSng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CIlb7vhgvVx3vjpkNksrPt/9jqhoDqOBOGxQUnA8eKA=;
        b=YCCncJUDaenlp3u5Gwt4pK6cUHJK/E4PQivLXiASWNkUg1EUW/jNrgsGTJyEkTgf3l
         +e2Ofe8vcKtaDniiULdbO0tXuoaDJb+9sYgbrm72kpdP5qWgi/4auDDooICNvpDIvjsS
         gVRTrihYTgjlEm0Qmwl2SF2M3vJDLfEgLbUiEIn+eaRw+Ukqiz+30Ee7HkiTjxkoaHF3
         d8yU5x+kxtMS0H7xdxUvutbhfhjUioqQs5ABWB1filApoFSIjCP40uRFsrbbxlSOimJb
         WSVjQJmcwU9ZxUb3AYLIJGswjmYI3VrUwzrLAjGtSTj8fPDUhMdk4GsIrVWeO2YY1hwX
         bAKA==
X-Gm-Message-State: APjAAAWz2LxDeEUPo30DfCaKN7nlNxaySqdDM4WIqDkCHj42JfLLjBot
        xjF/LvimcCnKHustPLS0IKOPm9Gc
X-Google-Smtp-Source: APXvYqxGKDheyLu/NAEMfp2vm1CiAGuivLPrqmUnLlcOhpcoFpheUIlhs3ycE0bhb6F2TWexUCN3cw==
X-Received: by 2002:a5d:63c1:: with SMTP id c1mr18135518wrw.332.1572343253914;
        Tue, 29 Oct 2019 03:00:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c8sm1936620wml.44.2019.10.29.03.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 03:00:53 -0700 (PDT)
Message-Id: <052d4e5e56ae7b7d672579efc540d191a101bb2b.1572343246.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.git.1572343246.gitgitgadget@gmail.com>
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Oct 2019 10:00:44 +0000
Subject: [PATCH 08/10] attr: move doc to attr.h
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

Move the documentation from Documentation/technical/api-gitattributes.txt
to attr.h as it's easier for the developers to find the usage
information beside the code instead of looking for it in another doc file.

Also documentation/technical/api-gitattributes.txt is removed because the
information it has is now redundant and it'll be hard to keep it up to
date and synchronized with the documentation in the header file.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/technical/api-gitattributes.txt | 154 ------------------
 attr.h                                        | 141 +++++++++++++++-
 2 files changed, 134 insertions(+), 161 deletions(-)
 delete mode 100644 Documentation/technical/api-gitattributes.txt

diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
deleted file mode 100644
index 45f0df600f..0000000000
--- a/Documentation/technical/api-gitattributes.txt
+++ /dev/null
@@ -1,154 +0,0 @@
-gitattributes API
-=================
-
-gitattributes mechanism gives a uniform way to associate various
-attributes to set of paths.
-
-
-Data Structure
---------------
-
-`struct git_attr`::
-
-	An attribute is an opaque object that is identified by its name.
-	Pass the name to `git_attr()` function to obtain the object of
-	this type.  The internal representation of this structure is
-	of no interest to the calling programs.  The name of the
-	attribute can be retrieved by calling `git_attr_name()`.
-
-`struct attr_check_item`::
-
-	This structure represents one attribute and its value.
-
-`struct attr_check`::
-
-	This structure represents a collection of `attr_check_item`.
-	It is passed to `git_check_attr()` function, specifying the
-	attributes to check, and receives their values.
-
-
-Attribute Values
-----------------
-
-An attribute for a path can be in one of four states: Set, Unset,
-Unspecified or set to a string, and `.value` member of `struct
-attr_check_item` records it.  There are three macros to check these:
-
-`ATTR_TRUE()`::
-
-	Returns true if the attribute is Set for the path.
-
-`ATTR_FALSE()`::
-
-	Returns true if the attribute is Unset for the path.
-
-`ATTR_UNSET()`::
-
-	Returns true if the attribute is Unspecified for the path.
-
-If none of the above returns true, `.value` member points at a string
-value of the attribute for the path.
-
-
-Querying Specific Attributes
-----------------------------
-
-* Prepare `struct attr_check` using attr_check_initl()
-  function, enumerating the names of attributes whose values you are
-  interested in, terminated with a NULL pointer.  Alternatively, an
-  empty `struct attr_check` can be prepared by calling
-  `attr_check_alloc()` function and then attributes you want to
-  ask about can be added to it with `attr_check_append()`
-  function.
-
-* Call `git_check_attr()` to check the attributes for the path.
-
-* Inspect `attr_check` structure to see how each of the
-  attribute in the array is defined for the path.
-
-
-Example
--------
-
-To see how attributes "crlf" and "ident" are set for different paths.
-
-. Prepare a `struct attr_check` with two elements (because
-  we are checking two attributes):
-
-------------
-static struct attr_check *check;
-static void setup_check(void)
-{
-	if (check)
-		return; /* already done */
-	check = attr_check_initl("crlf", "ident", NULL);
-}
-------------
-
-. Call `git_check_attr()` with the prepared `struct attr_check`:
-
-------------
-	const char *path;
-
-	setup_check();
-	git_check_attr(path, check);
-------------
-
-. Act on `.value` member of the result, left in `check->items[]`:
-
-------------
-	const char *value = check->items[0].value;
-
-	if (ATTR_TRUE(value)) {
-		The attribute is Set, by listing only the name of the
-		attribute in the gitattributes file for the path.
-	} else if (ATTR_FALSE(value)) {
-		The attribute is Unset, by listing the name of the
-		attribute prefixed with a dash - for the path.
-	} else if (ATTR_UNSET(value)) {
-		The attribute is neither set nor unset for the path.
-	} else if (!strcmp(value, "input")) {
-		If none of ATTR_TRUE(), ATTR_FALSE(), or ATTR_UNSET() is
-		true, the value is a string set in the gitattributes
-		file for the path by saying "attr=value".
-	} else if (... other check using value as string ...) {
-		...
-	}
-------------
-
-To see how attributes in argv[] are set for different paths, only
-the first step in the above would be different.
-
-------------
-static struct attr_check *check;
-static void setup_check(const char **argv)
-{
-	check = attr_check_alloc();
-	while (*argv) {
-		struct git_attr *attr = git_attr(*argv);
-		attr_check_append(check, attr);
-		argv++;
-	}
-}
-------------
-
-
-Querying All Attributes
------------------------
-
-To get the values of all attributes associated with a file:
-
-* Prepare an empty `attr_check` structure by calling
-  `attr_check_alloc()`.
-
-* Call `git_all_attrs()`, which populates the `attr_check`
-  with the attributes attached to the path.
-
-* Iterate over the `attr_check.items[]` array to examine
-  the attribute names and values.  The name of the attribute
-  described by an `attr_check.items[]` object can be retrieved via
-  `git_attr_name(check->items[i].attr)`.  (Please note that no items
-  will be returned for unset attributes, so `ATTR_UNSET()` will return
-  false for all returned `attr_check.items[]` objects.)
-
-* Free the `attr_check` struct by calling `attr_check_free()`.
diff --git a/attr.h b/attr.h
index b0378bfe5f..404548f028 100644
--- a/attr.h
+++ b/attr.h
@@ -1,9 +1,121 @@
 #ifndef ATTR_H
 #define ATTR_H
 
+/**
+ * gitattributes mechanism gives a uniform way to associate various attributes
+ * to set of paths.
+ *
+ *
+ * Querying Specific Attributes
+ * ----------------------------
+ *
+ * - Prepare `struct attr_check` using attr_check_initl() function, enumerating
+ *   the names of attributes whose values you are interested in, terminated with
+ *   a NULL pointer.  Alternatively, an empty `struct attr_check` can be
+ *   prepared by calling `attr_check_alloc()` function and then attributes you
+ *   want to ask about can be added to it with `attr_check_append()` function.
+ *
+ * - Call `git_check_attr()` to check the attributes for the path.
+ *
+ * - Inspect `attr_check` structure to see how each of the attribute in the
+ *   array is defined for the path.
+ *
+ *
+ * Example
+ * -------
+ *
+ * To see how attributes "crlf" and "ident" are set for different paths.
+ *
+ * - Prepare a `struct attr_check` with two elements (because we are checking
+ *   two attributes):
+ *
+ * ------------
+ * static struct attr_check *check;
+ * static void setup_check(void)
+ * {
+ * 	if (check)
+ * 		return; // already done
+ * check = attr_check_initl("crlf", "ident", NULL);
+ * }
+ * ------------
+ *
+ * - Call `git_check_attr()` with the prepared `struct attr_check`:
+ *
+ * ------------
+ * const char *path;
+ *
+ * setup_check();
+ * git_check_attr(path, check);
+ * ------------
+ *
+ * - Act on `.value` member of the result, left in `check->items[]`:
+ *
+ * ------------
+ * const char *value = check->items[0].value;
+ *
+ * if (ATTR_TRUE(value)) {
+ * The attribute is Set, by listing only the name of the
+ * attribute in the gitattributes file for the path.
+ * } else if (ATTR_FALSE(value)) {
+ * The attribute is Unset, by listing the name of the
+ *         attribute prefixed with a dash - for the path.
+ * } else if (ATTR_UNSET(value)) {
+ * The attribute is neither set nor unset for the path.
+ * } else if (!strcmp(value, "input")) {
+ * If none of ATTR_TRUE(), ATTR_FALSE(), or ATTR_UNSET() is
+ *         true, the value is a string set in the gitattributes
+ * file for the path by saying "attr=value".
+ * } else if (... other check using value as string ...) {
+ * ...
+ * }
+ * ------------
+ *
+ * To see how attributes in argv[] are set for different paths, only
+ * the first step in the above would be different.
+ *
+ * ------------
+ * static struct attr_check *check;
+ * static void setup_check(const char **argv)
+ * {
+ *     check = attr_check_alloc();
+ *     while (*argv) {
+ *         struct git_attr *attr = git_attr(*argv);
+ *         attr_check_append(check, attr);
+ *         argv++;
+ *     }
+ * }
+ * ------------
+ *
+ *
+ * Querying All Attributes
+ * -----------------------
+ *
+ * To get the values of all attributes associated with a file:
+ *
+ * - Prepare an empty `attr_check` structure by calling `attr_check_alloc()`.
+ *
+ * - Call `git_all_attrs()`, which populates the `attr_check` with the
+ * attributes attached to the path.
+ *
+ * - Iterate over the `attr_check.items[]` array to examine the attribute
+ * names and values. The name of the attribute described by an
+ * `attr_check.items[]` object can be retrieved via
+ * `git_attr_name(check->items[i].attr)`. (Please note that no items will be
+ * returned for unset attributes, so `ATTR_UNSET()` will return false for all
+ * returned `attr_check.items[]` objects.)
+ *
+ * - Free the `attr_check` struct by calling `attr_check_free()`.
+ */
+
 struct index_state;
 
-/* An attribute is a pointer to this opaque structure */
+/**
+ * An attribute is an opaque object that is identified by its name. Pass the
+ * name to `git_attr()` function to obtain the object of this type.
+ * The internal representation of this structure is of no interest to the
+ * calling programs. The name of the attribute can be retrieved by calling
+ * `git_attr_name()`.
+ */
 struct git_attr;
 
 /* opaque structures used internally for attribute collection */
@@ -21,21 +133,36 @@ const struct git_attr *git_attr(const char *);
 extern const char git_attr__true[];
 extern const char git_attr__false[];
 
-/* For public to check git_attr_check results */
+/**
+ * Attribute Values
+ * ----------------
+ *
+ * An attribute for a path can be in one of four states: Set, Unset, Unspecified
+ * or set to a string, and `.value` member of `struct attr_check_item` records
+ * it. The three macros check these, if none of them returns true, `.value`
+ * member points at a string value of the attribute for the path.
+ */
+
+/* Returns true if the attribute is Set for the path. */
 #define ATTR_TRUE(v) ((v) == git_attr__true)
+
+/* Returns true if the attribute is Unset for the path. */
 #define ATTR_FALSE(v) ((v) == git_attr__false)
+
+/* Returns true if the attribute is Unspecified for the path. */
 #define ATTR_UNSET(v) ((v) == NULL)
 
-/*
- * Send one or more git_attr_check to git_check_attrs(), and
- * each 'value' member tells what its value is.
- * Unset one is returned as NULL.
- */
+/* This structure represents one attribute and its value. */
 struct attr_check_item {
 	const struct git_attr *attr;
 	const char *value;
 };
 
+/**
+ * This structure represents a collection of `attr_check_item`. It is passed to
+ * `git_check_attr()` function, specifying the attributes to check, and
+ * receives their values.
+ */
 struct attr_check {
 	int nr;
 	int alloc;
-- 
gitgitgadget

