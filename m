Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3EF71F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 23:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439029AbeKWJsB (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Nov 2018 04:48:01 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39613 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439014AbeKWJr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Nov 2018 04:47:59 -0500
Received: by mail-wm1-f65.google.com with SMTP id u13-v6so10458229wmc.4
        for <git@vger.kernel.org>; Thu, 22 Nov 2018 15:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I6sHroP/Z9s8Jcx/x7oZS3PQP23KJlBVV1glp/wJeZs=;
        b=ODwBXnJQjPa6GY8crZ/CWRlvvC8C4dIRpYvsC+xBVdOfuKZrpy7YAhc9B416w+AcUo
         4Xrat/fp0cpwtn8lJHXwWtTIFZwiKKm+ApHMbbkw4Y4YRH2tAczKwmgfPoPNRk3y5pe3
         wTIpawPNXWdwaD3GLo+597meOFVWfk+MU6ZX486qhs4EoRjhwFcq9YGtkSQ43oYHplCT
         NSTRmW5hWXku8XUiyeedNgyRF67Km511dJ1A6qxruw1Zu3k2jHAcfPr5hVTQeCrnE0Ce
         aLeL70EJViEmIvB/b/w0YXX7gc7hzsvgU2WChckyeyszTtPHszVeYRjVPvnmAVe/G+sg
         NO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I6sHroP/Z9s8Jcx/x7oZS3PQP23KJlBVV1glp/wJeZs=;
        b=Za8kZ5Zus5e98nuUiWUVxPpEl4Us/+UHmt+8qqjWBxzIxiAeTt1PI1k2Tbk3/XLJhJ
         GbvONo+4vJGW5dDQlyUroafd/ZoJnCJSjsw9gHnwBlI7FuyEL/z5UxUJnObeHi2IOJ4o
         mAxjM+HqoMjbQMCX/U/uYO61jEI/NxoyouL5roaBDGl++EwzdZidQ97zq6XkjIUZzF/i
         +nKLAqiAi/S4aVZ3Nd+kffthBKlg4IOxzlebjNwekObYuoB+DmV/kzUOxBSWMfT3dWNn
         2ktAQEpUIaWcFwdNx/0RI3kLLywTo0tR1OkXkvOV51NKMsE9lPeXEka69iQ0J4kb2+5J
         S17g==
X-Gm-Message-State: AA+aEWaOVJXzNwxJFTFQqFGfM7fzfpLrkp/MPYpluVXyRybeDNLbT2le
        70yB/Z+m+53rZW1nrO+tncIRPCZP
X-Google-Smtp-Source: AJdET5dqNm9+VbcKfKM7/bfQ7WhkJLOkOV4Z/T6SLZQh5qdl1ZKcIZrEdw+8IRoxzQVQ9787at6Z7g==
X-Received: by 2002:a1c:cb4c:: with SMTP id b73mr12236932wmg.69.1542927977455;
        Thu, 22 Nov 2018 15:06:17 -0800 (PST)
Received: from localhost.localdomain ([91.250.255.197])
        by smtp.gmail.com with ESMTPSA id v5sm11099670wrr.11.2018.11.22.15.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 15:06:16 -0800 (PST)
From:   Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
To:     git@vger.kernel.org
Cc:     t.gummerer@gmail.com
Subject: [PATCH v11 06/22] stash: rename test cases to be more descriptive
Date:   Fri, 23 Nov 2018 01:05:26 +0200
Message-Id: <52becd09368bec7e24df4d837f2687012f12f190.1542925164.git.ungureanupaulsebastian@gmail.com>
X-Mailer: git-send-email 2.19.1.878.g0482332a22
In-Reply-To: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
References: <cover.1542925164.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename some test cases' labels to be more descriptive and under 80
characters per line.

Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
---
 t/t3903-stash.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 098a387a82..8b09a3d6cc 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -604,7 +604,7 @@ test_expect_success 'stash show -p - no stashes on stack, stash-like argument' '
 	test_cmp expected actual
 '
 
-test_expect_success 'stash drop - fail early if specified stash is not a stash reference' '
+test_expect_success 'drop: fail early if specified stash is not a stash ref' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD && git stash clear" &&
 	git reset --hard &&
@@ -618,7 +618,7 @@ test_expect_success 'stash drop - fail early if specified stash is not a stash r
 	git reset --hard HEAD
 '
 
-test_expect_success 'stash pop - fail early if specified stash is not a stash reference' '
+test_expect_success 'pop: fail early if specified stash is not a stash ref' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD && git stash clear" &&
 	git reset --hard &&
@@ -682,7 +682,7 @@ test_expect_success 'invalid ref of the form "n", n >= N' '
 	git stash drop
 '
 
-test_expect_success 'stash branch should not drop the stash if the branch exists' '
+test_expect_success 'branch: do not drop the stash if the branch exists' '
 	git stash clear &&
 	echo foo >file &&
 	git add file &&
@@ -693,7 +693,7 @@ test_expect_success 'stash branch should not drop the stash if the branch exists
 	git rev-parse stash@{0} --
 '
 
-test_expect_success 'stash branch should not drop the stash if the apply fails' '
+test_expect_success 'branch: should not drop the stash if the apply fails' '
 	git stash clear &&
 	git reset HEAD~1 --hard &&
 	echo foo >file &&
@@ -707,7 +707,7 @@ test_expect_success 'stash branch should not drop the stash if the apply fails'
 	git rev-parse stash@{0} --
 '
 
-test_expect_success 'stash apply shows status same as git status (relative to current directory)' '
+test_expect_success 'apply: show same status as git status (relative to ./)' '
 	git stash clear &&
 	echo 1 >subdir/subfile1 &&
 	echo 2 >subdir/subfile2 &&
@@ -1048,7 +1048,7 @@ test_expect_success 'stash push -p with pathspec shows no changes only once' '
 	test_i18ncmp expect actual
 '
 
-test_expect_success 'stash push with pathspec shows no changes when there are none' '
+test_expect_success 'push <pathspec>: show no changes when there are none' '
 	>foo &&
 	git add foo &&
 	git commit -m "tmp" &&
@@ -1058,7 +1058,7 @@ test_expect_success 'stash push with pathspec shows no changes when there are no
 	test_i18ncmp expect actual
 '
 
-test_expect_success 'stash push with pathspec not in the repository errors out' '
+test_expect_success 'push: <pathspec> not in the repository errors out' '
 	>untracked &&
 	test_must_fail git stash push untracked &&
 	test_path_is_file untracked
-- 
2.19.1.878.g0482332a22

