Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9521939FC9
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 06:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzkGpp7I"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e461c1f5bso32560045e9.3
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 22:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704869494; x=1705474294; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqlRNHRCuFB8NQk2NyQLb8saiGR6AYUgzXfLJm6t8a8=;
        b=dzkGpp7ImvhTTz0eYfAqOHaVPEn4Et54UroZyKaEWBwzLEGQLFPbv5L72ehIOapU/t
         jfxo0nlUntqJrlCTFs7FGqKkR38J9MnxPyveplFMOAihYZdg0h2/iXBg/Wi96U+VsAAw
         K8APg/SioPzZ2McSjlofheWUMI0tHMRFxrH9/HhFrUCYNbR/+LlzjqXO8wx/Dmv4bEIp
         ZzaYA9BuI+4pu2H6DxIc7dFVVPa8L+U15zWE16tu3amB8T7iT5AIv6m605YlE/8ko/oB
         dkxHl1ok3ONiQOY0/ziH9HRuAnpIDJDVaw58tYsXthgvMJAAPqwr1k0pw4cScL/l47+k
         glcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704869494; x=1705474294;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqlRNHRCuFB8NQk2NyQLb8saiGR6AYUgzXfLJm6t8a8=;
        b=eG/V5hu5v4P3wv+2cNKshEmccdODgFQ+KF2+XWuRZIeWJqXH/hXb+bpTtzbLtQE2/f
         lTQtXN1i3WNgZhS7pD+O/YNLX+rU51OJN9R4AJcvBXIZ0LSXVCEiH2QVuSlg5pIREW2k
         QkSPOQqOmV3jvDlajRQh4TFvAvN5LZsRV20NBc13QiIbosz5SDMjnuI64dnTwAFMbIah
         w7fmXGlC+78dhbtTML+V+MLcFcHewYut/Kk9hiU451S+8xg1ZyF9cWzf3X7VTzuSwzfR
         bdgqNjPSSSVG8pCpDqPmHnQBPoS33qhx9p/AwurgUbaP9OKdq4E7RR1T21Bbc+NC+UE4
         kkPQ==
X-Gm-Message-State: AOJu0YzPOzBtzvkVVhyAQR55OqrAKVTISJJucoyukphDj0S53jL9cNBz
	025Jh1HB/r+WKlliwFTrhHYVsTMaYEo=
X-Google-Smtp-Source: AGHT+IFlNb8+k3NZetxf6p6NL6jsMJqHBHX4TcDqM34LqM9FP015t13GsWUyEOp/1LBR9WriChX/iw==
X-Received: by 2002:a05:600c:3548:b0:40e:3d34:3eb6 with SMTP id i8-20020a05600c354800b0040e3d343eb6mr252915wmq.0.1704869494168;
        Tue, 09 Jan 2024 22:51:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fl14-20020a05600c0b8e00b0040e3488f16dsm1006079wmb.12.2024.01.09.22.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 22:51:34 -0800 (PST)
Message-ID: <9183990583f9a591c79301a20fa327462bb50cf9.1704869487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 10 Jan 2024 06:51:23 +0000
Subject: [PATCH 07/10] trailer: spread usage of "trailer_block" language
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Emily Shaffer <nasamuffin@google.com>,
    Junio C Hamano <gitster@pobox.com>,
    Christian Couder <chriscool@tuxfamily.org>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

Deprecate the "trailer_info" struct name and replace it with
"trailer_block". The main reason is to help readability, because
"trailer_info" on the surface sounds like it's about a single trailer
when in reality it is a collection of contiguous lines, at least 25% of
which are trailers.

