From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] git-rev-list: add documentation for --parents, --no-merges
Date: Mon, 10 Jul 2006 19:57:21 +0200
Message-ID: <E1G000X-0004om-A0@moooo.ath.cx>
References: <20060710192622.70c51a81.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jul 10 19:57:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G000d-0007oZ-6C
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 19:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422737AbWGJR5Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 13:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422738AbWGJR5Y
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 13:57:24 -0400
Received: from moooo.ath.cx ([85.116.203.178]:13737 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1422737AbWGJR5Y (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 13:57:24 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060710192622.70c51a81.diegocg@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23630>

---
Btw: grep -E ' .* ' should work too.

 Documentation/git-rev-list.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index e220842..f60eacd 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -56,6 +56,9 @@ OPTIONS
 	Print the contents of the commit in raw-format; each
 	record is separated with a NUL character.
 
+--parents::
+	Print the parents of the commit.
+
 --objects::
 	Print the object IDs of any object referenced by the listed commits.
 	'git-rev-list --objects foo ^bar' thus means "send me all object IDs
@@ -102,6 +105,9 @@ OPTIONS
 --remove-empty::
 	Stop when a given path disappears from the tree.
 
+--no-merges::
+	Do not print commits with more than one parent.
+
 --not::
 	Reverses the meaning of the '{caret}' prefix (or lack
 	thereof) for all following revision specifiers, up to
-- 
1.4.1.gf157-dirty
