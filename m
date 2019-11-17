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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7292D1F4B5
	for <e@80x24.org>; Sun, 17 Nov 2019 23:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfKQXQP (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Nov 2019 18:16:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54983 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfKQXQP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Nov 2019 18:16:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id z26so15419495wmi.4
        for <git@vger.kernel.org>; Sun, 17 Nov 2019 15:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=w/UWCcnkJgHeMygQWAmMMuGuT4lBQSTg7Q1Yvc3gD4E=;
        b=cIcfS/rYIWN1z1o1TmtAPAiQpE3gFc4wE8cpgOcOQYFELZGWL57k0lm/gbvBjTi9tl
         dpfuBc0iGR6xp8o/oW/ZrHnqTWSLwyxtjT09Z2TlXqiaVPs0CVTha5HGR8qnEH5cGGOM
         Otn+ylzkyuxDvoMlG2Szz/nQWxrlfyoHxhIdfQ0Kg1mBWoKzAL6Wzmp5YSVa7FcWSnmS
         YW2SX/Ho45uQLzxUbEwdSNW1Yh0AF84rdcgS/xHK0KqnHLYYfKLSyqou/moExRhL9Frw
         nFTpnp5uT7+bVdsa+XcyQdhsIm0B1wiOz/yZcPYd45oziTMxcktMxxrWaU9PecL/suU+
         dTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=w/UWCcnkJgHeMygQWAmMMuGuT4lBQSTg7Q1Yvc3gD4E=;
        b=Xbmz2RwNNNYGpIVmQO6IEVLu3aJwiE2OHqNDX9crY9E4rCWsUM1tjXlnv9KeydMeIP
         5V8cfc/tDGndc3yDu7023ae5b40Z3lVQQV9tOGDvQKvj2hAyfSiaiv+gCjrTezDy19iE
         jnUX1egZ6YRwhgDBJwgNMGg/M/qGmhquE1bSuz/J7pvlDDGGQHkYXHZb+lAs+/oTPQ+I
         f217BXE4O/vhNwYRzVC1wWzD2LYd/KMjrTXYqUj633IxtfLkhQCmJSGcHu7//JQ00qSm
         RpbeVpP2mPdeuoP9LM9aRil5BH21gbbJxVxIquZc7WWetL4AX6L9aAd20ZUyic9v981+
         2/qQ==
X-Gm-Message-State: APjAAAX46d2+frbjnVZyYiH6yZyhjFpVERexViMjsXvFOOMSIbP9bvfW
        MFWJ6oTdoKGpM10xFosGHewerHwX45w=
X-Google-Smtp-Source: APXvYqyk91qSfOdY8zIDtOaI3AfWxkYHTMCjadEUQY+eOthTO+Qjf7QTLmdzzMHzBMgkkuHEcet+Gw==
X-Received: by 2002:a1c:8055:: with SMTP id b82mr27023920wmd.176.1574032572235;
        Sun, 17 Nov 2019 15:16:12 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f140sm19237866wme.21.2019.11.17.15.16.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Nov 2019 15:16:11 -0800 (PST)
Message-Id: <3f4d086e805b69cf1cbf8058f382cc154239f703.1574032570.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.327.v2.git.1574032570.gitgitgadget@gmail.com>
References: <pull.327.git.gitgitgadget@gmail.com>
        <pull.327.v2.git.1574032570.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 17 Nov 2019 23:16:09 +0000
Subject: [PATCH v2 1/2] rebase-merges: move labels' whitespace mangling into
 `label_oid()`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

One of the trickier aspects of the design of `git rebase
--rebase-merges` is the way labels are generated for the initial todo
list: those labels are supposed to be intuitive and first and foremost
unique.

To that end, `label_oid()` appends a unique suffix when necessary.

Those labels not only need to be unique, but they also need to be valid
refs. To make sure of that, `make_script_with_merges()` replaces
whitespace by dashes.

That would appear to be the wrong layer for that sanitizing step,
though: all callers of `label_oid()` should get that same benefit.

Even if it does not make a difference currently (the only called of
`label_oid()` that passes a label that might need to be sanitized _is_
`make_script_with_merges()`), let's move the responsibility for
sanitizing labels into the `label_oid()` function.

This commit is best viewed with `-w` because it unfortunately needs to
change the indentation of a large block of code in `label_oid()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 56 ++++++++++++++++++++++++++---------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8952cfa89b..85c66f489f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4423,7 +4423,6 @@ static const char *label_oid(struct object_id *oid, const char *label,
 	struct labels_entry *labels_entry;
 	struct string_entry *string_entry;
 	struct object_id dummy;
-	size_t len;
 	int i;
 
 	string_entry = oidmap_get(&state->commit2label, oid);
@@ -4443,10 +4442,10 @@ static const char *label_oid(struct object_id *oid, const char *label,
 	 * abbreviation for any uninteresting commit's names that does not
 	 * clash with any other label.
 	 */
+	strbuf_reset(&state->buf);
 	if (!label) {
 		char *p;
 
-		strbuf_reset(&state->buf);
 		strbuf_grow(&state->buf, GIT_MAX_HEXSZ);
 		label = p = state->buf.buf;
 
@@ -4469,32 +4468,37 @@ static const char *label_oid(struct object_id *oid, const char *label,
 				p[i] = save;
 			}
 		}
-	} else if (((len = strlen(label)) == the_hash_algo->hexsz &&
-		    !get_oid_hex(label, &dummy)) ||
-		   (len == 1 && *label == '#') ||
-		   hashmap_get_from_hash(&state->labels,
-					 strihash(label), label)) {
-		/*
-		 * If the label already exists, or if the label is a valid full
-		 * OID, or the label is a '#' (which we use as a separator
-		 * between merge heads and oneline), we append a dash and a
-		 * number to make it unique.
-		 */
+	} else {
 		struct strbuf *buf = &state->buf;
 
-		strbuf_reset(buf);
-		strbuf_add(buf, label, len);
+		for (; *label; label++)
+			strbuf_addch(buf, isspace(*label) ? '-' : *label);
+		label = buf->buf;
 
-		for (i = 2; ; i++) {
-			strbuf_setlen(buf, len);
-			strbuf_addf(buf, "-%d", i);
-			if (!hashmap_get_from_hash(&state->labels,
-						   strihash(buf->buf),
-						   buf->buf))
-				break;
-		}
+		if ((buf->len == the_hash_algo->hexsz &&
+		     !get_oid_hex(label, &dummy)) ||
+		    (buf->len == 1 && *label == '#') ||
+		    hashmap_get_from_hash(&state->labels,
+					  strihash(label), label)) {
+			/*
+			 * If the label already exists, or if the label is a
+			 * valid full OID, or the label is a '#' (which we use
+			 * as a separator between merge heads and oneline), we
+			 * append a dash and a number to make it unique.
+			 */
+			size_t len = buf->len;
 
-		label = buf->buf;
+			for (i = 2; ; i++) {
+				strbuf_setlen(buf, len);
+				strbuf_addf(buf, "-%d", i);
+				if (!hashmap_get_from_hash(&state->labels,
+							   strihash(buf->buf),
+							   buf->buf))
+					break;
+			}
+
+			label = buf->buf;
+		}
 	}
 
 	FLEX_ALLOC_STR(labels_entry, label, label);
@@ -4596,10 +4600,6 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		else
 			strbuf_addbuf(&label, &oneline);
 
-		for (p1 = label.buf; *p1; p1++)
-			if (isspace(*p1))
-				*(char *)p1 = '-';
-
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "%s -C %s",
 			    cmd_merge, oid_to_hex(&commit->object.oid));
-- 
gitgitgadget

