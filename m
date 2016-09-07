Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFA081F859
	for <e@80x24.org>; Wed,  7 Sep 2016 14:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757487AbcIGOvV (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 10:51:21 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:39610 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757090AbcIGOvH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 10:51:07 -0400
Received: (qmail 16820 invoked from network); 7 Sep 2016 14:51:05 -0000
Received: (qmail 8925 invoked from network); 7 Sep 2016 14:51:05 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 7 Sep 2016 14:51:02 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 13/13] i18n: update-index: mark warnings for translation
Date:   Wed,  7 Sep 2016 14:49:18 +0000
Message-Id: <1473259758-11836-14-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
References: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/update-index.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index ba04b19..7a17ce1 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1127,9 +1127,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		break;
 	case UC_DISABLE:
 		if (git_config_get_untracked_cache() == 1)
-			warning("core.untrackedCache is set to true; "
-				"remove or change it, if you really want to "
-				"disable the untracked cache");
+			warning(_("core.untrackedCache is set to true; "
+				  "remove or change it, if you really want to "
+				  "disable the untracked cache"));
 		remove_untracked_cache(&the_index);
 		report(_("Untracked cache disabled"));
 		break;
@@ -1139,9 +1139,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	case UC_ENABLE:
 	case UC_FORCE:
 		if (git_config_get_untracked_cache() == 0)
-			warning("core.untrackedCache is set to false; "
-				"remove or change it, if you really want to "
-				"enable the untracked cache");
+			warning(_("core.untrackedCache is set to false; "
+				  "remove or change it, if you really want to "
+				  "enable the untracked cache"));
 		add_untracked_cache(&the_index);
 		report(_("Untracked cache enabled for '%s'"), get_git_work_tree());
 		break;
-- 
2.7.4

