Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70858249E6
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 22:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fjSwdxKr"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78EDF5
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 15:28:40 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5af9ad9341fso61562187b3.2
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 15:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698791320; x=1699396120; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jFqlmzfjxaj3ax6Zx1Dr5dQxFI87VmUXJOTDutnTjGc=;
        b=fjSwdxKr1dykMScPPZo7flbORh5qUqceAGulTGon6JmU/N/k27PwcaMl09O1JQLpls
         G6sjtRI/rl3j8+sfZjvbyJlUIaFR9sY5Eg6ak2dM+8iQhkgKmBX9gcjmVUACkgPmr8Ti
         I7CESOQ92tNoxPYBCmLoWgTNoBPxBoAk2uumVXLb6ELZVw0MYa+YAZutpdvGDu33Lefp
         qRKXVWo2Gt22IKxgeAbkY3ZhA7n5jnCWMG/EBbQDYxyClB8QRaxGqHlQgEIxPjyCY5oX
         xj6n+41AL/2cXeeKLlAKbfPoi+Y0tqY42/icohCyqOen9d+WSpWy/H0uKXOuTBfTudvs
         ck1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698791320; x=1699396120;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFqlmzfjxaj3ax6Zx1Dr5dQxFI87VmUXJOTDutnTjGc=;
        b=OFE0U8nQgcTBxlwrYOByxjkCWHEkUxxE2NtTQwapQzop1+oleyWaMG66KqVxfb5pAG
         53KG5CJMTLu7COvKD/e6wzXn/RpkWb5LbCCaWPjN8krTPMBHIYAZZKECMgOlFBk5HMCU
         lRGec5AjxromajFCNVhhej+334OGyfcSbdPY6sJTBcYLLQ6VOQIjeZC8tLsjolPgWhfx
         ra1PeuUWEjWTxbVpYeOy2g+RNqkVNLACv0fi/X83Q400zB6qaWJ9e4QUXBVpTdRaRWVz
         RIW4bxoytxKvggIP1TR6/JflMekNZE015Qe/ApkYRkFr2DzoyYhsd8PIdAGyJD7USUqF
         dK1A==
X-Gm-Message-State: AOJu0YwqLb0isd4Vot6VrMVjEYEkh+CcKgWG+kjyxoQ5OAp4cBVy0Sef
	2Pasywsn85zPfFKvC4cr2EnsxahoEd+vCjr2V6A9bplZxjVto5OSqix/s7kUR4GzJjwXz3cbxAM
	Nc9xg8qEglmIK3njP7PSCD5eoN2YeQdfew1xG2oqCA1pmsLR6p1KR3MspF2nB3KdjnV62Q7rS+g
	c5
X-Google-Smtp-Source: AGHT+IFtanXTk960IJYAgk2ipYruDMJHes2PGeDq9vhF0j1viOJaxt2SbmOYngP34BIq1m4jZVwZeu7N1jkJFshJG2CY
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:70a1:f59a:2e01:c62e])
 (user=jonathantanmy job=sendgmr) by 2002:a0d:df82:0:b0:586:a8ab:f8fe with
 SMTP id i124-20020a0ddf82000000b00586a8abf8femr293476ywe.10.1698791319963;
 Tue, 31 Oct 2023 15:28:39 -0700 (PDT)
Date: Tue, 31 Oct 2023 15:28:30 -0700
In-Reply-To: <cover.1698791220.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <db6702ba-11a7-44c1-af2a-95b080aaeb77@gmail.com> <cover.1698791220.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <98c9f70608d7b6f7bee49a89634de100b2dd5ecf.1698791220.git.jonathantanmy@google.com>
Subject: [PATCH v2 1/4] strbuf_commented_addf(): drop the comment_line_char parameter
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>, 
	Phillip Wood <phillip.wood123@gmail.com>, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Junio C Hamano <gitster@pobox.com>

All the callers of this function supply the global variable
comment_line_char as an argument to its second parameter.  Remove
the parameter to allow us in the future to change the reference to
the global variable with something else, like a function call.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 add-patch.c          | 8 ++++----
 builtin/branch.c     | 2 +-
 builtin/merge.c      | 8 ++++----
 builtin/tag.c        | 4 ++--
 rebase-interactive.c | 2 +-
 sequencer.c          | 4 ++--
 strbuf.c             | 3 ++-
 strbuf.h             | 4 ++--
 wt-status.c          | 2 +-
 9 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index bfe19876cd..471a0037be 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1106,11 +1106,11 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
 	size_t i;
 
 	strbuf_reset(&s->buf);
