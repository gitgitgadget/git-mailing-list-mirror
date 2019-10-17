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
	by dcvr.yhbt.net (Postfix) with ESMTP id C321A1F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 23:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441764AbfJQXRK (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 19:17:10 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39331 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441759AbfJQXRI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 19:17:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id p12so2227481pgn.6
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 16:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YC4fNJbTJjmIdhF80DE7oVpxjmUfghRQyvty2Bht8KY=;
        b=L/h27Ep2h0whu510TamX0oI5Q+wB+wFL7u4vVWfJnZLjpyu4nE4A4FVaLN25iriskI
         mlm9Dp9C6q1lpbk7F/j20bUsRJVAuVNcshYjZqS5MivEL6d7qSsUV0hNjdhSUucYJE0g
         6uxIitS0vr5hwrJpoN44Dcvb0Ig1Ed1+huwedMs1MAlgpWArhH1JYYDEv0Jrj0WEc71Q
         a6ks50EVE5yiQd2YPWXDB1FIcFsvq1Ad33eGRLigkMIVC3gworp1NTYwpo+k/wWJkEkU
         hvGqbTmSKDYdF1zkc7FrrKaYRZvjrXQP8qeRotbhqYddjm+rrcq0SQrmN+8u/aNlKhAf
         FXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YC4fNJbTJjmIdhF80DE7oVpxjmUfghRQyvty2Bht8KY=;
        b=GOsaDAHDixcFcKuf5f74TFOT8XdXHhiiLj8c0UYh4uYUwsZDgbkLY2oytbLpsI5kUE
         bS7xPGZndmLcPaoZcL0pT3fHdxHQjmKeOUSZ0HkaKoUEytxfmgWER3SPXagU16QcLpY9
         fIpeiQ+GizuzFTpgV8FDQ7JbJ2/CfMF5r6ADx5IuQoQ33fjwDel9QNoSBOZxeB4ZsaH0
         Zk7MRJmq6IuK1iTSYVDJuBvumvINHQrLBPOV81fNYX3d5/nYnINHxO+Na2Vd3gTnINmR
         M7Dmigtg9SsPMqbVlugbBA0jokORkeMSBXx1uUoewG5io65fhj6ZvXHiNPgRrArla0Rs
         qE7w==
X-Gm-Message-State: APjAAAVPnyKyhjnaFTsB2ig4fHh2+r3gxdgrpDVuZ2avwsq7+rq7gjEH
        EnKwNlX2nzps1tb+prItgya4zIzv
X-Google-Smtp-Source: APXvYqznwbuj/QnJVLrhTQ51N3w+nkUc1dBGc4wXmlfsoYIgQw5OAaTt2vq6/sIjDBx3vE/qzyOeXw==
X-Received: by 2002:aa7:870f:: with SMTP id b15mr3055635pfo.123.1571354227365;
        Thu, 17 Oct 2019 16:17:07 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id b18sm3794972pfi.157.2019.10.17.16.17.06
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 16:17:06 -0700 (PDT)
Date:   Thu, 17 Oct 2019 16:17:05 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 05/12] t5520: remove spaces after redirect operator
Message-ID: <60ee00535e95400bedc76300efdf781c83cfc8aa.1571354136.git.liu.denton@gmail.com>
References: <cover.1571354136.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571354136.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The style for tests in Git is to have the redirect operator attached to
the filename with no spaces. Fix test cases where this is not the case.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 5ab5ec508a..68b8822db2 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -243,10 +243,10 @@ test_expect_success 'fast-forward fails with conflicting work tree' '
 
 test_expect_success '--rebase' '
 	git branch to-rebase &&
-	echo modified again > file &&
+	echo modified again >file &&
 	git commit -m file file &&
 	git checkout to-rebase &&
-	echo new > file2 &&
+	echo new >file2 &&
 	git add file2 &&
 	git commit -m "new file" &&
 	git tag before-rebase &&
@@ -542,10 +542,10 @@ test_expect_success '--rebase with rebased upstream' '
 	git checkout copy &&
 	git tag copy-orig &&
 	git reset --hard HEAD^ &&
-	echo conflicting modification > file &&
+	echo conflicting modification >file &&
 	git commit -m conflict file &&
 	git checkout to-rebase &&
-	echo file > file2 &&
+	echo file >file2 &&
 	git commit -m to-rebase file2 &&
 	git tag to-rebase-orig &&
 	git pull --rebase me copy &&
@@ -591,7 +591,7 @@ test_expect_success 'pull --rebase dies early with dirty working directory' '
 	test_config branch.to-rebase.remote me &&
 	test_config branch.to-rebase.merge refs/heads/copy &&
 	test_config branch.to-rebase.rebase true &&
-	echo dirty >> file &&
+	echo dirty >>file &&
 	git add file &&
 	test_must_fail git pull &&
 	test "$COPY" = "$(git rev-parse --verify me/copy)" &&
-- 
2.23.0.897.g0a19638b1e

