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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AB131F454
	for <e@80x24.org>; Wed,  6 Nov 2019 10:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731756AbfKFKAD (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 05:00:03 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:44168 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731647AbfKFKAA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 05:00:00 -0500
Received: by mail-wr1-f54.google.com with SMTP id f2so16050895wrs.11
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 01:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WlammgDF0L+1RNwpwU1Hv0Eo8cOXgnk5/hW7BCWo5IU=;
        b=MQZ128OTvg0kjtAmgeYhPuaW6kqbY+HqCm+LFepmlYnRQru1k18e9qHtIGmvTcnoOm
         lz6XGVM3U1qoLTpp1Bb4GP1oqOBy/2FWbT5W+L6GVJFL3UgzCp56kXsjnQeNEsVOx26R
         Th14wax93AaiZ8oIqVMnoHH6I7hzrHVvk3GK8ktlDZKmKkT8gQYk/cU1ocNCI2+jsxP8
         G6CtWXpOPxMQNiJSyuUPQfD8v0exc6T7Hh9kWHk5m/zqi6+afU4iAED8xsyRs98KyML9
         kFFG1Tc4QdQwEAi1/9GxNFCq+ZJ1VGJDIAL7D5EcOwEAeB0Y6q0PxcXCgz3xibWE/ejF
         WIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WlammgDF0L+1RNwpwU1Hv0Eo8cOXgnk5/hW7BCWo5IU=;
        b=A1ADJRWCBpa4H/y62A/BXfbSr2M2oQW36D5ergvThXBqiQK4P09q/g/JeXAAPyYi9H
         aHzj7a54VysbkZq4+QmuawOiaYVhlQVR6Xrh6bV6QtJaYwKMtnz5upS3l2fBZVZh9uGQ
         TaT94Md8+rHd1hnIxnQGdbQuLECl/m13VkJljZIPwPLDeqQqSsdlTCniArgBp5vgeU+i
         u6LSlJM5wrn1BOb4PjrqmBkFLnyCW1vxCBrhfwgK0mCSAZYBRk17ezDLUGOcb2jtbDZa
         KjW5tOBDIpT+uq5J2xsfUVctklricveiVM1ogZEBSeNTyRZF71N58JysNDiew8Qzfr4x
         VgQw==
X-Gm-Message-State: APjAAAWmtxytCEKHFx2nR0v5U6SRRUt59Pw0wDejTo+Yv0jxyuVwYwYY
        EvtUyAmLXj+g6rJz3znFCznIa44K
X-Google-Smtp-Source: APXvYqyNyd2IMxIk6yej9KoxliVgVjhrvxtPN/U6ahH40vKPXDdlEYk85PvXlGC91e3HyUClRgCv3A==
X-Received: by 2002:a05:6000:12d1:: with SMTP id l17mr1731980wrx.261.1573034395913;
        Wed, 06 Nov 2019 01:59:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r19sm27626641wrr.47.2019.11.06.01.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 01:59:55 -0800 (PST)
Message-Id: <dcb78b6708937c3c6af5a86c276918c19e46acd4.1573034387.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
        <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 09:59:37 +0000
Subject: [PATCH v2 10/20] pathspec: move doc to pathspec.h
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
 pathspec.h                            | 34 ++++++++++++++++++-
 2 files changed, 33 insertions(+), 48 deletions(-)
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
index 1c18a2c90c..0fbd7a051d 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -22,6 +22,10 @@ struct index_state;
 
 #define PATHSPEC_ONESTAR 1	/* the pathspec pattern satisfies GFNM_ONESTAR */
 
+/**
+ * In memory, a pathspec set is represented by "struct pathspec" and is
+ * prepared by parse_pathspec().
+ */
 struct pathspec {
 	int nr;
 	unsigned int has_wildcard:1;
@@ -73,18 +77,46 @@ struct pathspec {
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

