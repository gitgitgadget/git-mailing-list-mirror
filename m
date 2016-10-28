Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5122035F
	for <e@80x24.org>; Fri, 28 Oct 2016 18:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034289AbcJ1S4N (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 14:56:13 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35376 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755815AbcJ1S4I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 14:56:08 -0400
Received: by mail-pf0-f180.google.com with SMTP id s8so41513075pfj.2
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 11:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LGVCoIlzr1meXCJpAzG85Yt7LageaEPwYwQdYpLWAPc=;
        b=Wb4RA3C+DZv9Eskx3CcbgX/B02jtd4tatrZzE/YAIHOwAdG5Wl7fXbhpcS5kGMED+z
         7zFKCWfLkgQ/wiZSxOUwVhOyV+tK3RwA0h7lyr8Dzjw4WHCYlj6B2Y34NNqCwIkKjcIS
         6ESDFKs9VDmXWQOnke3KlvP2xmYiV3GjimTIn6/Q91JnOKE0EyJxNI5VtL2XUw8g0zRo
         Ne7ohWrtttuM3sHOpRQCNY+73ke89sszpNsPY0+dYvm2+qCyqTznwMYEt/DSweCsiGxV
         1WMrvTRb1u1AdBE2QlZGqa0Ojbz6K2sZrK0JgQrrGinXeRxnjmmT/QFzwGG25IUsJf4N
         65Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LGVCoIlzr1meXCJpAzG85Yt7LageaEPwYwQdYpLWAPc=;
        b=HOGtAdO5VBojdAVDs8p9rZyoRuS81uuFw9WXfhxzdy8WdidMkUUXlJbW/jAgrRgqIf
         U85Hh9z3BsrwPCgawgkST/zAcb7TexjA1nICMOdFAepmtOPayDIi5wf9XDZYo8jvJ+s5
         c1VG+WMOFoWl/KaRwGY4SWZtgt4+4HmRziVUN5s4tVrMlw9Xg0PhO15wAZnygUbfVjaZ
         g0tTK6nVJCUpkCNq/2Fi+R+/f36AgF2p8ka07JZOxm29WxHWboe2XJEDB5PdLMXJkM8Z
         OvDJ3vcjuWLgmaCTveBdnCY3Y4ImCQqPD5ksLzWWwqhmQmFVXf5g3+/q+anGfIMCSqB7
         7EPw==
X-Gm-Message-State: ABUngvdg8v3inxqKEvtBT3Gfz73rMgVQ+I93c3HDwwjLv4t4nO66fMcRh/rut6HDB14Nxt0X
X-Received: by 10.98.102.84 with SMTP id a81mr27075251pfc.176.1477680966956;
        Fri, 28 Oct 2016 11:56:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:91ed:bb99:5319:17e9])
        by smtp.gmail.com with ESMTPSA id h5sm20530544pfg.86.2016.10.28.11.56.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 28 Oct 2016 11:56:06 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 25/36] attr.c: outline the future plans by heavily commenting
Date:   Fri, 28 Oct 2016 11:54:51 -0700
Message-Id: <20161028185502.8789-26-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.714.ge3da0db
In-Reply-To: <20161028185502.8789-1-sbeller@google.com>
References: <20161028185502.8789-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 attr.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 92b3130f1e..10f2042fbb 100644
--- a/attr.c
+++ b/attr.c
@@ -30,6 +30,11 @@ static const char git_attr__unknown[] = "(builtin)unknown";
 #define DEBUG_ATTR 0
 #endif
 
+/*
+ * NEEDSWORK: the global dictionary of the interned attributes
+ * must stay a singleton even after we become thread-ready.
+ * Access to these must be surrounded with mutex when it happens.
+ */
 struct git_attr {
 	struct git_attr *next;
 	unsigned h;
@@ -39,10 +44,19 @@ struct git_attr {
 	char name[FLEX_ARRAY];
 };
 static int attr_nr;
+static struct git_attr *(git_attr_hash[HASHSIZE]);
+
+/*
+ * NEEDSWORK: maybe-real, maybe-macro are not property of
+ * an attribute, as it depends on what .gitattributes are
+ * read.  Once we introduce per git_attr_check attr_stack
+ * and check_all_attr, the optimization based on them will
+ * become unnecessary and can go away.  So is this variable.
+ */
 static int cannot_trust_maybe_real;
 
+/* NEEDSWORK: This will become per git_attr_check */
 static struct git_attr_check_elem *check_all_attr;
-static struct git_attr *(git_attr_hash[HASHSIZE]);
 
 const char *git_attr_name(const struct git_attr *attr)
 {
@@ -117,6 +131,11 @@ struct git_attr *git_attr_counted(const char *name, size_t len)
 	a->maybe_real = 0;
 	git_attr_hash[pos] = a;
 
+	/*
+	 * NEEDSWORK: per git_attr_check check_all_attr
+	 * will be initialized a lot more lazily, not
+	 * like this, and not here.
+	 */
 	REALLOC_ARRAY(check_all_attr, attr_nr);
 	check_all_attr[a->attr_nr].attr = a;
 	check_all_attr[a->attr_nr].value = ATTR__UNKNOWN;
@@ -329,6 +348,7 @@ static struct match_attr *parse_attr_line(const char *line, const char *src,
  * .gitignore file and info/excludes file as a fallback.
  */
 
+/* NEEDSWORK: This will become per git_attr_check */
 static struct attr_stack {
 	struct attr_stack *prev;
 	char *origin;
@@ -393,6 +413,24 @@ static struct attr_stack *read_attr_from_array(const char **list)
 	return res;
 }
 
+/*
+ * NEEDSWORK: these two are tricky.  The callers assume there is a
+ * single, system-wide global state "where we read attributes from?"
+ * and when the state is flipped by calling git_attr_set_direction(),
+ * attr_stack is discarded so that subsequent attr_check will lazily
+ * read from the right place.  And they do not know or care who called
+ * by them uses the attribute subsystem, hence have no knowledge of
+ * existing git_attr_check instances or future ones that will be
+ * created).
+ *
+ * Probably we need a thread_local that holds these two variables,
+ * and a list of git_attr_check instances (which need to be maintained
+ * by hooking into git_attr_check_alloc(), git_attr_check_initl(), and
+ * git_attr_check_clear().  Then git_attr_set_direction() updates the
+ * fields in that thread_local for these two variables, iterate over
+ * all the active git_attr_check instances and discard the attr_stack
+ * they hold.  Yuck, but it sounds doable.
+ */
 static enum git_attr_direction direction;
 static struct index_state *use_index;
 
-- 
2.10.1.714.ge3da0db

