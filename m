From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] git-merge(1): document diff-algorithm option to merge-recursive
Date: Fri,  5 Apr 2013 12:37:30 +0100
Message-ID: <8caba965bddcffd75972c730985b04a1eef3744e.1365161840.git.john@keeping.me.uk>
Cc: Michal Privoznik <mprivozn@redhat.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 06 18:47:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWFa-0002u6-AY
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125Ab3DELhm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 07:37:42 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:39248 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765545Ab3DELhl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 07:37:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 26C58161E3A1;
	Fri,  5 Apr 2013 12:37:41 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hyA3+jgqn3Eo; Fri,  5 Apr 2013 12:37:40 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 1169D161E3D3;
	Fri,  5 Apr 2013 12:37:35 +0100 (BST)
X-Mailer: git-send-email 1.8.2.540.gf023cfe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220162>

Commit 07924d4 (diff: Introduce --diff-algorithm command line option
2013-01-16) added diff-algorithm as a parameter to the recursive merge
strategy but did not document it.  Do so.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 Documentation/merge-strategies.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 66db802..49a9a7d 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -48,6 +48,12 @@ patience;;
 	this when the branches to be merged have diverged wildly.
 	See also linkgit:git-diff[1] `--patience`.
 
+diff-algorithm=[patience|minimal|histogram|myers];;
+	Tells 'merge-recursive' to use a different diff algorithm, which
+	can help avoid mismerges that occur due to unimportant matching
+	lines (such as braces from distinct functions).  See also
+	linkgit:git-diff[1] `--diff-algorithm`.
+
 ignore-space-change;;
 ignore-all-space;;
 ignore-space-at-eol;;
-- 
1.8.2.540.gf023cfe
