Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 308241F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbeHKAqZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:46:25 -0400
Received: from mail-pl0-f41.google.com ([209.85.160.41]:33717 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbeHKAqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:46:25 -0400
Received: by mail-pl0-f41.google.com with SMTP id b90-v6so4584100plb.0
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SEpBYFHK0HtbcnU3DxN6ytdSesg/BbWHz7D8aY4XmFM=;
        b=tpC/5ac6rwTUfPzxdPb9EOz+zhPCrFIy2VIclPCixEUFe+USDSf749cG7QU5MyAblZ
         w9kMlq+23OImnCZJbmEypuvnWuibgtcLzg2r3zE3XD4YK3yhZjwIiZYUcQzLVLtSDt7/
         uphkYG4MJSpjsqQSoXeDTEUqW1hURQwGk5VFM9WgyEAL6pUqhANtWZH+dy1RmobPODHN
         6/b1dFJxeRLoixiIGuhhylITTmJ+9HKOSjPNpknrfe5Lo4YKirYNUYYthn3WILSQsJI9
         fpIaI8NtyIvbCkbokKWuhdlPI7J9VVvz0i6B300KgIyR1osWvDxAGBSy/pR8y/MLeml4
         Jy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SEpBYFHK0HtbcnU3DxN6ytdSesg/BbWHz7D8aY4XmFM=;
        b=pnNCxTuajuLfCy/nA0J5LKMeoMFSny58pJQTmOt3oJP+vjFhQYBCbHugAbeVjFqsRv
         TU0OuU2CZXIMaRPfXx/i+x1hlYmCAJ+lnuWTh9w+ESYWx4jTWZ6AxZ9go/krqEBhDBqB
         WTJ/BXZbgrJkRZ4QZwiQPvqXjQSnDWS208nFrm02BLrP2OWHVHaIKovrF4VhKlJrXRbh
         E2AU2g6+fLd+ZtxaFETKMKY2upgn5tWL9oVaE41IMjXTOqOB6kjVP+7R+Prpbeg6MQnH
         0x+00JGSmgjBDvyZPkNN+U2Uh/S1QiQhlXaDdiQ4PA84gjNp7RKjuz/qUO4Q/RZMf9Rm
         hiaQ==
X-Gm-Message-State: AOUpUlHo8FzXRBGrk6P3btLS5GvEzoUl3OckmRHIvsAyQiCrIlxAN268
        HSouXgTR2NaeEzTx39hl+q0hAWIV
X-Google-Smtp-Source: AA+uWPz/gWoPd6wagQEAYUh/dt+dB84CruC3icxDBdmaMBeBlTUos2dF27zqMpS5M65leN1kW67gqw==
X-Received: by 2002:a17:902:3a3:: with SMTP id d32-v6mr7739841pld.294.1533939279383;
        Fri, 10 Aug 2018 15:14:39 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id a20-v6sm20286697pfc.14.2018.08.10.15.14.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 15:14:38 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:14:38 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Aug 2018 22:14:11 GMT
Message-Id: <6330afad9e727e6940385cc60661739ec55e0ced.1533939264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v5.git.gitgitgadget@gmail.com>
References: <pull.1.v4.git.gitgitgadget@gmail.com>
        <pull.1.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 09/21] range-diff: adjust the output of the commit pairs
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

