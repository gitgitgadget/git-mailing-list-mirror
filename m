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
	by dcvr.yhbt.net (Postfix) with ESMTP id 080EC1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 20:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbfFRUVb (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 16:21:31 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40582 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730232AbfFRUVa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 16:21:30 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so23537363eds.7
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 13:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RJ1Ti10njS9BL/HuXiX+d0N7jKi7cBIA9Od8GnBBr8I=;
        b=bfKY3FCRQ6qHW1OyA20tiqJunGpl+0FihCQOREA3mUr50OkL8n3PJ2nS9VAhezbM//
         z2Kuvxz/YM+J4KtVfsQhWsMM0CC8OYa5PSGSWP5JjCZGLi0j8rkVRukjcWbuhBxG+RN1
         c4kYBMyKeORz5ahqJfClxT3QgBrag5bGsgfwa47zJMaTCdlnQEB9glMIokizpJey/g1c
         vUNMOS9EO5kt3yqq00+y77iaqwsVYywwCQX4Uki9EA9J1jwY2ctu3Vkag2oHqsrN0f/x
         1MB+IDjY8rfJwqZ8r/nL1BKAuMQBSDNxhiMCt3WPJoGmLCwvLQE6cwPt0HNCUpHlaEaw
         +ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RJ1Ti10njS9BL/HuXiX+d0N7jKi7cBIA9Od8GnBBr8I=;
        b=FY6ZYQKwBpqmr8pU1ti9I3XPYEfTcmS9axsQl2QtGS7a+qz0sjbjpG+z1nMtg2+ION
         ohPd8TIT9fKZp+EkMkBvVuX6QaqClFZOAesAVXFSQh6U8ofnRHSJadUbzwtQATkmsFvG
         u5wsSZgz0AAxemvOKyHPG3DcSAUGERjGpIsVDDW57kNaQie6+Wl2QiIQKkk3JC3LzfIU
         PZG9gW/++5NWRYP/EFxf6C5jPVw2+QBDwmGQG7f2k9HHfcI0rEQtDpjSMucWyU8WeCTY
         uRQtjwjm9f6xoMTzUXYb6Fc3Tix21ysUeUwqTBm6bRaqvyqv1klFH667jFaOUG+wbfUF
         XL6A==
X-Gm-Message-State: APjAAAUu+dGuJraKBERglb4eoktn+A64sQw3FUVol5FogMw4oKCe7oEF
        yTYggtxY5Ychr2wSJ+V9r6a9mL+x
X-Google-Smtp-Source: APXvYqzK0zIfiUKadr5bN6lO6rwxBUXwh1GPmW2QM0gDflcIPFOLMitlpKyWENV1Xz0ToJGi+C3gYg==
X-Received: by 2002:a17:906:4694:: with SMTP id a20mr89244648ejr.67.1560889288447;
        Tue, 18 Jun 2019 13:21:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e1sm1579483ejl.2.2019.06.18.13.21.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 13:21:28 -0700 (PDT)
Date:   Tue, 18 Jun 2019 13:21:28 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 20:21:23 GMT
Message-Id: <feea3f6ef12b22364e3f9790b64484be96c48193.1560889284.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.272.git.gitgitgadget@gmail.com>
References: <pull.272.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/3] status: ignore status.aheadbehind in porcelain formats
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     git@jeffhostetler, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach porcelain V[12] formats to ignore the status.aheadbehind
config setting. They only respect the --[no-]ahead-behind
command line argument.  This is for backwards compatibility
with existing scripts.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/commit.c        | 10 ++++++----
 t/t7064-wtstatus-pv2.sh | 12 ++++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 71305073ad..79cb238d87 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1111,11 +1111,13 @@ static void finalize_deferred_config(struct wt_status *s)
 
 	/*
 	 * If the user did not give a "--[no]-ahead-behind" command
-	 * line argument, then we inherit the a/b config setting.
-	 * If is not set, then we inherit _FULL for backwards
-	 * compatibility.
+	 * line argument *AND* we will print in a human-readable format
+	 * (short, long etc.) then we inherit from the status.aheadbehind
+	 * config setting.  In all other cases (and porcelain V[12] formats
+	 * in particular), we inherit _FULL for backwards compatibility.
 	 */
-	if (s->ahead_behind_flags == AHEAD_BEHIND_UNSPECIFIED)
+	if (use_deferred_config &&
+	    s->ahead_behind_flags == AHEAD_BEHIND_UNSPECIFIED)
 		s->ahead_behind_flags = status_deferred_config.ahead_behind;
 
 	if (s->ahead_behind_flags == AHEAD_BEHIND_UNSPECIFIED)
diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index a0baf6e8b0..537787e598 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -436,10 +436,6 @@ test_expect_success 'verify --[no-]ahead-behind with V2 format' '
 		git status --no-ahead-behind --porcelain=v2 --branch --untracked-files=all >actual &&
 		test_cmp expect actual &&
 
-		# Confirmat that "status.aheadbehind" works on V2 format.
-		git -c status.aheadbehind=false status --porcelain=v2 --branch --untracked-files=all >actual &&
-		test_cmp expect actual &&
-
 		# Confirm --ahead-behind reports traditional branch.ab with 1/0.
 		cat >expect <<-EOF &&
 		# branch.oid $HUF
@@ -449,6 +445,14 @@ test_expect_success 'verify --[no-]ahead-behind with V2 format' '
 		EOF
 
 		git status --ahead-behind --porcelain=v2 --branch --untracked-files=all >actual &&
+		test_cmp expect actual &&
+
+		# Confirm that "status.aheadbehind" DOES NOT work on V2 format.
+		git -c status.aheadbehind=false status --porcelain=v2 --branch --untracked-files=all >actual &&
+		test_cmp expect actual &&
+
+		# Confirm that "status.aheadbehind" DOES NOT work on V2 format.
+		git -c status.aheadbehind=true status --porcelain=v2 --branch --untracked-files=all >actual &&
 		test_cmp expect actual
 	)
 '
-- 
gitgitgadget
