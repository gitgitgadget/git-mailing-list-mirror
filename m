Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84B521F404
	for <e@80x24.org>; Tue,  4 Sep 2018 14:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbeIDTVn (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 15:21:43 -0400
Received: from 17.mo6.mail-out.ovh.net ([46.105.36.150]:56631 "EHLO
        17.mo6.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbeIDTVn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 15:21:43 -0400
X-Greylist: delayed 1205 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Sep 2018 15:21:42 EDT
Received: from player687.ha.ovh.net (unknown [10.109.160.46])
        by mo6.mail-out.ovh.net (Postfix) with ESMTP id 6B7A617A0F3
        for <git@vger.kernel.org>; Tue,  4 Sep 2018 16:19:25 +0200 (CEST)
Received: from jnavila-Latitude-E6540.DOMALEPH.local (static-csq-cds-097114.business.bouyguestelecom.com [164.177.97.114])
        (Authenticated sender: jean-noel.avila@scantech.fr)
        by player687.ha.ovh.net (Postfix) with ESMTPSA id 669B72C00D2;
        Tue,  4 Sep 2018 16:19:22 +0200 (CEST)
From:   Jean-Noel Avila <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     Jean-Noel Avila <jn.avila@free.fr>
Subject: [PATCH] i18n: fix dangling dot in die() messages
Date:   Tue,  4 Sep 2018 16:18:16 +0200
Message-Id: <20180904141816.26398-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CANYiYbHmU=j+MwLTumJ+BK_0msyPBeux92wF8VqL9J04VOc-FQ@mail.gmail.com>
References: <CANYiYbHmU=j+MwLTumJ+BK_0msyPBeux92wF8VqL9J04VOc-FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10695204691495541725
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtjedrheekgdeihecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---

It is not clear what the style guide for messages is.

 builtin/submodule--helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b56028ba9d..a011abfd7c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -521,7 +521,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 		printf(_("Entering '%s'\n"), displaypath);
 
 	if (info->argv[0] && run_command(&cp))
-		die(_("run_command returned non-zero status for %s\n."),
+		die(_("run_command returned non-zero status for %s"),
 			displaypath);
 
 	if (info->recursive) {
@@ -543,7 +543,7 @@ static void runcommand_in_submodule_cb(const struct cache_entry *list_item,
 
 		if (run_command(&cpr))
 			die(_("run_command returned non-zero status while "
-				"recursing in the nested submodules of %s\n."),
+				"recursing in the nested submodules of %s"),
 				displaypath);
 	}
 
-- 
2.18.0

