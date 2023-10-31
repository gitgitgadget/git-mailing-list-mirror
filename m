Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693BA2745D
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 22:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3rsmGqTa"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5474F3
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 15:28:42 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7b9e83b70so2829467b3.0
        for <git@vger.kernel.org>; Tue, 31 Oct 2023 15:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698791322; x=1699396122; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O9pvSQ4uIAfJHCTHvc6jewH23WsYYLZIzyZ0484t/nM=;
        b=3rsmGqTa2xfKyApuTxhlGuOZfA89wHg4YWdAAZFCYupWZp+q5+Lp2WpfTTH2Ywy4W7
         2Rty+rI28bvd1FSJxiIicDU0qwBH/vLewcdiQR2aJBkx5rnIZq9FUaCvikerku4XJ498
         ATcSG/YdXaya9tM51UuKo9e819pvrXjIOvpHCS7xOfIbo3K19JbL1pbuvKW01i7gJw0R
         fuqbh19N+XToMzBkDvjb/KiK7Fb9h5WF2gyGSKzJ1/vhlznLnVOYR2caQE86zACKePnM
         5/d6Nh4LBeHobgGwugE/IYBWm/URlr/fGEqHusTDVS6lV037qjoZGwEJvq5QV07gGRd0
         ZK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698791322; x=1699396122;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O9pvSQ4uIAfJHCTHvc6jewH23WsYYLZIzyZ0484t/nM=;
        b=EuIksg7SiD9HjZ2CVdITbXrGGa95tiLqxvgKslfz2asu5Xgm373aPoD3K10U9VIMvg
         KIrRPjEs86VnWAwLftjwtGXDuO3ciZaZccY6sJ13e412pham62RFupg255P/GGAaf65C
         2iQjhBQ1gFUHN5fLiTZBZPMiqUakceEdWXFJ9vACGKYfrQR1+7++tqBYE5MiMO9zuFxg
         6cg9smfogJyxiU3qOv3MCXsY1RIAQ0QAsMFHnbTmJ8gHGkC/t5q/aUjCEoJhprbD5Vk/
         OkvfSz8cwOkq+PBVhZw3zDpoltPCQmykplPZcBgJ5F9j1jmXtJmE9duzTFcs0wSwnQnA
         Nyzg==
X-Gm-Message-State: AOJu0YxVFLJV2RumZ4qii4NNrFsODTyj2MjaMzeqb2mM4r99Aq5QPIe7
	m97xRUKH+zJRl30R+WMLJivp9bkjjt5fmzkThOJcUpDV5HMLrUnJUDpJdj4G05zWZe3tR7cORWb
	kwmvhfeqGtZvA6ci+OlWKRVXE16bQUmNjnj3HzPBsIutoN50UNUDbHer2JkHtD4iU6HJ8Q4NGoC
	rT
X-Google-Smtp-Source: AGHT+IFUF4dpQHjCd8ETD1rJjRiB75V2PapqtiZmv65/iHvIBTSUebhQixJLVoe/g5Ri9jrELPdMmHu3I+5pCIFWG2Ke
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:70a1:f59a:2e01:c62e])
 (user=jonathantanmy job=sendgmr) by 2002:a0d:c001:0:b0:5a4:fd03:2516 with
 SMTP id b1-20020a0dc001000000b005a4fd032516mr102639ywd.1.1698791322009; Tue,
 31 Oct 2023 15:28:42 -0700 (PDT)
Date: Tue, 31 Oct 2023 15:28:31 -0700
In-Reply-To: <cover.1698791220.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <db6702ba-11a7-44c1-af2a-95b080aaeb77@gmail.com> <cover.1698791220.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <22e96f5ba1a36e96d9577ba279711f7c61308441.1698791220.git.jonathantanmy@google.com>
Subject: [PATCH v2 2/4] strbuf_add_commented_lines(): drop the
 comment_line_char parameter
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>, 
	Phillip Wood <phillip.wood123@gmail.com>, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Junio C Hamano <gitster@pobox.com>

All the callers of this function supply the global variable
comment_line_char as an argument to its last parameter.  Remove the
parameter to allow us in the future to change the reference to the
global variable with something else, like a function call.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/notes.c      |  9 ++++-----
 builtin/stripspace.c |  2 +-
 fmt-merge-msg.c      |  9 +++------
 rebase-interactive.c |  6 +++---
 sequencer.c          | 10 ++++------
 strbuf.c             |  6 +++---
 strbuf.h             |  3 +--
 wt-status.c          |  4 ++--
 8 files changed, 21 insertions(+), 28 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 9f38863dd5..355ecce07a 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -181,7 +181,7 @@ static void write_commented_object(int fd, const struct object_id *object)
 
 	if (strbuf_read(&buf, show.out, 0) < 0)
 		die_errno(_("could not read 'show' output"));
