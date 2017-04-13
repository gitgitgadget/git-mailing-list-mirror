Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19A1220960
	for <e@80x24.org>; Thu, 13 Apr 2017 16:41:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755003AbdDMQlE (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 12:41:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32889 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755025AbdDMQlB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 12:41:01 -0400
Received: by mail-wm0-f68.google.com with SMTP id o81so13561266wmb.0
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 09:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DaUTc3XR2dMUTQez7hjbcb9uO29FnjnwdUK+XlW3Fjs=;
        b=eq+HOWP2txof2v82qAdoIXldhN8rrlCZrXTQvSwN7k+QsWioahDliOeZY6mPpAUDQL
         DNPYBEw+6SdPJQIAihD7Eh9csosoZmceioSHLTFdbjyIEKVed4tkVOE70LQATXKeq3hr
         2jPk1zW4YK5DQSlNXKnmiJ+0KiNiBUm97HGrIu7OdVwtSL+Rq15+ns6/hrTGRurzp1HP
         op8TZRifuVJEfO832gFK014P/S5fkS06oZY0p+ESG17qmZUEMtSqBy13Zz5CfOJ46KzL
         UECrcdQ5iXdQEWDpLjqrattfvVc3pz5QrmA1/erRI5CXnxm76pFE/Xjgah8eZBB3csCC
         RPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DaUTc3XR2dMUTQez7hjbcb9uO29FnjnwdUK+XlW3Fjs=;
        b=q0fqoj09pwxufkEsM4QljAlbsyDc72aZDo+dqCpzaWTdOrTqQS6EogYrAk3NMLNwXR
         H9knOck5S4wmvcfiyKQPM6WwWlWFh1KL1v3AgXl/ts2c5did6dmFe9RW1oAvd6i+8313
         z2iU+NRw1z9ECguHJwi4ur9ZNPwyjIZ/9aqe8VZY76TPNpvL2TFFkotLOTaVDA5ZuBSk
         N6ikGIzEJ0NOqPUPFa9F9NjXJeaEZYi16Gaw1ut+E6sbUsRWhX2NOI+OMcIJyzT3F6Yk
         dGkQqE6JMdtevm1ayg6coUro/w6YlWoeGhEHHjf31YkhbAyIeJWefBWBTvRhwWkYcE2U
         PTdA==
X-Gm-Message-State: AN3rC/4YTJ5TBp01N711/o53RZGc3P21Xp1SYVBxGA/n+rQpPvtLdhi5
        sQ9Rl6DawW+IyQ==
X-Received: by 10.28.45.216 with SMTP id t207mr4247001wmt.85.1492101649468;
        Thu, 13 Apr 2017 09:40:49 -0700 (PDT)
Received: from localhost (cable-94-139-14-18.cust.telecolumbus.net. [94.139.14.18])
        by smtp.gmail.com with ESMTPSA id 33sm30025655wrd.40.2017.04.13.09.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Apr 2017 09:40:48 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] submodule.c: add missing ' in error messages
Date:   Thu, 13 Apr 2017 18:40:45 +0200
Message-Id: <20170413164045.19570-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.12.2.762.g0e3151a22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 submodule.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/submodule.c b/submodule.c
index c52d6634c..02033c97e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1251,7 +1251,7 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
 	cp.dir = path;
 	if (start_command(&cp)) {
 		if (flags & SUBMODULE_REMOVAL_DIE_ON_ERROR)
-			die(_("could not start 'git status in submodule '%s'"),
+			die(_("could not start 'git status' in submodule '%s'"),
 				path);
 		ret = -1;
 		goto out;
@@ -1264,7 +1264,7 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
 
 	if (finish_command(&cp)) {
 		if (flags & SUBMODULE_REMOVAL_DIE_ON_ERROR)
-			die(_("could not run 'git status in submodule '%s'"),
+			die(_("could not run 'git status' in submodule '%s'"),
 				path);
 		ret = -1;
 	}
-- 
2.12.2.762.g0e3151a22

