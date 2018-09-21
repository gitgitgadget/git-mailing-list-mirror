Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03AE61F453
	for <e@80x24.org>; Fri, 21 Sep 2018 23:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391641AbeIVFuX (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 01:50:23 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:48117 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeIVFuX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 01:50:23 -0400
Received: by mail-qk1-f202.google.com with SMTP id u195-v6so14741677qka.14
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 16:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jZKkAGz2INWqdD6E1auo1nbOQOB/JsdJ+G3fxcI67kM=;
        b=OEslp3/C3s8OaUerNdxRRu5k07YOIZ1SgcYYQ9vpkDBrM08toFCpJu+4xLym/4g7Na
         54gcoctMWoB+RM+LPw+eDrWuKeveODwHhcX1K+1eKcs2LJACjO8INH06wOL0Zopo3QFG
         tmFDybFcrftLHlakR7+dqdIQCJ0x7UL20UTLqgADkLY4AIbp1dCvCl26QU9n4G8hPYro
         usAvcpVTpQzoRNFL6gZOaGxTk1tWt17ckONWuNLe/E/LRZocXrHlRnW1HtapyrZXUKGV
         QuXqlZwlnFz7RI0kE5qxhETz6q3pCIxw3XXbwNjwRbXdVgwXNQt6o49K+08G0b0YlxDU
         7PuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jZKkAGz2INWqdD6E1auo1nbOQOB/JsdJ+G3fxcI67kM=;
        b=WJUNExzbSwP+e4Fviu3gJJkMYz2LD3GmYj5Zp8fgdloYoWcMsZctuxBhAo3XvrkQU3
         b9CQ0FKKsYAOlwRVcEuE70R8atoL8tjBNSqmLfI61Ga3Tvso6HmpldTnQNxEj5j+c4uF
         vEEeTRdbxgwehCZhsNcbJfqgaYsSW9YmUXcQ3rjeeqs13zbbUwAosDPlHVNu0If5H5An
         bo5iYbg0cV0GDMg1mUNq0K10L5OllhMFiI1atLgWxCY9z0I7iaI03/vcYhdFjtxsUA6m
         m/7EFu16QW6LeYL/FaLnSnJ6IeOowTcyCjWJJt89JkjhOduj7sxMCt138qKT4DPlXVxX
         d1cA==
X-Gm-Message-State: APzg51AAqjWcfFH+gswnM2R1IA32frm1kQporyUDZexhDN2UWCTHkVlI
        ildtpPpVwmFRWokhTVj8Zh67C4GAACXnGwK+acAN1ZVZooPWqXrkN+jfnnDbbjQh4cvMhfcXsLI
        7M0KjYQ7+5KWVjhaKsLohpxp2TsS00RkpFLJ24x43RgCNxYTbh0rhpLmwrbGS
X-Google-Smtp-Source: ACcGV60L8fN6sSzUTDxYFLKMGwZNy9uPEMukzlIxdcgv2ef2zI9RWa40uB67fmmuB5OxK05Ikvgvjx4FvEJ5
X-Received: by 2002:aed:3cd8:: with SMTP id e24-v6mr17779qtf.55.1537574348862;
 Fri, 21 Sep 2018 16:59:08 -0700 (PDT)
Date:   Fri, 21 Sep 2018 16:58:33 -0700
In-Reply-To: <20180921235833.99045-1-sbeller@google.com>
Message-Id: <20180921235833.99045-4-sbeller@google.com>
Mime-Version: 1.0
References: <20180921235833.99045-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH 3/3] t0030: reformat style
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t0030-stripspace.sh | 525 ++++++++++++++++++++----------------------
 1 file changed, 254 insertions(+), 271 deletions(-)

diff --git a/t/t0030-stripspace.sh b/t/t0030-stripspace.sh
index 5ce47e8af51..c2281a39b58 100755
--- a/t/t0030-stripspace.sh
+++ b/t/t0030-stripspace.sh
@@ -12,379 +12,362 @@ s40='                                        '
 sss="$s40$s40$s40$s40$s40$s40$s40$s40$s40$s40" # 400
 ttt="$t40$t40$t40$t40$t40$t40$t40$t40$t40$t40" # 400
 
