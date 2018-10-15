Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20F0D1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 10:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeJOR4q (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 13:56:46 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42756 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJOR4q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 13:56:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id i4-v6so8932000pgq.9
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 03:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3ULs1ExeZNOpvCCMKWrTYD+uW61BtcLr0jCSXVcolVU=;
        b=ph79/+aUXoeJD/U3EBxUVrLC8vBNT2HtVp9wU5GJTk157sLAxgzgIxP1/HXgfuYuFh
         CB6ozoitC02X2fC+thM36Hu5+iUPEd+6lOOLCe8NLsq051od0WQVzj2NzBLQNJTvdGti
         GraeizmUD/ftJL/oNEbD++WnqzvC+cM53cL+35ZDlK9qUx2lb4TmDaFDy/Dmxclyhaie
         Gyc6SeQmO3rg4PIyz40XFjBtajJ9C92dvcw/9tvhrXrgaYDTBlg59TLE//71o7Ac2usw
         Xanhvt5PKoL/C44uihz+A4cOpIRgKLQrwVKjwt1kF3TiWk28EDLn41aMCZG84VoVfA0H
         KMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3ULs1ExeZNOpvCCMKWrTYD+uW61BtcLr0jCSXVcolVU=;
        b=F3CNRb/417hPgLNenaEfKChxAo79uBjZkFFtpI3Sp7zaj4YJD1TN3tE/9BX01e4lTT
         4plEx0GW/be9G4zmIb2+ljB10qHZ0MlLKIgHgdN6na8P35g6Jos/vxn8BaYty5xUljuu
         PHcQnwouIQsOfw0wFBdjYgu57+JylQkcsIEL9O7AYRmohTTfs7ghsUrrItON5oFlsYDu
         /OuhYvnv6WlKs9otAdOmiipaavcAUg2nUzwjx/6mpFWdhBEVYqu4ylon+bNluzYRMjwU
         GVUhePRvz1xSfWQL8jj72KzOSadMJ0boERYYwCRXtHbzbzfQrXAFMEKMuYXgJuWjNJJq
         7UHQ==
X-Gm-Message-State: ABuFfoiRsq1y7vNhEYyVy2ko+rLx+1YJfKE5Xh1pgg1vofmC2aTcj84K
        eKgOcaz6AcBnzgDRR238uwkc4hby
X-Google-Smtp-Source: ACcGV60nWv4DSks/JsQXJ1IMNla9bK0bknZpaEZ6SagMTEw8HkTTaJa1t+6CJzowH9Ymk3HkMqblyA==
X-Received: by 2002:a63:4047:: with SMTP id n68-v6mr14968717pga.224.1539598330620;
        Mon, 15 Oct 2018 03:12:10 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id n63-v6sm12788928pfn.9.2018.10.15.03.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 03:12:09 -0700 (PDT)
Date:   Mon, 15 Oct 2018 03:12:09 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 10:11:50 GMT
Message-Id: <3bb226b79b87e30a3e8f6360c7f94d9adf4fe1b7.1539598316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v2.git.gitgitgadget@gmail.com>
References: <pull.31.git.gitgitgadget@gmail.com>
        <pull.31.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 08/13] git-daemon: use `test_atexit` in the tests
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

This makes use of the just-introduced consistent way to specify that a
long-running process needs to be terminated at the end of a test script
run.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/interop/i5500-git-daemon.sh | 1 -
 t/lib-git-daemon.sh           | 3 +--
 t/t5570-git-daemon.sh         | 1 -
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/interop/i5500-git-daemon.sh b/t/interop/i5500-git-daemon.sh
index 1daf69420b..4d22e42f84 100755
--- a/t/interop/i5500-git-daemon.sh
+++ b/t/interop/i5500-git-daemon.sh
@@ -37,5 +37,4 @@ test_expect_success "fetch with $VERSION_B" '
 	test_cmp expect actual
 '
 
-stop_git_daemon
 test_done
diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index edbea2d986..a896af2284 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -13,7 +13,6 @@
 #
 #	test_expect_success ...
 #
-#	stop_git_daemon
 #	test_done
 
 test_tristate GIT_TEST_GIT_DAEMON
@@ -43,7 +42,7 @@ start_git_daemon() {
 
 	mkdir -p "$GIT_DAEMON_DOCUMENT_ROOT_PATH"
 
-	trap 'code=$?; stop_git_daemon; (exit $code); die' EXIT
+	test_atexit 'stop_git_daemon'
 
 	say >&3 "Starting git daemon ..."
 	mkfifo git_daemon_output
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index 7466aad111..08f95c80a2 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -211,5 +211,4 @@ test_expect_success FAKENC 'hostname interpolation works after LF-stripping' '
 	test_cmp expect actual
 '
 
-stop_git_daemon
 test_done
-- 
gitgitgadget

