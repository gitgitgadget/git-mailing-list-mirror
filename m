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
	by dcvr.yhbt.net (Postfix) with ESMTP id 015631F454
	for <e@80x24.org>; Thu,  7 Nov 2019 08:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfKGIKN (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 03:10:13 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:46787 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbfKGIKG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 03:10:06 -0500
Received: by mail-wr1-f43.google.com with SMTP id b3so1833396wrs.13
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 00:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aamaLcA79yyqR72Rk3YW//QDGt5ORWKUIij1I88jGPU=;
        b=h5+1EOs+PggvwzvRVVBS6ph/VcvAuOu7+GOeDlce/XaA6j40kFcXSPpbWw4NjL8rwB
         iQ3ovftgvXyQw4b6affdAuMkySJuFRc1kEid80Gy6KdpjEDQsTweBbLUFxzbIMCD3Dy2
         nCtXhn1ftbvA4ccgu3mnudQ762A8n4e0HIRuifHlrL+1qjbifKS3dpn9jl0S/IWZ/Nd7
         KwDVO+8rvM7I0brzYMM7h8yXC/8jTWlYtpFhtWg8ooLrXsUH9vloG2jd7Dz0MtJSu3Mk
         +Xe/xsRHcGJVXHdn/6pW8dMgpb7YUOPqK1oxbRzBjjxUaK6xJCF8k+B5dEXbi9su97OD
         R7+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aamaLcA79yyqR72Rk3YW//QDGt5ORWKUIij1I88jGPU=;
        b=Do17k3IQqAbvQCAM7uTsz/nXKPEw0ZGbKmB8qKwbMntkaNNSzvOT86GYVHySRSG8Ju
         EAbbHC1QEkbneQXGFpwRKQQPJCm2trWmmImcmlAfK99kxL/4d1arKZsPxS7KqYjpnFbW
         e85B+Cbg8oEJa2oV2a8DnJEToLpnaB4yjgQz0XTc6g9pu7Qa1/f1L8eJ4/Putgd8qdbU
         XdXxgFZrEEBLVbjrDx+vG/LrNKHVNnR1rPS6coQ7HPPxqfXATQkRQTcWH1Rbz+CwXzqj
         sovhVzGNgMr1YRIEWbveOGcRdDqhPPWa2lSjItl9oQ35F7OegGOWMtuWtje8lW1UG3dA
         62zA==
X-Gm-Message-State: APjAAAUC4bYbW0XHn/hMH9sD58YviLKomrt/GrFN3lVzzZYJnGOxSRu6
        3Ifm87oG2BVE7iCljvpFwiVAnDvw
X-Google-Smtp-Source: APXvYqyGcAZDf+nak9INT/O8iNtGFG//X9zlBgDXcFFsEa1v6nHYcJ2DoWWHAXAji1LziClTKL4OMA==
X-Received: by 2002:adf:fd85:: with SMTP id d5mr1594417wrr.101.1573114204821;
        Thu, 07 Nov 2019 00:10:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4sm1171756wmk.29.2019.11.07.00.10.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 00:10:04 -0800 (PST)
Message-Id: <0a1c8e2dea25d2e485cbf8350b08953ed33e96b7.1573114201.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.449.git.1573114201.gitgitgadget@gmail.com>
References: <pull.449.git.1573114201.gitgitgadget@gmail.com>
From:   "george espinoza via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Nov 2019 08:09:58 +0000
Subject: [PATCH 4/6] [Outreachy] check-ref-format: parse options
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

As a consequence of using OPT_BOOL data structure on --normalize &
--refspec-pattern, --no-normalize & --no-refspec-pattern can now be
used.

NO_PARSEOPT flag was also removed to update git.c with the
conversion of the structure in this command.

This is a rough draft and I need some advice if I'm doing this
correctly since its being built but it is failing tests.

Helped by: emily shaffer emilyshaffer@google.com
Helped by: johannes schindelin johannes.schindelin@gmx.de

Signed-off-by: george espinoza <gespinoz2019@gmail.com>
---
 builtin/check-ref-format.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index 3fe0b5410a..c48fb19eda 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -61,10 +61,8 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 	};
 
 	int i = 0;
-	int verbose;
-	int normalize;
-	int allow_onelevel;
-	int refspec_pattern;
+	int verbose = 0;
+	int normalize = 0;
 	int flags = 0;
 	const char *refname;
 
@@ -73,12 +71,13 @@ int cmd_check_ref_format(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(""),
 		OPT_CMDMODE( 0 , "branch", &check_ref_format_branch, N_("branch"), CHECK_REF_FORMAT_BRANCH),
 		OPT_BOOL( 0 , "normalize", &normalize, N_("normalize tracked files")),
-		OPT_BOOL( 0 , "allow-onelevel", &allow_onelevel, N_("allow one level")),
-		OPT_BOOL( 0 , "refspec-pattern", &refspec_pattern, N_("refspec pattern")),
+		OPT_BIT( 0 , "allow-onelevel", &flags, N_("allow one level"), REFNAME_ALLOW_ONELEVEL),
+		OPT_NEGBIT( 0, "no-allow-onelevel", &flags, N_("no allow one level"), REFNAME_ALLOW_ONELEVEL),
+		OPT_BIT( 0 , "refspec-pattern", &flags, N_("refspec pattern"), REFNAME_REFSPEC_PATTERN),
 		OPT_END(),
 	};
 
-	argc = parse_options(argc, argv, prefix, options, builtin_check_ref_format_usage, PARSE_OPT_KEEP_ARGV0);
+	argc = parse_options(argc, argv, prefix, options, builtin_check_ref_format_usage, 0);
 
 	refname = argv[i];
 	if (normalize)
-- 
gitgitgadget