-	strbuf_add_commented_lines(&cbuf, buf.buf, buf.len, comment_line_char);
+	strbuf_add_commented_lines(&cbuf, buf.buf, buf.len);
 	write_or_die(fd, cbuf.buf, cbuf.len);
 
 	strbuf_release(&cbuf);
@@ -209,10 +209,9 @@ static void prepare_note_data(const struct object_id *object, struct note_data *
 			copy_obj_to_fd(fd, old_note);
 
 		strbuf_addch(&buf, '\n');
-		strbuf_add_commented_lines(&buf, "\n", strlen("\n"), comment_line_char);
-		strbuf_add_commented_lines(&buf, _(note_template), strlen(_(note_template)),
-					   comment_line_char);
-		strbuf_add_commented_lines(&buf, "\n", strlen("\n"), comment_line_char);
+		strbuf_add_commented_lines(&buf, "\n", strlen("\n"));
+		strbuf_add_commented_lines(&buf, _(note_template), strlen(_(note_template)));
+		strbuf_add_commented_lines(&buf, "\n", strlen("\n"));
 		write_or_die(fd, buf.buf, buf.len);
 
 		write_commented_object(fd, object);
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 7b700a9fb1..11e475760c 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -13,7 +13,7 @@ static void comment_lines(struct strbuf *buf)
 	size_t len;
 
 	msg = strbuf_detach(buf, &len);
-	strbuf_add_commented_lines(buf, msg, len, comment_line_char);
+	strbuf_add_commented_lines(buf, msg, len);
 	free(msg);
 }
 
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 66e47449a0..adc85d2a72 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -509,8 +509,7 @@ static void fmt_tag_signature(struct strbuf *tagbuf,
 	strbuf_complete_line(tagbuf);
 	if (sig->len) {
 		strbuf_addch(tagbuf, '\n');
-		strbuf_add_commented_lines(tagbuf, sig->buf, sig->len,
-					   comment_line_char);
+		strbuf_add_commented_lines(tagbuf, sig->buf, sig->len);
 	}
 }
 
@@ -556,8 +555,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 				strbuf_addch(&tagline, '\n');
 				strbuf_add_commented_lines(&tagline,
 						origins.items[first_tag].string,
-						strlen(origins.items[first_tag].string),
-						comment_line_char);
+						strlen(origins.items[first_tag].string));
 				strbuf_insert(&tagbuf, 0, tagline.buf,
 					      tagline.len);
 				strbuf_release(&tagline);
@@ -565,8 +563,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 			strbuf_addch(&tagbuf, '\n');
 			strbuf_add_commented_lines(&tagbuf,
 					origins.items[i].string,
-					strlen(origins.items[i].string),
-					comment_line_char);
+					strlen(origins.items[i].string));
 			fmt_tag_signature(&tagbuf, &sig, buf, len);
 		}
 		strbuf_release(&payload);
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 3f33da7f03..1138bd37ba 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -78,7 +78,7 @@ void append_todo_help(int command_count,
 				      shortrevisions, shortonto, command_count);
 	}
 
