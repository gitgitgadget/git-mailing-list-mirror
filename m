Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F28CB20437
	for <e@80x24.org>; Tue, 31 Oct 2017 21:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932373AbdJaVTG (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 17:19:06 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:54711 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932296AbdJaVTF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 17:19:05 -0400
Received: by mail-io0-f194.google.com with SMTP id e89so1864766ioi.11
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 14:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e2Evyai3KlGaeTLcZ3uGPCXJdzkhiXh455QgONsR78g=;
        b=R5eg8mbaoqniH3H/ezLUe7Q3nD5y90apSJhoOAg7GcypAdQ+qTRdaL6IvPisCehj6+
         8HRr8V7GvJvvlQVvvXhR6+Obyn7/Gd4oWN00LcfANQfvaf68ir1Vjheya61i8kF4Qm0Q
         qjdXbUyu2A61WZJ/LEWabnLcHsIr6aA/4pdLtzHPE/BtUSkwBDmYooresDlDpmweWCQs
         C99vokjdJYvB8goe3bc7W2kz7AZKQ9UwwttfSkqe3oJTogOg5sfeYOK8b9mrjDILRBPh
         fSggJvCv65+paf0Vr26diHXV9l6X4SGEjtbDtenYZ80XTh+uTUgaEk0Qu4VzLUZsUrMg
         7Dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e2Evyai3KlGaeTLcZ3uGPCXJdzkhiXh455QgONsR78g=;
        b=LrujTuqp1n94q87FHPdeCSlymPlEBDK7UHE30E9zGbYvJ5RVXhDVkeswmqjLGN7WFb
         a9jzfNCOVuOC+v1R/m2HVtf/44iUUCBiXl9kV1T6h37WlIDmfvqGn1LGGH9GlqMQq0KA
         cspWvUJp1gnbsNdTcRSMZw0+nwYy1O0wH5TtlrjAtvorP4ZdXTBrUJ1PejouCdfNUcCF
         UtAqkdLz/oIm1plXSLZMUZb28c5Wnpwz2fFvbDBjkILYiGGU3e2+gahR++s4adqcpf//
         kCtaETlZpuwNKe7TgXQcr4BxoJmOhFeRNwVtAj4s6yuRrjNg6wYev/1s76mn21mxY/Rw
         vAgg==
X-Gm-Message-State: AMCzsaVmykyhpEyfQG2E1SjQcVEa6RIBKhb6wGTrKOpKJaOt9IRTjpBJ
        SZinMLBYH08Bj0LanehSy6u6ew==
X-Google-Smtp-Source: ABhQp+TZgzGYTujfeI05t1NmLzlIhl+0zBilQWaDm9n+1aPenPiFgmftVdxL9JX5Z8/j96KtTUFitg==
X-Received: by 10.36.69.74 with SMTP id y71mr5247982ita.47.1509484744715;
        Tue, 31 Oct 2017 14:19:04 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:55a5:57f1:5248:2d32])
        by smtp.gmail.com with ESMTPSA id h66sm1320695itg.17.2017.10.31.14.19.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 31 Oct 2017 14:19:04 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jacob.keller@gmail.com, me@ikke.info
Subject: [PATCHv2 7/7] t6120: fix typo in test name
Date:   Tue, 31 Oct 2017 14:18:52 -0700
Message-Id: <20171031211852.13001-8-sbeller@google.com>
X-Mailer: git-send-email 2.15.0.rc2.443.gfcc3b81c0a
In-Reply-To: <20171031211852.13001-1-sbeller@google.com>
References: <20171031003351.22341-1-sbeller@google.com>
 <20171031211852.13001-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t6120-describe.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 3be01316e8..fd329f173a 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -304,7 +304,7 @@ test_expect_success 'describe chokes on severely broken submodules' '
 	mv .git/modules/sub1/ .git/modules/sub_moved &&
 	test_must_fail git describe --dirty
 '
-test_expect_success 'describe ignoring a borken submodule' '
+test_expect_success 'describe ignoring a broken submodule' '
 	git describe --broken >out &&
 	test_when_finished "mv .git/modules/sub_moved .git/modules/sub1" &&
 	grep broken out
-- 
2.15.0.rc2.443.gfcc3b81c0a

