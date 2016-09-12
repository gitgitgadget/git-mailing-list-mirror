Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6225A20984
	for <e@80x24.org>; Mon, 12 Sep 2016 11:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758064AbcILLiM (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 07:38:12 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:51809 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1758012AbcILLiK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 07:38:10 -0400
Received: (qmail 10919 invoked from network); 12 Sep 2016 11:38:08 -0000
Received: (qmail 17102 invoked from network); 12 Sep 2016 11:31:26 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 12 Sep 2016 11:31:23 -0000
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
Subject: [PATCH v2 08/14] i18n: merge-recursive: mark verbose message for translation
Date:   Mon, 12 Sep 2016 11:29:56 +0000
Message-Id: <1473679802-31381-8-git-send-email-vascomalmeida@sapo.pt>
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
 builtin/merge-recursive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index 0bc88a7..1c21802 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -71,7 +71,7 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	o.branch2 = better_branch_name(o.branch2);
 
 	if (o.verbosity >= 3)
-		printf("Merging %s with %s\n", o.branch1, o.branch2);
+		printf(_("Merging %s with %s\n"), o.branch1, o.branch2);
 
 	failed = merge_recursive_generic(&o, &h1, &h2, bases_count, bases, &result);
 	if (failed < 0)
-- 
2.7.4

