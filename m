Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81D061F404
	for <e@80x24.org>; Fri, 31 Aug 2018 23:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbeIADyx (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 23:54:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41359 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbeIADyx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 23:54:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id h79-v6so6173950pfk.8
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 16:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NaTpj6bMr3uUPYu7GJ9N9O7tcmpf0XenmwfvifIOVqk=;
        b=P5UnX5vfM3e51wqlblbX1BbRwLWk6LsnHNNsmEr0O+QH7sl9st7RTiYP4JpMaIMC/c
         ywRX+gQOBAdfWyNDdmarleNtZIw2ScstdH0YnK7kwGeIoj++OpUtrOQqJHVQmRSsSczz
         4E008iQKhbFiMyZVcpTB//squ+LojIxx7igfOq2eOU1K7m09D8ZNypcpvT2ai8UPAUkf
         YNhPtXARI+dJ3OtEtYqlXWaTmEScYclff6u59BXFvgDz6XeMTbXFVtG7gshAmRYvW/H/
         yUddiBnE0UBiK8q2iRn6cqcDfq0+RyID+Rx72//oD45yTbzEZW9eJmMNd2a/L+b1NY0D
         4+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NaTpj6bMr3uUPYu7GJ9N9O7tcmpf0XenmwfvifIOVqk=;
        b=La+v0Hpc3Gfoml+AL2XnxxwEBWWs3Gphb6TyWW8gMLLH+iw7MnI07NDVnOlU0Udfqu
         2R6HGGsXi4PdTv+Dfv0qC8CdDH0oFtp5UeRYyhacljyG/CXGLnk5pBywQ6memN1lnVf9
         qG1yzTp28FwOZGskeIKwa2tEs1B7Ddhaj58x4N6FojAG4ML7BagO6eOjH8iAzmDk5XFz
         RFwh/rWxaKa9914KmZv32qAgGdEgyHgILDM/RMjpfPLGr1icJ0pmjumyVYUNFGTrKvME
         M1sFOV0uNLN7cUKx3nfeAcwzhj4lYU4jhIc5e19Mf6/FDEWq7MJT4q0OKlKF/RmhFY5o
         rvBw==
X-Gm-Message-State: APzg51DQn6FG2tqvyaMsa28aNVM8nBxcD1EcYU5zLnyxOqJJcSSgYhZK
        cA3SuKSEGXHsWJzL/0GRyQX3lxty
X-Google-Smtp-Source: ANB0VdZf2XsAk6M47dxi2mY8ISXiapSyMqdzmbrE/xTT8NvLQbjb4E1kubIN2i6wOOobupD6hOnZCw==
X-Received: by 2002:a63:7557:: with SMTP id f23-v6mr1748056pgn.135.1535759103443;
        Fri, 31 Aug 2018 16:45:03 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id 8-v6sm12394963pgu.10.2018.08.31.16.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:45:02 -0700 (PDT)
Date:   Fri, 31 Aug 2018 16:45:02 -0700 (PDT)
X-Google-Original-Date: Fri, 31 Aug 2018 23:44:58 GMT
Message-Id: <8753c4e5fba5bb9cc42fdf438f4a69e702261a15.1535759099.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.30.git.gitgitgadget@gmail.com>
References: <pull.30.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] rebase -i --autosquash: demonstrate a problem skipping
 the last squash
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

The `git commit --squash` command can be used not only to amend commit
messages and changes, but also to record notes for an upcoming rebase.

For example, when the author information of a given commit is incorrect,
a user might call `git commit --allow-empty -m "Fix author" --squash
<commit>`, to remind them to fix that during the rebase. When the editor
would pop up, the user would simply delete the commit message to abort
the rebase at this stage, fix the author information, and continue with
`git rebase --skip`. (This is a real-world example from the rebase of
Git for Windows onto v2.19.0-rc1.)

However, there is a bug in `git rebase` that will cause the squash
message *not* to be forgotten in this case. It will therefore be reused
in the next fixup/squash chain (if any).

This patch adds a test case to demonstrate this breakage.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3415-rebase-autosquash.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index e364c12622..7d5ea340b3 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -330,4 +330,23 @@ test_expect_success 'wrapped original subject' '
 	test $base = $parent
 '
 
+test_expect_failure 'abort last squash' '
+	test_when_finished "test_might_fail git rebase --abort" &&
+	test_when_finished "git checkout master" &&
+
+	git checkout -b some-squashes &&
+	git commit --allow-empty -m first &&
+	git commit --allow-empty --squash HEAD &&
+	git commit --allow-empty -m second &&
+	git commit --allow-empty --squash HEAD &&
+
+	test_must_fail git -c core.editor="grep -q ^pick" \
+		rebase -ki --autosquash HEAD~4 &&
+	: do not finish the squash, but resolve it manually &&
+	git commit --allow-empty --amend -m edited-first &&
+	git rebase --skip &&
+	git show >actual &&
+	! grep first actual
+'
+
 test_done
-- 
gitgitgadget

