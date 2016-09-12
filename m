Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D567520984
	for <e@80x24.org>; Mon, 12 Sep 2016 11:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758054AbcILLiA (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 07:38:00 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:54660 "EHLO sapo.pt"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1758012AbcILLh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 07:37:59 -0400
Received: (qmail 14037 invoked from network); 12 Sep 2016 11:37:52 -0000
Received: (qmail 12413 invoked from network); 12 Sep 2016 11:31:12 -0000
Received: from unknown (HELO catarina.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 12 Sep 2016 11:31:07 -0000
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
Subject: [PATCH v2 05/14] i18n: branch: mark option description for translation
Date:   Mon, 12 Sep 2016 11:29:53 +0000
Message-Id: <1473679802-31381-5-git-send-email-vascomalmeida@sapo.pt>
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
 builtin/branch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 7df0543..d5d93a8 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -657,7 +657,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT( 0, "set-upstream",  &track, N_("change upstream info"),
 			BRANCH_TRACK_OVERRIDE),
 		OPT_STRING('u', "set-upstream-to", &new_upstream, N_("upstream"), N_("change the upstream info")),
-		OPT_BOOL(0, "unset-upstream", &unset_upstream, "Unset the upstream info"),
+		OPT_BOOL(0, "unset-upstream", &unset_upstream, N_("Unset the upstream info")),
 		OPT__COLOR(&branch_use_color, N_("use colored output")),
 		OPT_SET_INT('r', "remotes",     &filter.kind, N_("act on remote-tracking branches"),
 			FILTER_REFS_REMOTES),
-- 
2.7.4

