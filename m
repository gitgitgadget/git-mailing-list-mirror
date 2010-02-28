Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 28286 invoked by uid 107); 28 Feb 2010 13:24:53 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.180.67)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 28 Feb 2010 08:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967986Ab0B1NYT (ORCPT <rfc822;peff@peff.net>);
	Sun, 28 Feb 2010 08:24:19 -0500
Received: from smtprelay02.ispgateway.de ([80.67.31.29]:59289 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967964Ab0B1NYT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 08:24:19 -0500
Received: from [79.210.50.103] (helo=stokes.schwinge.homeip.net)
	by smtprelay02.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <thomas@dirichlet.schwinge.homeip.net>)
	id 1Nlj84-000875-LS
	for git@vger.kernel.org; Sun, 28 Feb 2010 14:24:16 +0100
Received: (qmail 881 invoked from network); 28 Feb 2010 13:24:09 -0000
Received: from dslb-084-057-207-194.pools.arcor-ip.net (84.57.207.194)
  by stokes.schwinge.homeip.net with QMQP; 28 Feb 2010 13:24:09 -0000
Received: (nullmailer pid 27854 invoked by uid 1000);
	Sun, 28 Feb 2010 13:24:08 -0000
From:	Thomas Schwinge <thomas@schwinge.name>
To:	u.kleine-koenig@pengutronix.de
Cc:	Thomas Schwinge <thomas@schwinge.name>, git@vger.kernel.org
Subject: [PATCH] tg-mail: Properly quote --in-reply-to.
Date:	Sun, 28 Feb 2010 14:24:08 +0100
Message-Id: <1267363448-27830-1-git-send-email-thomas@schwinge.name>
X-Mailer: git-send-email 1.6.0.4
To:	u.kleine-koenig@pengutronix.de
X-Df-Sender: thomas@schwinge.name
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Thomas Schwinge <thomas@schwinge.name>

---
 tg-mail.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tg-mail.sh b/tg-mail.sh
index 6a008b4..8167ade 100644
--- a/tg-mail.sh
+++ b/tg-mail.sh
@@ -30,7 +30,7 @@ base_rev="$(git rev-parse --short --verify "refs/top-bases/$name" 2>/dev/null)"
 	die "not a TopGit-controlled branch"
 
 if [ -n "$in_reply_to" ]; then
-	send_email_args="$send_email_args --in-reply-to=$in_reply_to"
+	send_email_args="$send_email_args --in-reply-to='$in_reply_to'"
 fi
 
 
-- 
tg: (341a371..) t/tg_mail_quote_in-reply-to (depends on: master)
