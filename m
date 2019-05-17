Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1A5E1F461
	for <e@80x24.org>; Fri, 17 May 2019 19:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfEQT0d (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 15:26:33 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:12893 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbfEQT0d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 15:26:33 -0400
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 9A2F5200410;
        Fri, 17 May 2019 21:26:30 +0200 (CEST)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH] diff: fix mistake in translatable strings
Date:   Fri, 17 May 2019 21:26:19 +0200
Message-Id: <20190517192619.17555-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.22.0.rc0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 4d3cf83a27..6e87f95645 100644
--- a/diff.c
+++ b/diff.c
@@ -5453,13 +5453,13 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("equivalent to --word-diff=color --word-diff-regex=<regex>"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, diff_opt_color_words),
 		OPT_CALLBACK_F(0, "color-moved", options, N_("<mode>"),
-			       N_("move lines of code are colored differently"),
+			       N_("moved lines of code are colored differently"),
 			       PARSE_OPT_OPTARG, diff_opt_color_moved),
 		OPT_CALLBACK_F(0, "color-moved-ws", options, N_("<mode>"),
 			       N_("how white spaces are ignored in --color-moved"),
 			       0, diff_opt_color_moved_ws),
 
-		OPT_GROUP(N_("Diff other options")),
+		OPT_GROUP(N_("Other diff options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
 			       N_("when run from subdir, exclude changes outside and show relative paths"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
-- 
2.22.0.rc0

