Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC9A020248
	for <e@80x24.org>; Tue,  5 Mar 2019 21:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfCEVo2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 16:44:28 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:1663 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfCEVo2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 16:44:28 -0500
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id 82E10200371;
        Tue,  5 Mar 2019 22:44:25 +0100 (CET)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH] Doc: fix misleading asciidoc formating
Date:   Tue,  5 Mar 2019 22:44:23 +0100
Message-Id: <20190305214423.27820-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The end of sentence in "x." at the begining of a line misleads
ascidoctor into interpreting it as the start of numbered sub-list.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/technical/directory-rename-detection.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/directory-rename-detection.txt b/Documentation/technical/directory-rename-detection.txt
index 1c0086e287..844629c8c4 100644
--- a/Documentation/technical/directory-rename-detection.txt
+++ b/Documentation/technical/directory-rename-detection.txt
@@ -20,8 +20,8 @@ More interesting possibilities exist, though, such as:
   * one side of history renames x -> z, and the other renames some file to
     x/e, causing the need for the merge to do a transitive rename.
 
-  * one side of history renames x -> z, but also renames all files within
-    x.  For example, x/a -> z/alpha, x/b -> z/bravo, etc.
+  * one side of history renames x -> z, but also renames all files within x.
+    For example, x/a -> z/alpha, x/b -> z/bravo, etc.
 
   * both 'x' and 'y' being merged into a single directory 'z', with a
     directory rename being detected for both x->z and y->z.
-- 
2.21.0

