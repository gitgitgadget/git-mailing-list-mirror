Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDB8E1F609
	for <e@80x24.org>; Tue, 18 Jun 2019 22:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfFRW3Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 18:29:25 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:33275 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfFRW3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 18:29:24 -0400
Received: by mail-qt1-f201.google.com with SMTP id r40so13899611qtk.0
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 15:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n5wjmKc+wFEkmCIEbWaDQwwRKinMZoLvKQPML8GexMM=;
        b=Xi8OsxN7HiPAMm2crtyTvepbOccNVJjTxv0ybnRqZC2zdpTL092wA/TA8Z5TvNSfAp
         I+8dKTJcCreSn0dYRcMotH6bwNrLiAfY8ft8dD8dZBouMIT41ufJSKPtuMWPq/uPWNJy
         8CVNAlJV00E+4PzPP41cMIQiXj47H+/rjbIAOruCyR0GTcyT0q3MnwRXnUOlrFheKgLe
         0JCn30TtwzRXkmNlh+QeBoxr9Y4yCx5691qKFczHk8Ja8keWE+a5WkrmkPChWnXC2ppV
         skdgoPO29Zs7xGr1sS8ZYcKoEka3hPXK4Fj0q3MNz0FdMgpEX/sSzBjxYQfnjhfhDmdl
         XtIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n5wjmKc+wFEkmCIEbWaDQwwRKinMZoLvKQPML8GexMM=;
        b=U1V4nQIJVKiwfmE1/x6S0MK0WVLMNb5/iQ1Ez+mfPdN3uEOVXOuPdVA0GYyXFbSUy6
         YjJvQz8+n3ctURefBQh72AmZCk1+tvM1eiEAXF/CezRthQTe3tsTYmw7qScDz0iT2Bwk
         JEM1O8SGH4jEzXMnXsNFHcFlWuj/C+zgAtgpTKKBqwexFOrIbHaWtSj1NBjhdT/6uDns
         HiDVgG+Vsp2imnhE1LPRh1SIn5F0BvZ30JRcYwuA1d+SXRHKrOV7rcqLB7CjT2xgQGPO
         k25ny4NY8s6MxU8SPz6zlpSj5Yyaik/oyhIXdqu0wAQ+xAp+bT+ZDQyb5lJZKW0Qx4yZ
         ycSw==
X-Gm-Message-State: APjAAAWp0QBQf8qYYeTt5E1U4H7l3VOdjYaZS9K8U5gJurBaC7nmOe//
        ur1GRujpJm8jI7d644kRAPxu4J64Toypihk5O4hKuO/0S/BsjV2NQQh2vGXqqP/UfWHx85+f/JR
        izQnzLRmnsaWhVXyNElepb8SUEZw4JYsCGHSEOFtQN20YvY4LJ7UpfAlwFTU=
X-Google-Smtp-Source: APXvYqwEv+xxYzQeEHtelHz+LbkfI8qWsEwlu75TNjRgEeuEbSQCCYzQkG/u8LPQhDpx/FhXQh1KtfGyyhvS
X-Received: by 2002:ac8:264f:: with SMTP id v15mr26345597qtv.51.1560896963772;
 Tue, 18 Jun 2019 15:29:23 -0700 (PDT)
Date:   Tue, 18 Jun 2019 15:29:15 -0700
In-Reply-To: <cover.1560895672.git.matvore@google.com>
Message-Id: <9bd85516f91c3e2fdefdafd51df71f75603e51f6.1560895672.git.matvore@google.com>
Mime-Version: 1.0
References: <faaa9a3d6ba66d77cc2a8eab438d1bfc8f762fa1.1559857032.git.matvore@google.com>
 <cover.1560895672.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH v3 1/1] ref-filter: sort detached HEAD lines firstly
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, avarab@gmail.com,
        git@matthieu-moy.fr, olyatelezhnaya@gmail.com,
        samuel.maftoul@gmail.com, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, karthik.188@gmail.com,
        pclouds@gmail.com, sunshine@sunshineco.com,
        emilyshaffer@google.com, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before this patch, "git branch" would put "(HEAD detached...)" and "(no
branch, rebasing...)" lines before all the other branches *in most
cases* except for when using Chinese-language messages. zh_CN generally
uses a full-width "(" symbol (codepoint FF08) to match the full-width
proportions of Chinese characters, and the translated strings we had did
use them. This meant that the detached HEAD line would appear after all
local refs and even after the remote refs if there were any.

AFAIK, it is sometimes not jarring to see the half-width parenthesis in
"full-width" text as in the CJK languages, for instance when there are
no characters preceding or following the parenthesized text fragment. By
removing the parenthesis from the localizable text, we can share strings
with wt-status.c and remove a cautionary comment to translators.

