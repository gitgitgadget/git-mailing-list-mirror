Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 381D020357
	for <e@80x24.org>; Mon, 17 Jul 2017 20:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbdGQULe (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Jul 2017 16:11:34 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34266 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdGQULc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2017 16:11:32 -0400
Received: by mail-lf0-f68.google.com with SMTP id p11so9707lfd.1
        for <git@vger.kernel.org>; Mon, 17 Jul 2017 13:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Oh6Y+EO22j0jQi2XHticmma/W/SZhUgb0QFjwl3BAc=;
        b=XTIhq1cDVnrsJM6ZIzUk1DwVmRORsaZsrI/RmXNBnCE91fTBa1E5F6aFy3vVbsC1Gl
         4eOsuRqg9FSYhoEQozSc5dJqGCMm51k+EvIp0xJyOQDLZ/0yZOfI+/Gi8DSDW072pfg7
         gsSSQ49oJVmKOZyD/ZaGJxJz7H1TJOpr8qUrmPGSlwcAsc5VnjrTba1jbQ6LsxhhZBiT
         p84vVRU8+4dTaFH+T501UyK6QD6X6JSiz1faDNuyMoBr+rH56E9fLMzCNPG/H85syroy
         GmxFPajEDA0RQH9Ifv7NLzKsuMll0cA++SK0ajb0NC4Z/WbpygdhRE/2+QUx1ezKsiN+
         tS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Oh6Y+EO22j0jQi2XHticmma/W/SZhUgb0QFjwl3BAc=;
        b=XA8zlKG/EBckgIF42CopNO38F0+G5gFYatiAJVtF0JWih4+0ngfqDEIPaes1u6NCmh
         rNn1TewbKn6hW+6TXHt5gFJoCA13CGNk7XMKr3Hrl6YS0sJSbFcRGVoCziOFLwpAg6yO
         C48c+dX9exBBKlBfdTWK29ny1MyAZeUdURGs/abGFakwbUT6MudBRIxCMVcHZdfKx7tr
         KOLzycBsezZZj+jXnAEZYSgdeXhxXhIb8R8zIgOjcdwryVk8UJbFJSXV5bzq1jN5l/7x
         0QQ5ayUJUNebM9NhzEtG9TH/xiJxN1G3uVm7DE42XlHwEg4E2LQxv4X/Y8rJbRGx4mKn
         Qi+g==
X-Gm-Message-State: AIVw111gxt/0Kxm4Klg70dTeqb+aS0rU4Ve6+pLEP8M1fGURaJ+UHqwg
        IVUMlCIYh3a1mRvU
X-Received: by 10.25.196.213 with SMTP id u204mr7881241lff.30.1500322290879;
        Mon, 17 Jul 2017 13:11:30 -0700 (PDT)
Received: from localhost.localdomain (c83-248-253-33.bredband.comhem.se. [83.248.253.33])
        by smtp.gmail.com with ESMTPSA id l12sm30752ljb.39.2017.07.17.13.11.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Jul 2017 13:11:30 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 02/10] builtin.h: format documentation-comment properly
Date:   Mon, 17 Jul 2017 22:10:44 +0200
Message-Id: <c0a58c6eacb79bde92a594b501971cb8360e507f.1500321657.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.rc0
In-Reply-To: <cover.1500321657.git.martin.agren@gmail.com>
References: <cover.1499723297.git.martin.agren@gmail.com> <cover.1500321657.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit moved technical documentation verbatim into
builtin.h. Prefix all the lines with '*' to follow the coding
guidelines.

Remove a '+' which was needed when the information was formatted for
AsciiDoc. Similarly, change "::" to ":".

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 builtin.h | 146 +++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 73 insertions(+), 73 deletions(-)

