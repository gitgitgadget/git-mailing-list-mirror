Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD61374C4
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 06:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6zLws6Z"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e585ec8ebso609485e9.3
        for <git@vger.kernel.org>; Tue, 09 Jan 2024 22:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704869492; x=1705474292; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+XtGcq4JfiHzuMRg7zikG1tVAdUtgFV7VlIuM6fVgo=;
        b=N6zLws6ZB/aAF5OGMmPJioBtA6w1z05SJo177bTplk/06D9WUaEMiJS9dEybFP5efY
         VhRL1Mbc1c28WpGmqXFcoppQsbaztEtdpAUxFT37krYdbY3Fk2BeL2vW3Gnn3qqdyClN
         74RJk4UKiwWv/hkn/WriflIzDXc9AZ+LTGeo5VfAtGrTEQrBoe3cgZJt16Wpj3Fj423G
         QMeTuaom8x00FMMA2TF1DbmIqtWbAgq+C2y7B7YENf7I4Awmg1psl+0Zx3zSul9Dd8x7
         Q9zkT2Bz4PX69vkbhBTcz+4pfDze7jrkXYAm/v+Jc9J/lgJpUwVLx1AGuDfzf2yC1UL/
         R8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704869492; x=1705474292;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+XtGcq4JfiHzuMRg7zikG1tVAdUtgFV7VlIuM6fVgo=;
        b=kzF6tUJCmhL4Q/LoYqkm4e4A25S10RJHL7eczJn7lbjD2ayzdlM2k6YUfiOshSdUcT
         VgO0GIxvXe2+y6Lr/knrymQRqkALJbTRb+w9hUH/HKDTgPVxFyCqRgv/q6/PtxKK/EjL
         kypAyu49HHOGFP+ugT5G1rQHvdFcQuRAdjZn2fsSo+xpQFO83UZRM4W+3HMhZ3TWMCGC
         yy82w7VNvTUj6YyBLaG89foooH7vEWirZrZCEVsh0Z6MCYA1BsTFahrJdYF1PsWErKCG
         3Vn/HwZPDiC30olA/ONcQBB6MkpXs/TWhHtKhbNj+chplyUiHrX/9c9QQVhOloJJA0Br
         nJUw==
X-Gm-Message-State: AOJu0Yzp/+WdcBsRWiQvPluH8nPHQlk+7k8UuhuDrJaYsmNU/SQPKmZ4
	P4MXej46kCBcQxshsG/NXKntdDIvnAQ=
X-Google-Smtp-Source: AGHT+IH09q1Yd25U4WVrY+4Ftyh3n+L8s1DLJdZn89YwiauFgmMB/f778kroQM+AWmNOQ08eGcntmw==
X-Received: by 2002:a05:600c:540a:b0:40e:5332:1934 with SMTP id he10-20020a05600c540a00b0040e53321934mr257442wmb.15.1704869492128;
        Tue, 09 Jan 2024 22:51:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l17-20020a05600c1d1100b0040e4a2b36bfsm997377wms.22.2024.01.09.22.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 22:51:31 -0800 (PST)
Message-ID: <8d86461475765ac04ad0ed207e46598eb90a45ba.1704869487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 10 Jan 2024 06:51:20 +0000
Subject: [PATCH 04/10] trailer: delete obsolete formatting functions
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

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 79 -------------------------------------------------------
 1 file changed, 79 deletions(-)

diff --git a/trailer.c b/trailer.c
index 315d90ee1ab..132f22b3dd7 100644
--- a/trailer.c
+++ b/trailer.c
@@ -144,24 +144,6 @@ static char last_non_space_char(const char *s)
 	return '\0';
 }
 
-static void print_tok_val(FILE *outfile, const char *tok, const char *val)
-{
-	char c;
-
-	if (!tok) {
-		fprintf(outfile, "%s\n", val);
-		return;
-	}
-
-	c = last_non_space_char(tok);
-	if (!c)
-		return;
-	if (strchr(separators, c))
-		fprintf(outfile, "%s%s\n", tok, val);
-	else
-		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
-}
-
 static struct trailer_item *trailer_from_arg(struct arg_item *arg_tok)
 {
 	struct trailer_item *new_item = xcalloc(1, sizeof(*new_item));
@@ -1142,67 +1124,6 @@ void trailer_info_release(struct trailer_info *info)
 	free(info->trailers);
 }
 
-static void format_trailer_info(struct strbuf *out,
-				const struct trailer_info *info,
-				const char *msg,
-				const struct process_trailer_options *opts)
-{
-	size_t origlen = out->len;
-	size_t i;
-
-	/* If we want the whole block untouched, we can take the fast path. */
-	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
-	    !opts->separator && !opts->key_only && !opts->value_only &&
-	    !opts->key_value_separator) {
-		strbuf_add(out, msg + info->trailer_block_start,
-			   info->trailer_block_end - info->trailer_block_start);
-		return;
-	}
-
-	for (i = 0; i < info->trailer_nr; i++) {
-		char *trailer = info->trailers[i];
-		ssize_t separator_pos = find_separator(trailer, separators);
-
-		if (separator_pos >= 1) {
-			struct strbuf tok = STRBUF_INIT;
-			struct strbuf val = STRBUF_INIT;
-
-			parse_trailer(&tok, &val, NULL, trailer, separator_pos);
-			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
-				if (opts->unfold)
-					unfold_value(&val);
-
-				if (opts->separator && out->len != origlen)
-					strbuf_addbuf(out, opts->separator);
-				if (!opts->value_only)
-					strbuf_addbuf(out, &tok);
-				if (!opts->key_only && !opts->value_only) {
-					if (opts->key_value_separator)
-						strbuf_addbuf(out, opts->key_value_separator);
-					else
-						strbuf_addstr(out, ": ");
-				}
-				if (!opts->key_only)
-					strbuf_addbuf(out, &val);
-				if (!opts->separator)
-					strbuf_addch(out, '\n');
-			}
-			strbuf_release(&tok);
-			strbuf_release(&val);
-
-		} else if (!opts->only_trailers) {
-			if (opts->separator && out->len != origlen) {
-				strbuf_addbuf(out, opts->separator);
-			}
-			strbuf_addstr(out, trailer);
-			if (opts->separator) {
-				strbuf_rtrim(out);
-			}
-		}
-	}
-
-}
-
 void format_trailers_from_commit(const char *msg,
 				 const struct process_trailer_options *opts,
 				 struct strbuf *out)
-- 
gitgitgadget

