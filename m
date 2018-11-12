Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8774D1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 20:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbeKMGtq (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 01:49:46 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:34741 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeKMGtq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 01:49:46 -0500
Received: by mail-pl1-f182.google.com with SMTP id f12-v6so4895626plo.1
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 12:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DXyeagzwbzMkdNVT1T4Af9l9G2T2jSJ+t1d36Dw5+QU=;
        b=RA+VOfebwVohjHtT846/wMa00DKkXy2LXb8ZQy/lel5F+1IJXRMte1gZPUDDZNjA1T
         uU5jTWbe6cw9Vt4YKnFuK6wNajCKqjgyWTcrvMznW7NSUe+s6IlNWV5/FvQuYHwrEpGR
         PbbL9hd8m6DxwdZwuvowqVlE6BcVjvZ5ocVgIf7toecgbeLVjAdcrqu3PDuvF2KL5l02
         gKl8GS4wZDWGHLGXcolVOxlaHIPlEHQRN/LhB4aYma8eQq08MtyjpMCQXC6xSgYKrWRP
         TGiJpfPrYJuT/U7mHaGlZn2Wp1LjCmSXgZRiaaQNqxqtcR6+UA07PRZY43LswmoRYBzl
         0GLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DXyeagzwbzMkdNVT1T4Af9l9G2T2jSJ+t1d36Dw5+QU=;
        b=Iya7i/+9j2Oi1YBK0R00P6ATzTXjRVeggchBZRXdETiyDtXLwwhlTcOL3I0lFkt3k/
         R5lkOIpLmvBVVQiXrXBwFeNUY6U6TfMH2LeOD3546XK12m79seQiA/u129J9cBPfwZ9h
         0oHZStz3uc62s6DGNbLu9WDiF7EV097UFULjvSK34iYNQjNd/ydBPMrJRz1fDp2butQj
         mFJv1JSqF/6GvTJvchsXkyjxbKhuEv4QjFDwTxS53SpSSySkWl2mLxzwOYZoYcBC8ppp
         WefYvhOFy5Ty9zazgJqlW6MeaG90kv7zmDESvuGjf33rz6fI+FaFbzKgp75h0nwjcLR7
         Fxzg==
X-Gm-Message-State: AGRZ1gLmmo0YqSZJl5AxTbH+7OS9aMfp1VFzkszDg1JZ31FLcDwHztL3
        ETvJxEXTOr8YyVG7s9/XM8dnvQVu
X-Google-Smtp-Source: AJdET5fIEG67irdXTiUy3PSOeVjgEj7m9yyH4q8nMz7PgcjP484o3CNwr/jXDjS6iWagI5yCH+fXVQ==
X-Received: by 2002:a17:902:a987:: with SMTP id bh7-v6mr2309369plb.46.1542056089784;
        Mon, 12 Nov 2018 12:54:49 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id w10sm8972400pgi.81.2018.11.12.12.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 12:54:49 -0800 (PST)
Date:   Mon, 12 Nov 2018 12:54:49 -0800 (PST)
X-Google-Original-Date: Mon, 12 Nov 2018 20:54:45 GMT
Message-Id: <dffe2e1144e4a3533f67784abd36671b078105d3.1542056085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.74.git.gitgitgadget@gmail.com>
References: <pull.74.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] apply --recount: allow "no-op hunks"
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

When editing patches e.g. in `git add -e`, it is quite common that a
hunk ends up having no -/+ lines, i.e. it is now supposed to do nothing.

This use case was broken by ad6e8ed37bc1 (apply: reject a hunk that does
not do anything, 2015-06-01) with the good intention of catching a very
real, different issue in hand-edited patches.

So let's use the `--recount` option as the tell-tale whether the user
would actually be okay with no-op hunks.

Add a test case to make sure that this use case does not regress again.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 apply.c                |  2 +-
 t/t4136-apply-check.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index 073d5f0451..76955afb00 100644
--- a/apply.c
+++ b/apply.c
@@ -1748,7 +1748,7 @@ static int parse_fragment(struct apply_state *state,
 	}
 	if (oldlines || newlines)
 		return -1;
-	if (!deleted && !added)
+	if (!patch->recount && !deleted && !added)
 		return -1;
 
 	fragment->leading = leading;
diff --git a/t/t4136-apply-check.sh b/t/t4136-apply-check.sh
index 6d92872318..4c3f264a63 100755
--- a/t/t4136-apply-check.sh
+++ b/t/t4136-apply-check.sh
@@ -29,6 +29,18 @@ test_expect_success 'apply exits non-zero with no-op patch' '
 	test_must_fail git apply --check input
 '
 
+test_expect_success '`apply --recount` allows no-op patch' '
+	echo 1 >1 &&
+	git apply --recount --check <<-\EOF
+	diff --get a/1 b/1
+	index 6696ea4..606eddd 100644
+	--- a/1
+	+++ b/1
+	@@ -1,1 +1,1 @@
+	 1
+	EOF
+'
+
 test_expect_success 'invalid combination: create and copy' '
 	test_must_fail git apply --check - <<-\EOF
 	diff --git a/1 b/2
-- 
gitgitgadget
