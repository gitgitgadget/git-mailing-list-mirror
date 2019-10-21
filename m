Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8731F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 21:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730402AbfJUVyr (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 17:54:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35105 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730368AbfJUVyq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 17:54:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id l10so15239420wrb.2
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 14:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z6O0LxUrJwYuVGjxRR7DUhT/1ZDDCrOsg+uVNxrCuxk=;
        b=ZjCH1BvxVr6vqqzoBh1WNPRZbONN4P6swxMg+4Oo2XfBWkjsGKGg14fHMqxSN09Lnh
         IqwQ3XFDnnIgz4+BpXZm+iMPoJjOX/CkAfjFlvIBR38fHNI6m4beDGeAziZBb1nK9jiR
         yzwFJOKvAk1d5GJUqIogejfeXbRiHluKboiUEUDTr9WZcFkfyV9A3E43Hnn+yZ4kwn9g
         E/frcku0bP4HUJS4GHgqKXX2NS7rOeqbyCutZDYKoh2fQRRMX/9GCp1e17vz/WOgG0Ko
         c+pS5oE9eR7yxMZOOPWTL25iLiN6/9JTf68pMw9IL6W65Hja07bgPNtOFUrU/whnY9Se
         uJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Z6O0LxUrJwYuVGjxRR7DUhT/1ZDDCrOsg+uVNxrCuxk=;
        b=VtLXqv2sjGikJu/0Vhm+yo9nrkqaofjLP/R2g18rT1LKztKlUksepcts6BoFiG7DSu
         sghLKCoaz90UsOzf//RKHXlVzCxbzkP2EwpcHOQDx4royH+Z0hvN9TyXfarCRzetR0YK
         H5E8OCO2plgT+mUMTEXYycGXkyTIsq0zACHeLWEld51htJ9+7QZgh9sy1k6o5d4tw5gA
         pM52bPRu36udvqxgQTEX/wGXT8zNOBxsFDr9qt+n9hqTFUtnMAdsRk0Vn+VDs5KrQ/N7
         ojc99DsQnE1pjsH7njc8ebaBOA93rdN2xpZNWsPMgHO+ak+XE77lTRptLZZKAuRWiCgI
         TyeA==
X-Gm-Message-State: APjAAAXT72L/i3dYaxnfGUKVuhMgbpYGv1eyPRJrmQMVGltfp/gdNxNv
        M2cHipyluqMoLWYW7/W1T+LFiK1A
X-Google-Smtp-Source: APXvYqw98LGN7HDAdEq8muz7tJUl11alfRaG0OUV3LR2VKOYX8Cw2eoGbmpX/3AjMnl54c62wrQAEg==
X-Received: by 2002:adf:e903:: with SMTP id f3mr362235wrm.121.1571694884671;
        Mon, 21 Oct 2019 14:54:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s21sm17470204wrb.31.2019.10.21.14.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Oct 2019 14:54:44 -0700 (PDT)
Message-Id: <cf97c5182eb98cc0ae72f94d4331abcb4486ca83.1571694882.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.401.v3.git.1571694882.gitgitgadget@gmail.com>
References: <pull.401.v2.git.1571350077.gitgitgadget@gmail.com>
        <pull.401.v3.git.1571694882.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Oct 2019 21:54:41 +0000
Subject: [PATCH v3 1/2] t1400: wrap setup code in test case
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Without this, you cannot use `--run=<...>` to skip that part, and a run
with `--run=0` (which is a common way to determine the test case number
corresponding to a given test case title).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1400-update-ref.sh | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 1fbd940408..69a7f27311 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -344,14 +344,16 @@ test_expect_success "verifying $m's log (logged by config)" '
 	test_cmp expect .git/logs/$m
 '
 
-git update-ref $m $D
-cat >.git/logs/$m <<EOF
-$Z $C $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 -0500
-$C $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150350 -0500
-$A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 -0500
-$F $Z $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150680 -0500
-$Z $E $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 -0500
-EOF
+test_expect_success 'set up for querying the reflog' '
+	git update-ref $m $D &&
+	cat >.git/logs/$m <<-EOF
+	$Z $C $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150320 -0500
+	$C $A $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150350 -0500
+	$A $B $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150380 -0500
+	$F $Z $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150680 -0500
+	$Z $E $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150980 -0500
+	EOF
+'
 
 ed="Thu, 26 May 2005 18:32:00 -0500"
 gd="Thu, 26 May 2005 18:33:00 -0500"
-- 
gitgitgadget

