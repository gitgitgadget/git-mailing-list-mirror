Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84FA620984
	for <e@80x24.org>; Mon, 12 Sep 2016 11:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758073AbcILLio (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 07:38:44 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:55346 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1758068AbcILLil (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 07:38:41 -0400
Received: (qmail 16076 invoked from network); 12 Sep 2016 11:38:39 -0000
Received: (qmail 26837 invoked from network); 12 Sep 2016 11:31:59 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 12 Sep 2016 11:31:54 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 13/14] i18n: update-index: mark warnings for translation
Date:   Mon, 12 Sep 2016 11:30:01 +0000
Message-Id: <1473679802-31381-13-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473679802-31381-1-git-send-email-vascomalmeida@sapo.pt>
References: <1473679802-31381-1-git-send-email-vascomalmeida@sapo.pt>
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