-test_expect_success \
-    'long lines without spaces should be unchanged' '
-    echo "$ttt" >expect &&
-    git stripspace <expect >actual &&
-    test_cmp expect actual &&
-
-    echo "$ttt$ttt" >expect &&
-    git stripspace <expect >actual &&
-    test_cmp expect actual &&
-
-    echo "$ttt$ttt$ttt" >expect &&
-    git stripspace <expect >actual &&
-    test_cmp expect actual &&
-
-    echo "$ttt$ttt$ttt$ttt" >expect &&
-    git stripspace <expect >actual &&
-    test_cmp expect actual
+test_expect_success 'long lines without spaces should be unchanged' '
+	echo "$ttt" >expect &&
+	git stripspace <expect >actual &&
+	test_cmp expect actual &&
+
+	echo "$ttt$ttt" >expect &&
+	git stripspace <expect >actual &&
+	test_cmp expect actual &&
+
+	echo "$ttt$ttt$ttt" >expect &&
+	git stripspace <expect >actual &&
+	test_cmp expect actual &&
+
+	echo "$ttt$ttt$ttt$ttt" >expect &&
+	git stripspace <expect >actual &&
+	test_cmp expect actual
 '
 
-test_expect_success \
-    'lines with spaces at the beginning should be unchanged' '
-    echo "$sss$ttt" >expect &&
-    git stripspace <expect >actual &&
-    test_cmp expect actual &&
+test_expect_success 'lines with spaces at the beginning should be unchanged' '
+	echo "$sss$ttt" >expect &&
+	git stripspace <expect >actual &&
+	test_cmp expect actual &&
 
-    echo "$sss$sss$ttt" >expect &&
-    git stripspace <expect >actual &&
-    test_cmp expect actual &&
+	echo "$sss$sss$ttt" >expect &&
+	git stripspace <expect >actual &&
+	test_cmp expect actual &&
 
-    echo "$sss$sss$sss$ttt" >expect &&
-    git stripspace <expect >actual &&
-    test_cmp expect actual
+	echo "$sss$sss$sss$ttt" >expect &&
+	git stripspace <expect >actual &&
+	test_cmp expect actual
 '
 
-test_expect_success \
-    'lines with intermediate spaces should be unchanged' '
-    echo "$ttt$sss$ttt" >expect &&
-    git stripspace <expect >actual &&
-    test_cmp expect actual &&
+test_expect_success 'lines with intermediate spaces should be unchanged' '
+	echo "$ttt$sss$ttt" >expect &&
+	git stripspace <expect >actual &&
+	test_cmp expect actual &&
 
-    echo "$ttt$sss$sss$ttt" >expect &&
-    git stripspace <expect >actual &&
-    test_cmp expect actual
+	echo "$ttt$sss$sss$ttt" >expect &&
+	git stripspace <expect >actual &&
+	test_cmp expect actual
 '
 
