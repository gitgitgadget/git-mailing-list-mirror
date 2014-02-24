From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 10/19] tree-diff: show_path prototype is not needed anymore
Date: Mon, 24 Feb 2014 20:21:42 +0400
Message-ID: <c35d8878ffbf36601bc8b6b20a4dae709f1cc552.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 17:21:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHyHU-0003ZL-55
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 17:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbaBXQVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 11:21:14 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:34210 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753163AbaBXQVN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 11:21:13 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WHyHI-00040M-78; Mon, 24 Feb 2014 20:21:12 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WHyIx-00079u-Ce; Mon, 24 Feb 2014 20:22:55 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1393257006.git.kirr@mns.spb.ru>
References: <cover.1393257006.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242597>

We moved all action-taking code below show_path() in recent HEAD~~
(tree-diff: move all action-taking code out of compare_tree_entry).

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

( re-posting without change )

 tree-diff.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 3345534..20a4fda 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -6,9 +6,6 @@
 #include "diffcore.h"
 #include "tree.h"
 
-static void show_path(struct strbuf *base, struct diff_options *opt,
-		      struct tree_desc *t1, struct tree_desc *t2);
-
 /*
  * Compare two tree entries, taking into account only path/S_ISDIR(mode),
  * but not their sha1's.
-- 
1.9.rc1.181.g641f458