-	strbuf_commented_addf(&s->buf, comment_line_char,
+	strbuf_commented_addf(&s->buf,
 			      _("Manual hunk edit mode -- see bottom for "
 				"a quick guide.\n"));
 	render_hunk(s, hunk, 0, 0, &s->buf);
-	strbuf_commented_addf(&s->buf, comment_line_char,
+	strbuf_commented_addf(&s->buf,
 			      _("---\n"
 				"To remove '%c' lines, make them ' ' lines "
 				"(context).\n"
@@ -1119,13 +1119,13 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
 			      s->mode->is_reverse ? '+' : '-',
 			      s->mode->is_reverse ? '-' : '+',
 			      comment_line_char);
-	strbuf_commented_addf(&s->buf, comment_line_char, "%s",
+	strbuf_commented_addf(&s->buf, "%s",
 			      _(s->mode->edit_hunk_hint));
 	/*
 	 * TRANSLATORS: 'it' refers to the patch mentioned in the previous
 	 * messages.
 	 */
-	strbuf_commented_addf(&s->buf, comment_line_char,
+	strbuf_commented_addf(&s->buf,
 			      _("If it does not apply cleanly, you will be "
 				"given an opportunity to\n"
 				"edit again.  If all lines of the hunk are "
diff --git a/builtin/branch.c b/builtin/branch.c
index 2ec190b14a..b2f171e10b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -668,7 +668,7 @@ static int edit_branch_description(const char *branch_name)
 	exists = !read_branch_desc(&buf, branch_name);
 	if (!buf.len || buf.buf[buf.len-1] != '\n')
 		strbuf_addch(&buf, '\n');
-	strbuf_commented_addf(&buf, comment_line_char,
+	strbuf_commented_addf(&buf,
 		    _("Please edit the description for the branch\n"
 		      "  %s\n"
 		      "Lines starting with '%c' will be stripped.\n"),
diff --git a/builtin/merge.c b/builtin/merge.c
index d748d46e13..8f0e8be7c3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -857,15 +857,15 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		strbuf_addch(&msg, '\n');
 		if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS) {
 			wt_status_append_cut_line(&msg);
-			strbuf_commented_addf(&msg, comment_line_char, "\n");
+			strbuf_commented_addf(&msg, "\n");
 		}
-		strbuf_commented_addf(&msg, comment_line_char,
+		strbuf_commented_addf(&msg,
 				      _(merge_editor_comment));
 		if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
-			strbuf_commented_addf(&msg, comment_line_char,
+			strbuf_commented_addf(&msg,
 					      _(scissors_editor_comment));
 		else
-			strbuf_commented_addf(&msg, comment_line_char,
+			strbuf_commented_addf(&msg,
 				_(no_scissors_editor_comment), comment_line_char);
 	}
 	if (signoff)
diff --git a/builtin/tag.c b/builtin/tag.c
index 3918eacbb5..a85a0d8def 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -314,10 +314,10 @@ static void create_tag(const struct object_id *object, const char *object_ref,
 			struct strbuf buf = STRBUF_INIT;
 			strbuf_addch(&buf, '\n');
 			if (opt->cleanup_mode == CLEANUP_ALL)
-				strbuf_commented_addf(&buf, comment_line_char,
+				strbuf_commented_addf(&buf,
 				      _(tag_template), tag, comment_line_char);
 			else
-				strbuf_commented_addf(&buf, comment_line_char,
+				strbuf_commented_addf(&buf,
 				      _(tag_template_nocleanup), tag, comment_line_char);
 			write_or_die(fd, buf.buf, buf.len);
 			strbuf_release(&buf);
diff --git a/rebase-interactive.c b/rebase-interactive.c
index d9718409b3..3f33da7f03 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -71,7 +71,7 @@ void append_todo_help(int command_count,
 
 	if (!edit_todo) {
 		strbuf_addch(buf, '\n');
-		strbuf_commented_addf(buf, comment_line_char,
+		strbuf_commented_addf(buf,
 				      Q_("Rebase %s onto %s (%d command)",
 					 "Rebase %s onto %s (%d commands)",
 					 command_count),
diff --git a/sequencer.c b/sequencer.c
index d584cac8ed..5d348a3f12 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -675,11 +675,11 @@ void append_conflicts_hint(struct index_state *istate,
 	}
 
 	strbuf_addch(msgbuf, '\n');
-	strbuf_commented_addf(msgbuf, comment_line_char, "Conflicts:\n");
+	strbuf_commented_addf(msgbuf, "Conflicts:\n");
 	for (i = 0; i < istate->cache_nr;) {
 		const struct cache_entry *ce = istate->cache[i++];
 		if (ce_stage(ce)) {
-			strbuf_commented_addf(msgbuf, comment_line_char,
+			strbuf_commented_addf(msgbuf,
 					      "\t%s\n", ce->name);
 			while (i < istate->cache_nr &&
 			       !strcmp(ce->name, istate->cache[i]->name))
diff --git a/strbuf.c b/strbuf.c
index 7827178d8e..15550b2619 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "environment.h"
 #include "gettext.h"
 #include "hex-ll.h"
 #include "strbuf.h"
@@ -372,7 +373,7 @@ void strbuf_add_commented_lines(struct strbuf *out, const char *buf,
 	add_lines(out, prefix1, prefix2, buf, size);
 }
 
-void strbuf_commented_addf(struct strbuf *sb, char comment_line_char,
+void strbuf_commented_addf(struct strbuf *sb,
 			   const char *fmt, ...)
 {
 	va_list params;
diff --git a/strbuf.h b/strbuf.h
index e959caca87..981617dc77 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -378,8 +378,8 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
  * Add a formatted string prepended by a comment character and a
  * blank to the buffer.
  */
-__attribute__((format (printf, 3, 4)))
-void strbuf_commented_addf(struct strbuf *sb, char comment_line_char, const char *fmt, ...);
+__attribute__((format (printf, 2, 3)))
+void strbuf_commented_addf(struct strbuf *sb, const char *fmt, ...);
 
 __attribute__((format (printf,2,0)))
 void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
diff --git a/wt-status.c b/wt-status.c
index 9f45bf6949..54b2775730 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1102,7 +1102,7 @@ void wt_status_append_cut_line(struct strbuf *buf)
 {
 	const char *explanation = _("Do not modify or remove the line above.\nEverything below it will be ignored.");
 
-	strbuf_commented_addf(buf, comment_line_char, "%s", cut_line);
+	strbuf_commented_addf(buf, "%s", cut_line);
 	strbuf_add_commented_lines(buf, explanation, strlen(explanation), comment_line_char);
 }
 
-- 
2.42.0.820.g83a721a137-goog

