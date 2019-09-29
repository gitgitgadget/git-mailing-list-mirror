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
	by dcvr.yhbt.net (Postfix) with ESMTP id 464001F464
	for <e@80x24.org>; Sun, 29 Sep 2019 01:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfI2BaX (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Sep 2019 21:30:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38101 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfI2BaX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Sep 2019 21:30:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id u28so4511758lfc.5
        for <git@vger.kernel.org>; Sat, 28 Sep 2019 18:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eisXpCs5vDyv2GrHuvnIZC0xLGr6UB0SyOoUQGKxwNo=;
        b=H+hQsNU4Hej3xse3k/WwtH6mL3YkZKRnOARvpAKHTEjGcBptuxn05S6tZX5cx1MxQw
         qy3XySLBDvOn8kEzC0xCnGUBEffzrw/TkevmImGbp+Xz3pjjwiTENNHra8NUR2/TsmMr
         JgjTT2od19lsLP6X5dD9b48HFs9y5t6EebUYz8JO3s0KjVdUcmPqQqUgVwZYRy2QU1nR
         a+pl2f8rRa09yfIiUHocee2079ay/il7Gqx1kOSYChl7gKxCV9IU0TOT5qqTK1oEnbFG
         IY71vuN48zVrjZLdiUUliwhvZEMFne5f3jhTsMobu7mvAJPTh9YPzEXxJc//vp0Z0WZs
         fuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eisXpCs5vDyv2GrHuvnIZC0xLGr6UB0SyOoUQGKxwNo=;
        b=qnQ57ynQlmiWtLFuQmdypOxRtyKCIskOlu1TkCVGarRkomCW+4mS9ZgNo7lkmU4bHM
         epbWU/9fnk13WcIlzfVFsiNplzI0r1misdzGusyi0OQOC3zwKhD46l1HqBRFQbWyiV3d
         2i12ZgEePPXBbjdwx2PPBcSOULLlC0coYBcJI/OzIpm/p3tLxsN0Cs/iN6NllJeb4gyA
         8iAupmh0iXRdTgipdStqLCpcxuFhrf56Sdhi7u1me6dD0mlDGNr/tFz6YyiMO7qJpbVw
         Rnp0+5jOjxvnfuMGS2Le9Lw5mB5c+v1ob45mwCNSs4JgM6RStEOeAic9beA36Hqa3foC
         Q1XQ==
X-Gm-Message-State: APjAAAXu35OmE6EylHoWo5Nlld9mXU/GiMXQQtrFRFa9+CloSs6J6EFv
        I+OqtBJSMcTCHkuP6pAvZWOBqI/j
X-Google-Smtp-Source: APXvYqy2pt67VjDRtFqRGMg46kWSOZkdnfKOVCECI//In0yYuryxzq164EKOyx6An950z+Cpci2egg==
X-Received: by 2002:ac2:4a8f:: with SMTP id l15mr7334157lfp.21.1569720619579;
        Sat, 28 Sep 2019 18:30:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d28sm1664716lfq.88.2019.09.28.18.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Sep 2019 18:30:19 -0700 (PDT)
Date:   Sat, 28 Sep 2019 18:30:19 -0700 (PDT)
X-Google-Original-Date: Sun, 29 Sep 2019 01:30:16 GMT
Message-Id: <a9c590689931ebc49e91c56d8a095f66193801c2.1569720616.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.349.v2.git.gitgitgadget@gmail.com>
References: <pull.349.git.gitgitgadget@gmail.com>
        <pull.349.v2.git.gitgitgadget@gmail.com>
From:   "Kunal Tyagi via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] git-add--interactive.perl: Add progress counter in the
 prompt
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Kunal Tyagi <tyagi.kunal@live.com>,
        Junio C Hamano <gitster@pobox.com>,
        Kunal Tyagi <tyagi.kunal@live.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kunal Tyagi <tyagi.kunal@live.com>

Adds a feedback regarding how many hunks from the current file have been
processed and total number of hunks
Also included: changes to the test script due to change in expected
output string

Change in UI: displays '(${current-hunk-id} + 1/${total-hunks-in-file})' before
displaying the current prompt during user interaction

Signed-off-by: Kunal Tyagi <tyagi.kunal@live.com>
---
 git-add--interactive.perl  | 2 +-
 t/t3701-add-interactive.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index c20ae9e210..51c30e08cb 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1541,7 +1541,7 @@ sub patch_update_file {
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
-		print colored $prompt_color,
+		print colored $prompt_color,"(". ($ix+1) ."/$num) ",
 			sprintf(__($patch_update_prompt_modes{$patch_mode}{$hunk[$ix]{TYPE}}), $other);
 
 		my $line = prompt_single_character;
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 69991a3168..3a2d9fb607 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -314,7 +314,7 @@ test_expect_success C_LOCALE_OUTPUT 'add first line works' '
 	git commit -am "clear local changes" &&
 	git apply patch &&
 	printf "%s\n" s y y | git add -p file 2>error |
-		sed -n -e "s/^Stage this hunk[^@]*\(@@ .*\)/\1/" \
+		sed -n -e "s/^(.*) Stage this hunk[^@]*\(@@ .*\)/\1/" \
 		       -e "/^[-+@ \\\\]"/p  >output &&
 	test_must_be_empty error &&
 	git diff --cached >diff &&
-- 
gitgitgadget
