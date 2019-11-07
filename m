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
	by dcvr.yhbt.net (Postfix) with ESMTP id 705AA1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 08:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbfKGIKI (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 03:10:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42680 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfKGIKG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 03:10:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so1864931wrf.9
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 00:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RgukjGt0ufqWdhNiMoY06r8rcOm/Ha5L1wkZwicuG5M=;
        b=Qc4BFCZlrwucvdxWBni0dnr+fpUDpKA08iMOilfRqA0wH8ORhMknUkWJcegHtUpCkd
         WPXV9kA3UJLy/rTHvb/lkp0EJ54sBCnIJrHDRuIQdxEuwsPANvi+0HqRwbtrbrtdc8Uk
         uF4fUj56/mmN+WtfDhPuJC3o0E3PAjT2Llp0LSm4A7k/UUSmVfhCBziFke//ABZg2EmN
         XL9jlzX/U71gjSlnO1Bpum2AJ3YkyA4GdKT4sNsnzYvfGX/LFfwODsvUP+JYrLX18IFF
         oROXHf0wy/YKA+LvOMJGhyhchqUYR5i3Epx4afwfBostempyctQfXMKKY6ThePxIRVlB
         5V5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RgukjGt0ufqWdhNiMoY06r8rcOm/Ha5L1wkZwicuG5M=;
        b=NRrzsvUHJMXxJY8BJEETrCEBQPvMxwQW0wmzMELDumuakkbQn4/ioEo2oAAnPl5cpY
         4FEW+V0TMaD+Qn74uhJ+vZ0Vdipliyj7HZEQD2bJHfN0LFfZQhuusXze4gpBUq6wMTgC
         5m3HVciMMgkAjqIPFqf4tBFaMataqcxjVqWr5NWPodEwQe9z6TiiH+nFu3m7ttt3CNbY
         pJcFpQbh3SxLzHNp5L5XVEcVqfgTJTqcTARVtR4R2m14npXqUreyZdZbGn9Vy1c0/mD3
         kpS7O70BLmoX3Qy8DWFsHMj3uRdg83qs7OuUyLUW8M3FMU1E6A1o3hWRIad7CKMoF9Be
         uLZA==
X-Gm-Message-State: APjAAAXiyBCVvZEiEko/YM0Bv/bBtXkUxmthNDXqslBj3JIYPYKp8fa0
        XfjKnxQTui+4OjXT9zRaQtvlPRHp
X-Google-Smtp-Source: APXvYqz4QnMFc8ByD3pLTwgF0P1yxETjAf6BV88Ebe+RBPsUbliCXTssSbsknrYrVyI6cziVzeufiA==
X-Received: by 2002:a05:6000:18c:: with SMTP id p12mr1546184wrx.154.1573114205496;
        Thu, 07 Nov 2019 00:10:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f19sm3098205wrf.23.2019.11.07.00.10.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 00:10:05 -0800 (PST)
Message-Id: <aeff5d9908e80f8534144529bc5cedd6dd190021.1573114201.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.449.git.1573114201.gitgitgadget@gmail.com>
References: <pull.449.git.1573114201.gitgitgadget@gmail.com>
From:   "george espinoza via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Nov 2019 08:09:59 +0000
Subject: [PATCH 5/6] [Outreachy] check-ref-format: parse-options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     George Espinoza <gespinoz2019@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        george espinoza <gespinoz2019@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: george espinoza <gespinoz2019@gmail.com>

This command currently handles its own argv so by teaching it to
use parse-options instead we can standardize the way commands
handle user input across the project.

Because OPT_BOOL data structure is being used on --normalize
--no-normalize can now be utilized.

NO_PARSEOPT flag was also removed to update git.c with the
conversion of the structure in this command.

I got all tests to pass at the moment. My next commit will be to
check if OPT_NEGBIT isn't needed and moving around OPT_VERBOSE.

Helped by: emily shaffer emilyshaffer@google.com
Helped by: johannes schindelin johannes.schindelin@gmx.de

Signed-off-by: george espinoza <gespinoz2019@gmail.com>
---
 builtin/check-ref-format.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index c48fb19eda..be3b1bd84d 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -57,10 +57,10 @@ static int check_ref_format_branch(const char *arg)
 int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 {
 	enum {
+		CHECK_REFNAME_FORMAT = 0,
 		CHECK_REF_FORMAT_BRANCH,
-	};
+	} mode = CHECK_REFNAME_FORMAT;
 
-	int i = 0;
 	int verbose = 0;
 	int normalize = 0;
 	int flags = 0;
@@ -69,17 +69,19 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT_GROUP(""),
-		OPT_CMDMODE( 0 , "branch", &check_ref_format_branch, N_("branch"), CHECK_REF_FORMAT_BRANCH),
-		OPT_BOOL( 0 , "normalize", &normalize, N_("normalize tracked files")),
-		OPT_BIT( 0 , "allow-onelevel", &flags, N_("allow one level"), REFNAME_ALLOW_ONELEVEL),
-		OPT_NEGBIT( 0, "no-allow-onelevel", &flags, N_("no allow one level"), REFNAME_ALLOW_ONELEVEL),
-		OPT_BIT( 0 , "refspec-pattern", &flags, N_("refspec pattern"), REFNAME_REFSPEC_PATTERN),
+		OPT_CMDMODE(0 , "branch", &mode, N_("branch"), CHECK_REF_FORMAT_BRANCH),
+		OPT_BOOL(0 , "normalize", &normalize, N_("normalize tracked files")),
+		OPT_BIT(0 , "allow-onelevel", &flags, N_("allow one level"), REFNAME_ALLOW_ONELEVEL),
+		OPT_NEGBIT(0, "no-allow-onelevel", &flags, N_("no allow one level"), REFNAME_ALLOW_ONELEVEL),
+		OPT_BIT(0 , "refspec-pattern", &flags, N_("refspec pattern"), REFNAME_REFSPEC_PATTERN),
 		OPT_END(),
 	};
 
 	argc = parse_options(argc, argv, prefix, options, builtin_check_ref_format_usage, 0);
 
-	refname = argv[i];
+	refname = argv[0];
+	if (mode)
+		return  check_ref_format_branch(argv[2]);
 	if (normalize)
 		refname = collapse_slashes(refname);
 	if (check_refname_format(refname, flags))
-- 
gitgitgadget

