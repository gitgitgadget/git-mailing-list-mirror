Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 750791F597
	for <e@80x24.org>; Tue, 17 Jul 2018 00:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729969AbeGQA4x (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 20:56:53 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:38575 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729811AbeGQA4x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 20:56:53 -0400
Received: by mail-it0-f74.google.com with SMTP id i4-v6so15181887ite.3
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 17:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=S5Ws0EFjsQ7pxKevDC1thXDb/zQ0dmc7RuEndiHRcmo=;
        b=HdwQd/2yUq4A8WsfpP5H85qPN6qKnNOY0uxm9xzXP3gNCiuGK4uJbD6wxtQ1gEnQ3E
         dbXBnZVC3U6vhOl6v+Y9DYSwYblcw2K9/9jBq0qNyTrYHnp5WGxkI/AjlJrw33UWNzfe
         8ZRvGdI/LZjdFMPZmhTwNRY5K9wVSnxZ8MmhfUA30zDyCSU2+VCykQJhTmfUMetA0/zD
         5X7wfUHW8gJYUodH3XWKT/ahX6RHZsBMpEQ4D1sfQIz/Ee6X0V1nLOjJURjI0JYbTk5n
         UZ33jbxeXVaxc6GHb0wLsv9uwPTHQ4CbaFZeh3laF0uCYdK/sCVPrhX2m+Bc2frBU1be
         BqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=S5Ws0EFjsQ7pxKevDC1thXDb/zQ0dmc7RuEndiHRcmo=;
        b=IyZSe64b3SK3kvc4IS+s7tzCxcbYKB8VwR6F/+FUwBwFlOdqA5h9DU5euo2vwI5ZIC
         FLHK21jIPnieKS346TC/H/ct0hZC8opCqu3kZM6H4ZUoi1eA3VxyXxs10RpwfFeMxYX+
         9JAKLkzPdJ45l5sheGcbFaX87tTjkqp83r9cYOg6DBk9di9SJL7dmsGGyTThw48tc+hy
         MlV9IJIQME06W5cjx0acdET/vTiejjGBTyM7e8DZ+UKlJQb5N199joG41AP+wRfTcaqn
         sA5ZsrHqOyPSjjCranHAT4lxapPNNqr2OoaskfLdr0MbslsMK3PB0AVatw8kEdUPRTq1
         AKdA==
X-Gm-Message-State: AOUpUlHHAXwrMfV4Wnx/Cm9SUpMPuu/OgABmJ1NR+JdbLxyyT/kZPfS3
        EVRnzFWoPVKvMTtExiog5u575qxyzhBeG5RUpIgjkNbowFEn5AB8TAgcM1HxpWMzOkAPW498RR4
        58A28AFmik+XLvo99UXzO4LoolmSVY2lXkW22wURzxUGQswGuUiEtce3WUntr
X-Google-Smtp-Source: AAOMgpcpFrRLTm5DkDagnVxGoCFivFAROpVWHxflLrUZy+/CG0CXZzg5ECS1ToCfBADPFkZupwMbYTiPucKX
MIME-Version: 1.0
X-Received: by 2002:a24:700a:: with SMTP id f10-v6mr7775803itc.40.1531787222857;
 Mon, 16 Jul 2018 17:27:02 -0700 (PDT)
Date:   Mon, 16 Jul 2018 17:26:50 -0700
In-Reply-To: <20180717002654.120375-1-sbeller@google.com>
Message-Id: <20180717002654.120375-3-sbeller@google.com>
References: <20180717002654.120375-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH v2 2/6] git-submodule.sh: rename unused variables
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'mode' variable is not used in cmd_update for its original purpose,
rename it to 'dummy' as it only serves the purpose to abort quickly
documenting this knowledge.

The variable 'stage' is also not used any more in cmd_update, so remove it.

This went unnoticed as first each function used the commonly used
submodule listing, which was converted in 74703a1e4df (submodule: rewrite
`module_list` shell function in C, 2015-09-02). When cmd_update was
using its own function starting in 48308681b07 (git submodule update:
have a dedicated helper for cloning, 2016-02-29), its removal was missed.

A later patch in this series also touches the communication between
the submodule helper and git-submodule.sh, but let's have this as
a preparatory patch, as it eases the next patch, which stores the
raw data instead of the line printed for this communication.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 5 ++---
 git-submodule.sh            | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 20ae9191ca3..ebcfe85bfa9 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1571,9 +1571,8 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	needs_cloning = !file_exists(sb.buf);
 
 	strbuf_reset(&sb);
-	strbuf_addf(&sb, "%06o %s %d %d\t%s\n", ce->ce_mode,
-			oid_to_hex(&ce->oid), ce_stage(ce),
-			needs_cloning, ce->name);
+	strbuf_addf(&sb, "dummy %s %d\t%s\n",
+		    oid_to_hex(&ce->oid), needs_cloning, ce->name);
 	string_list_append(&suc->projectlines, sb.buf);
 
 	if (!needs_cloning)
diff --git a/git-submodule.sh b/git-submodule.sh
index 8a611865397..56588aa304d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -531,9 +531,9 @@ cmd_update()
 		"$@" || echo "#unmatched" $?
 	} | {
 	err=
-	while read -r mode sha1 stage just_cloned sm_path
+	while read -r quickabort sha1 just_cloned sm_path
 	do
-		die_if_unmatched "$mode" "$sha1"
+		die_if_unmatched "$quickabort" "$sha1"
 
 		name=$(git submodule--helper name "$sm_path") || exit
 		if ! test -z "$update"
-- 
2.18.0.203.gfac676dfb9-goog

