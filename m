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
	by dcvr.yhbt.net (Postfix) with ESMTP id B9BFE1F463
	for <e@80x24.org>; Thu, 26 Sep 2019 21:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfIZVRO (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Sep 2019 17:17:14 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:42684 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfIZVRN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Sep 2019 17:17:13 -0400
Received: by mail-lj1-f174.google.com with SMTP id y23so356312lje.9
        for <git@vger.kernel.org>; Thu, 26 Sep 2019 14:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zvlb7WqjkI/qZlOIr5HvOL97s8w49okBhHtv37Pjh1o=;
        b=fghyRb7NMktYf6UpOrnHQE9xr2mM9WuxJans/CmSYq5dXWvTSqYUEF120tyBixgmnn
         K4YmNS/GOeULlN5r7WSI5VvbemNW91FWBLQ1t0HO39BBrii9IFWe2AYdhAY0REtKga9n
         aK3Oa8RP8iDkxUsisggyJ0/QbbONZHDR6Sr2Noj+cTpXHNCFsLvOjAi0H58VvVncxR61
         Jv604JV5wwoZrQjdwIMyqdI1yWj2BnBcu6AuNwSmG+vSabjpJVAcRLBafsmM1Bl+bPYX
         MOJoZYyEumIgNeDWreNabKb8o8aMhB5eUcsIbRhPNCE7w07rjPCM4KjsOxotbaKvv3QG
         c6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Zvlb7WqjkI/qZlOIr5HvOL97s8w49okBhHtv37Pjh1o=;
        b=J1LWmUPfZ422Ox8++/D5438P8CQjl5H3lH7/tWulf+ujCU3mfxHUUx0qlFphENBNpW
         TUOQHvq+ZRlmMwug3HE0mxTA36fqNbeujSzPgdX/GjO7I7z0Usjl2CpF0K7Bs0TLoy57
         iVDeBrPWefyN3pC3tqaK7gGWP6gvvX8MmWQP/ha94z4d2oDs/4Rhe0WR5oNe5/j5wrPQ
         +xL3/ez6Jy+RYpFqcu5Qv+tGw8N7dvrdv07Zf5M/f2ZbbNzQNSS5jW1vMCAF2hawOLgI
         9yjUG9pqQVjbKGF1aKP+Y7k2znSit+ujtRmQe4S23k/ixWFNUrNCseQEweYbMcvV8qr1
         eJJg==
X-Gm-Message-State: APjAAAV2H+/YTLSBqzaxGce6tYalwCFqQV/q7mRhTiVAbNzsP0y3pyVM
        +Ur/NFwjMuqhgkJVoEwnj/pRd6qV
X-Google-Smtp-Source: APXvYqw62dJ1cWQi8wt6pN1ortT1LneA2sUP9nLuTnubjzIwoljbbH0NGut9X9d+UBfp1PqP2z9oUA==
X-Received: by 2002:a2e:9a0c:: with SMTP id o12mr466873lji.204.1569532631083;
        Thu, 26 Sep 2019 14:17:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d3sm63076ljc.66.2019.09.26.14.17.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 14:17:10 -0700 (PDT)
Date:   Thu, 26 Sep 2019 14:17:10 -0700 (PDT)
X-Google-Original-Date: Thu, 26 Sep 2019 21:17:08 GMT
Message-Id: <eca193f91b85fc4ffea453bc3adb64bc5c8831a8.1569532628.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.361.git.gitgitgadget@gmail.com>
References: <pull.361.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] respect core.hooksPath, falling back to .git/hooks
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Since v2.9.0, Git knows about the config variable core.hookspath
that allows overriding the path to the directory containing the
Git hooks.

Since v2.10.0, the `--git-path` option respects that config
variable, too, so we may just as well use that command.

For Git versions older than v2.5.0 (which was the first version to
support the `--git-path` option for the `rev-parse` command), we
simply fall back to the previous code.

This fixes https://github.com/git-for-windows/git/issues/1755

Initial-patch-by: Philipp Gortan <philipp@gortan.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-gui.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/git-gui.sh b/git-gui.sh
index fd476b6999..b2c6e7a1db 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -623,7 +623,11 @@ proc git_write {args} {
 }
 
 proc githook_read {hook_name args} {
-	set pchook [gitdir hooks $hook_name]
+	if {[package vcompare $::_git_version 2.5.0] >= 0} {
+		set pchook [git rev-parse --git-path "hooks/$hook_name"]
+	} else {
+		set pchook [gitdir hooks $hook_name]
+	}
 	lappend args 2>@1
 
 	# On Windows [file executable] might lie so we need to ask
-- 
gitgitgadget