-	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_char);
+	strbuf_add_commented_lines(buf, msg, strlen(msg));
 
 	if (get_missing_commit_check_level() == MISSING_COMMIT_CHECK_ERROR)
 		msg = _("\nDo not remove any line. Use 'drop' "
@@ -87,7 +87,7 @@ void append_todo_help(int command_count,
 		msg = _("\nIf you remove a line here "
 			 "THAT COMMIT WILL BE LOST.\n");
 
-	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_char);
+	strbuf_add_commented_lines(buf, msg, strlen(msg));
 
 	if (edit_todo)
 		msg = _("\nYou are editing the todo file "
@@ -98,7 +98,7 @@ void append_todo_help(int command_count,
 		msg = _("\nHowever, if you remove everything, "
 			"the rebase will be aborted.\n\n");
 
-	strbuf_add_commented_lines(buf, msg, strlen(msg), comment_line_char);
+	strbuf_add_commented_lines(buf, msg, strlen(msg));
 }
 
 int edit_todo_list(struct repository *r, struct todo_list *todo_list,
diff --git a/sequencer.c b/sequencer.c
index 5d348a3f12..29c8b5e32b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1859,7 +1859,7 @@ static void add_commented_lines(struct strbuf *buf, const void *str, size_t len)
 		s += count;
 		len -= count;
 	}
-	strbuf_add_commented_lines(buf, s, len, comment_line_char);
+	strbuf_add_commented_lines(buf, s, len);
 }
 
 /* Does the current fixup chain contain a squash command? */
@@ -1958,7 +1958,7 @@ static int append_squash_message(struct strbuf *buf, const char *body,
 	strbuf_addf(buf, _(nth_commit_msg_fmt),
 		    ++opts->current_fixup_count + 1);
 	strbuf_addstr(buf, "\n\n");
-	strbuf_add_commented_lines(buf, body, commented_len, comment_line_char);
+	strbuf_add_commented_lines(buf, body, commented_len);
 	/* buf->buf may be reallocated so store an offset into the buffer */
 	fixup_off = buf->len;
 	strbuf_addstr(buf, body + commented_len);
@@ -2048,8 +2048,7 @@ static int update_squash_messages(struct repository *r,
 			      _(first_commit_msg_str));
 		strbuf_addstr(&buf, "\n\n");
 		if (is_fixup_flag(command, flag))
-			strbuf_add_commented_lines(&buf, body, strlen(body),
-						   comment_line_char);
+			strbuf_add_commented_lines(&buf, body, strlen(body));
 		else
 			strbuf_addstr(&buf, body);
 
@@ -2068,8 +2067,7 @@ static int update_squash_messages(struct repository *r,
 		strbuf_addf(&buf, _(skip_nth_commit_msg_fmt),
 			    ++opts->current_fixup_count + 1);
 		strbuf_addstr(&buf, "\n\n");
-		strbuf_add_commented_lines(&buf, body, strlen(body),
-					   comment_line_char);
+		strbuf_add_commented_lines(&buf, body, strlen(body));
 	} else
 		return error(_("unknown command: %d"), command);
 	repo_unuse_commit_buffer(r, commit, message);
diff --git a/strbuf.c b/strbuf.c
index 15550b2619..2088f7800a 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -360,8 +360,8 @@ static void add_lines(struct strbuf *out,
 	strbuf_complete_line(out);
 }
 
-void strbuf_add_commented_lines(struct strbuf *out, const char *buf,
-				size_t size, char comment_line_char)
+void strbuf_add_commented_lines(struct strbuf *out,
+				const char *buf, size_t size)
 {
 	static char prefix1[3];
 	static char prefix2[2];
@@ -384,7 +384,7 @@ void strbuf_commented_addf(struct strbuf *sb,
 	strbuf_vaddf(&buf, fmt, params);
 	va_end(params);
 
-	strbuf_add_commented_lines(sb, buf.buf, buf.len, comment_line_char);
+	strbuf_add_commented_lines(sb, buf.buf, buf.len);
 	if (incomplete_line)
 		sb->buf[--sb->len] = '\0';
 
diff --git a/strbuf.h b/strbuf.h
index 981617dc77..4547efa62e 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -287,8 +287,7 @@ void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
  * by a comment character and a blank.
  */
 void strbuf_add_commented_lines(struct strbuf *out,
-				const char *buf, size_t size,
-				char comment_line_char);
+				const char *buf, size_t size);
 
 
 /**
diff --git a/wt-status.c b/wt-status.c
index 54b2775730..b390c77334 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1027,7 +1027,7 @@ static void wt_longstatus_print_submodule_summary(struct wt_status *s, int uncom
 	if (s->display_comment_prefix) {
 		size_t len;
 		summary_content = strbuf_detach(&summary, &len);
-		strbuf_add_commented_lines(&summary, summary_content, len, comment_line_char);
+		strbuf_add_commented_lines(&summary, summary_content, len);
 		free(summary_content);
 	}
 
@@ -1103,7 +1103,7 @@ void wt_status_append_cut_line(struct strbuf *buf)
 	const char *explanation = _("Do not modify or remove the line above.\nEverything below it will be ignored.");
 
 	strbuf_commented_addf(buf, "%s", cut_line);
-	strbuf_add_commented_lines(buf, explanation, strlen(explanation), comment_line_char);
+	strbuf_add_commented_lines(buf, explanation, strlen(explanation));
 }
 
 void wt_status_add_cut_line(FILE *fp)
-- 
2.42.0.820.g83a721a137-goog

