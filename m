Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF1791F404
	for <e@80x24.org>; Sun, 25 Mar 2018 13:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753352AbeCYNqq (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 09:46:46 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34992 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753337AbeCYNqk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 09:46:40 -0400
Received: by mail-wm0-f65.google.com with SMTP id r82so10944119wme.0
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 06:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fNAwNWtX413n5H0cBqComBfOtwAAO4mqnHCQhU4q17U=;
        b=GveU8LWcA6VRO43j75rp07azAFV8Mw34a1UzX5MhRd+4hplqz7w6G5dhgPQH6eUO2A
         XI5nEN86bUzarUjS/bH2B7K8Kuja8t7nFXwOQhGOEA0xQJpQbiafN/57I84Zv9zBDGW5
         u2gbcEZTMbfq49NiwdvYOR8g+dyA69U7unj9tDrh31A4JQWLnY7Kv5HJoHT81KUPQj5I
         jd+6dB94z7a0pZ0cmzpLtLge1VfITV3sFqjy9WogS/1D8Vbmfm8Co/KfIVDln5Fv6CcS
         cEkLGX0wgTL4Zjs+xXyK7XQHOyzBHMVFD3VQNUx9NXfKM/s9iBpI3DmSTdYFYBohhV6X
         oAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fNAwNWtX413n5H0cBqComBfOtwAAO4mqnHCQhU4q17U=;
        b=agWbXjzn3MpzOT8uniTMgE2riXmcHpSjFuwC9odt/fFOpdXoXNfqzrIEfLzD3fH5If
         FFGZZU0wQvhJRKATUQxVFpXfaEjYAH7y6WTRtfiAgwhTEYT1fpVZ0FjIDOXSnEU3eiri
         7zRJkFuZbGrAfVaiuO2sP4URwA4T8sUymOqSpqcMG4liXfA7X6t/269vJaT/CQ6HbW9j
         u7D1/QyOV4XvqGvDoSITRo8pfXhv30mKo2txY284RIcVq+6qFZUDqckFt1XVBGM3XiS7
         B0w27goOZhZZgA59+cgvQMF9Vqxw9Zxtad5/WK84NpUuL4st22q37KbIE7QkPdMMw9G4
         WIOw==
X-Gm-Message-State: AElRT7G5fSqNe1CRvHsVCyCpdaOQB1MTyE/czWJTOZ6M76cdvVTpepCX
        BqUjL6GkIVAM45yLpqE1uTKUHaht
X-Google-Smtp-Source: AG47ELsfBdoYlFdi/uy0xKpcYzctqwSgtfEuPWPoSmi2kis+FDTs7l2bBZ7qos8/ghA1k6AC8yCkHQ==
X-Received: by 10.28.193.13 with SMTP id r13mr11943653wmf.38.1521985598906;
        Sun, 25 Mar 2018 06:46:38 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 96sm12511788wrk.54.2018.03.25.06.46.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 06:46:37 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v5 6/6] t2025: rename now outdated branch name
Date:   Sun, 25 Mar 2018 14:49:47 +0100
Message-Id: <20180325134947.25828-7-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.77.g8685934aa2
In-Reply-To: <20180325134947.25828-1-t.gummerer@gmail.com>
References: <20180317222219.4940-1-t.gummerer@gmail.com>
 <20180325134947.25828-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before the previous commit, the branch named precious was used to check
that 'git worktree' wouldn't clobber the branch.  While 'git worktree'
still shouldn't (and doesn't) modify the branch, that's no longer the
main thing the test is checking.

Rename the branch to avoid making future readers wonder why this
particular branch is more "precious" than others.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t2025-worktree-add.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index ae602cf20e..fb99f4c46f 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -201,12 +201,12 @@ test_expect_success '"add" with <branch> omitted' '
 test_expect_success '"add" checks out existing branch of dwimd name' '
 	test_commit c1 &&
 	test_commit c2 &&
-	git branch precious HEAD~1 &&
-	git worktree add precious &&
-	test_cmp_rev HEAD~1 precious &&
+	git branch dwim HEAD~1 &&
+	git worktree add dwim &&
+	test_cmp_rev HEAD~1 dwim &&
 	(
-		cd precious &&
-		test_cmp_rev precious HEAD
+		cd dwim &&
+		test_cmp_rev dwim HEAD
 	)
 '
 
-- 
2.16.1.77.g8685934aa2

