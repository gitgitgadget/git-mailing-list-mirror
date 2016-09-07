Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99F451F859
	for <e@80x24.org>; Wed,  7 Sep 2016 14:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757174AbcIGOuy (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 10:50:54 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:39419 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757098AbcIGOuu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 10:50:50 -0400
Received: (qmail 16318 invoked from network); 7 Sep 2016 14:50:49 -0000
Received: (qmail 991 invoked from network); 7 Sep 2016 14:50:37 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 7 Sep 2016 14:50:32 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/13] i18n: config: mark error message for translation
Date:   Wed,  7 Sep 2016 14:49:10 +0000
Message-Id: <1473259758-11836-6-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
References: <1473259758-11836-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 builtin/config.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 6cbf733..05843a0 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -622,8 +622,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		value = normalize_value(argv[0], argv[1]);
 		ret = git_config_set_in_file_gently(given_config_source.file, argv[0], value);
 		if (ret == CONFIG_NOTHING_SET)
-			error("cannot overwrite multiple values with a single value\n"
-			"       Use a regexp, --add or --replace-all to change %s.", argv[0]);
+			error(_("cannot overwrite multiple values with a single value\n"
+			"       Use a regexp, --add or --replace-all to change %s."), argv[0]);
 		return ret;
 	}
 	else if (actions == ACTION_SET_ALL) {
-- 
2.7.4