-test_expect_success \
-    'consecutive blank lines should be unified' '
-    printf "$ttt\n\n$ttt\n" > expect &&
-    printf "$ttt\n\n\n\n\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+test_expect_success 'consecutive blank lines should be unified' '
+	printf "$ttt\n\n$ttt\n" > expect &&
+	printf "$ttt\n\n\n\n\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt\n\n$ttt\n" > expect &&
-    printf "$ttt$ttt\n\n\n\n\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt\n\n$ttt\n" > expect &&
+	printf "$ttt$ttt\n\n\n\n\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt$ttt\n\n$ttt\n" > expect &&
-    printf "$ttt$ttt$ttt\n\n\n\n\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt$ttt\n\n$ttt\n" > expect &&
+	printf "$ttt$ttt$ttt\n\n\n\n\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n\n$ttt\n" > expect &&
-    printf "$ttt\n\n\n\n\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n\n$ttt\n" > expect &&
+	printf "$ttt\n\n\n\n\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n\n$ttt$ttt\n" > expect &&
-    printf "$ttt\n\n\n\n\n$ttt$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n\n$ttt$ttt\n" > expect &&
+	printf "$ttt\n\n\n\n\n$ttt$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n\n$ttt$ttt$ttt\n" > expect &&
-    printf "$ttt\n\n\n\n\n$ttt$ttt$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n\n$ttt$ttt$ttt\n" > expect &&
+	printf "$ttt\n\n\n\n\n$ttt$ttt$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n\n$ttt\n" > expect &&
-    printf "$ttt\n\t\n \n\n  \t\t\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n\n$ttt\n" > expect &&
+	printf "$ttt\n\t\n \n\n  \t\t\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt\n\n$ttt\n" > expect &&
-    printf "$ttt$ttt\n\t\n \n\n  \t\t\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt\n\n$ttt\n" > expect &&
+	printf "$ttt$ttt\n\t\n \n\n  \t\t\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt$ttt\n\n$ttt\n" > expect &&
-    printf "$ttt$ttt$ttt\n\t\n \n\n  \t\t\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt$ttt\n\n$ttt\n" > expect &&
+	printf "$ttt$ttt$ttt\n\t\n \n\n  \t\t\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n\n$ttt\n" > expect &&
-    printf "$ttt\n\t\n \n\n  \t\t\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n\n$ttt\n" > expect &&
+	printf "$ttt\n\t\n \n\n  \t\t\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n\n$ttt$ttt\n" > expect &&
-    printf "$ttt\n\t\n \n\n  \t\t\n$ttt$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n\n$ttt$ttt\n" > expect &&
+	printf "$ttt\n\t\n \n\n  \t\t\n$ttt$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n\n$ttt$ttt$ttt\n" > expect &&
-    printf "$ttt\n\t\n \n\n  \t\t\n$ttt$ttt$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual
+	printf "$ttt\n\n$ttt$ttt$ttt\n" > expect &&
+	printf "$ttt\n\t\n \n\n  \t\t\n$ttt$ttt$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual
 '
 
-test_expect_success \
-    'only consecutive blank lines should be completely removed' '
+test_expect_success 'only consecutive blank lines should be completely removed' '
 
-    printf "\n" | git stripspace >actual &&
-    test_must_be_empty actual &&
+	printf "\n" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    printf "\n\n\n" | git stripspace >actual &&
-    test_must_be_empty actual &&
+	printf "\n\n\n" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    printf "$sss\n$sss\n$sss\n" | git stripspace >actual &&
-    test_must_be_empty actual &&
+	printf "$sss\n$sss\n$sss\n" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    printf "$sss$sss\n$sss\n\n" | git stripspace >actual &&
-    test_must_be_empty actual &&
+	printf "$sss$sss\n$sss\n\n" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    printf "\n$sss\n$sss$sss\n" | git stripspace >actual &&
-    test_must_be_empty actual &&
+	printf "\n$sss\n$sss$sss\n" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    printf "$sss$sss$sss$sss\n\n\n" | git stripspace >actual &&
-    test_must_be_empty actual &&
+	printf "$sss$sss$sss$sss\n\n\n" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    printf "\n$sss$sss$sss$sss\n\n" | git stripspace >actual &&
-    test_must_be_empty actual &&
+	printf "\n$sss$sss$sss$sss\n\n" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    printf "\n\n$sss$sss$sss$sss\n" | git stripspace >actual &&
-    test_must_be_empty actual
+	printf "\n\n$sss$sss$sss$sss\n" | git stripspace >actual &&
+	test_must_be_empty actual
 '
 
-test_expect_success \
-    'consecutive blank lines at the beginning should be removed' '
-    printf "$ttt\n" > expect &&
-    printf "\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+test_expect_success 'consecutive blank lines at the beginning should be removed' '
+	printf "$ttt\n" > expect &&
+	printf "\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n" > expect &&
-    printf "\n\n\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n" > expect &&
+	printf "\n\n\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt\n" > expect &&
-    printf "\n\n\n$ttt$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt\n" > expect &&
+	printf "\n\n\n$ttt$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt$ttt\n" > expect &&
-    printf "\n\n\n$ttt$ttt$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt$ttt\n" > expect &&
+	printf "\n\n\n$ttt$ttt$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt$ttt$ttt\n" > expect &&
-    printf "\n\n\n$ttt$ttt$ttt$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt$ttt$ttt\n" > expect &&
+	printf "\n\n\n$ttt$ttt$ttt$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n" > expect &&
+	printf "$ttt\n" > expect &&
 
