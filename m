From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH 06/11] tree-diff: show_path prototype is not needed anymore
Date: Fri,  7 Feb 2014 21:48:47 +0400
Message-ID: <19670dbace36ef3996d697bf0fecd8eb9e8a98f2.1391794688.git.kirr@mns.spb.ru>
References: <cover.1391794688.git.kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 18:47:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBpWb-0000ZZ-1p
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 18:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313AbaBGRr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 12:47:26 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:33785 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753180AbaBGRrY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 12:47:24 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WBpWN-0002LL-6h; Fri, 07 Feb 2014 21:47:23 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WBpY8-0004AH-W0; Fri, 07 Feb 2014 21:49:12 +0400
X-Mailer: git-send-email 1.9.rc1.181.g641f458
In-Reply-To: <cover.1391794688.git.kirr@mns.spb.ru>
In-Reply-To: <cover.1391794688.git.kirr@mns.spb.ru>
References: <cover.1391794688.git.kirr@mns.spb.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241779>

We moved all action-taking code below show_path() in recent HEAD~~
(tree-diff: move all action-taking code out of compare_tree_entry).

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 tree-diff.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index df90bbe..604dc57 100644
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
