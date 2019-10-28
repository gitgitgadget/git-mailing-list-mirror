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
	by dcvr.yhbt.net (Postfix) with ESMTP id C61CF1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 12:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbfJ1M5W (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 08:57:22 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38884 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729284AbfJ1M5W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 08:57:22 -0400
Received: by mail-wm1-f67.google.com with SMTP id 22so8898468wms.3
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 05:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Z6O0LxUrJwYuVGjxRR7DUhT/1ZDDCrOsg+uVNxrCuxk=;
        b=LXXGx9I/for49OUCePKaQ4fg2xj8iJkcvEhg6R2snhMczIoeX9HK5qnOWwLVcnVygz
         0/8IYQWNh/DQwA+1aaINDlKfJMfliRVmlK2HaUk1x6iR6mi9j/G1NdbGsVJL6JL7w6Zz
         69zAwgzJY5skZcejV4lCuKuHL0sqZsQjsuODEQDtCaVplxvEGENhWj9wduPkgnVcsL2g
         IO6+2foJWecfwCgb91UpapM3TAHZ0/eNuo9QQ3J9lZ+H0SVBVigr1Za8QJz/X4WBMnAE
         AuFcurDAP7Y8MSmQ+KmS4ujxYmrWzigaFP2MY/lNSoL24ifCpsmZp39Yml1o32776zXw
         QDvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Z6O0LxUrJwYuVGjxRR7DUhT/1ZDDCrOsg+uVNxrCuxk=;
        b=BYbT/W+oZyMz7S1NBQJUCiHfyHuM9QDooatUvuL4Mq6/zqrW9ZI4kzAmBXNLCDWsgh
         +QAXLNuCmTFTR7yYZ5odMGAltrrWl/EkY2D4p38ZlYiF/txqr4VPCEl9J9YUUMc8HTxC
         bkEdli49Z66SRYck+8vUmRUTmFpcE4bY0IaAZMwz30WIapLVXPB6H/VHE2+QX3p2M0Nj
         KAUtXOd3E3/++gOid3oisGn8KkFJtnm7ibucTk071DZBvCta+5pduuHW+pUMeFy7EOT+
         GH4EWqyeJAX4LWWzQItZpUKTCeW0WmXq5ZIfsXSXs/VymYDy2ZL5islon3C0wZIIu1pA
         E6fw==
X-Gm-Message-State: APjAAAWbofJP2LPFziOV9zSnoO0ia35FrHdvtrDoqoKQT7rQQkzK7cf+
        GjmsZ3C340D0p8h5QgFh/13HGziD
X-Google-Smtp-Source: APXvYqxKECXsYW6pxc8G6FsolbiD4xYOBP5PdEiDvZ28ockjeINPLPenTml48BrxfYU9UwYkyRk9UA==
X-Received: by 2002:a05:600c:24d2:: with SMTP id 18mr15632479wmu.139.1572267440277;
        Mon, 28 Oct 2019 05:57:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k3sm10808377wro.77.2019.10.28.05.57.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 05:57:19 -0700 (PDT)
Message-Id: <cf97c5182eb98cc0ae72f94d4331abcb4486ca83.1572267438.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.401.v4.git.1572267438.gitgitgadget@gmail.com>
References: <pull.401.v3.git.1571694882.gitgitgadget@gmail.com>
        <pull.401.v4.git.1572267438.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Oct 2019 12:57:17 +0000
Subject: [PATCH v4 1/2] t1400: wrap setup code in test case
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

