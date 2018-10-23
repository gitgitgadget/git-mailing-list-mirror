Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78DD21F453
	for <e@80x24.org>; Tue, 23 Oct 2018 19:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeJXEWJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 00:22:09 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40175 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeJXEWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 00:22:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id b9-v6so801942pls.7
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 12:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6MlFu7BVWmuMQlEKaizfbmEkiBCeIo1J0q/3KuWk4Ys=;
        b=JLv8HWxwgZ5hbhC5NrTF/yqCRVh+sG8xUzJ3J3IlKEQh5jMIfatL1wrheyE9k1U1NJ
         pWbHR//KyaPVfyYbP8wM5a6p5YafRte8yREQlCgEN/BhRhIrsI6dnnwFwoT7urNZ0fqx
         jsVJ6GwXY87mdaWasYV/HrBpu9etTeGVznbDSsNc5Pb0o6AGGig+qvZGjpcRvbghcca9
         jaWxsWIcsB3iTwZWl+nHHPXHDE63m/9UKHA2gltX9NsIEZjTX8nP/6D5U6JF1gln3Gt/
         0C9oDYRXOtNQReGdN6U1IVS75vRGuLLYxv3qR6J8HdLHr6y0/v1iq+/0sLcAzEKr7Af1
         97Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6MlFu7BVWmuMQlEKaizfbmEkiBCeIo1J0q/3KuWk4Ys=;
        b=iXn0j/xUFnDDQQJezsX3R75rkParYySJiXYaX3NEykNeAoNflbA3i/FUw8/kLNzxGT
         jie3JiPXXaWZe88Qh05yLSXHAlahdZ9GlRizd0yko8p+Xxj3IovqkwcIRr0jDNc3lb6x
         npfJpliYHYeDvwPDDmFUQ/dyTa18J1vusXGwrI/BYcHBX/JNucSecPlS9XaSdgMd1X/z
         V68IQfb6Wgumkg0Wgq6O26SZa5fJwpIE4Jk6eJvMljwh4ph8w3sYbTQtmd8D1ipa5JG2
         GT4253VhR4w6LKqIu2rVYUDsU4x/pa5verhuZwjIldAJHQq0WAZxCAPPhpkwsUin05p7
         oWqg==
X-Gm-Message-State: ABuFfoi+YjckoJZmhQlpxgnidX17gpSdrksILt1xIvdjHu0FFLFxLofv
        WdzHGGFPYFe+GIeMu+2cxHcXqSkm
X-Google-Smtp-Source: ACcGV62JNVh6jjMjrJQnU4tqtHrRIka7aKAtmApP4od4wnBLfcdmhhs1pHF1rKGbnmHmAbHw2iK7pg==
X-Received: by 2002:a17:902:6a8b:: with SMTP id n11-v6mr48717288plk.16.1540324637233;
        Tue, 23 Oct 2018 12:57:17 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id w63-v6sm2865372pgw.60.2018.10.23.12.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 12:57:16 -0700 (PDT)
Date:   Tue, 23 Oct 2018 12:57:16 -0700 (PDT)
X-Google-Original-Date: Tue, 23 Oct 2018 19:57:11 GMT
Message-Id: <6d9ff59733e632f69ff414baaaa084dfd461b7e1.1540324633.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.56.git.gitgitgadget@gmail.com>
References: <pull.56.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] rebase --autostash: demonstrate a problem with dirty
 submodules
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

It has been reported that dirty submodules cause problems with the
built-in rebase when it is asked to autostash. The symptom is:

	fatal: Unexpected stash response: ''

This patch adds a regression test that demonstrates that bug.

Original report: https://github.com/git-for-windows/git/issues/1820

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3420-rebase-autostash.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index 0c4eefec7..7eb9f9041 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -351,4 +351,14 @@ test_expect_success 'autostash is saved on editor failure with conflict' '
 	test_cmp expected file0
 '
 
+test_expect_failure 'autostash with dirty submodules' '
+	test_when_finished "git reset --hard && git checkout master" &&
+	git checkout -b with-submodule &&
+	git submodule add ./ sub &&
+	test_tick &&
+	git commit -m add-submodule &&
+	echo changed >sub/file0 &&
+	git rebase -i --autostash HEAD
+'
+
 test_done
-- 
gitgitgadget

