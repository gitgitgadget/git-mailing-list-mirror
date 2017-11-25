Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 411C920954
	for <e@80x24.org>; Sat, 25 Nov 2017 19:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751664AbdKYTz3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Nov 2017 14:55:29 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:25720 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751196AbdKYTz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Nov 2017 14:55:28 -0500
Received: from localhost.localdomain (unknown [IPv6:2a01:e35:2ef1:f910:580d:40ec:c1e:d5b3])
        by smtp1-g21.free.fr (Postfix) with ESMTP id 92F30B00573;
        Sat, 25 Nov 2017 20:55:26 +0100 (CET)
From:   Jean-Noel Avila <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     Jean-Noel Avila <jn.avila@free.fr>
Subject: [PATCH] submodule--helper.c: i18n: add a missing space in message
Date:   Sat, 25 Nov 2017 20:55:24 +0100
Message-Id: <20171125195524.29162-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.15.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The message spans over 2 lines but the C conconcatenation does not add
the needed space between the two lines.

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
---
 builtin/submodule--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2086f0eb0..a5c4a8a69 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -623,7 +623,7 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 
 		if (refs_head_ref(get_submodule_ref_store(path),
 				  handle_submodule_head_ref, &oid))
-			die(_("could not resolve HEAD ref inside the"
+			die(_("could not resolve HEAD ref inside the "
 			      "submodule '%s'"), path);
 
 		print_status(flags, '+', path, &oid, displaypath);
-- 
2.15.0

