From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Documentation/git-merge: document subtree strategy.
Date: Tue, 18 Mar 2008 13:26:43 +0100
Message-ID: <20080318122643.GC15297@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 13:27:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jbauf-00075X-JX
	for gcvg-git-2@gmane.org; Tue, 18 Mar 2008 13:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbYCRM0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2008 08:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752261AbYCRM0s
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Mar 2008 08:26:48 -0400
Received: from virgo.iok.hu ([193.202.89.103]:11909 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752220AbYCRM0s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2008 08:26:48 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A88EF1B2503;
	Tue, 18 Mar 2008 13:26:45 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 63BF044698;
	Tue, 18 Mar 2008 13:23:49 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 48A6D1864058; Tue, 18 Mar 2008 13:26:43 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77497>

There was already some documentation about subtree under
Documentation/howto but it was missing from git-merge manpage.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Based on the commit message of 68faf68938ee943fc251c702f2027e4dfda354db.

 Documentation/merge-strategies.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index 7df0266..1276f85 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -33,3 +33,10 @@ ours::
 	merge is always the current branch head.  It is meant to
 	be used to supersede old development history of side
 	branches.
+
+subtree::
+	This is a modified recursive strategy. When merging trees A and
+	B, if B corresponds to a subtree of A, B is first adjusted to
+	match the tree structure of A, instead of reading the trees at
+	the same level. This adjustment is also done to the common
+	ancestor tree.
-- 
1.5.4.3
