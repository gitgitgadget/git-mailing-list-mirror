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
	by dcvr.yhbt.net (Postfix) with ESMTP id 79A171F463
	for <e@80x24.org>; Mon, 23 Sep 2019 07:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393482AbfIWH05 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 03:26:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37891 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393460AbfIWH05 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 03:26:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id 3so7993859wmi.3
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 00:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BQSwWHGsdf3U7XGa9SXJERdXPVpznw03WNDigUiYQO0=;
        b=eZatoxRmNGdZZmBYMKZc7+ZhSg6XhMN62xuD7oOH4+Oa6gD4BlO+OOot5ARp/W7L29
         YegmJY0vDOvkyAbDbK/pfxVWIZ5ZvcrrTpoEPKA2fN1vCjuYXTBbiPV3wyUoaN4KCOoV
         5siDVX1etipGuRy/zT2CjrtaVUrhqEvPQXw/Y7HwxND1+c3prUk98iVq+7243ETOm0eA
         Foc1FnBpR4uW91Ni79avG8eehUvVBn1FdyR2Qjy07JGNrQEH6jP1gcHtoUIbQSw4sNLt
         M/ENcsmBHiTRaU60SF5BF5cOc43WWFNChHxr02vKZohEjyFZm7fBjLHlVTcqlqkxVm1v
         IBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BQSwWHGsdf3U7XGa9SXJERdXPVpznw03WNDigUiYQO0=;
        b=Az3eFhYL2GTuYze2QVWD80m+382x6bwSIIGmVnE971d6LAsSr1j0yisMobdtbiJxzR
         zBe+ayOKs7usulkjc/ngkpLr+JbH0+L4I6E/APB6sZAnn3ch0WnuraFfXiHeNw9cW6ZJ
         PgLiPi9XyJb9zomGOY3ammOl0GUsAEuvXpFPF43RqtbwFgCIrNdAAekqKWZJZu7WNEg5
         87VCGRqRaV6MK4OXv0Crm77KxRQy6GCnx2V0B/YU46FYBhfeMtXVzv3/mBe+PihAL/Ug
         xsO3B7JYZNQo4//7OAjoc7kh/fWtu9W9cRA9DitCwSs/h2SWKZhp2LknOfBaQHKvoUKs
         dppA==
X-Gm-Message-State: APjAAAVTUTBnS52uKYYLkLbPKbJBmotELtkHdmX8KhpH16VjYlbq4eB3
        GtXBPymXY2areNLCqY8sxlIBN29I
X-Google-Smtp-Source: APXvYqx1nNNSwPrdtBJaT28BisxlrUdxzJnVa/mQR41tPGFgwqAREer/hzImeDf6VeDtQGjZN1JU7Q==
X-Received: by 2002:a7b:c35a:: with SMTP id l26mr951732wmj.81.1569223614800;
        Mon, 23 Sep 2019 00:26:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2sm8637384wrm.3.2019.09.23.00.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 00:26:54 -0700 (PDT)
Date:   Mon, 23 Sep 2019 00:26:54 -0700 (PDT)
X-Google-Original-Date: Mon, 23 Sep 2019 07:26:52 GMT
Message-Id: <8edf23f816dc0546fb3b5812573d7a759184206b.1569223612.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.349.git.gitgitgadget@gmail.com>
References: <pull.349.git.gitgitgadget@gmail.com>
From:   "Kunal Tyagi via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] git-add--interactive.perl: Add progress counter in the
 prompt
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kunal Tyagi <tyagi.kunal@live.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kunal Tyagi <tyagi.kunal@live.com>

Signed-off-by: Kunal Tyagi <tyagi.kunal@live.com>
---
 git-add--interactive.perl  | 2 +-
 t/t3701-add-interactive.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index c20ae9e210..3951c25a28 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1541,7 +1541,7 @@ sub patch_update_file {
 		for (@{$hunk[$ix]{DISPLAY}}) {
 			print;
 		}
-		print colored $prompt_color,
+		print colored $prompt_color,"(", $ix+1, "/$num) ",
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
