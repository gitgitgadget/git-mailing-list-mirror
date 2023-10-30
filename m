Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363E71BDD4
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 20:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K8oIIiIQ"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C3E113
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 13:22:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a839b31a0dso78533177b3.0
        for <git@vger.kernel.org>; Mon, 30 Oct 2023 13:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698697375; x=1699302175; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ca07YqBQZ+ZumzmFGjz42CMph0rJWSX8b8Hm+rqoPoE=;
        b=K8oIIiIQ3ryG758gtvlAjRZ3FEzsDKiq1AFvPd1ItMLNqCtzX8SPFviR8rD9PzeRmX
         4f5JMcRdC11Mr1t5ba9S02iiLarCnPnLjjVHihSD2Fn9wAhNgEpAY9iDkVA0jyjc/ALz
         bwIDseBUpdRi3pRQKVenQLmAkGwJFIKJqkV1edxoBlatpIqyFxmfzuDWnzcxDWyAVae1
         0k+cL3ETPpRcjum0fsqZvA+uBkSlsgoX29z3eb4Rw+u3f8UX3lpb6XsXk2Nl8ogyPvts
         4ac/GxKKlp3n3+RQ+78DDBJPOptBVxyuQRj8NWDMBDz+GSsjQH5tf7DCp/3s4dQ0IyU7
         G4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698697375; x=1699302175;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ca07YqBQZ+ZumzmFGjz42CMph0rJWSX8b8Hm+rqoPoE=;
        b=w48sMu5iY6Hp2bmAMHTsMlppGXnjwVYJ8Vn+Egkn7s/JGs7WZ5Tv3d20H7Cce7eTrw
         I6zVfHQaD4ncYHYK+D1iSl+43qt9HRT28liJWCynvWAqv4ju/ZZZP90KUXyMtDiHzAnC
         t+YTna7GhXl/odyJNPzaEU7wWUSZQb65sbfQE6zMxiEPnngXlrKBbLbUto5dL3gTjigl
         XBRuYOQDBhfRBbHeUfzZFE9gNUsfqV/y0qtEpi+2Iha8Yf8on8qFesZKBtdXWw5A11yM
         dHPVhHlolpSnfDXvNhKMpmqciDIhc2ggKIhL9LxrDfVst2BGr/+X9pY3ePR5sa7/dR8k
         cf4A==
X-Gm-Message-State: AOJu0YxrXlztXJV158faNVEo/T48nKMhdUeLekqWNKV8LlS7jL1SAyNd
	oFmeAwz0Z77nq+/hVaudFCzZ7eV2NTk28gwC4npE+XSLs0CBU25aRsp/C9VWrCDqrCVnvQ4vpGz
	/8Vs/UyTkoxSm3G13D+Y4dwYEpOWF3morZLgLEv/8KU0SQ+BwJ2R2XOXzEZoey3hd6HsQeqc343
	F7
X-Google-Smtp-Source: AGHT+IHn4fhS8/SMYfnWclffglomugmGtBUJZW9lYFS2L/eoHI3ZPiio/mg/4YZu0/37qGy3HZXmzAiHteqjaMeLBiZt
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:3e1e:2bd9:a4cd:fa38])
 (user=jonathantanmy job=sendgmr) by 2002:a25:2589:0:b0:d9a:c946:c18c with
 SMTP id l131-20020a252589000000b00d9ac946c18cmr203911ybl.6.1698697374882;
 Mon, 30 Oct 2023 13:22:54 -0700 (PDT)
Date: Mon, 30 Oct 2023 13:22:46 -0700
In-Reply-To: <cover.1698696798.git.jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <db6702ba-11a7-44c1-af2a-95b080aaeb77@gmail.com> <cover.1698696798.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <d96633a2919ac619ccf29e87abc6f25314a8bfb1.1698696798.git.jonathantanmy@google.com>
Subject: [RFC PATCH 1/3] strbuf: make add_lines() public
From: Jonathan Tan <jonathantanmy@google.com>
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@google.com>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Dragan Simic <dsimic@manjaro.org>
Content-Type: text/plain; charset="UTF-8"

Subsequent patches will require the ability to add different prefixes
to different lines (depending on their contents), so make this
functionality available from outside strbuf.c.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 branch.c |  3 ++-
 commit.c |  2 +-
 strbuf.c | 39 ++++++++++++++++-----------------------
 strbuf.h |  3 ++-
 4 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/branch.c b/branch.c