-    printf "$sss\n$sss\n$sss\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$sss\n$sss\n$sss\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "\n$sss\n$sss$sss\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "\n$sss\n$sss$sss\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$sss$sss\n$sss\n\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$sss$sss\n$sss\n\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$sss$sss$sss\n\n\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$sss$sss$sss\n\n\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "\n$sss$sss$sss\n\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "\n$sss$sss$sss\n\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "\n\n$sss$sss$sss\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual
+	printf "\n\n$sss$sss$sss\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual
 '
 
-test_expect_success \
-    'consecutive blank lines at the end should be removed' '
-    printf "$ttt\n" > expect &&
-    printf "$ttt\n\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+test_expect_success 'consecutive blank lines at the end should be removed' '
+	printf "$ttt\n" > expect &&
+	printf "$ttt\n\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n" > expect &&
-    printf "$ttt\n\n\n\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n" > expect &&
+	printf "$ttt\n\n\n\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt\n" > expect &&
-    printf "$ttt$ttt\n\n\n\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt\n" > expect &&
+	printf "$ttt$ttt\n\n\n\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt$ttt\n" > expect &&
-    printf "$ttt$ttt$ttt\n\n\n\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt$ttt\n" > expect &&
+	printf "$ttt$ttt$ttt\n\n\n\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt$ttt$ttt\n" > expect &&
-    printf "$ttt$ttt$ttt$ttt\n\n\n\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt$ttt$ttt\n" > expect &&
+	printf "$ttt$ttt$ttt$ttt\n\n\n\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n" > expect &&
+	printf "$ttt\n" > expect &&
 
-    printf "$ttt\n$sss\n$sss\n$sss\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n$sss\n$sss\n$sss\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n\n$sss\n$sss$sss\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n\n$sss\n$sss$sss\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n$sss$sss\n$sss\n\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n$sss$sss\n$sss\n\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n$sss$sss$sss\n\n\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n$sss$sss$sss\n\n\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n\n$sss$sss$sss\n\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n\n$sss$sss$sss\n\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n\n\n$sss$sss$sss\n" | git stripspace >actual &&
-    test_cmp expect actual
+	printf "$ttt\n\n\n$sss$sss$sss\n" | git stripspace >actual &&
+	test_cmp expect actual
 '
 
