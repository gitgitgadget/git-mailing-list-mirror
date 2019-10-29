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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F8851F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 10:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbfJ2KBB (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 06:01:01 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:34528 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfJ2KA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 06:00:56 -0400
Received: by mail-wr1-f50.google.com with SMTP id t16so12931275wrr.1
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 03:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/r3LV3ig26h2jE3K96c9klAmXlWRTCzKv5xNU6JF0nQ=;
        b=m5+2/Vdy7WWnMQDMiDVM+CKGDNxGg8U0tBEWyMRDRyAH2ymDk7ISGAZTcB2uvSQ8+E
         orVQIWET7SD8SMZX1IqlyxLZ8o843xzzC1GBitWZ1zAUrhxc4aVoGloP0mfv/N+DYJrt
         n/V5HfRK1cq4dxPfi+KUBQW/I2lV5m+EV3Ml5hefqShmVTP9aAgyG9nfYaKmvI0Y2aoY
         vV36XAu+VFDAWpkkMUhtuvZxbPAYlK6fkm0nKIdLi9aZjxEbTI4teHYAtLMFbXBexNJr
         RBzO1QbYXbi9zQlAhVVzBOK2W/qFjrvcRH+f9KJYmB60wI/OQjzGJJ1Jlzhlyuu7A1zK
         WHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/r3LV3ig26h2jE3K96c9klAmXlWRTCzKv5xNU6JF0nQ=;
        b=innX2ywCz1hmszrIkszgXcyjgFCshMcJl6YlzWuyA0SHr1UDAaJjrwkd3cBkJmroQf
         oxWGQzwHfzSFLrfbIFWJVx6bhFHDdDSYmKjvDWBnfmcz8IP1dSuWwaIFbHT6mHuSyPyG
         fxHjIkRAlmEs8u+vMDmZULJvj0CxTi/a9sIIjEH/gdkfJZTlV2g2+zFdK+gyrltS0rdh
         gIdWUKUKE6tMZ4oVMzVeYkSDibnvG3P1k0c1yF1g5yNOUDmLSAuZ7GUQxkeugfcoo2iy
         PunwaEOypZwpDTDRePjuhmEkW8MxkluQHrZBFTcVkLBGAr6bc1jUI4n58jM2C27PuoZ8
         Ht1w==
X-Gm-Message-State: APjAAAVQQ5SiIjHkK5KF75GNIQCuLEmvcfYZHqTP4s4VklS7Fjc5Pv/c
        pv+lvYZqmjSF2zcajrn67s5kAQnU
X-Google-Smtp-Source: APXvYqyZoG3YQGixeRDS2YeSAKiPUmBRhzQW+cwaIVjZ+0PkLJVmqc9LIkEX0irYOU6mDkZHqiHy6Q==
X-Received: by 2002:a5d:614b:: with SMTP id y11mr1524759wrt.374.1572343254555;
        Tue, 29 Oct 2019 03:00:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x8sm14795758wrr.43.2019.10.29.03.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 03:00:54 -0700 (PDT)
Message-Id: <afab6d5f4ed8cbe8e6dcba9a50282a471b542b13.1572343246.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.git.1572343246.gitgitgadget@gmail.com>
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Oct 2019 10:00:45 +0000
Subject: [PATCH 09/10] revision: move doc to revision.h
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

Move the documentation from Documentation/technical/api-revision-walking.txt
to revision.h as it's easier for the developers to find the usage
information beside the code instead of looking for it in another doc file.

Also documentation/technical/api-revision-walking.txt is removed because the
information it has is now redundant and it'll be hard to keep it up to
date and synchronized with the documentation in the header file.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 .../technical/api-revision-walking.txt        | 72 -------------------
 revision.h                                    | 59 +++++++++++++++
 2 files changed, 59 insertions(+), 72 deletions(-)
 delete mode 100644 Documentation/technical/api-revision-walking.txt

diff --git a/Documentation/technical/api-revision-walking.txt b/Documentation/technical/api-revision-walking.txt
deleted file mode 100644
index 03f9ea6ac4..0000000000
--- a/Documentation/technical/api-revision-walking.txt
+++ /dev/null
@@ -1,72 +0,0 @@
-revision walking API
-====================
-
-The revision walking API offers functions to build a list of revisions
-and then iterate over that list.
-
-Calling sequence
-----------------
-
-The walking API has a given calling sequence: first you need to
-initialize a rev_info structure, then add revisions to control what kind
-of revision list do you want to get, finally you can iterate over the
-revision list.
-
-Functions
----------
-
-`repo_init_revisions`::
-
-	Initialize a rev_info structure with default values. The third
-	parameter may be NULL or can be prefix path, and then the `.prefix`
-	variable will be set to it. This is typically the first function you
-	want to call when you want to deal with a revision list. After calling
-	this function, you are free to customize options, like set
-	`.ignore_merges` to 0 if you don't want to ignore merges, and so on. See
-	`revision.h` for a complete list of available options.
-
-`add_pending_object`::
-
-	This function can be used if you want to add commit objects as revision
-	information. You can use the `UNINTERESTING` object flag to indicate if
-	you want to include or exclude the given commit (and commits reachable
-	from the given commit) from the revision list.
-+
-NOTE: If you have the commits as a string list then you probably want to
-use setup_revisions(), instead of parsing each string and using this
-function.
-
-`setup_revisions`::
-
-	Parse revision information, filling in the `rev_info` structure, and
-	removing the used arguments from the argument list. Returns the number
-	of arguments left that weren't recognized, which are also moved to the
-	head of the argument list. The last parameter is used in case no
-	parameter given by the first two arguments.
-
-`prepare_revision_walk`::
-
-	Prepares the rev_info structure for a walk. You should check if it
-	returns any error (non-zero return code) and if it does not, you can
-	start using get_revision() to do the iteration.
-
-`get_revision`::
-
-	Takes a pointer to a `rev_info` structure and iterates over it,
-	returning a `struct commit *` each time you call it. The end of the
-	revision list is indicated by returning a NULL pointer.
-
-`reset_revision_walk`::
-
-	Reset the flags used by the revision walking api. You can use
-	this to do multiple sequential revision walks.
-
-Data structures
----------------
-
-Talk about <revision.h>, things like:
-
-* two diff_options, one for path limiting, another for output;
-* remaining functions;
-
-(Linus, JC, Dscho)
diff --git a/revision.h b/revision.h
index 4134dc6029..983ffc0f12 100644
--- a/revision.h
+++ b/revision.h
@@ -9,6 +9,19 @@
 #include "diff.h"
 #include "commit-slab-decl.h"
 
+/**
+ * The revision walking API offers functions to build a list of revisions
+ * and then iterate over that list.
+ *
+ * Calling sequence
+ * ----------------
+ *
+ * The walking API has a given calling sequence: first you need to initialize
+ * a rev_info structure, then add revisions to control what kind of revision
+ * list do you want to get, finally you can iterate over the revision list.
+ *
+ */
+
 /* Remember to update object flag allocation in object.h */
 #define SEEN		(1u<<0)
 #define UNINTERESTING   (1u<<1)
@@ -306,11 +319,29 @@ struct setup_revision_opt {
 #ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
 #define init_revisions(revs, prefix) repo_init_revisions(the_repository, revs, prefix)
 #endif
+
+/**
+ * Initialize a rev_info structure with default values. The third parameter may
+ * be NULL or can be prefix path, and then the `.prefix` variable will be set
+ * to it. This is typically the first function you want to call when you want
+ * to deal with a revision list. After calling this function, you are free to
+ * customize options, like set `.ignore_merges` to 0 if you don't want to
+ * ignore merges, and so on.
+ */
 void repo_init_revisions(struct repository *r,
 			 struct rev_info *revs,
 			 const char *prefix);
+
+/**
+ * Parse revision information, filling in the `rev_info` structure, and
+ * removing the used arguments from the argument list. Returns the number
+ * of arguments left that weren't recognized, which are also moved to the
+ * head of the argument list. The last parameter is used in case no
+ * parameter given by the first two arguments.
+ */
 int setup_revisions(int argc, const char **argv, struct rev_info *revs,
 		    struct setup_revision_opt *);
+
 void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 			const struct option *options,
 			const char * const usagestr[]);
@@ -319,9 +350,26 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
 int handle_revision_arg(const char *arg, struct rev_info *revs,
 			int flags, unsigned revarg_opt);
 
+/**
+ * Reset the flags used by the revision walking api. You can use this to do
+ * multiple sequential revision walks.
+ */
 void reset_revision_walk(void);
+
+/**
+ * Prepares the rev_info structure for a walk. You should check if it returns
+ * any error (non-zero return code) and if it does not, you can start using
+ * get_revision() to do the iteration.
+ */
 int prepare_revision_walk(struct rev_info *revs);
+
+/**
+ * Takes a pointer to a `rev_info` structure and iterates over it, returning a
+ * `struct commit *` each time you call it. The end of the revision list is
+ * indicated by returning a NULL pointer.
+ */
 struct commit *get_revision(struct rev_info *revs);
+
 char *get_revision_mark(const struct rev_info *revs,
 			const struct commit *commit);
 void put_revision_mark(const struct rev_info *revs,
@@ -333,8 +381,19 @@ void mark_trees_uninteresting_sparse(struct repository *r, struct oidset *trees)
 
 void show_object_with_name(FILE *, struct object *, const char *);
 
+/**
+ * This function can be used if you want to add commit objects as revision
+ * information. You can use the `UNINTERESTING` object flag to indicate if
+ * you want to include or exclude the given commit (and commits reachable
+ * from the given commit) from the revision list.
+ *
+ * NOTE: If you have the commits as a string list then you probably want to
+ * use setup_revisions(), instead of parsing each string and using this
+ * function.
+ */
 void add_pending_object(struct rev_info *revs,
 			struct object *obj, const char *name);
+
 void add_pending_oid(struct rev_info *revs,
 		     const char *name, const struct object_id *oid,
 		     unsigned int flags);
-- 
gitgitgadget

