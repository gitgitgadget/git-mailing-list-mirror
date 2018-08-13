Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF13F1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbeHMOPH (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:15:07 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:38655 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbeHMOPH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:15:07 -0400
Received: by mail-pl0-f47.google.com with SMTP id u11-v6so6776249plq.5
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 04:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SEpBYFHK0HtbcnU3DxN6ytdSesg/BbWHz7D8aY4XmFM=;
        b=AL8yCrBqdqn1t0S0iwC9kg4/4sL0LQJfOOLqKY67WVx7zRGCwQAayyFaYQPNmwm/ca
         ZcoxpMRk4uFXshRqGH1J5bIUTpj+Hmb5pOXnmIP4T41foioFLDjejdVoZA31rNT+dm6/
         6IWWYhr/uvjl/TcplRlPhFVJtGwkMZLMFNUbHT6g39daFecmhqMP7/9fhzHe5Ln0TTKi
         nr/KK2AoHAF93Mzx5xpWY95fFZXOyd/HEB70aVjA93NI2tCtaEJ731rcB2jOJjMZ9Umv
         TlYGDcBfpvpxPpVQjaZNYW3cvYjt/DSz4d6e6YH33K3/b29QB5f3OHUvS8ARpv0Caocd
         fYjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SEpBYFHK0HtbcnU3DxN6ytdSesg/BbWHz7D8aY4XmFM=;
        b=U5BEBZAeMGgJv5CtpkeuG+gd9LAhRMON2RN9BV0sp8pvhJ4BZhDRIZ4ELii+vQrR14
         C4OcnTNSse+Mu1b/ZlZANaKngZP7EHRUN/F3o4E/ytq6yRJgMda8UHRxDkIx1bl1pqiw
         /ctbFVVaKZ7NxE5rh9qLYze33CG5iMP21DZxIEieHnYEHRbMhbXhp5TCFm40QTbLORZa
         NEtR33m3YLy/OWbTS3pH0Rj0EbpdyWMgyi0SPDvrfcLl44QI9Sxp0/aRdKu6pC/nPGuV
         wTt+DcVaOEPMTSmMgePPWno6hKlk/zw5NRIVHw6mneb5N9wjY+NbTmg2ERia8YWxzNkx
         Do7w==
X-Gm-Message-State: AOUpUlGbR53IYGk/54elKw2qslgaFDi57MgMIWvj8uAHAHXubcDlrpC6
        hyldNeyuLjKGuC8/U5H3vnAacAK5
X-Google-Smtp-Source: AA+uWPzraHKLC95bVfJUIuEU88xHUZz4SuEYe/RI/5yjBOARDwFD01WlFA7NYqKHlNczgr7JTt4b6w==
X-Received: by 2002:a17:902:bc41:: with SMTP id t1-v6mr16535159plz.26.1534159994183;
        Mon, 13 Aug 2018 04:33:14 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id v82-v6sm29050481pfd.64.2018.08.13.04.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 04:33:13 -0700 (PDT)
Date:   Mon, 13 Aug 2018 04:33:13 -0700 (PDT)
X-Google-Original-Date: Mon, 13 Aug 2018 11:32:44 GMT
Message-Id: <d3be03a446a40d2176b6ffdd9e095d97873042c2.1534159977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v6.git.gitgitgadget@gmail.com>
References: <pull.1.v5.git.gitgitgadget@gmail.com>
        <pull.1.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 09/21] range-diff: adjust the output of the commit pairs
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

This not only uses "dashed stand-ins" for "pairs" where one side is
missing (i.e. unmatched commits that are present only in one of the two
commit ranges), but also adds onelines for the reader's pleasure.

This change brings `git range-diff` yet another step closer to
feature parity with tbdiff: it now shows the oneline, too, and indicates
with `=` when the commits have identical diffs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 range-diff.c | 59 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 1ecee2c09..23aa61af5 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -7,6 +7,8 @@
 #include "xdiff-interface.h"
 #include "linear-assignment.h"
 #include "diffcore.h"