Signed-off-by: Linus Arver <linusa@google.com>
---
 builtin/interpret-trailers.c | 26 +++++-----
 trailer.c                    | 99 ++++++++++++++++++------------------
 trailer.h                    | 18 +++----
 3 files changed, 71 insertions(+), 72 deletions(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 0838a57e157..42d9ca07a56 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -140,8 +140,8 @@ static void interpret_trailers(const char *file,
 {
 	LIST_HEAD(head);
 	struct strbuf sb = STRBUF_INIT;
-	struct strbuf trailer_block = STRBUF_INIT;
-	struct trailer_info *info;
+	struct strbuf tb = STRBUF_INIT;
+	struct trailer_block *trailer_block;
 	FILE *outfile = stdout;
 
 	trailer_config_init();
@@ -151,13 +151,13 @@ static void interpret_trailers(const char *file,
 	if (opts->in_place)
 		outfile = create_in_place_tempfile(file);
 
-	info = parse_trailers(sb.buf, &head, opts);
+	trailer_block = parse_trailers(sb.buf, opts, &head);
 
-	/* Print the lines before the trailers */
+	/* Print the lines before the trailer block */
 	if (!opts->only_trailers)
-		fwrite(sb.buf, 1, trailer_block_start(info), outfile);
+		fwrite(sb.buf, 1, trailer_block_start(trailer_block), outfile);
 
-	if (!opts->only_trailers && !blank_line_before_trailer_block(info))
+	if (!opts->only_trailers && !blank_line_before_trailer_block(trailer_block))
 		fprintf(outfile, "\n");
 
 
@@ -171,17 +171,17 @@ static void interpret_trailers(const char *file,
 	}
 
 	/* Print trailer block. */
-	format_trailers(&head, opts, &trailer_block);
-	fwrite(trailer_block.buf, 1, trailer_block.len, outfile);
-	strbuf_release(&trailer_block);
+	format_trailers(&head, opts, &tb);
+	fwrite(tb.buf, 1, tb.len, outfile);
+	strbuf_release(&tb);
 
 	free_trailers(&head);
 
-	/* Print the lines after the trailers as is */
+	/* Print the lines after the trailer block as is */
 	if (!opts->only_trailers)
-		fwrite(sb.buf + trailer_block_end(info), 1, sb.len - trailer_block_end(info), outfile);
-
-	trailer_info_release(info);
+		fwrite(sb.buf + trailer_block_end(trailer_block),
+		       1, sb.len - trailer_block_end(trailer_block), outfile);
+	trailer_block_release(trailer_block);
 
 	if (opts->in_place)
 		if (rename_tempfile(&trailers_tempfile, file))
diff --git a/trailer.c b/trailer.c
index 0c66e2d3812..360e76376b8 100644
--- a/trailer.c
+++ b/trailer.c
@@ -11,19 +11,20 @@
  * Copyright (c) 2013, 2014 Christian Couder <chriscool@tuxfamily.org>
  */
 
-struct trailer_info {
+struct trailer_block {
 	/*
 	 * True if there is a blank line before the location pointed to by
-	 * trailer_block_start.
+	 * "start".
 	 */
 	int blank_line_before_trailer;
 
 	/*
-	 * Offsets to the trailer block start and end positions in the input
-	 * string. If no trailer block is found, these are both set to the
-	 * "true" end of the input (find_end_of_log_message()).
+	 * The locations of the start and end positions of the trailer block
+	 * found, as offsets from the beginning of the source text from which
+	 * this trailer block was parsed. If no trailer block is found, these
+	 * are both set to 0.
 	 */
-	size_t trailer_block_start, trailer_block_end;
+	size_t start, end;
 
 	/*
 	 * Array of trailers found.
@@ -1046,16 +1047,16 @@ void format_trailers(struct list_head *head,
 	}
 }
 
-static struct trailer_info *trailer_info_new(void)
+static struct trailer_block *trailer_block_new(void)
 {
-	struct trailer_info *info = xcalloc(1, sizeof(*info));
-	return info;
+	struct trailer_block *trailer_block = xcalloc(1, sizeof(*trailer_block));
+	return trailer_block;
 }
 
-static struct trailer_info *trailer_info_get(const char *str,
-					     const struct process_trailer_options *opts)
+static struct trailer_block *trailer_block_get(const char *str,
+					       const struct process_trailer_options *opts)
 {
-	struct trailer_info *info = trailer_info_new();
+	struct trailer_block *trailer_block = trailer_block_new();
 	size_t end_of_log_message = 0, trailer_block_start = 0;
 	struct strbuf **trailer_lines, **ptr;
 	char **trailer_strings = NULL;
@@ -1088,34 +1089,34 @@ static struct trailer_info *trailer_info_get(const char *str,
 	}
 	strbuf_list_free(trailer_lines);
 
-	info->blank_line_before_trailer = ends_with_blank_line(str,
-							       trailer_block_start);
-	info->trailer_block_start = trailer_block_start;
-	info->trailer_block_end = end_of_log_message;
-	info->trailers = trailer_strings;
-	info->trailer_nr = nr;
+	trailer_block->blank_line_before_trailer = ends_with_blank_line(str,
+									trailer_block_start);
+	trailer_block->start = trailer_block_start;
+	trailer_block->end = end_of_log_message;
+	trailer_block->trailers = trailer_strings;
+	trailer_block->trailer_nr = nr;
 
-	return info;
+	return trailer_block;
 }
 
 /*
- * Parse trailers in "str", populating the trailer info and "head"
- * linked list structure.
+ * Parse trailers in "str", populating the trailer_block info and "head" linked
+ * list structure.
  */
-struct trailer_info *parse_trailers(const char *str,
-				    struct list_head *head,
-				    const struct process_trailer_options *opts)
+struct trailer_block *parse_trailers(const char *str,
+				     const struct process_trailer_options *opts,
+				     struct list_head *head)
 {
-	struct trailer_info *info;
+	struct trailer_block *trailer_block;
 	struct strbuf tok = STRBUF_INIT;
 	struct strbuf val = STRBUF_INIT;
 	size_t i;
 
-	info = trailer_info_get(str, opts);
+	trailer_block = trailer_block_get(str, opts);
 
-	for (i = 0; i < info->trailer_nr; i++) {
+	for (i = 0; i < trailer_block->trailer_nr; i++) {
 		int separator_pos;
-		char *trailer = info->trailers[i];
+		char *trailer = trailer_block->trailers[i];
 		if (trailer[0] == comment_line_char)
 			continue;
 		separator_pos = find_separator(trailer, separators);
@@ -1136,7 +1137,7 @@ struct trailer_info *parse_trailers(const char *str,
 		}
 	}
 
-	return info;
+	return trailer_block;
 }
 
 void free_trailers(struct list_head *head)
@@ -1148,28 +1149,28 @@ void free_trailers(struct list_head *head)
 	}
 }
 
-size_t trailer_block_start(struct trailer_info *info)
+size_t trailer_block_start(struct trailer_block *trailer_block)
 {
-	return info->trailer_block_start;
+	return trailer_block->start;
 }
 
-size_t trailer_block_end(struct trailer_info *info)
+size_t trailer_block_end(struct trailer_block *trailer_block)
 {
-	return info->trailer_block_end;
+	return trailer_block->end;
 }
 
-int blank_line_before_trailer_block(struct trailer_info *info)
+int blank_line_before_trailer_block(struct trailer_block *trailer_block)
 {
-	return info->blank_line_before_trailer;
+	return trailer_block->blank_line_before_trailer;
 }
 
-void trailer_info_release(struct trailer_info *info)
+void trailer_block_release(struct trailer_block *trailer_block)
 {
 	size_t i;
-	for (i = 0; i < info->trailer_nr; i++)
-		free(info->trailers[i]);
-	free(info->trailers);
-	free(info);
+	for (i = 0; i < trailer_block->trailer_nr; i++)
+		free(trailer_block->trailers[i]);
+	free(trailer_block->trailers);
+	free(trailer_block);
 }
 
 void format_trailers_from_commit(const char *msg,
@@ -1177,31 +1178,29 @@ void format_trailers_from_commit(const char *msg,
 				 struct strbuf *out)
 {
 	LIST_HEAD(head);
-	struct trailer_info *info = parse_trailers(msg, &head, opts);
+	struct trailer_block *trailer_block = parse_trailers(msg, opts, &head);
 
 	/* If we want the whole block untouched, we can take the fast path. */
 	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
 	    !opts->separator && !opts->key_only && !opts->value_only &&
 	    !opts->key_value_separator) {
-		strbuf_add(out, msg + info->trailer_block_start,
-			   info->trailer_block_end - info->trailer_block_start);
+		strbuf_add(out, msg + trailer_block->start,
+			   trailer_block->end - trailer_block->start);
 	} else
 		format_trailers(&head, opts, out);
 
 	free_trailers(&head);
-	trailer_info_release(info);
+	trailer_block_release(trailer_block);
 }
 
 void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
 {
 	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
-	struct trailer_info *internal = trailer_info_new();
 	strbuf_init(&iter->key, 0);
 	strbuf_init(&iter->val, 0);
 	strbuf_init(&iter->raw, 0);
 	opts.no_divider = 1;
-	iter->internal.info = internal;
-	iter->internal.info = trailer_info_get(msg, &opts);
+	iter->internal.trailer_block = trailer_block_get(msg, &opts);
 	iter->internal.cur = 0;
 }
 
@@ -1209,8 +1208,8 @@ int trailer_iterator_advance(struct trailer_iterator *iter)
 {
 	char *line;
 	int separator_pos;
-	if (iter->internal.cur < iter->internal.info->trailer_nr) {
-		line = iter->internal.info->trailers[iter->internal.cur++];
+	if (iter->internal.cur < iter->internal.trailer_block->trailer_nr) {
+		line = iter->internal.trailer_block->trailers[iter->internal.cur++];
 		separator_pos = find_separator(line, separators);
 		iter->is_trailer = (separator_pos > 0);
 
@@ -1228,7 +1227,7 @@ int trailer_iterator_advance(struct trailer_iterator *iter)
 
 void trailer_iterator_release(struct trailer_iterator *iter)
 {
-	trailer_info_release(iter->internal.info);
+	trailer_block_release(iter->internal.trailer_block);
 	strbuf_release(&iter->val);
 	strbuf_release(&iter->key);
 	strbuf_release(&iter->raw);
diff --git a/trailer.h b/trailer.h
index b06da1a7d3a..5c8503ade78 100644
--- a/trailer.h
+++ b/trailer.h
@@ -4,7 +4,7 @@
 #include "list.h"
 #include "strbuf.h"
 
-struct trailer_info;
+struct trailer_block;
 
 enum trailer_where {
 	WHERE_DEFAULT,
@@ -70,15 +70,15 @@ void parse_trailers_from_command_line_args(struct list_head *arg_head,
 void process_trailers_lists(struct list_head *head,
 			    struct list_head *arg_head);
 
-struct trailer_info *parse_trailers(const char *str,
-				    struct list_head *head,
-				    const struct process_trailer_options *opts);
+struct trailer_block *parse_trailers(const char *str,
+				     const struct process_trailer_options *opts,
+				     struct list_head *head);
 
-size_t trailer_block_start(struct trailer_info *info);
-size_t trailer_block_end(struct trailer_info *info);
-int blank_line_before_trailer_block(struct trailer_info *info);
+size_t trailer_block_start(struct trailer_block *trailer_block);
+size_t trailer_block_end(struct trailer_block *trailer_block);
+int blank_line_before_trailer_block(struct trailer_block *trailer_block);
 
-void trailer_info_release(struct trailer_info *info);
+void trailer_block_release(struct trailer_block *trailer_block);
 
 void trailer_config_init(void);
 void free_trailers(struct list_head *trailers);
@@ -123,7 +123,7 @@ struct trailer_iterator {
 
 	/* private */
 	struct {
-		struct trailer_info *info;
+		struct trailer_block *trailer_block;
 		size_t cur;
 	} internal;
 };
-- 
gitgitgadget

