Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E781A1F660
	for <e@80x24.org>; Tue,  3 Jul 2018 11:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932105AbeGCL0f (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 07:26:35 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:43808 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753164AbeGCL0X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 07:26:23 -0400
Received: by mail-pf0-f178.google.com with SMTP id y8-v6so874345pfm.10
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 04:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=K2Bg1o1ec2hMnIgzrHgreCQdbW7MKI6nZwfI9rVF320=;
        b=DdZfGdTCI31zqVESj+VHBGP8r/rWWNA+syoOP8EwEspO/llzv52h7ILg+fEg9oWo4c
         shG3chrXC9CBeII2lFhY3ad/fTSCiTPfPrdpYgX5ABqzv2OpW0hxFI7Y40MsNAb5Krds
         wRTXw+fjY1uPJylEHWXCd3kRfObq00mSa8Ek7UKnuEj+m9pByhidJeOKpQWWMZ2Y79H6
         uf9eerUOFf1TxUbhnsrtzIQUoS3j8HpfBvNOVuu9zhieLE04wjc0PiSTNp6ZlweyIemk
         JBeEMKYyrgh0+0Oit66gXUjQTMDBkHeYXdUUE//lQz4W/CP79IyPF+PjPmfAqlwkkkwO
         JzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=K2Bg1o1ec2hMnIgzrHgreCQdbW7MKI6nZwfI9rVF320=;
        b=A8RltGNDEXuaWMPbk3aQSvzqw1Yvidl6MJC2hDUsnojy7N8mfybXtS1IiOODwt4Qq2
         2Vfc/mxE3TmwED8YRWzP+/wkWHNBQZFaq7yGxTjS8qvzuFCiMEsAQ+AuIAogxoENDoMH
         SueRMWNJfxtLVvmtHEgfn82Iy8bX5NmYM2PPuhATGeiWO44ZgRfSLEtegTx8tjybdnf6
         /vLty754xaWZN3Qi63KaOmP2JGvwVkcCktFBahU7cfQd2Mv/B5/4/QlYJ1gJHfUMnQsV
         uD7msf/CkD6jcz/BLnk8lyH5LGKN33BSliyzRdTTdWboJzApI047p92J2MULRYBkgQ98
         JVFA==
X-Gm-Message-State: APt69E2Ho3duFj3IHMD0u3Xwx1q+swQ+Cr/3Q2hKTgRI+/MG1f6aDLNV
        8J/d4BGcB/4hTTDO9RQsYoQN4A==
X-Google-Smtp-Source: AAOMgpfV+J9vvSHB42aBf5iOsPZaBmgjBLExMHJXi1ZrwQFFnWgw+5RY/QRi8Er1Ssl5C2ZIKBdUMw==
X-Received: by 2002:a65:6143:: with SMTP id o3-v6mr12273800pgv.52.1530617182528;
        Tue, 03 Jul 2018 04:26:22 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id 204-v6sm2306488pfc.131.2018.07.03.04.26.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 04:26:21 -0700 (PDT)
Message-Id: <6b31cbf72c4752771965de333b3cb6e82cf90b2b.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v3.git.gitgitgadget@gmail.com>
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 2 May 2018 23:35:48 +0200
Subject: [PATCH v3 09/20] range-diff: adjust the output of the commit pairs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This change brings `git range-diff` yet another step closer to
feature parity with tbdiff: it now shows the oneline, too, and indicates
with `=` when the commits have identical diffs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 range-diff.c | 66 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 9 deletions(-)

diff --git a/range-diff.c b/range-diff.c
index 8d3b96455..0e0e77106 100644
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
@@ -251,9 +253,57 @@ static void get_correspondences(struct string_list *a, struct string_list *b,
 	free(b2a);
 }
 
-static const char *short_oid(struct patch_util *util)
+static void output_pair_header(struct strbuf *buf,
+			       struct patch_util *a_util,
+			       struct patch_util *b_util)
 {
-	return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
+	static char *dashes;
+	struct object_id *oid = a_util ? &a_util->oid : &b_util->oid;
+	struct commit *commit;
+
+	if (!dashes) {
+		char *p;
+
+		dashes = xstrdup(find_unique_abbrev(oid, DEFAULT_ABBREV));
+		for (p = dashes; *p; p++)
+			*p = '-';
+	}
+
+	strbuf_reset(buf);
+	if (!a_util)
+		strbuf_addf(buf, "-:  %s ", dashes);
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
+		strbuf_addf(buf, " -:  %s", dashes);
+	else
+		strbuf_addf(buf, " %d:  %s", b_util->i + 1,
+			    find_unique_abbrev(&b_util->oid, DEFAULT_ABBREV));
+
+	commit = lookup_commit_reference(oid);
+	if (commit) {
+		const char *commit_buffer = get_commit_buffer(commit, NULL);
+		const char *subject;
+
+		find_commit_subject(commit_buffer, &subject);
+		strbuf_addch(buf, ' ');
+		format_subject(buf, subject, " ");
+		unuse_commit_buffer(commit, commit_buffer);
+	}
+	strbuf_addch(buf, '\n');
+
+	fwrite(buf->buf, buf->len, 1, stdout);
 }
 
 static struct diff_filespec *get_filespec(const char *name, const char *p)
@@ -282,6 +332,7 @@ static void patch_diff(const char *a, const char *b,
 static void output(struct string_list *a, struct string_list *b,
 		   struct diff_options *diffopt)
 {
+	struct strbuf buf = STRBUF_INIT;
 	int i = 0, j = 0;
 
 	/*
@@ -303,25 +354,21 @@ static void output(struct string_list *a, struct string_list *b,
 
 		/* Show unmatched LHS commit whose predecessors were shown. */
 		if (i < a->nr && a_util->matching < 0) {
-			printf("%d: %s < -: --------\n",
-			       i + 1, short_oid(a_util));
+			output_pair_header(&buf, a_util, NULL);
 			i++;
 			continue;
 		}
 
 		/* Show unmatched RHS commits. */
 		while (j < b->nr && b_util->matching < 0) {
-			printf("-: -------- > %d: %s\n",
-			       j + 1, short_oid(b_util));
+			output_pair_header(&buf, NULL, b_util);
 			b_util = ++j < b->nr ? b->items[j].util : NULL;
 		}
 
 		/* Show matching LHS/RHS pair. */
 		if (j < b->nr) {
 			a_util = a->items[b_util->matching].util;
-			printf("%d: %s ! %d: %s\n",
-			       b_util->matching + 1, short_oid(a_util),
-			       j + 1, short_oid(b_util));
+			output_pair_header(&buf, a_util, b_util);
 			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
 				patch_diff(a->items[b_util->matching].string,
 					   b->items[j].string, diffopt);
@@ -329,6 +376,7 @@ static void output(struct string_list *a, struct string_list *b,
 			j++;
 		}
 	}
+	strbuf_release(&buf);
 }
 
 int show_range_diff(const char *range1, const char *range2,
-- 
gitgitgadget

