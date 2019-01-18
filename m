Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 611BB1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 07:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbfARHrO (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 02:47:14 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37714 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbfARHrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 02:47:09 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so10419451edb.4
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 23:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=j+7JffoxNBIVZ3QpeyLd0isG5DGXw98QOCaM9TGCpzo=;
        b=t8cyPbP+Rc4EjIqgInvD8e0fMlIZk+bJ8iTMydA+TyJwmBCfO/Ob77qC169NDxoj5v
         xpidha/CwQKdLozQu7hLxzm1t86c1ta9UB/R2RwfFuD/vrEEk5t5TXk2Pb75Vqlo9q2p
         EzuALh6wIEwSgmF3of6Ah+hsYnj+13eNdrIiRsgj/vYNVV67ESpe24QLyk9bxSiq8y7W
         n/ifCQCHDHUPOmBCqufRi765CLdn+wr6SIACT2FEAaJLEHlEH4VI4In8l3K9SksxB33g
         ZsN/SMbQZVCcql9HzwFdLEaRdjDsRv8TkN99P7InQfelW8+69lJCLC2ctjBqTgXaIbqX
         M+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=j+7JffoxNBIVZ3QpeyLd0isG5DGXw98QOCaM9TGCpzo=;
        b=Z59WTz11o4g2pGKiRt+eZ5fa1sDmh9fO5dW5pfXNPtVVhA3RvtXE+jFvWnvxuxMagH
         5M+el5PSLUcdIuwEKqB/0QiTpO6Nej9/3pC7c9uJzrZgoJ74Sc9OMpygpj4wtEOXqZz4
         x1uvpgME/HLKbEWoXVug5Mpdv5SxklBK1odoZc5hdes8TG71yAoPLy+Dpf6FCR0OukcC
         M7IInH1IIrWgqiRbYvYTEi/bsj+9wAB3QruqQieIgWcwytkq1Qu9NEQlBEjwrbBkyU9c
         4YS/oCzBDtOd7+JESRYlo8KUOk+KPvUpq+rgY7ZqN4H7qdBFqEscdX2vOjvSDeLuirJM
         aObg==
X-Gm-Message-State: AJcUukcdU1M3DtQsrkT4TjCDRCsvU2YG1FGOMbWT2HmrRyU0EbhgYhvN
        LpP6YmiqElV6JkijDzBcSsiDVARI
X-Google-Smtp-Source: ALg8bN7bkvqgN7FkJCS0A6tLu3Oj1lEahBpFCxHOSzUOf8lxni4ffV3qNa3pTdRHpqKpmrypn5GM+w==
X-Received: by 2002:a17:906:6b99:: with SMTP id l25-v6mr13708188ejr.154.1547797627726;
        Thu, 17 Jan 2019 23:47:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p22-v6sm3863141ejf.48.2019.01.17.23.47.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 23:47:06 -0800 (PST)
Date:   Thu, 17 Jan 2019 23:47:06 -0800 (PST)
X-Google-Original-Date: Fri, 18 Jan 2019 07:46:59 GMT
Message-Id: <2b4714b8d04f98a6d35f3f4f15881406fa87c320.1547797620.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v2.git.gitgitgadget@gmail.com>
References: <pull.103.git.gitgitgadget@gmail.com>
        <pull.103.v2.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 6/7] t3701-add-interactive: test add_i_show_help()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Slavica Djukic <slawica92@hotmail.com>

Add test to t3701-add-interactive to verify that add_i_show_help()
outputs expected content.
Also, add it before changing git-add--interactive.perl's help_cmd
to demonstrate that there are no changes introduced by the
conversion to C.
Prefix git add -i call with GIT_PAGER_IN_USE=true TERM=vt100
to force colored output on Windows.

Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 t/t3701-add-interactive.sh | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 65dfbc033a..14e3286995 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -639,4 +639,28 @@ test_expect_success 'add -p patch editing works with pathological context lines'
 	test_cmp expected-2 actual
 '
 
+test_expect_success 'show help from add--helper' '
+	git reset --hard &&
+	cat >expect <<-\EOF &&
+
+	<BOLD>*** Commands ***<RESET>
+	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
+	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
+	<BOLD;BLUE>What now<RESET>> <BOLD;RED>status        - show paths with changes<RESET>
+	<BOLD;RED>update        - add working tree state to the staged set of changes<RESET>
+	<BOLD;RED>revert        - revert staged set of changes back to the HEAD version<RESET>
+	<BOLD;RED>patch         - pick hunks and update selectively<RESET>
+	<BOLD;RED>diff          - view diff between HEAD and index<RESET>
+	<BOLD;RED>add untracked - add contents of untracked files to the staged set of changes<RESET>
+	<BOLD>*** Commands ***<RESET>
+	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
+	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
+	<BOLD;BLUE>What now<RESET>> 
+	Bye.
+	EOF
+	test_write_lines h | GIT_PAGER_IN_USE=true TERM=vt100 git add -i >actual.colored &&
+	test_decode_color <actual.colored >actual &&
+	test_i18ncmp expect actual
+'
+
 test_done
-- 
gitgitgadget

