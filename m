Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80D161FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936358AbcHJTus (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:50:48 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:56457 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S934939AbcHJTur (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 15:50:47 -0400
Received: (qmail 20112 invoked from network); 10 Aug 2016 10:50:44 -0000
Received: (qmail 7411 invoked from network); 10 Aug 2016 10:50:43 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 10 Aug 2016 10:50:41 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] i18n: git-stash: mark messages for translation
Date:	Wed, 10 Aug 2016 10:50:30 +0000
Message-Id: <1470826230-4211-3-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1470826230-4211-1-git-send-email-vascomalmeida@sapo.pt>
References: <1470654961-2842-1-git-send-email-vascomalmeida@sapo.pt>
 <1470826230-4211-1-git-send-email-vascomalmeida@sapo.pt>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---

I added the second mark that I had missed the first time.
Thank you Junio C Hamano for spotting that.

 git-stash.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 22fb8bc..826af18 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -265,7 +265,7 @@ save_stash () {
 	create_stash "$stash_msg" $untracked
 	store_stash -m "$stash_msg" -q $w_commit ||
 	die "$(gettext "Cannot save the current status")"
-	say Saved working directory and index state "$stash_msg"
+	say "$(eval_gettext "Saved working directory and index state \$stash_msg")"
 
 	if test -z "$patch_mode"
 	then
@@ -548,7 +548,7 @@ pop_stash() {
 		drop_stash "$@"
 	else
 		status=$?
-		say "The stash is kept in case you need it again."
+		say "$(gettext "The stash is kept in case you need it again.")"
 		exit $status
 	fi
 }
-- 
2.7.4