+#include "commit.h"
+#include "pretty.h"
 
 struct patch_util {
 	/* For the search for an exact match */
@@ -255,9 +257,49 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
 	free(b2a);
 }
 
-static const char *short_oid(struct patch_util *util)
+static void output_pair_header(struct strbuf *buf,
+			       struct strbuf *dashes,
+			       struct patch_util *a_util,
+			       struct patch_util *b_util)
 {
-	return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
+	struct object_id *oid = a_util ? &a_util->oid : &b_util->oid;
+	struct commit *commit;
+
+	if (!dashes->len)
+		strbuf_addchars(dashes, '-',
+				strlen(find_unique_abbrev(oid,
+							  DEFAULT_ABBREV)));
+
+	strbuf_reset(buf);
+	if (!a_util)
+		strbuf_addf(buf, "-:  %s ", dashes->buf);
+	else
+		strbuf_addf(buf, "%d:  %s ", a_util->i + 1,
+			    find_unique_abbrev(&a_util->oid, DEFAULT_ABBREV));
+
+	if (!a_util)
+		strbuf_addch(buf, '>');
+	else if (!b_util)
+		strbuf_addch(buf, '<');
+	else if (strcmp(a_util->patch, b_util->patch))
+		strbuf_addch(buf, '!');
+	else
+		strbuf_addch(buf, '=');
+
+	if (!b_util)
+		strbuf_addf(buf, " -:  %s", dashes->buf);
+	else
+		strbuf_addf(buf, " %d:  %s", b_util->i + 1,
+			    find_unique_abbrev(&b_util->oid, DEFAULT_ABBREV));
+
+	commit = lookup_commit_reference(the_repository, oid);
+	if (commit) {
+		strbuf_addch(buf, ' ');
+		pp_commit_easy(CMIT_FMT_ONELINE, commit, buf);
+	}
+	strbuf_addch(buf, '\n');
+
+	fwrite(buf->buf, buf->len, 1, stdout);
 }
 
 static struct diff_filespec *get_filespec(const char *name, const char *p)
@@ -286,6 +328,7 @@ static void patch_diff(const char *a, const char *b,
 static void output(struct string_list *a, struct string_list *b,
 		   struct diff_options *diffopt)
 {
+	struct strbuf buf = STRBUF_INIT, dashes = STRBUF_INIT;
 	int i = 0, j = 0;
 
 	/*
@@ -307,25 +350,21 @@ static void output(struct string_list *a, struct string_list *b,
 
 		/* Show unmatched LHS commit whose predecessors were shown. */
 		if (i < a->nr && a_util->matching < 0) {
-			printf("%d: %s < -: --------\n",
-			       i + 1, short_oid(a_util));
+			output_pair_header(&buf, &dashes, a_util, NULL);
 			i++;
 			continue;
 		}
 
 		/* Show unmatched RHS commits. */
 		while (j < b->nr && b_util->matching < 0) {
-			printf("-: -------- > %d: %s\n",
-			       j + 1, short_oid(b_util));
+			output_pair_header(&buf, &dashes, NULL, b_util);
 			b_util = ++j < b->nr ? b->items[j].util : NULL;
 		}
 
 		/* Show matching LHS/RHS pair. */
 		if (j < b->nr) {
 			a_util = a->items[b_util->matching].util;
-			printf("%d: %s ! %d: %s\n",
-			       b_util->matching + 1, short_oid(a_util),
-			       j + 1, short_oid(b_util));
+			output_pair_header(&buf, &dashes, a_util, b_util);
 			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
 				patch_diff(a->items[b_util->matching].string,
 					   b->items[j].string, diffopt);
@@ -333,6 +372,8 @@ static void output(struct string_list *a, struct string_list *b,
 			j++;
 		}
 	}
+	strbuf_release(&buf);
+	strbuf_release(&dashes);
 }
 
 int show_range_diff(const char *range1, const char *range2,
-- 
gitgitgadget