diff --git a/builtin.h b/builtin.h
index 51cb0249d..62f22b547 100644
--- a/builtin.h
+++ b/builtin.h
@@ -7,79 +7,79 @@
 #include "commit.h"
 
 /*
-builtin API
-===========
-
-Adding a new built-in
----------------------
-
-There are 4 things to do to add a built-in command implementation to
-Git:
-
-. Define the implementation of the built-in command `foo` with
-  signature:
-
-	int cmd_foo(int argc, const char **argv, const char *prefix);
-
-. Add the external declaration for the function to `builtin.h`.
-
-. Add the command to the `commands[]` table defined in `git.c`.
-  The entry should look like:
-
-	{ "foo", cmd_foo, <options> },
-+
-where options is the bitwise-or of:
-
-`RUN_SETUP`::
-	If there is not a Git directory to work on, abort.  If there
-	is a work tree, chdir to the top of it if the command was
-	invoked in a subdirectory.  If there is no work tree, no
-	chdir() is done.
-
-`RUN_SETUP_GENTLY`::
-	If there is a Git directory, chdir as per RUN_SETUP, otherwise,
-	don't chdir anywhere.
-
-`USE_PAGER`::
-
-	If the standard output is connected to a tty, spawn a pager and
-	feed our output to it.
-
-`NEED_WORK_TREE`::
-
-	Make sure there is a work tree, i.e. the command cannot act
-	on bare repositories.
-	This only makes sense when `RUN_SETUP` is also set.
-
-. Add `builtin/foo.o` to `BUILTIN_OBJS` in `Makefile`.
-
-Additionally, if `foo` is a new command, there are 3 more things to do:
-
-. Add tests to `t/` directory.
-
-. Write documentation in `Documentation/git-foo.txt`.
-
-. Add an entry for `git-foo` to `command-list.txt`.
-
-. Add an entry for `/git-foo` to `.gitignore`.
-
-
-How a built-in is called
-------------------------
-
-The implementation `cmd_foo()` takes three parameters, `argc`, `argv,
-and `prefix`.  The first two are similar to what `main()` of a
-standalone command would be called with.
-
-When `RUN_SETUP` is specified in the `commands[]` table, and when you
-were started from a subdirectory of the work tree, `cmd_foo()` is called
-after chdir(2) to the top of the work tree, and `prefix` gets the path
-to the subdirectory the command started from.  This allows you to
-convert a user-supplied pathname (typically relative to that directory)
-to a pathname relative to the top of the work tree.
-
-The return value from `cmd_foo()` becomes the exit status of the
-command.
+ * builtin API
+ * ===========
+ *
+ * Adding a new built-in
+ * ---------------------
+ *
+ * There are 4 things to do to add a built-in command implementation to
+ * Git:
+ *
+ * . Define the implementation of the built-in command `foo` with
+ *   signature:
+ *
+ *	int cmd_foo(int argc, const char **argv, const char *prefix);
+ *
+ * . Add the external declaration for the function to `builtin.h`.
+ *
+ * . Add the command to the `commands[]` table defined in `git.c`.
+ *   The entry should look like:
+ *
+ *	{ "foo", cmd_foo, <options> },
+ *
+ * where options is the bitwise-or of:
+ *
+ * `RUN_SETUP`:
+ *	If there is not a Git directory to work on, abort.  If there
+ *	is a work tree, chdir to the top of it if the command was
+ *	invoked in a subdirectory.  If there is no work tree, no
+ *	chdir() is done.
+ *
+ * `RUN_SETUP_GENTLY`:
+ *	If there is a Git directory, chdir as per RUN_SETUP, otherwise,
+ *	don't chdir anywhere.
+ *
+ * `USE_PAGER`:
+ *
+ *	If the standard output is connected to a tty, spawn a pager and
+ *	feed our output to it.
+ *
+ * `NEED_WORK_TREE`:
+ *
+ *	Make sure there is a work tree, i.e. the command cannot act
+ *	on bare repositories.
+ *	This only makes sense when `RUN_SETUP` is also set.
+ *
+ * . Add `builtin/foo.o` to `BUILTIN_OBJS` in `Makefile`.
+ *
+ * Additionally, if `foo` is a new command, there are 3 more things to do:
+ *
+ * . Add tests to `t/` directory.
+ *
+ * . Write documentation in `Documentation/git-foo.txt`.
+ *
+ * . Add an entry for `git-foo` to `command-list.txt`.
+ *
+ * . Add an entry for `/git-foo` to `.gitignore`.
+ *
+ *
+ * How a built-in is called
+ * ------------------------
+ *
+ * The implementation `cmd_foo()` takes three parameters, `argc`, `argv,
+ * and `prefix`.  The first two are similar to what `main()` of a
+ * standalone command would be called with.
+ *
+ * When `RUN_SETUP` is specified in the `commands[]` table, and when you
+ * were started from a subdirectory of the work tree, `cmd_foo()` is called
+ * after chdir(2) to the top of the work tree, and `prefix` gets the path
+ * to the subdirectory the command started from.  This allows you to
+ * convert a user-supplied pathname (typically relative to that directory)
+ * to a pathname relative to the top of the work tree.
+ *
+ * The return value from `cmd_foo()` becomes the exit status of the
+ * command.
  */
 
 #define DEFAULT_MERGE_LOG_LEN 20
-- 
2.14.0.rc0

