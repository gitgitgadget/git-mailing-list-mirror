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
	by dcvr.yhbt.net (Postfix) with ESMTP id 58AD01F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 22:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438190AbfJQWIB (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 18:08:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38288 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391597AbfJQWIB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 18:08:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id o15so3608869wru.5
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 15:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z6O0LxUrJwYuVGjxRR7DUhT/1ZDDCrOsg+uVNxrCuxk=;
        b=WUCFCqhRtvzWyo45fGk/1FW6z/JhzkAA193cssosPTy4sMiODYdUYBTxvVPr/DF4+X
         VMATMvLbmpiS57WoLfwdSV+icWp+WxBNMQkEvBLKohkbQ17H1mrDfKypFxxxQzTeuogl
         41sQq94xTnZg1vpYzbnru26eHxywiPMQ6G6TrhTkhsBeJFhalJZ4FqqbjGWMHnplQuhE
         6BV1/XaWYd2KJ+6jYeDlWIjvQat9p5x47QQ1bNdZ9hfBqx+QhTHbIv/ba6mNn13c7fqg
         +Qqv6Y0MnNxFH5Ato9/OL9d7MHJ2eX5AcRO0xvfsBQkUowlR8MiblNBMMvAye791oPVc
         rMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Z6O0LxUrJwYuVGjxRR7DUhT/1ZDDCrOsg+uVNxrCuxk=;
        b=GbVcZpEs5+sdfSE7UqXzGciAe/tNutxmOStQ52l/rQ78IQXrnnspFP39af6MzOYyrS
         x1EE5qNst99EoTbN8yi+Jmkb/dDdEAKfcyK4JWPo49poifpjnD9ti2uEaW+GsmF1ITwL
         OH5ABVzgF09H1zktLa/hHs2IPJaJseKoxmKmhU8wyZvDiWvB/Wod4QT2CXPOOWuY4ZYp
         Ig/hCdEhEWN7DOSEA/w27lR6GbK3/mQWedRhx/LmRdu68EkED5YyDG2pYDYjg6smFdd3
         Ui2YYKEO/jeIGq9t6LgMB/V3EOHuLtKGVXprOQta2Iv+EQT4WQ4sFrRe+mfuvBmJyIAF
         rKGQ==
X-Gm-Message-State: APjAAAV0WjO/sp93pj35bWlQSJPFIbaeSxqAsvh2kczBfaYS74TtT22Q
        gVWuhAvk0oTfKtDzGdhNz9He4aL3
X-Google-Smtp-Source: APXvYqzukHWTw/KyYunOulDERxAoXFjKIiBzQk3Uha+h5OsE5t00PDi9NsB7XRitdn0TNGJg8NcWJg==
X-Received: by 2002:adf:ea01:: with SMTP id q1mr4721319wrm.240.1571350079279;
        Thu, 17 Oct 2019 15:07:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r7sm3324321wrt.28.2019.10.17.15.07.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 15:07:58 -0700 (PDT)
Message-Id: <cf97c5182eb98cc0ae72f94d4331abcb4486ca83.1571350077.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.401.v2.git.1571350077.gitgitgadget@gmail.com>
References: <pull.401.git.1571209637.gitgitgadget@gmail.com>
        <pull.401.v2.git.1571350077.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Oct 2019 22:07:56 +0000
Subject: [PATCH v2 1/2] t1400: wrap setup code in test case
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

