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
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EC2C1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 09:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfKOJyP (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 04:54:15 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:56176 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfKOJyE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 04:54:04 -0500
Received: by mail-wm1-f49.google.com with SMTP id b11so9009538wmb.5
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 01:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G1BlCnRtqqGqGPD8gxA2TSlXPEPL7IzBXqSxVTtnsrw=;
        b=WRXfEvifMkv4qH14Dz+9flk6Q3/3Hh1xMZkPRMpbGXLO9xyifdSMITeRbhBZTgbDO+
         pjPgLTmWSJqRJ5Y7pYZiLbcVyuptVIVU3G7TkZlRMaPGU2sUoiT8m+uNChYdSCqqsFau
         5fU9ZIeA973p87vbkx5f90kRxKe8neSQwLa6T+C+l+0s+QWCiJ3YoW78ys8jPQLKdVhH
         VhBLX2VRBYyYGf1f7zuMJKC2jsqeS4t8YXJj0ge0wjZyr55wO7xiWr0eyropQXGPFVgT
         fsAgv/9uyI9ne8ekrHQPsCYQcIVG3tO6Z31WBSbB7YG8BF9QIv73/X1eHafWBHNbg5FP
         UvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G1BlCnRtqqGqGPD8gxA2TSlXPEPL7IzBXqSxVTtnsrw=;
        b=R+2Ub9C6jzzUeFhqlbKIt8if2sW/LBYmQL7HIbADkIWyH8iGJ0THAvJbyjrDivXfJ/
         /WfY4MKBLftvCCNlLhCt0NVd335EOV5EStnoQ+gqLA6BLYGrcQaAO1ayB8a+DKn4PHSj
         M6RCzP5JsjHn+LiyGKkg1Skn/asbZc+bvU8qj+rZdJu0aXbai5vFMXnYmqQyMbfa9Zr+
         JE3BugtU2ML70I7RutpUPm0jlraxYVchC81441KjpoEgHpJbeLIOwohFWdBQlJc8cEyU
         oSC35SaQ+eiehH83NmJnHYpV15TPIVd9VOs68f31zdAhhBJjdATA9oVq45gVboFx7FKs
         EJWw==
X-Gm-Message-State: APjAAAWc3ZngxuMTM3gEF1JPe4E0JNywdPbghGcyFoTEdaNHZhoAuXCy
        8viNzgTl8JpkC52jvOpY0/g73IO5
X-Google-Smtp-Source: APXvYqyM6CIMK7Li4G8S06nm3jpbs/3KvMwp+HvW22wjjqSEuRtLURWVBFYFMBZZr33pkdPN8++h9g==
X-Received: by 2002:a1c:40c1:: with SMTP id n184mr14406359wma.116.1573811639560;
        Fri, 15 Nov 2019 01:53:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u187sm9935058wme.15.2019.11.15.01.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 01:53:59 -0800 (PST)
Message-Id: <ea78cb4ae509aca5f96599e16d9d816a10473728.1573811627.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
References: <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
        <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 09:53:39 +0000
Subject: [PATCH v4 14/21] credential: move doc to credential.h
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

Move the documentation from Documentation/technical/api-credentials.txt
to credential.h as it's easier for the developers to find the usage
information beside the code instead of looking for it in another doc file.

Documentation/technical/api-credentials.txt is removed because the
information it has is now redundant and it'll be hard to keep it up to
date and synchronized with the documentation in the header file.

Documentation/git-credential.txt and Documentation/gitcredentials.txt now link
to credential.h instead of Documentation/technical/api-credentials.txt for
details about the credetials API.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/git-credential.txt            |   3 +-
 Documentation/gitcredentials.txt            |   3 +-
 Documentation/technical/api-credentials.txt | 271 --------------------
 credential.h                                | 236 +++++++++++++++++
 4 files changed, 238 insertions(+), 275 deletions(-)
 delete mode 100644 Documentation/technical/api-credentials.txt

diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index b211440373..6f0c7ca80f 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -19,8 +19,7 @@ from system-specific helpers, as well as prompting the user for
 usernames and passwords. The git-credential command exposes this
 interface to scripts which may want to retrieve, store, or prompt for
 credentials in the same manner as Git. The design of this scriptable
-interface models the internal C API; see
-link:technical/api-credentials.html[the Git credential API] for more
+interface models the internal C API; see credential.h for more
 background on the concepts.
 
 git-credential takes an "action" option on the command-line (one of
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index adc759612d..ea759fdee5 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -186,8 +186,7 @@ CUSTOM HELPERS
 --------------
 
 You can write your own custom helpers to interface with any system in
-which you keep credentials. See the documentation for Git's
-link:technical/api-credentials.html[credentials API] for details.
+which you keep credentials. See credential.h for details.
 
 GIT
 ---
diff --git a/Documentation/technical/api-credentials.txt b/Documentation/technical/api-credentials.txt
deleted file mode 100644
index 75368f26ca..0000000000
--- a/Documentation/technical/api-credentials.txt
+++ /dev/null
@@ -1,271 +0,0 @@
-credentials API
-===============
-
-The credentials API provides an abstracted way of gathering username and
-password credentials from the user (even though credentials in the wider
-world can take many forms, in this document the word "credential" always
-refers to a username and password pair).
-
-This document describes two interfaces: the C API that the credential
-subsystem provides to the rest of Git, and the protocol that Git uses to
-communicate with system-specific "credential helpers". If you are
-writing Git code that wants to look up or prompt for credentials, see
-the section "C API" below. If you want to write your own helper, see
-the section on "Credential Helpers" below.
-
-Typical setup
--------------
-
-------------
-+-----------------------+
-| Git code (C)          |--- to server requiring --->
-|                       |        authentication
-|.......................|
-| C credential API      |--- prompt ---> User
-+-----------------------+
-	^      |
-	| pipe |
-	|      v
-+-----------------------+
-| Git credential helper |
-+-----------------------+
-------------
-
-The Git code (typically a remote-helper) will call the C API to obtain
-credential data like a login/password pair (credential_fill). The
-API will itself call a remote helper (e.g. "git credential-cache" or
-"git credential-store") that may retrieve credential data from a
-store. If the credential helper cannot find the information, the C API
-will prompt the user. Then, the caller of the API takes care of
-contacting the server, and does the actual authentication.
-
-C API
------
-
-The credential C API is meant to be called by Git code which needs to
-acquire or store a credential. It is centered around an object
-representing a single credential and provides three basic operations:
-fill (acquire credentials by calling helpers and/or prompting the user),
-approve (mark a credential as successfully used so that it can be stored
-for later use), and reject (mark a credential as unsuccessful so that it
-can be erased from any persistent storage).
-
-Data Structures
-~~~~~~~~~~~~~~~
-
-`struct credential`::
-
-	This struct represents a single username/password combination
-	along with any associated context. All string fields should be
-	heap-allocated (or NULL if they are not known or not applicable).
-	The meaning of the individual context fields is the same as
-	their counterparts in the helper protocol; see the section below
-	for a description of each field.
-+
-The `helpers` member of the struct is a `string_list` of helpers.  Each
-string specifies an external helper which will be run, in order, to
-either acquire or store credentials. See the section on credential
-helpers below. This list is filled-in by the API functions
-according to the corresponding configuration variables before
-consulting helpers, so there usually is no need for a caller to
-modify the helpers field at all.
-+
-This struct should always be initialized with `CREDENTIAL_INIT` or
-`credential_init`.
-
-
-Functions
-~~~~~~~~~
-
-`credential_init`::
-
-	Initialize a credential structure, setting all fields to empty.
-
-`credential_clear`::
-
-	Free any resources associated with the credential structure,
-	returning it to a pristine initialized state.
-
-`credential_fill`::
-
-	Instruct the credential subsystem to fill the username and
-	password fields of the passed credential struct by first
-	consulting helpers, then asking the user. After this function
-	returns, the username and password fields of the credential are
-	guaranteed to be non-NULL. If an error occurs, the function will
-	die().
-
-`credential_reject`::
-
-	Inform the credential subsystem that the provided credentials
-	have been rejected. This will cause the credential subsystem to
-	notify any helpers of the rejection (which allows them, for
-	example, to purge the invalid credentials from storage).  It
-	will also free() the username and password fields of the
-	credential and set them to NULL (readying the credential for
-	another call to `credential_fill`). Any errors from helpers are
-	ignored.
-
-`credential_approve`::
-
-	Inform the credential subsystem that the provided credentials
-	were successfully used for authentication.  This will cause the
-	credential subsystem to notify any helpers of the approval, so
-	that they may store the result to be used again.  Any errors
-	from helpers are ignored.
-
-`credential_from_url`::
-
-	Parse a URL into broken-down credential fields.
-
-Example
-~~~~~~~
-
-The example below shows how the functions of the credential API could be
-used to login to a fictitious "foo" service on a remote host:
-
------------------------------------------------------------------------
-int foo_login(struct foo_connection *f)
-{
-	int status;
-	/*
-	 * Create a credential with some context; we don't yet know the
-	 * username or password.
-	 */
-
-	struct credential c = CREDENTIAL_INIT;
-	c.protocol = xstrdup("foo");
-	c.host = xstrdup(f->hostname);
-
-	/*
-	 * Fill in the username and password fields by contacting
-	 * helpers and/or asking the user. The function will die if it
-	 * fails.
-	 */
-	credential_fill(&c);
-
-	/*
-	 * Otherwise, we have a username and password. Try to use it.
-	 */
-	status = send_foo_login(f, c.username, c.password);
-	switch (status) {
-	case FOO_OK:
-		/* It worked. Store the credential for later use. */
-		credential_accept(&c);
-		break;
-	case FOO_BAD_LOGIN:
-		/* Erase the credential from storage so we don't try it
-		 * again. */
-		credential_reject(&c);
-		break;
-	default:
-		/*
-		 * Some other error occurred. We don't know if the
-		 * credential is good or bad, so report nothing to the
-		 * credential subsystem.
-		 */
-	}
-
-	/* Free any associated resources. */
-	credential_clear(&c);
-
-	return status;
-}
------------------------------------------------------------------------
-
-
-Credential Helpers
-------------------
-
-Credential helpers are programs executed by Git to fetch or save
-credentials from and to long-term storage (where "long-term" is simply
-longer than a single Git process; e.g., credentials may be stored
-in-memory for a few minutes, or indefinitely on disk).
-
-Each helper is specified by a single string in the configuration
-variable `credential.helper` (and others, see linkgit:git-config[1]).
-The string is transformed by Git into a command to be executed using
-these rules:
-
-  1. If the helper string begins with "!", it is considered a shell
-     snippet, and everything after the "!" becomes the command.
-
-  2. Otherwise, if the helper string begins with an absolute path, the
-     verbatim helper string becomes the command.
-
-  3. Otherwise, the string "git credential-" is prepended to the helper
-     string, and the result becomes the command.
-
-The resulting command then has an "operation" argument appended to it
-(see below for details), and the result is executed by the shell.
-
-Here are some example specifications:
-
-----------------------------------------------------
-# run "git credential-foo"
-foo
-
-# same as above, but pass an argument to the helper
-foo --bar=baz
-
-# the arguments are parsed by the shell, so use shell
-# quoting if necessary
-foo --bar="whitespace arg"
-
-# you can also use an absolute path, which will not use the git wrapper
-/path/to/my/helper --with-arguments
-
-# or you can specify your own shell snippet
-!f() { echo "password=`cat $HOME/.secret`"; }; f
-----------------------------------------------------
-
-Generally speaking, rule (3) above is the simplest for users to specify.
-Authors of credential helpers should make an effort to assist their
-users by naming their program "git-credential-$NAME", and putting it in
-the $PATH or $GIT_EXEC_PATH during installation, which will allow a user
-to enable it with `git config credential.helper $NAME`.
-
-When a helper is executed, it will have one "operation" argument
-appended to its command line, which is one of:
-
-`get`::
-
-	Return a matching credential, if any exists.
-
-`store`::
-
-	Store the credential, if applicable to the helper.
-
-`erase`::
-
-	Remove a matching credential, if any, from the helper's storage.
-
-The details of the credential will be provided on the helper's stdin
-stream. The exact format is the same as the input/output format of the
-`git credential` plumbing command (see the section `INPUT/OUTPUT
-FORMAT` in linkgit:git-credential[1] for a detailed specification).
-
-For a `get` operation, the helper should produce a list of attributes
-on stdout in the same format. A helper is free to produce a subset, or
-even no values at all if it has nothing useful to provide. Any provided
-attributes will overwrite those already known about by Git.  If a helper
-outputs a `quit` attribute with a value of `true` or `1`, no further
-helpers will be consulted, nor will the user be prompted (if no
-credential has been provided, the operation will then fail).
-
-For a `store` or `erase` operation, the helper's output is ignored.
-If it fails to perform the requested operation, it may complain to
-stderr to inform the user. If it does not support the requested
-operation (e.g., a read-only store), it should silently ignore the
-request.
-
-If a helper receives any other operation, it should silently ignore the
-request. This leaves room for future operations to be added (older
-helpers will just ignore the new requests).
-
-See also
---------
-
-linkgit:gitcredentials[7]
-
-linkgit:git-config[1] (See configuration variables `credential.*`)
diff --git a/credential.h b/credential.h
index 6b0cd16be2..5772d50577 100644
--- a/credential.h
+++ b/credential.h
@@ -3,8 +3,208 @@
 
 #include "string-list.h"
 
+/**
+ * The credentials API provides an abstracted way of gathering username and
+ * password credentials from the user.
+ *
+ * Typical setup
+ * -------------
+ *
+ * ------------
+ * +-----------------------+
+ * | Git code (C)          |--- to server requiring --->
+ * |                       |        authentication
+ * |.......................|
+ * | C credential API      |--- prompt ---> User
+ * +-----------------------+
+ * 	^      |
+ * 	| pipe |
+ * 	|      v
+ * +-----------------------+
+ * | Git credential helper |
+ * +-----------------------+
+ * ------------
+ *
+ * The Git code (typically a remote-helper) will call the C API to obtain
+ * credential data like a login/password pair (credential_fill). The
+ * API will itself call a remote helper (e.g. "git credential-cache" or
+ * "git credential-store") that may retrieve credential data from a
+ * store. If the credential helper cannot find the information, the C API
+ * will prompt the user. Then, the caller of the API takes care of
+ * contacting the server, and does the actual authentication.
+ *
+ * C API
+ * -----
+ *
+ * The credential C API is meant to be called by Git code which needs to
+ * acquire or store a credential. It is centered around an object
+ * representing a single credential and provides three basic operations:
+ * fill (acquire credentials by calling helpers and/or prompting the user),
+ * approve (mark a credential as successfully used so that it can be stored
+ * for later use), and reject (mark a credential as unsuccessful so that it
+ * can be erased from any persistent storage).
+ *
+ * Example
+ * ~~~~~~~
+ *
+ * The example below shows how the functions of the credential API could be
+ * used to login to a fictitious "foo" service on a remote host:
+ *
+ * -----------------------------------------------------------------------
+ * int foo_login(struct foo_connection *f)
+ * {
+ * 	int status;
+ * 	// Create a credential with some context; we don't yet know the
+ * 	// username or password.
+ *
+ * struct credential c = CREDENTIAL_INIT;
+ * c.protocol = xstrdup("foo");
+ * c.host = xstrdup(f->hostname);
+ *
+ * // Fill in the username and password fields by contacting
+ * // helpers and/or asking the user. The function will die if it
+ * // fails.
+ * credential_fill(&c);
+ *
+ * // Otherwise, we have a username and password. Try to use it.
+ *
+ * status = send_foo_login(f, c.username, c.password);
+ * switch (status) {
+ * case FOO_OK:
+ * // It worked. Store the credential for later use.
+ * credential_accept(&c);
+ * break;
+ * case FOO_BAD_LOGIN:
+ * // Erase the credential from storage so we don't try it again.
+ * credential_reject(&c);
+ * break;
+ * default:
+ * // Some other error occurred. We don't know if the
+ * // credential is good or bad, so report nothing to the
+ * // credential subsystem.
+ * }
+ *
+ * // Free any associated resources.
+ * credential_clear(&c);
+ *
+ * return status;
+ * }
+ * -----------------------------------------------------------------------
+ *
+ * Credential Helpers
+ * ------------------
+ *
+ * Credential helpers are programs executed by Git to fetch or save
+ * credentials from and to long-term storage (where "long-term" is simply
+ * longer than a single Git process; e.g., credentials may be stored
+ * in-memory for a few minutes, or indefinitely on disk).
+ *
+ * Each helper is specified by a single string in the configuration
+ * variable `credential.helper` (and others, see Documentation/git-config.txt).
+ * The string is transformed by Git into a command to be executed using
+ * these rules:
+ *
+ *   1. If the helper string begins with "!", it is considered a shell
+ *      snippet, and everything after the "!" becomes the command.
+ *
+ *   2. Otherwise, if the helper string begins with an absolute path, the
+ *      verbatim helper string becomes the command.
+ *
+ *   3. Otherwise, the string "git credential-" is prepended to the helper
+ *      string, and the result becomes the command.
+ *
+ * The resulting command then has an "operation" argument appended to it
+ * (see below for details), and the result is executed by the shell.
+ *
+ * Here are some example specifications:
+ *
+ * ----------------------------------------------------
+ * # run "git credential-foo"
+ * foo
+ *
+ * # same as above, but pass an argument to the helper
+ * foo --bar=baz
+ *
+ * # the arguments are parsed by the shell, so use shell
+ * # quoting if necessary
+ * foo --bar="whitespace arg"
+ *
+ * # you can also use an absolute path, which will not use the git wrapper
+ * /path/to/my/helper --with-arguments
+ *
+ * # or you can specify your own shell snippet
+ * !f() { echo "password=`cat $HOME/.secret`"; }; f
+ * ----------------------------------------------------
+ *
+ * Generally speaking, rule (3) above is the simplest for users to specify.
+ * Authors of credential helpers should make an effort to assist their
+ * users by naming their program "git-credential-$NAME", and putting it in
+ * the $PATH or $GIT_EXEC_PATH during installation, which will allow a user
+ * to enable it with `git config credential.helper $NAME`.
+ *
+ * When a helper is executed, it will have one "operation" argument
+ * appended to its command line, which is one of:
+ *
+ * `get`::
+ *
+ * 	Return a matching credential, if any exists.
+ *
+ * `store`::
+ *
+ * 	Store the credential, if applicable to the helper.
+ *
+ * `erase`::
+ *
+ * 	Remove a matching credential, if any, from the helper's storage.
+ *
+ * The details of the credential will be provided on the helper's stdin
+ * stream. The exact format is the same as the input/output format of the
+ * `git credential` plumbing command (see the section `INPUT/OUTPUT
+ * FORMAT` in Documentation/git-credential.txt for a detailed specification).
+ *
+ * For a `get` operation, the helper should produce a list of attributes
+ * on stdout in the same format. A helper is free to produce a subset, or
+ * even no values at all if it has nothing useful to provide. Any provided
+ * attributes will overwrite those already known about by Git.  If a helper
+ * outputs a `quit` attribute with a value of `true` or `1`, no further
+ * helpers will be consulted, nor will the user be prompted (if no
+ * credential has been provided, the operation will then fail).
+ *
+ * For a `store` or `erase` operation, the helper's output is ignored.
+ * If it fails to perform the requested operation, it may complain to
+ * stderr to inform the user. If it does not support the requested
+ * operation (e.g., a read-only store), it should silently ignore the
+ * request.
+ *
+ * If a helper receives any other operation, it should silently ignore the
+ * request. This leaves room for future operations to be added (older
+ * helpers will just ignore the new requests).
+ *
+ */
+
+
+/**
+ * This struct represents a single username/password combination
+ * along with any associated context. All string fields should be
+ * heap-allocated (or NULL if they are not known or not applicable).
+ * The meaning of the individual context fields is the same as
+ * their counterparts in the helper protocol.
+ *
+ * This struct should always be initialized with `CREDENTIAL_INIT` or
+ * `credential_init`.
+ */
 struct credential {
+
+	/**
+	 * A `string_list` of helpers. Each string specifies an external
+	 * helper which will be run, in order, to either acquire or store
+	 * credentials. This list is filled-in by the API functions
+	 * according to the corresponding configuration variables before
+	 * consulting helpers, so there usually is no need for a caller to
+	 * modify the helpers field at all.
+	 */
 	struct string_list helpers;
+
 	unsigned approved:1,
 		 configured:1,
 		 quit:1,
@@ -19,16 +219,52 @@ struct credential {
 
 #define CREDENTIAL_INIT { STRING_LIST_INIT_DUP }
 
+/* Initialize a credential structure, setting all fields to empty. */
 void credential_init(struct credential *);
+
+/**
+ * Free any resources associated with the credential structure, returning
+ * it to a pristine initialized state.
+ */
 void credential_clear(struct credential *);
 
+/**
+ * Instruct the credential subsystem to fill the username and
+ * password fields of the passed credential struct by first
+ * consulting helpers, then asking the user. After this function
+ * returns, the username and password fields of the credential are
+ * guaranteed to be non-NULL. If an error occurs, the function will
+ * die().
+ */
 void credential_fill(struct credential *);
+
+/**
+ * Inform the credential subsystem that the provided credentials
+ * were successfully used for authentication.  This will cause the
+ * credential subsystem to notify any helpers of the approval, so
+ * that they may store the result to be used again.  Any errors
+ * from helpers are ignored.
+ */
 void credential_approve(struct credential *);
+
+/**
+ * Inform the credential subsystem that the provided credentials
+ * have been rejected. This will cause the credential subsystem to
+ * notify any helpers of the rejection (which allows them, for
+ * example, to purge the invalid credentials from storage). It
+ * will also free() the username and password fields of the
+ * credential and set them to NULL (readying the credential for
+ * another call to `credential_fill`). Any errors from helpers are
+ * ignored.
+ */
 void credential_reject(struct credential *);
 
 int credential_read(struct credential *, FILE *);
 void credential_write(const struct credential *, FILE *);
+
+/* Parse a URL into broken-down credential fields. */
 void credential_from_url(struct credential *, const char *url);
+
 int credential_match(const struct credential *have,
 		     const struct credential *want);
 
-- 
gitgitgadget

