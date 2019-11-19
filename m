Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BBC71F4B5
	for <e@80x24.org>; Tue, 19 Nov 2019 16:49:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfKSQtA (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Nov 2019 11:49:00 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56081 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbfKSQtA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 11:49:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id b11so3939243wmb.5
        for <git@vger.kernel.org>; Tue, 19 Nov 2019 08:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HjSBzc0rGvd4vC7CgPBj9hyIis2u+fMfIGl4JldqIGg=;
        b=eCqTx74FxLEy52x4JdfDmTP7Z/7vZlprN4oY9oyVDi6hL0jn5emUckaO4w10FieON5
         uUfbIzkVED2i+Ay0fcISDjtIhtcdnOST0ykNWF9F3LBzhFtdJQOTcn1mSl2NgszCajPi
         iEMJoM+JEF51CbIGgi6YzbeG8bxy6XbgErNSuR2wxZc0IQ20cONI5lZiz2ffe51Vlb4I
         XdXp9CCAOr8SbXHRvIfEQ8MjBR8dESqM1BCBJY5uaKZ28IUWiL3pDdlvUAAUqdEQL7SJ
         OAfto8WhqisF33ORMN9w++XzL7kskdVHtOwKdiKYwM1a91k6DiBgjMpbvzyTCZrvnkri
         /S6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HjSBzc0rGvd4vC7CgPBj9hyIis2u+fMfIGl4JldqIGg=;
        b=HpQBxPWtF+CCoSD2cWrWM7T+jDPX6WHpoTWHvpDLGQWOMH7W6+ySFkTrd5QogUFWXh
         RrHGCSMPWY/eQ0Q0LO3LQd5zpBxsUxSmNe1suCy1LpruNV+ALtJYROp6BJOdT2MCugpe
         bdy1q9W7VcnpfF8R7agk6hfMPOU/adCPeOnK71xabplJ+37K8KpddiloBureZFUHE8PN
         dJouDXZhmGiownSST+AGNZwuRoaMS7ErD+iqg9gSkeLpVgmhwqc/fc82VsAqYnCm35Bh
         Jy+ooEFvIoO2LYJWLZhX0YKpvOWFDHH1G8b7m3U0S5+wC3+23w1cvHMac0bRkJVBUcZ0
         6pdA==
X-Gm-Message-State: APjAAAXrtB3hZwY9tR/DtuQHCE7aRbcLZuOSb6cGC+U9rEIlpcfoHP0r
        KQxUXZV/7mpOi45K/vjvjbSJmu6pQiA=
X-Google-Smtp-Source: APXvYqw84RwjglP1f2fJXOzs9iLOnG2ePqWmo60EODfgLqUQMQ+dkaCrJFsOKC2VL/w0oRwPkb66qg==
X-Received: by 2002:a7b:c411:: with SMTP id k17mr6611816wmi.119.1574182138279;
        Tue, 19 Nov 2019 08:48:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r25sm3671189wmh.6.2019.11.19.08.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 08:48:57 -0800 (PST)
Message-Id: <55a7c6ec3cebd46b8650ad8116923676fa0e2b3a.1574182135.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
References: <pull.445.v2.git.1573055478.gitgitgadget@gmail.com>
        <pull.445.v3.git.1574182135.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Nov 2019 16:48:51 +0000
Subject: [PATCH v3 2/6] pathspec: add new function to parse file
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
index 12c2b322b3..128f27fcb7 100644
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
+	FILE *in;
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

