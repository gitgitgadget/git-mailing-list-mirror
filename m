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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D8F11F454
	for <e@80x24.org>; Mon, 11 Nov 2019 21:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfKKV2Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 16:28:25 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:37827 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfKKV2P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 16:28:15 -0500
Received: by mail-wm1-f52.google.com with SMTP id b17so803813wmj.2
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 13:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ByXG9NUEQXnOejxLNbqwymYZvqZVDNF4tVNaLMHYBnI=;
        b=AZ4/MIOh9+mPYdK/j9i7cvykNNVkOaUhuuicd18apykbHy0MEPS44FeRiPmHZPw1/D
         R+d2mJgo7v7vbYbPRaBzBWO/qhoU4uN9Q5rkGxYgnAkagDm2UidNvfQMaTkLFb6wXIUM
         7SZsFnhx4DEvP8ogJGIiX8UuxWbUrlQCpvyxM4nS/RN2t/lN69I2PRe23N7nZ+UhxfmS
         YbVYv6TwMRT53NUb/B73Ese/kAMGuEm78USZvIUfIE6O/2CVfQLePNywAfnCPjR/BI74
         r6ZC+yuZVsf8+RHvRMWQf/S39FVdxnFNZFh75MsOyCH+7fwD3ip/TdXO3CMp0Kjs0/12
         WvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ByXG9NUEQXnOejxLNbqwymYZvqZVDNF4tVNaLMHYBnI=;
        b=alSFuiSQN9BqIv/fpeqrijU5CsWpnfiSXLkunOJ+alV1kDAinBqLsHdLKilQ8HDY4S
         Vx8toMCHtV3xLH9SLZaC9AqenF+P7ujbKptnfcQy0kFAMruYCZOchRnkoghItIc+n5gC
         F6XTY8Dp7+601l5YYgDwKe4AVKmN6+VJG5gYLcFO9N+5doywm7FtV2Y0M2FH8H7rpIZu
         iO9KHHWx15+aFuZfu0QmMVEVZ/Q1LKP0iiU3NmXOMUADi86WtJbKSliYBHNNkqELdmaS
         R3MmNMzucYS2AkDqV/kPhO+lTGMjRAGtFBQbjOWmbmePdkkRX2OFr0LSE123xNe60TGe
         rYPA==
X-Gm-Message-State: APjAAAWhG8FZmOZ7l8NUyDF5WRf+4GRAzlg8jgtXzYTvmBORls9pG/3e
        ZLhGLLbNFIP3BKZZFXFGIINKArij
X-Google-Smtp-Source: APXvYqzG+gH7I6xSQ9F5GP9p/lbzZ8SUD6URh3eBpverFm4I8mz6GaOWS/hv8LrNcIBqxJGPy86+Ww==
X-Received: by 2002:a1c:7709:: with SMTP id t9mr897334wmi.80.1573507694278;
        Mon, 11 Nov 2019 13:28:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j22sm29069207wrd.41.2019.11.11.13.28.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 13:28:13 -0800 (PST)
Message-Id: <fa450e27a8d762af3d9da32ffa4723442c9795c5.1573507684.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
References: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
        <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 Nov 2019 21:27:53 +0000
Subject: [PATCH v3 10/21] pathspec: move doc to pathspec.h
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

