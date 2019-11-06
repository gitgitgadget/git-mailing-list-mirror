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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A14E1F454
	for <e@80x24.org>; Wed,  6 Nov 2019 15:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbfKFPvY (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 10:51:24 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53205 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbfKFPvX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 10:51:23 -0500
Received: by mail-wm1-f68.google.com with SMTP id c17so4090574wmk.2
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 07:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=w83SZdlbib6OA9QOEDTE8AxnqoSz+2R8oPE15T67B00=;
        b=Cy7BZcLYjhhsajWQdipJSBlxyDAmn8xgveMLa8hJa8j02wYWqMJRLjLq/+KYzcLxsZ
         h+JtlqvIY+M6PICsaOeN+F3+bIATntaIr8SOt/gUfnKDOwLPKtPvBanwYQI3/Wuyw9Fg
         agbXrKQmH4KEJjpyNjzSiWxeNttpwCtcFAM62hJCpIdUI95w5eIpSxFw2zgMOLuqbg+C
         HV0VfDgqBFk/28IS9pe1jD6hZqjNpzxxvUVONPxvYdjayUXMXBqKgwJXnnK04dcNiXkh
         y+EfjDOnrvYmoCyNOkwDTWc8Sn1X7XXeUN8+F3PoHZDO8dkEeUED9/hf1wMMRtLsx6Fc
         w7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=w83SZdlbib6OA9QOEDTE8AxnqoSz+2R8oPE15T67B00=;
        b=nDeEqZpxJAaUKq81mKQuo0MPWKjsl/j6KqT5ny2YPtX9Bi6Mf0c5lgjfFRFn0b5teG
         o2iCwgtpJ+Bx+DzB7hG/R+9YWVNhkTCRGtpSCXgezCA6IwqEpu9IJhfW8ft85ALtQbJA
         by7S9MEtWquS8afkkdsjg1edvSc/bO6WUYfx1YR9u3CiBkPN6mXVXssM5J2AHN8sd/S4
         +4lxdbxiNj+bq1t1LLVXM+Rr91+Bu3kJ/UNFyM0/AkPG/obBDnm2v/ttCx5D4ONk4g3M
         qI1BmksLr5vGMbf3tsOUEpGRMRh7zKaiZXe5D5UMIWbldejUls6JIVQ8M6YUHO7qicM3
         c9Og==
X-Gm-Message-State: APjAAAVG00XvuO5GrEwmtqgFKrMBtzQBFVZOFvbu0ob96Gg4Fnh2rouM
        FMc8MAYCd2Q+/UThbRS3j5MrrR02
X-Google-Smtp-Source: APXvYqxGiikiG3QLtSvtpKw4xNrWlV/MPjrIDI+0k3fQ7FioX/Vdcnw4N7L82atNCO04NYhMmyk9oA==
X-Received: by 2002:a05:600c:2945:: with SMTP id n5mr3432263wmd.80.1573055481299;
        Wed, 06 Nov 2019 07:51:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6sm2923386wrr.34.2019.11.06.07.51.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 07:51:20 -0800 (PST)
Message-Id: <96697ba0724caee556f21ada3959c4190d80c0b9.1573055478.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
        <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 15:51:14 +0000
Subject: [PATCH v2 2/6] pathspec: add new function to parse file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

This will be used to support the new option '--pathspec-from-file' in
`git add`, `git-commit`, `git reset` etc.

Note also that we specifically handle CR/LF line endings to support
Windows better.

To simplify code, file is first parsed into `argv_array`. This allows
to avoid refactoring `parse_pathspec()`.

I considered adding `nul_term_line` to `flags` instead, but decided
that it doesn't fit there.

The new code is mostly taken from `cmd_update_index()` and
`split_mail_conv()`.

Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 pathspec.c | 38 ++++++++++++++++++++++++++++++++++++++
 pathspec.h | 10 ++++++++++
 2 files changed, 48 insertions(+)

diff --git a/pathspec.c b/pathspec.c
index 12c2b322b3..2e9b376318 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -3,6 +3,8 @@
 #include "dir.h"
 #include "pathspec.h"
 #include "attr.h"
+#include "argv-array.h"
+#include "quote.h"
 
 /*
  * Finds which of the given pathspecs match items in the index.
@@ -613,6 +615,42 @@ void parse_pathspec(struct pathspec *pathspec,
 	}
 }
 
+void parse_pathspec_file(struct pathspec *pathspec, unsigned magic_mask,
+			 unsigned flags, const char *prefix,
+			 const char *file, int nul_term_line)
+{
+	struct argv_array parsed_file = ARGV_ARRAY_INIT;
+	strbuf_getline_fn getline_fn = nul_term_line ? strbuf_getline_nul :
+						       strbuf_getline;
+	struct strbuf buf = STRBUF_INIT;
+	struct strbuf unquoted = STRBUF_INIT;
+	FILE *in = NULL;
+
+	if (!strcmp(file, "-"))
+		in = stdin;
+	else
+		in = xfopen(file, "r");
+
+	while (getline_fn(&buf, in) != EOF) {
+		if (!nul_term_line && buf.buf[0] == '"') {
+			strbuf_reset(&unquoted);
+			if (unquote_c_style(&unquoted, buf.buf, NULL))
+				die(_("line is badly quoted: %s"), buf.buf);
+			strbuf_swap(&buf, &unquoted);
+		}
+		argv_array_push(&parsed_file, buf.buf);
+		strbuf_reset(&buf);
+	}
+
+	strbuf_release(&unquoted);
+	strbuf_release(&buf);
+	if (in != stdin)
+		fclose(in);
+
+	parse_pathspec(pathspec, magic_mask, flags, prefix, parsed_file.argv);
+	argv_array_clear(&parsed_file);
+}
+
 void copy_pathspec(struct pathspec *dst, const struct pathspec *src)
 {
 	int i, j;
diff --git a/pathspec.h b/pathspec.h
index 1c18a2c90c..a27dc81ba2 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -85,6 +85,16 @@ void parse_pathspec(struct pathspec *pathspec,
 		    unsigned flags,
 		    const char *prefix,
 		    const char **args);
+/*
+ * Same as parse_pathspec() but uses file as input.
+ * When 'file' is exactly "-" it uses 'stdin' instead.
+ */
+void parse_pathspec_file(struct pathspec *pathspec,
+			 unsigned magic_mask,
+			 unsigned flags,
+			 const char *prefix,
+			 const char *file,
+			 int nul_term_line);
 void copy_pathspec(struct pathspec *dst, const struct pathspec *src);
 void clear_pathspec(struct pathspec *);
 
-- 
gitgitgadget

