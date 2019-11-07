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
	by dcvr.yhbt.net (Postfix) with ESMTP id 31FEC1F454
	for <e@80x24.org>; Thu,  7 Nov 2019 08:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfKGIKJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 03:10:09 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:33973 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfKGIKI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 03:10:08 -0500
Received: by mail-wr1-f54.google.com with SMTP id e6so1945910wrw.1
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 00:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=no+4wbVfl7SdqxnSYLAlUXsrF4pHFfVoLGd2EC1WUYk=;
        b=RVa8JtF3ApRPPW72523MO3E+tHxoBKWJV2TSqBqF60h0C3Je1W44m76oip+DR6vMhd
         e5d27DCZkdNkR9jg4+XzV+FlDg5RiYeh6YFRyMC+AItdXdToV5477etm3ZNcb2EpYWPm
         8F2M5SkFk4MnReO2/auCGUQqUzVZx3kAXQGw5sNYEfFqfn2NUhf6nitByUp14PufBAxu
         MCUkDtsevWQxRFy6nC1+Nk29TwMUSltxWkgeow5TunkE3kdBLE6WiC41y6nREcsFExKG
         n4Gx0ob6mYZCl2QuliDxXbeeHSeuSxLuHgPMOCMcRaBn4vWhhkkVXogxffyEIUfc/b6F
         BGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=no+4wbVfl7SdqxnSYLAlUXsrF4pHFfVoLGd2EC1WUYk=;
        b=nmUUsLH9Q7Ll2UaHtEs7EAJAN5AI+X7rL42qIyGKXkKSvPG+RIhKWbrOpETzo6nbpT
         3qh5MHgiqhJIiPrDKRtDHmIv/0UToKRWoh+KOn3CIlvsfaDH6l0x7gJ+oJ+EcVRCYSc2
         2IEmr4s/zi7uevxTgHrvrK2cGN224Vqzrf77af+olGM1IJ+AJhrFtYiW7oV0i6R3i7GH
         buIU+bN8nXeLsqR2JyHpwnDPnnvmh3lsOwKy9XRoqIKlJ17jyOMoXGCDoMPelfy3pBDi
         jaLSEu+ctihN+tUTMeLdYvjNLqCjIFtfrNINECS7j7DvkosGiXv1LKVFQC54LsJmgUC5
         UcxQ==
X-Gm-Message-State: APjAAAV7Ym3f25SECId0DivzNyK2D4oiHtHgaxORjPBMtqpMbltVRXh9
        adn1xIVqqtM8o9B0IPbxShwAyNpt
X-Google-Smtp-Source: APXvYqyFXvAvuGHZ+Z/Me0aLlxLdsO2suRLHT0fG9BjGL+YLe89mv3p6TxroedUHODkRthwgsPm6gg==
X-Received: by 2002:adf:fbc4:: with SMTP id d4mr1675542wrs.265.1573114206219;
        Thu, 07 Nov 2019 00:10:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10sm2898599wrg.90.2019.11.07.00.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 00:10:05 -0800 (PST)
Message-Id: <d224564bc2969c1d95351a5b55b296e399f5b8c8.1573114201.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.449.git.1573114201.gitgitgadget@gmail.com>
References: <pull.449.git.1573114201.gitgitgadget@gmail.com>
From:   "george espinoza via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Nov 2019 08:10:00 +0000
Subject: [PATCH 6/6] [Outreachy] check-ref-format: parse-options
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

Helped by: emily shaffer emilyshaffer@google.com
Helped by: johannes schindelin johannes.schindelin@gmx.de

Signed-off-by: george espinoza <gespinoz2019@gmail.com>
---
 builtin/check-ref-format.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index be3b1bd84d..ea703cfabd 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -61,18 +61,15 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 		CHECK_REF_FORMAT_BRANCH,
 	} mode = CHECK_REFNAME_FORMAT;
 
-	int verbose = 0;
 	int normalize = 0;
 	int flags = 0;
 	const char *refname;
 
 	struct option options[] = {
-		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT_GROUP(""),
-		OPT_CMDMODE(0 , "branch", &mode, N_("branch"), CHECK_REF_FORMAT_BRANCH),
+		OPT_CMDMODE(0 , "branch", &mode, N_("check for valid branch name"), CHECK_REF_FORMAT_BRANCH),
 		OPT_BOOL(0 , "normalize", &normalize, N_("normalize tracked files")),
 		OPT_BIT(0 , "allow-onelevel", &flags, N_("allow one level"), REFNAME_ALLOW_ONELEVEL),
-		OPT_NEGBIT(0, "no-allow-onelevel", &flags, N_("no allow one level"), REFNAME_ALLOW_ONELEVEL),
 		OPT_BIT(0 , "refspec-pattern", &flags, N_("refspec pattern"), REFNAME_REFSPEC_PATTERN),
 		OPT_END(),
 	};
@@ -81,7 +78,7 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 
 	refname = argv[0];
 	if (mode)
-		return  check_ref_format_branch(argv[2]);
+		return check_ref_format_branch(argv[2]);
 	if (normalize)
 		refname = collapse_slashes(refname);
 	if (check_refname_format(refname, flags))
-- 
gitgitgadget
