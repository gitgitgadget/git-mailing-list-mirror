Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 691861F453
	for <e@80x24.org>; Wed,  7 Nov 2018 14:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbeKGXbW (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 18:31:22 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33795 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbeKGXbW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 18:31:22 -0500
Received: by mail-pg1-f195.google.com with SMTP id k1-v6so7372002pgq.1
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 06:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3n37fdwQJY2PTiBX4BBFgZdZfHKUVkXknVo2L4enXIM=;
        b=brM16oO/MAtv9kcPSBrlzdvOsnVym+ZZ1wJr+8Kup6mHUFiCxgM/s5ss9uIVj8Ggqt
         sFrFhMau09rnwX7v7zpLD2mmkrMF2IosfXiZaOQ47mgn/Dl+C1QqGSZd1M1FPwCtGlIm
         2k9gZZE46i5iqWpHNpGpDyaF9fxP3+QB72X8GDCNMEcJMgzqTxUd/sVaqNVyQaJq/kKZ
         5P5aKA3Wx6zJalE+VboolzSx3vK+tG7H4+N+NKgHBJH7v6SCprSSt4dWysmd7YFwjDGa
         sHh2wZHMQG/2A7bMRYf7xOEvfakTV8wNvmtiHsH702deKlQM8kMYowCwk65MjrOiy5ga
         HaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3n37fdwQJY2PTiBX4BBFgZdZfHKUVkXknVo2L4enXIM=;
        b=EMH7mf9oCbha7RPvPpK3g+k7zEHU3C19nNM451C0J/blA+DV8RVcslxYUEZ11F8Ipd
         qUMCF00qTYo0PP00k6WDvQZOtV2nArgTSpfAfbUKE3D+RRs+zOUq49gO3h2cSuA9p/sy
         DjhDz+OKjJyiEovAef8BAri6ma+baRfNTqwPPzg+tZKO/oaBkhK2FUtpZt7GaeazOXje
         9DdtsaISbs4i5bUo8ClthHchr+cpwVOXsly6h0W5bR1X0WMF6s0t0y4OfAqVSwuDgM2h
         AjQbsco7e8I366tx0W9mxPwuDd2LdgxUCNJw9ie7gmR2JlUE/IqVlTziOFT8HoSGmws0
         MGCQ==
X-Gm-Message-State: AGRZ1gLx0J9s9j0CrjvqNXMKHcllwQbONRXUnInBhhOY2AjKFevZ3AMk
        HkKLSG+1aJ5i2Ero0m7lUF/yqdkGdhA=
X-Google-Smtp-Source: AJdET5eGf7CoAUc9/QCF+Fn9l9qQHgF2lYCDEEqVwF3rBaNxJ1C+Pq+xDDSJjY02QUB3lZs8OW39Vw==
X-Received: by 2002:a63:585c:: with SMTP id i28mr285112pgm.178.1541599250614;
        Wed, 07 Nov 2018 06:00:50 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id e70-v6sm722313pfb.113.2018.11.07.06.00.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 06:00:50 -0800 (PST)
Date:   Wed, 07 Nov 2018 06:00:50 -0800 (PST)
X-Google-Original-Date: Wed, 07 Nov 2018 14:00:45 GMT
Message-Id: <a2f0b53db269e9a6d7c29b665c9be53bd2f30e42.1541599246.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.70.git.gitgitgadget@gmail.com>
References: <pull.70.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 2/2] built-in rebase --autostash: leave the current branch
 alone if possible
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     AEvar <avarab@gmail.com>, Pratik Karki <predatoramigo@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When we converted a `git reset --hard` call in the original Unix shell
script to built-in code, we asked to reset the worktree and the index
and explicitly *not* to detach the HEAD. By mistake, though, we still
did. Let's fix this.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c            | 3 ++-
 t/t3420-rebase-autostash.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0ee06aa363..4a608d0a78 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -613,7 +613,8 @@ static int reset_head(struct object_id *oid, const char *action,
 		reflog_head = msg.buf;
 	}
 	if (!switch_to_branch)
-		ret = update_ref(reflog_head, "HEAD", oid, orig, REF_NO_DEREF,
+		ret = update_ref(reflog_head, "HEAD", oid, orig,
+				 detach_head ? REF_NO_DEREF : 0,
 				 UPDATE_REFS_MSG_ON_ERR);
 	else {
 		ret = create_symref("HEAD", switch_to_branch, msg.buf);
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index d4e2520bcb..4c7494cc8f 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -361,7 +361,7 @@ test_expect_success 'autostash with dirty submodules' '
 	git rebase -i --autostash HEAD
 '
 
-test_expect_failure 'branch is left alone when possible' '
+test_expect_success 'branch is left alone when possible' '
 	git checkout -b unchanged-branch &&
 	echo changed >file0 &&
 	git rebase --autostash unchanged-branch &&
-- 
gitgitgadget