-test_expect_success \
-    'text without newline at end should end with newline' '
-    test $(printf "$ttt" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$ttt" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$ttt$ttt" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$ttt$ttt$ttt" | git stripspace | wc -l) -gt 0
+test_expect_success 'text without newline at end should end with newline' '
+	test $(printf "$ttt" | git stripspace | wc -l) -gt 0 &&
+	test $(printf "$ttt$ttt" | git stripspace | wc -l) -gt 0 &&
+	test $(printf "$ttt$ttt$ttt" | git stripspace | wc -l) -gt 0 &&
+	test $(printf "$ttt$ttt$ttt$ttt" | git stripspace | wc -l) -gt 0
 '
 
 # text plus spaces at the end:
 
-test_expect_success \
-    'text plus spaces without newline at end should end with newline' '
-    test $(printf "$ttt$sss" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$ttt$sss" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$ttt$ttt$sss" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$sss$sss" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$ttt$sss$sss" | git stripspace | wc -l) -gt 0 &&
-    test $(printf "$ttt$sss$sss$sss" | git stripspace | wc -l) -gt 0
+test_expect_success 'text plus spaces without newline at end should end with newline' '
+	test $(printf "$ttt$sss" | git stripspace | wc -l) -gt 0 &&
+	test $(printf "$ttt$ttt$sss" | git stripspace | wc -l) -gt 0 &&
+	test $(printf "$ttt$ttt$ttt$sss" | git stripspace | wc -l) -gt 0 &&
+	test $(printf "$ttt$sss$sss" | git stripspace | wc -l) -gt 0 &&
+	test $(printf "$ttt$ttt$sss$sss" | git stripspace | wc -l) -gt 0 &&
+	test $(printf "$ttt$sss$sss$sss" | git stripspace | wc -l) -gt 0
 '
 
-test_expect_success \
-    'text plus spaces without newline at end should not show spaces' '
-    ! (printf "$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (printf "$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (printf "$ttt$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (printf "$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (printf "$ttt$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (printf "$ttt$sss$sss$sss" | git stripspace | grep "  " >/dev/null)
+test_expect_success 'text plus spaces without newline at end should not show spaces' '
+	! (printf "$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
+	! (printf "$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
+	! (printf "$ttt$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
+	! (printf "$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
+	! (printf "$ttt$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
+	! (printf "$ttt$sss$sss$sss" | git stripspace | grep "  " >/dev/null)
 '
 
-test_expect_success \
-    'text plus spaces without newline should show the correct lines' '
-    printf "$ttt\n" >expect &&
-    printf "$ttt$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+test_expect_success 'text plus spaces without newline should show the correct lines' '
+	printf "$ttt\n" >expect &&
+	printf "$ttt$sss" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n" >expect &&
-    printf "$ttt$sss$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n" >expect &&
+	printf "$ttt$sss$sss" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n" >expect &&
-    printf "$ttt$sss$sss$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n" >expect &&
+	printf "$ttt$sss$sss$sss" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt\n" >expect &&
-    printf "$ttt$ttt$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt\n" >expect &&
+	printf "$ttt$ttt$sss" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt\n" >expect &&
-    printf "$ttt$ttt$sss$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt\n" >expect &&
+	printf "$ttt$ttt$sss$sss" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt$ttt\n" >expect &&
-    printf "$ttt$ttt$ttt$sss" | git stripspace >actual &&
-    test_cmp expect actual
+	printf "$ttt$ttt$ttt\n" >expect &&
+	printf "$ttt$ttt$ttt$sss" | git stripspace >actual &&
+	test_cmp expect actual
 '
 
-test_expect_success \
-    'text plus spaces at end should not show spaces' '
-    ! (echo "$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (echo "$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (echo "$ttt$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (echo "$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (echo "$ttt$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
-    ! (echo "$ttt$sss$sss$sss" | git stripspace | grep "  " >/dev/null)
+test_expect_success 'text plus spaces at end should not show spaces' '
+	! (echo "$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
+	! (echo "$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
+	! (echo "$ttt$ttt$ttt$sss" | git stripspace | grep "  " >/dev/null) &&
+	! (echo "$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
+	! (echo "$ttt$ttt$sss$sss" | git stripspace | grep "  " >/dev/null) &&
+	! (echo "$ttt$sss$sss$sss" | git stripspace | grep "  " >/dev/null)
 '
 
-test_expect_success \
-    'text plus spaces at end should be cleaned and newline must remain' '
-    echo "$ttt" >expect &&
-    echo "$ttt$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+test_expect_success 'text plus spaces at end should be cleaned and newline must remain' '
+	echo "$ttt" >expect &&
+	echo "$ttt$sss" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    echo "$ttt" >expect &&
-    echo "$ttt$sss$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+	echo "$ttt" >expect &&
+	echo "$ttt$sss$sss" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    echo "$ttt" >expect &&
-    echo "$ttt$sss$sss$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+	echo "$ttt" >expect &&
+	echo "$ttt$sss$sss$sss" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    echo "$ttt$ttt" >expect &&
-    echo "$ttt$ttt$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+	echo "$ttt$ttt" >expect &&
+	echo "$ttt$ttt$sss" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    echo "$ttt$ttt" >expect &&
-    echo "$ttt$ttt$sss$sss" | git stripspace >actual &&
-    test_cmp expect actual &&
+	echo "$ttt$ttt" >expect &&
+	echo "$ttt$ttt$sss$sss" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    echo "$ttt$ttt$ttt" >expect &&
-    echo "$ttt$ttt$ttt$sss" | git stripspace >actual &&
-    test_cmp expect actual
+	echo "$ttt$ttt$ttt" >expect &&
+	echo "$ttt$ttt$ttt$sss" | git stripspace >actual &&
+	test_cmp expect actual
 '
 
 # spaces only:
 
-test_expect_success \
-    'spaces with newline at end should be replaced with empty string' '
-    echo | git stripspace >actual &&
-    test_must_be_empty actual &&
+test_expect_success 'spaces with newline at end should be replaced with empty string' '
+	echo | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    echo "$sss" | git stripspace >actual &&
-    test_must_be_empty actual &&
+	echo "$sss" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    echo "$sss$sss" | git stripspace >actual &&
-    test_must_be_empty actual &&
+	echo "$sss$sss" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    echo "$sss$sss$sss" | git stripspace >actual &&
-    test_must_be_empty actual &&
+	echo "$sss$sss$sss" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    echo "$sss$sss$sss$sss" | git stripspace >actual &&
-    test_must_be_empty actual
+	echo "$sss$sss$sss$sss" | git stripspace >actual &&
+	test_must_be_empty actual
 '
 
-test_expect_success \
-    'spaces without newline at end should not show spaces' '
-    ! (printf "" | git stripspace | grep " " >/dev/null) &&
-    ! (printf "$sss" | git stripspace | grep " " >/dev/null) &&
-    ! (printf "$sss$sss" | git stripspace | grep " " >/dev/null) &&
-    ! (printf "$sss$sss$sss" | git stripspace | grep " " >/dev/null) &&
-    ! (printf "$sss$sss$sss$sss" | git stripspace | grep " " >/dev/null)
+test_expect_success 'spaces without newline at end should not show spaces' '
+	! (printf "" | git stripspace | grep " " >/dev/null) &&
+	! (printf "$sss" | git stripspace | grep " " >/dev/null) &&
+	! (printf "$sss$sss" | git stripspace | grep " " >/dev/null) &&
+	! (printf "$sss$sss$sss" | git stripspace | grep " " >/dev/null) &&
+	! (printf "$sss$sss$sss$sss" | git stripspace | grep " " >/dev/null)
 '
 
-test_expect_success \
-    'spaces without newline at end should be replaced with empty string' '
-    printf "" | git stripspace >actual &&
-    test_must_be_empty actual &&
+test_expect_success 'spaces without newline at end should be replaced with empty string' '
+	printf "" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    printf "$sss$sss" | git stripspace >actual &&
-    test_must_be_empty actual &&
+	printf "$sss$sss" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    printf "$sss$sss$sss" | git stripspace >actual &&
-    test_must_be_empty actual &&
+	printf "$sss$sss$sss" | git stripspace >actual &&
+	test_must_be_empty actual &&
 
-    printf "$sss$sss$sss$sss" | git stripspace >actual &&
-    test_must_be_empty actual
+	printf "$sss$sss$sss$sss" | git stripspace >actual &&
+	test_must_be_empty actual
 '
 
-test_expect_success \
-    'consecutive text lines should be unchanged' '
-    printf "$ttt$ttt\n$ttt\n" >expect &&
-    printf "$ttt$ttt\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+test_expect_success 'consecutive text lines should be unchanged' '
+	printf "$ttt$ttt\n$ttt\n" >expect &&
+	printf "$ttt$ttt\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n$ttt$ttt\n$ttt\n" >expect &&
-    printf "$ttt\n$ttt$ttt\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n$ttt$ttt\n$ttt\n" >expect &&
+	printf "$ttt\n$ttt$ttt\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n$ttt\n$ttt\n$ttt$ttt\n" >expect &&
-    printf "$ttt\n$ttt\n$ttt\n$ttt$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n$ttt\n$ttt\n$ttt$ttt\n" >expect &&
+	printf "$ttt\n$ttt\n$ttt\n$ttt$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n$ttt\n\n$ttt$ttt\n$ttt\n" >expect &&
-    printf "$ttt\n$ttt\n\n$ttt$ttt\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt\n$ttt\n\n$ttt$ttt\n$ttt\n" >expect &&
+	printf "$ttt\n$ttt\n\n$ttt$ttt\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt$ttt\n\n$ttt\n$ttt$ttt\n" >expect &&
-    printf "$ttt$ttt\n\n$ttt\n$ttt$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual &&
+	printf "$ttt$ttt\n\n$ttt\n$ttt$ttt\n" >expect &&
+	printf "$ttt$ttt\n\n$ttt\n$ttt$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual &&
 
-    printf "$ttt\n$ttt$ttt\n\n$ttt\n" >expect &&
-    printf "$ttt\n$ttt$ttt\n\n$ttt\n" | git stripspace >actual &&
-    test_cmp expect actual
+	printf "$ttt\n$ttt$ttt\n\n$ttt\n" >expect &&
+	printf "$ttt\n$ttt$ttt\n\n$ttt\n" | git stripspace >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'strip comments, too' '
-- 
2.19.0.444.g18242da7ef-goog

