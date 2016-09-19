Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 787412070F
	for <e@80x24.org>; Mon, 19 Sep 2016 13:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759837AbcISNJW (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 09:09:22 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:47312 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756331AbcISNJT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 09:09:19 -0400
Received: (qmail 31499 invoked from network); 19 Sep 2016 13:09:17 -0000
Received: (qmail 30657 invoked from network); 19 Sep 2016 13:09:16 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 19 Sep 2016 13:09:14 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:   Vasco Almeida <vascomalmeida@sapo.pt>
To:     git@vger.kernel.org
Cc:     Vasco Almeida <vascomalmeida@sapo.pt>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20AVILA?= <jn.avila@free.fr>
Subject: [PATCH 3/6] i18n: diff: mark die errors for translation
Date:   Mon, 19 Sep 2016 13:08:18 +0000
Message-Id: <1474290501-2743-3-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1474290501-2743-1-git-send-email-vascomalmeida@sapo.pt>
References: <1474290501-2743-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 diff.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index b4310f8..d82ad79 100644
--- a/diff.c
+++ b/diff.c
@@ -3325,7 +3325,7 @@ void diff_setup_done(struct diff_options *options)
 	if (options->output_format & DIFF_FORMAT_NO_OUTPUT)
 		count++;
 	if (count > 1)
-		die("--name-only, --name-status, --check and -s are mutually exclusive");
+		die(_("--name-only, --name-status, --check and -s are mutually exclusive"));
 
 	/*
 	 * Most of the time we can say "there are changes"
@@ -3521,7 +3521,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 			if (*arg == '=')
 				width = strtoul(arg + 1, &end, 10);
 			else if (!*arg && !av[1])
-				die("Option '--stat-width' requires a value");
+				die(_("Option '--stat-width' requires a value"));
 			else if (!*arg) {
 				width = strtoul(av[1], &end, 10);
 				argcount = 2;
@@ -3530,7 +3530,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 			if (*arg == '=')
 				name_width = strtoul(arg + 1, &end, 10);
 			else if (!*arg && !av[1])
-				die("Option '--stat-name-width' requires a value");
+				die(_("Option '--stat-name-width' requires a value"));
 			else if (!*arg) {
 				name_width = strtoul(av[1], &end, 10);
 				argcount = 2;
@@ -3539,7 +3539,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 			if (*arg == '=')
 				graph_width = strtoul(arg + 1, &end, 10);
 			else if (!*arg && !av[1])
-				die("Option '--stat-graph-width' requires a value");
+				die(_("Option '--stat-graph-width' requires a value"));
 			else if (!*arg) {
 				graph_width = strtoul(av[1], &end, 10);
 				argcount = 2;
@@ -3548,7 +3548,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 			if (*arg == '=')
 				count = strtoul(arg + 1, &end, 10);
 			else if (!*arg && !av[1])
-				die("Option '--stat-count' requires a value");
+				die(_("Option '--stat-count' requires a value"));
 			else if (!*arg) {
 				count = strtoul(av[1], &end, 10);
 				argcount = 2;
-- 
2.7.4

