Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99CED202BB
	for <e@80x24.org>; Thu, 14 Mar 2019 11:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfCNLZI (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 07:25:08 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37474 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfCNLZH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 07:25:07 -0400
Received: by mail-ed1-f66.google.com with SMTP id m12so4286146edv.4
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 04:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=keEllI8Z+5TnkM5sMC9FDHveweVpHAtNpyF3b/Fi6VI=;
        b=MPZyR70jWJKa8n9TJp/27RZ/i6e9qIKxduA+hd9IGoerB/Fwpa3SeqRm1ENmWahQOC
         0gNwckXcmsJe8kR0J8kgiQIloRtN54fI/HyXmApFXjr+VxPkSdvFp2HWDEREXDSt5AM0
         k5jFQNrNtnriRVZ+FWk9cZPaCHPvFN/ZNU3IBomWxRUc0D/dyAGGEunR3e1Q6z8AriI7
         qGVDCEfagIEUkFUu2Z8Vd7vPwyVim4uUqeA+MOHQZ3pO+2AnJmjDqOZBi1DFy7fTWbjf
         VzHgXo0TjdHqe41yWgKoZudWVE8VLSCsaXXyhKMYDl2S4Wt2pDdCCcMA5ssdGDivOC7K
         clvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=keEllI8Z+5TnkM5sMC9FDHveweVpHAtNpyF3b/Fi6VI=;
        b=tX99KPUjt20RoLZJTVr67+eStHEeO6KLgAmQXzmdRoRK/c1As8cYrhjmU2A1aVVGcg
         VMyxK6xICui9fpkS7LnKQf1LriBFyYn5UX2PwdVgyn+WtRWV1nEtLFKYTIVuS4cLvafy
         fhn1pSGxAAWZD0JFCrGGHdk51sdvlaquAdznHnf+l40Wx8eYFwzHaZABpP5O/Eb0UHLg
         bHSk+WL+aNB/stnCa9JRmJZbfqbQqnckf2+mar7Sj5aaBvcAS7MxLBzrGwfdbv7S5UkE
         wokD/cjtam14RZw1lWoAJKeQFfh5DIa46y9YNYSD3v3v4Rlbh4XGfa8Yh2xfv00joRBi
         PqRQ==
X-Gm-Message-State: APjAAAV6q2QCCpbWhBJbRkVuqdCx3pLghZQnxPf6iarn0sF6XHRNVFeY
        F9VpTSn/X2OD3/ZOrz4UYOMtnQMV
X-Google-Smtp-Source: APXvYqwQbhdspq5Wf8OizWL4WRVcM+58o4Pwhu4ejvvaxqDfwo4AffTxW7OwHjl3qVu/INi8M63c3g==
X-Received: by 2002:a50:9ea8:: with SMTP id a37mr3010015edf.147.1552562704678;
        Thu, 14 Mar 2019 04:25:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e27sm1390131eda.52.2019.03.14.04.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 04:25:04 -0700 (PDT)
Date:   Thu, 14 Mar 2019 04:25:04 -0700 (PDT)
X-Google-Original-Date: Thu, 14 Mar 2019 11:25:00 GMT
Message-Id: <10775638ad8f2ef9b64b8dbaf71b80d8546e81d8.1552562701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.163.v2.git.gitgitgadget@gmail.com>
References: <pull.163.git.gitgitgadget@gmail.com>
        <pull.163.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/3] parse-options: make OPT_ARGUMENT()  more useful
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

`OPT_ARGUMENT()` is intended to keep the specified long option in `argv`
and not to do anything else.

However, it would make a lot of sense for the caller to know whether
this option was seen at all or not. For example, we want to teach `git
difftool` to work outside of any Git worktree, but only when
`--no-index` was specified.

Note: nothing in Git uses OPT_ARGUMENT(). Even worse, looking through
the commit history, one can easily see that nothing even
ever used it, apart from the regression test.

So not only do we make `OPT_ARGUMENT()` more useful, we are also about
to introduce its first real user!

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/technical/api-parse-options.txt | 4 +++-
 parse-options.c                               | 2 ++
 parse-options.h                               | 4 ++--
 t/helper/test-parse-options.c                 | 2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 2b036d7838..2e2e7c10c6 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -198,8 +198,10 @@ There are some macros to easily define options:
 	The filename will be prefixed by passing the filename along with
 	the prefix argument of `parse_options()` to `prefix_filename()`.
 
-`OPT_ARGUMENT(long, description)`::
+`OPT_ARGUMENT(long, &int_var, description)`::
 	Introduce a long-option argument that will be kept in `argv[]`.
+	If this option was seen, `int_var` will be set to one (except
+	if a `NULL` pointer was passed).
 
 `OPT_NUMBER_CALLBACK(&var, description, func_ptr)`::
 	Recognize numerical options like -123 and feed the integer as
diff --git a/parse-options.c b/parse-options.c
index cec74522e5..1d57802da0 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -286,6 +286,8 @@ static enum parse_opt_result parse_long_opt(
 					     optname(options, flags));
 			if (*rest)
 				continue;
+			if (options->value)
+				*(int *)options->value = options->defval;
 			p->out[p->cpidx++] = arg - 2;
 			return PARSE_OPT_DONE;
 		}
diff --git a/parse-options.h b/parse-options.h
index 7d83e2971d..c3d45ba1ac 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -138,8 +138,8 @@ struct option {
 	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), (f), (cb) }
 
 #define OPT_END()                   { OPTION_END }
-#define OPT_ARGUMENT(l, h)          { OPTION_ARGUMENT, 0, (l), NULL, NULL, \
-				      (h), PARSE_OPT_NOARG}
+#define OPT_ARGUMENT(l, v, h)       { OPTION_ARGUMENT, 0, (l), (v), NULL, \
+				      (h), PARSE_OPT_NOARG, NULL, 1 }
 #define OPT_GROUP(h)                { OPTION_GROUP, 0, NULL, NULL, NULL, (h) }
 #define OPT_BIT(s, l, v, h, b)      OPT_BIT_F(s, l, v, h, b, 0)
 #define OPT_BITOP(s, l, v, h, set, clear) { OPTION_BITOP, (s), (l), (v), NULL, (h), \
diff --git a/t/helper/test-parse-options.c b/t/helper/test-parse-options.c
index cc88fba057..2232b2f79e 100644
--- a/t/helper/test-parse-options.c
+++ b/t/helper/test-parse-options.c
@@ -132,7 +132,7 @@ int cmd__parse_options(int argc, const char **argv)
 		OPT_NOOP_NOARG(0, "obsolete"),
 		OPT_STRING_LIST(0, "list", &list, "str", "add str to list"),
 		OPT_GROUP("Magic arguments"),
-		OPT_ARGUMENT("quux", "means --quux"),
+		OPT_ARGUMENT("quux", NULL, "means --quux"),
 		OPT_NUMBER_CALLBACK(&integer, "set integer to NUM",
 			number_callback),
 		{ OPTION_COUNTUP, '+', NULL, &boolean, NULL, "same as -b",
-- 
gitgitgadget

