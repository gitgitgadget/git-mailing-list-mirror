Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8186F1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 20:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbeKUGcy (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 01:32:54 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44801 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbeKUGcy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 01:32:54 -0500
Received: by mail-pl1-f196.google.com with SMTP id s5-v6so1855160plq.11
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 12:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=A1e/z5cXv9Q+fTzL2WnPwToSHg1vBg9eJeILFPlqKdM=;
        b=ty0u4+wxrUrF4gSZMqGaLZvX5ZUQZfAvJbd86SO69gRb8I5N2erl9g1P6NBRW44CSN
         uQ97Jbni28ojOfGptSwHb2EnJ12juSeLSzaLwoPHLphwn8ONVsOt1xFhGQytY/3J9OHK
         B0zsxXKQJ7gHyyd+RMblV0wG1wW68t8FNq2EMK4vvA8AXQOGFZToplr2yAjdSpPJFT9y
         RqsC9xiCu0ErNT8wMPYVBrEOrI4ymjeDQy63jLwrWPTWrC34NTPUhyleD4dSXJIVCsop
         KtS2FWvdrx9r1o+AjjfNNxnuJwD3ntcl0/AKs1Jwz1zwBt48Ft4DAGhYybgnklWvr9wc
         UIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A1e/z5cXv9Q+fTzL2WnPwToSHg1vBg9eJeILFPlqKdM=;
        b=c2OV2DxTP/Q3397piJ84O0kmYlVEO64QiDX24y4a/H3e2DtDGb0+BSm/tA/uAy7gvP
         0avcLxNauq6lqEp9BJGtDpiZ3ATWLD5XQGmErZ/tKTm82eccTMfSb9Qwp2UtY5HhRIkY
         Riga/M9sBgT8a4tU6xJ9OOSH50sbuLL2ymvYgXvHrnXVVpXNWfF616yXN7Vk8Kv+R+IX
         MqDbCjQqNII08y6ElUslwZ25EVYsyHe14U29mBrmYdARlgJ/w2B9XdOl4r3oLeSy54GS
         xaNNCSeLQpUxwexsC0SyYZ7AXOlnqIYhC/5HplTDs5pb0z6iKIDqQjmZW2bmEuRg+ttP
         SJUg==
X-Gm-Message-State: AA+aEWZSM5WcsHSDrE7mIKiiF5trt7jPgXCCjysMbVBjKwBIe9872yTr
        L5Qr19bDIH6n4rTYRX++vV3HExWE
X-Google-Smtp-Source: AFSGD/W3LIgeRNiPLSziaqqZjWFZQoE2iNW+fSCZakHrr2+2Aiw4ROdD22HnFRvQlpRTIuSAEHF+wg==
X-Received: by 2002:a17:902:b60a:: with SMTP id b10mr3401117pls.303.1542744121924;
        Tue, 20 Nov 2018 12:02:01 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id q1sm26681801pfb.96.2018.11.20.12.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 12:02:01 -0800 (PST)
Date:   Tue, 20 Nov 2018 12:02:01 -0800 (PST)
X-Google-Original-Date: Tue, 20 Nov 2018 20:01:57 GMT
Message-Id: <84e65a4efb3d58ca777cd59c52fe86d63060ea9e.1542744118.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.86.git.gitgitgadget@gmail.com>
References: <pull.86.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] legacy-rebase: backport -C<n> and --whitespace=<option>
 checks
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Since 04519d720114 (rebase: validate -C<n> and --whitespace=<mode>
parameters early, 2018-11-14), the built-in rebase validates the -C and
--whitespace arguments early. As this commit also introduced a
regression test for this, and as a later commit introduced the
GIT_TEST_REBASE_USE_BUILTIN mode to run tests, we now have a
"regression" in the scripted version of `git rebase` on our hands.

Backport the validation to fix this.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-legacy-rebase.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/git-legacy-rebase.sh b/git-legacy-rebase.sh
index 75a08b2683..ced0635326 100755
--- a/git-legacy-rebase.sh
+++ b/git-legacy-rebase.sh
@@ -337,6 +337,11 @@ do
 		fix|strip)
 			force_rebase=t
 			;;
+		warn|nowarn|error|error-all)
+			;; # okay, known whitespace option
+		*)
+			die "Invalid whitespace option: '${1%*=}'"
+			;;
 		esac
 		;;
 	--ignore-whitespace)
@@ -352,6 +357,9 @@ do
 		git_am_opt="$git_am_opt $1"
 		force_rebase=t
 		;;
+	-C*[!0-9]*)
+		die "switch \`C' expects a numerical value"
+		;;
 	-C*)
 		git_am_opt="$git_am_opt $1"
 		;;
-- 
gitgitgadget
