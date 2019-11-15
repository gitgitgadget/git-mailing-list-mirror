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
	by dcvr.yhbt.net (Postfix) with ESMTP id 779B21F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 09:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfKOJx7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 04:53:59 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:36242 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfKOJx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 04:53:59 -0500
Received: by mail-wr1-f45.google.com with SMTP id r10so10265682wrx.3
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 01:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ByXG9NUEQXnOejxLNbqwymYZvqZVDNF4tVNaLMHYBnI=;
        b=QZRmLeqAlcb5QaBwmrumv7NhTl3UZ2uEJLAyVBw09tJ+oIb0TaAomL3VKbZhGahYjK
         2RPk/fELnLjXQnnS7HrS7Uc+A7leSRj3/cYugyNWQZOw8iYV8nGP71TafaV92OunetJu
         vJWNMOeCDLSadZkMzHzNObFs8MrFsl7uk25HME/a6YOlTqGlKDgckJd5GJynPbl5Wyp2
         iTIfDWn9I09dN2KqkScBWD+Sp6owg9DUJfDP2q3FZbVG++Hvwo428+gwGRDTZwnEH8Yj
         bmDrc2+GR1KMMVTFUkYaYuqRrja5Cwy1L7PlHVlGOSduBNkClEXzLgXk8bgW7PprPA/V
         10wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ByXG9NUEQXnOejxLNbqwymYZvqZVDNF4tVNaLMHYBnI=;
        b=sXNQ6cdlxVg49Ho67WYJDv61wcRuUOtISOgEzGRJCQd2E8x2imhGm+2Z+hFjcgvyUv
         GbCzWCnkcjVN0rDy9T+BGYFRIFbxlwATVliQtjikExzj1zwoFveAHncEPHmUCShtgaie
         u+ekDfs4+CwMM1H6Qj1QeG0vwOF69xFf2GHTC8bZDqr7afzrzFhE51MLykQ7R7KzQ3EB
         3lhXANvU/uLn6JP9Owjrx2SLA7YmtPA+uIpMNFXqs7VgqqQBf3iX0lNGQ8EepkkPJJEU
         vaX45gQmTjfKA65SHl/reI5MCpgd0KIt92wGNYEr0k5Rm0w7l91hoSlD/j2symLnoon7
         81jw==
X-Gm-Message-State: APjAAAXg2uSOXPvIBzUzJ2GSaguBas5Wf4q2ibkMc4iLWLU3EaCLgQ1T
        Li3UFuvUSQOsSS+2iydC9QO8wFxr
X-Google-Smtp-Source: APXvYqyyop9xrmJcWtjvH5OmwueCMWnjmFh2HM6abhD+McHcONPZweF2tjOE5LCobwHCuF+iqgwU5A==
X-Received: by 2002:a5d:5092:: with SMTP id a18mr3925321wrt.297.1573811636169;
        Fri, 15 Nov 2019 01:53:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t13sm10289742wrr.88.2019.11.15.01.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 01:53:55 -0800 (PST)
Message-Id: <0042d10223d011de6d318a271388ac932004672c.1573811626.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
References: <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
        <pull.434.v4.git.1573811626.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 09:53:35 +0000
Subject: [PATCH v4 10/21] pathspec: move doc to pathspec.h
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

Move the documentation from Documentation/technical/api-setup.txt
to pathspec.h as it's easier for the developers to find the usage
information beside the code instead of looking for it in another doc file.

Also documentation/technical/api-setup.txt is removed because the
information it has is now redundant and it'll be hard to keep it up to
date and synchronized with the documentation in the header file.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/technical/api-setup.txt | 47 ---------------------------
 pathspec.h                            | 35 +++++++++++++++++++-
 2 files changed, 34 insertions(+), 48 deletions(-)
 delete mode 100644 Documentation/technical/api-setup.txt

