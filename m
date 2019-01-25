Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE2931F453
	for <e@80x24.org>; Fri, 25 Jan 2019 12:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbfAYMXk (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 07:23:40 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36129 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728259AbfAYMXi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 07:23:38 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so7237302edb.3
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 04:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HIgRm5vFNg//FPj2SLO3U4N+Eo2uvn6bw48MyLgAU3o=;
        b=eJ2tqAknI8rW3Mz3VZbshp8/4XQJVgn6emd6CqSLYdLYZnwLS2bt+3a4Y+gjZVU/ng
         gXWS8S9d2h5B6gBAdgLbA8strpr96BoE2xETDl0RklWWqpiUcUREKUz8khH3eYttCowM
         1ozB6j9VZzoj5tmwigMhAHM0L9RNRT1q+CeY8AuorVw58SolrcYImfrIGVesPPQZfnxe
         Ql74uF3Omz2Wc2lPTwRDJo3EoQ7pOgFfa3A32jIfOki1SGsV5N9gPOzq8d4zmoFOjOd0
         pLKNwRndSMwFU7nHWPNk3UbFczb5/lgiHZFO9GT1NJl8Tpluc/a7gkEZr4o/G9WvjFco
         trJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HIgRm5vFNg//FPj2SLO3U4N+Eo2uvn6bw48MyLgAU3o=;
        b=q0SXm7RP5d+7JEqgRAQ8eoR9O5BhagGrVLTP+b0xtKXz6BO3Ys8r6BddZ2jk/9Ekpl
         vwkT76SA4CDAAbtqcRuQqlLxBM9cLe4HdQqh1siVxMVt/22InSMJWVrfJNkflb96W/GW
         RbyC7eDxdbqhM4NBghPvLPLmPblgS6AJVRgU8dM2CyL6C4GGlnDAP09v90Q7lBUTZI97
         FVK/72XdrTP1FC3XJpToyvYApq4bGsg8hD00B36H99VXfHdhye7dCWbKfX7diKPF3P4W
         xbUjBzxLBH6sB2ADEx15ANIJm1YuKjzFcleFfqQwQOLU7eD5Kowcvz28C6oXNbKLCn/8
         J73g==
X-Gm-Message-State: AJcUukfROhSRQ8SPQzrK+330YKNsf7fKThwl2v5eFzxC0vJJSL5QMQRr
        pu4PvBVRX4KZYgdbbRnvVnqDTCy8
X-Google-Smtp-Source: ALg8bN6n1wDBWeP44NtStre2JPjFvND4B40wT9igPyc8zZAhfYC/Y80dcn3wqUXhGrKZJK0qz54l0w==
X-Received: by 2002:aa7:c703:: with SMTP id i3mr10657224edq.170.1548419016481;
        Fri, 25 Jan 2019 04:23:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k12sm826262ejz.4.2019.01.25.04.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 04:23:35 -0800 (PST)
Date:   Fri, 25 Jan 2019 04:23:35 -0800 (PST)
X-Google-Original-Date: Fri, 25 Jan 2019 12:23:28 GMT
Message-Id: <0a27304a840a88fded721259b795762e9b786530.1548419009.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v4.git.gitgitgadget@gmail.com>
References: <pull.103.v3.git.gitgitgadget@gmail.com>
        <pull.103.v4.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 6/7] t3701-add-interactive: test add_i_show_help()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
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
index 65dfbc033a..91aaef2932 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -639,4 +639,28 @@ test_expect_success 'add -p patch editing works with pathological context lines'
 	test_cmp expected-2 actual
 '
 
+test_expect_success 'show help from add--helper' '
+	git reset --hard &&
+	cat >expect <<-EOF &&
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
+	<BOLD;BLUE>What now<RESET>>$SP
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