Remove the ( from the localizable portion of messages so the sorting
happens properly regardless of locale.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Matthew DeVore <matvore@google.com>
---
 ref-filter.c | 32 ++++++++++++++++----------------
 wt-status.c  |  4 ++--
 wt-status.h  |  3 +++
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 8500671bc6..87aa6b4774 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1440,49 +1440,49 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 	} else
 		BUG("unhandled RR_* enum");
 }
 
 char *get_head_description(void)
 {
 	struct strbuf desc = STRBUF_INIT;
 	struct wt_status_state state;
 	memset(&state, 0, sizeof(state));
 	wt_status_get_state(the_repository, &state, 1);
+
+	/*
+	 * The ( character must be hard-coded and not part of a localizable
+	 * string, since the description is used as a sort key and compared
+	 * with ref names.
+	 */
+	strbuf_addch(&desc, '(');
 	if (state.rebase_in_progress ||
 	    state.rebase_interactive_in_progress) {
 		if (state.branch)
-			strbuf_addf(&desc, _("(no branch, rebasing %s)"),
+			strbuf_addf(&desc, _("no branch, rebasing %s"),
 				    state.branch);
 		else
-			strbuf_addf(&desc, _("(no branch, rebasing detached HEAD %s)"),
+			strbuf_addf(&desc, _("no branch, rebasing detached HEAD %s"),
 				    state.detached_from);
 	} else if (state.bisect_in_progress)
-		strbuf_addf(&desc, _("(no branch, bisect started on %s)"),
+		strbuf_addf(&desc, _("no branch, bisect started on %s"),
 			    state.branch);
 	else if (state.detached_from) {
 		if (state.detached_at)
-			/*
-			 * TRANSLATORS: make sure this matches "HEAD
-			 * detached at " in wt-status.c
-			 */
-			strbuf_addf(&desc, _("(HEAD detached at %s)"),
-				state.detached_from);
+			strbuf_addstr(&desc, HEAD_DETACHED_AT);
 		else
-			/*
-			 * TRANSLATORS: make sure this matches "HEAD
-			 * detached from " in wt-status.c
-			 */
-			strbuf_addf(&desc, _("(HEAD detached from %s)"),
-				state.detached_from);
+			strbuf_addstr(&desc, HEAD_DETACHED_FROM);
+		strbuf_addstr(&desc, state.detached_from);
 	}
 	else
-		strbuf_addstr(&desc, _("(no branch)"));
+		strbuf_addstr(&desc, _("no branch"));
+	strbuf_addch(&desc, ')');
+
 	free(state.branch);
 	free(state.onto);
 	free(state.detached_from);
 	return strbuf_detach(&desc, NULL);
 }
 
 static const char *get_symref(struct used_atom *atom, struct ref_array_item *ref)
 {
 	if (!ref->symref)
 		return xstrdup("");
diff --git a/wt-status.c b/wt-status.c
index 0bccef542f..c29e4bf091 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1669,23 +1669,23 @@ static void wt_longstatus_print(struct wt_status *s)
 			if (s->state.rebase_in_progress ||
 			    s->state.rebase_interactive_in_progress) {
 				if (s->state.rebase_interactive_in_progress)
 					on_what = _("interactive rebase in progress; onto ");
 				else
 					on_what = _("rebase in progress; onto ");
 				branch_name = s->state.onto;
 			} else if (s->state.detached_from) {
 				branch_name = s->state.detached_from;
 				if (s->state.detached_at)
-					on_what = _("HEAD detached at ");
+					on_what = HEAD_DETACHED_AT;
 				else
-					on_what = _("HEAD detached from ");
+					on_what = HEAD_DETACHED_FROM;
 			} else {
 				branch_name = "";
 				on_what = _("Not currently on any branch.");
 			}
 		} else
 			skip_prefix(branch_name, "refs/heads/", &branch_name);
 		status_printf(s, color(WT_STATUS_HEADER, s), "%s", "");
 		status_printf_more(s, branch_status_color, "%s", on_what);
 		status_printf_more(s, branch_color, "%s\n", branch_name);
 		if (!s->is_initial)
diff --git a/wt-status.h b/wt-status.h
index 64f1ddc9fd..b0cfdc8011 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -58,20 +58,23 @@ struct wt_status_change_data {
 enum wt_status_format {
 	STATUS_FORMAT_NONE = 0,
 	STATUS_FORMAT_LONG,
 	STATUS_FORMAT_SHORT,
 	STATUS_FORMAT_PORCELAIN,
 	STATUS_FORMAT_PORCELAIN_V2,
 
 	STATUS_FORMAT_UNSPECIFIED
 };
 
+#define HEAD_DETACHED_AT _("HEAD detached at ")
+#define HEAD_DETACHED_FROM _("HEAD detached from ")
+
 struct wt_status_state {
 	int merge_in_progress;
 	int am_in_progress;
 	int am_empty_patch;
 	int rebase_in_progress;
 	int rebase_interactive_in_progress;
 	int cherry_pick_in_progress;
 	int bisect_in_progress;
 	int revert_in_progress;
 	int detached_at;
-- 
2.21.0