index 06f7af9dd4..04a8b90b6a 100644
--- a/branch.c
+++ b/branch.c
@@ -721,7 +721,8 @@ static int submodule_create_branch(struct repository *r,
 		return ret;
 	ret = finish_command(&child);
 	strbuf_read(&child_err, child.err, 0);
-	strbuf_add_lines(&out_buf, out_prefix, child_err.buf, child_err.len);
+	strbuf_add_lines(&out_buf, out_prefix, out_prefix,
+			 child_err.buf, child_err.len);
 
 	if (ret)
 		fprintf(stderr, "%s", out_buf.buf);
diff --git a/commit.c b/commit.c
index b3223478bc..7caafcde01 100644
--- a/commit.c
+++ b/commit.c
@@ -1361,7 +1361,7 @@ static void add_extra_header(struct strbuf *buffer,
 {
 	strbuf_addstr(buffer, extra->key);
 	if (extra->len)
-		strbuf_add_lines(buffer, " ", extra->value, extra->len);
+		strbuf_add_lines(buffer, " ", " ", extra->value, extra->len);
 	else
 		strbuf_addch(buffer, '\n');
 }
diff --git a/strbuf.c b/strbuf.c
index 7827178d8e..9ee639519a 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -339,26 +339,6 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
 	va_end(ap);
 }
 
-static void add_lines(struct strbuf *out,
-			const char *prefix1,
-			const char *prefix2,
-			const char *buf, size_t size)
-{
-	while (size) {
-		const char *prefix;
-		const char *next = memchr(buf, '\n', size);
-		next = next ? (next + 1) : (buf + size);
-
-		prefix = ((prefix2 && (buf[0] == '\n' || buf[0] == '\t'))
-			  ? prefix2 : prefix1);
-		strbuf_addstr(out, prefix);
-		strbuf_add(out, buf, next - buf);
-		size -= next - buf;
-		buf = next;
-	}
-	strbuf_complete_line(out);
-}
-
 void strbuf_add_commented_lines(struct strbuf *out, const char *buf,
 				size_t size, char comment_line_char)
 {
@@ -369,7 +349,7 @@ void strbuf_add_commented_lines(struct strbuf *out, const char *buf,
 		xsnprintf(prefix1, sizeof(prefix1), "%c ", comment_line_char);
 		xsnprintf(prefix2, sizeof(prefix2), "%c", comment_line_char);
 	}
-	add_lines(out, prefix1, prefix2, buf, size);
+	strbuf_add_lines(out, prefix1, prefix2, buf, size);
 }
 
 void strbuf_commented_addf(struct strbuf *sb, char comment_line_char,
@@ -747,10 +727,23 @@ ssize_t strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 	return len;
 }
 
-void strbuf_add_lines(struct strbuf *out, const char *prefix,
+void strbuf_add_lines(struct strbuf *out, const char *default_prefix,
+		      const char *tab_or_nl_prefix,
 		      const char *buf, size_t size)
 {
-	add_lines(out, prefix, NULL, buf, size);
+	while (size) {
+		const char *prefix;
+		const char *next = memchr(buf, '\n', size);
+		next = next ? (next + 1) : (buf + size);
+
+		prefix = (buf[0] == '\n' || buf[0] == '\t')
+			  ? tab_or_nl_prefix : default_prefix;
+		strbuf_addstr(out, prefix);
+		strbuf_add(out, buf, next - buf);
+		size -= next - buf;
+		buf = next;
+	}
+	strbuf_complete_line(out);
 }
 
 void strbuf_addstr_xml_quoted(struct strbuf *buf, const char *s)
diff --git a/strbuf.h b/strbuf.h
index e959caca87..3559e73dd8 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -599,7 +599,8 @@ void strbuf_list_free(struct strbuf **list);
 void strbuf_strip_file_from_path(struct strbuf *sb);
 
 void strbuf_add_lines(struct strbuf *sb,
-		      const char *prefix,
+		      const char *default_prefix,
+		      const char *tab_or_nl_prefix,
 		      const char *buf,
 		      size_t size);
 
-- 
2.42.0.820.g83a721a137-goog

