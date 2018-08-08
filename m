Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 605C31F405
	for <e@80x24.org>; Wed,  8 Aug 2018 22:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbeHIAkB (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Aug 2018 20:40:01 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:54099 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHIAkB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Aug 2018 20:40:01 -0400
Received: by mail-qk0-f202.google.com with SMTP id f64-v6so3716976qkb.20
        for <git@vger.kernel.org>; Wed, 08 Aug 2018 15:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ey8c5RN2RBTt3qKJpS/8iZzRDpXsa4biMMEwdMAjlVg=;
        b=M7rTarT0xbZWOQ5vyywnFvdyKBe7fLLgxKid/AR6U/lFV65ORdjm+k00s012SVtpDm
         lLVS+crcZGl+lLJ09XTman8WLTOK1JLwp3B65rFBwhq4KQH1QOnvjlgZOJCSb6knIKFh
         eM4aYV87U3dBmoBGD3XuGtZZG+3TW4WY9gPoVefNrra0/zmSVMaccdGlMaiYHhzlOQNH
         ZtiMFBPccyfuPG49w+YHy5MoahmGXRyID093p2xQIHdDfy6ek4/SDZPGCliEhD2hF6FI
         34OSfTlOhqASqx4edkLj0NeR/RCY5J8N88BRkwIhcUpucAfYRw/6PJ7+kisfO3rU5lDh
         ZbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ey8c5RN2RBTt3qKJpS/8iZzRDpXsa4biMMEwdMAjlVg=;
        b=YZP+T+XXq1Bd5dPjWTGWgFaH3L9w5+JE7C1sy0y2BqT7MWFt8xO8h1atsrS+zAI02m
         N8fgx5fL156Qdiz3C/ft9iVCL04jphxOXvfkHefTuBUHkrRAJcAr30Ch/dX6QBFS/eLJ
         rwH6GeDLP31dhPlguuorys5dOL3+M5thoCi0r4BFqEGYjx3R+RCrUOvSH3CoUJQYtr7O
         /sgMyXOKpYv0F+AEsOL3IR0NCw2sNIhRQhgOdyk281u3tZQOU5rJeloxAIZQ5OIkWiUm
         VKevcjTSs90DjG7aeRKFobepZJuAy71CS5YkIZW70XLGgWo5akhXQbARxxehSGIzseIL
         oUkA==
X-Gm-Message-State: AOUpUlHzLWnPWWmDT+Wpmt3N8ioDoOHCT24r2eLZ4zRG1Rujy3WrmbOj
        KRHPYGOx06coglUkH+1UhUU5NN7He/Qgg2qhE6Zq/c/vU6LebIAhH4eaMl6ypmIViUICkq3NfL/
        CP5t4A19J8NbGWoNjZKOnVQ6T9aNDZuIEBmORvjSZmyXmFbAKutQVgr+6JhfW
X-Google-Smtp-Source: AA+uWPyOF4V+PGBMStdoO9owKTwKjQXgpKvlQOsGkssRdkt7xXXWEkUrXcKallorbPWA2N1MogsNnMllXTpM
X-Received: by 2002:ac8:1ab2:: with SMTP id x47-v6mr2403027qtj.43.1533766700074;
 Wed, 08 Aug 2018 15:18:20 -0700 (PDT)
Date:   Wed,  8 Aug 2018 15:17:47 -0700
In-Reply-To: <20180808221752.195419-1-sbeller@google.com>
Message-Id: <20180808221752.195419-6-sbeller@google.com>
Mime-Version: 1.0
References: <20180808221752.195419-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 05/10] submodule.c: fix indentation
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     hvoigt@hvoigt.net, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The submodule subsystem is really bad at staying within 80 characters.
Fix it while we are here.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index 5b4e5227d90..bceeba13217 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1244,7 +1244,8 @@ static int get_next_submodule(struct child_process *cp,
 		if (!submodule) {
 			const char *name = default_name_or_path(ce->name);
 			if (name) {
-				default_submodule.path = default_submodule.name = name;
+				default_submodule.path = name;
+				default_submodule.name = name;
 				submodule = &default_submodule;
 			}
 		}
@@ -1254,8 +1255,9 @@ static int get_next_submodule(struct child_process *cp,
 		default:
 		case RECURSE_SUBMODULES_DEFAULT:
 		case RECURSE_SUBMODULES_ON_DEMAND:
-			if (!submodule || !unsorted_string_list_lookup(&changed_submodule_names,
-							 submodule->name))
+			if (!submodule || !unsorted_string_list_lookup(
+					&changed_submodule_names,
+					submodule->name))
 				continue;
 			default_argv = "on-demand";
 			break;
-- 
2.18.0.597.ga71716f1ad-goog