diff --git a/Documentation/technical/api-setup.txt b/Documentation/technical/api-setup.txt
deleted file mode 100644
index eb1fa9853e..0000000000
--- a/Documentation/technical/api-setup.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-setup API
-=========
-
-Talk about
-
-* setup_git_directory()
-* setup_git_directory_gently()
-* is_inside_git_dir()
-* is_inside_work_tree()
-* setup_work_tree()
-
-(Dscho)
-
-Pathspec
---------
-
-See glossary-context.txt for the syntax of pathspec. In memory, a
-pathspec set is represented by "struct pathspec" and is prepared by
-parse_pathspec(). This function takes several arguments:
-
-- magic_mask specifies what features that are NOT supported by the
-  following code. If a user attempts to use such a feature,
-  parse_pathspec() can reject it early.
-
-- flags specifies other things that the caller wants parse_pathspec to
-  perform.
-
-- prefix and args come from cmd_* functions
-
-parse_pathspec() helps catch unsupported features and reject them
-politely. At a lower level, different pathspec-related functions may
-not support the same set of features. Such pathspec-sensitive
-functions are guarded with GUARD_PATHSPEC(), which will die in an
-unfriendly way when an unsupported feature is requested.
-
-The command designers are supposed to make sure that GUARD_PATHSPEC()
-never dies. They have to make sure all unsupported features are caught
-by parse_pathspec(), not by GUARD_PATHSPEC. grepping GUARD_PATHSPEC()
-should give the designers all pathspec-sensitive codepaths and what
-features they support.
-
-A similar process is applied when a new pathspec magic is added. The
-designer lifts the GUARD_PATHSPEC restriction in the functions that
-support the new magic. At the same time (s)he has to make sure this
-new feature will be caught at parse_pathspec() in commands that cannot
-handle the new magic in some cases. grepping parse_pathspec() should
-help.
diff --git a/pathspec.h b/pathspec.h
index 1c18a2c90c..f3ee8d9871 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -22,6 +22,11 @@ struct index_state;
 
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern satisfies GFNM_ONESTAR */
 
+/**
+ * See glossary-context.txt for the syntax of pathspec.
+ * In memory, a pathspec set is represented by "struct pathspec" and is
+ * prepared by parse_pathspec().
+ */
 struct pathspec {
 	int nr;
 	unsigned int has_wildcard:1;
@@ -73,18 +78,46 @@ struct pathspec {
  */
 #define PATHSPEC_LITERAL_PATH (1<<6)
 
-/*
+/**
  * Given command line arguments and a prefix, convert the input to
  * pathspec. die() if any magic in magic_mask is used.
  *
  * Any arguments used are copied. It is safe for the caller to modify
  * or free 'prefix' and 'args' after calling this function.
+ *
+ * - magic_mask specifies what features that are NOT supported by the following
+ * code. If a user attempts to use such a feature, parse_pathspec() can reject
+ * it early.
+ *
+ * - flags specifies other things that the caller wants parse_pathspec to
+ * perform.
+ *
+ * - prefix and args come from cmd_* functions
+ *
+ * parse_pathspec() helps catch unsupported features and reject them politely.
+ * At a lower level, different pathspec-related functions may not support the
+ * same set of features. Such pathspec-sensitive functions are guarded with
+ * GUARD_PATHSPEC(), which will die in an unfriendly way when an unsupported
+ * feature is requested.
+ *
+ * The command designers are supposed to make sure that GUARD_PATHSPEC() never
+ * dies. They have to make sure all unsupported features are caught by
+ * parse_pathspec(), not by GUARD_PATHSPEC. grepping GUARD_PATHSPEC() should
+ * give the designers all pathspec-sensitive codepaths and what features they
+ * support.
+ *
+ * A similar process is applied when a new pathspec magic is added. The designer
+ * lifts the GUARD_PATHSPEC restriction in the functions that support the new
+ * magic. At the same time (s)he has to make sure this new feature will be
+ * caught at parse_pathspec() in commands that cannot handle the new magic in
+ * some cases. grepping parse_pathspec() should help.
  */
 void parse_pathspec(struct pathspec *pathspec,
 		    unsigned magic_mask,
 		    unsigned flags,
 		    const char *prefix,
 		    const char **args);
+
 void copy_pathspec(struct pathspec *dst, const struct pathspec *src);
 void clear_pathspec(struct pathspec *);
 
-- 
gitgitgadget

