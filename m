From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: [PATCH] Typos.
Date: Mon, 29 Sep 2008 22:30:00 +0200
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20080929202959.GD22976@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 29 22:31:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkPP0-0003bq-7r
	for gcvg-git-2@gmane.org; Mon, 29 Sep 2008 22:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752294AbYI2UaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 16:30:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752330AbYI2UaS
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 16:30:18 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:52471 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbYI2UaR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 16:30:17 -0400
Received: from localhost.localdomain (xdsl-87-79-252-199.netcologne.de [87.79.252.199])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 7B24E40001D34
	for <git@vger.kernel.org>; Mon, 29 Sep 2008 22:30:14 +0200 (CEST)
Received: from ralf by localhost.localdomain with local (Exim 4.69)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1KkPNY-0001fk-5y
	for git@vger.kernel.org; Mon, 29 Sep 2008 22:30:00 +0200
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97051>

---
 Documentation/RelNotes-1.6.1.txt |    4 ++--
 Documentation/git-read-tree.txt  |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RelNotes-1.6.1.txt b/Documentation/RelNotes-1.6.1.txt
index 421e569..906932c 100644
--- a/Documentation/RelNotes-1.6.1.txt
+++ b/Documentation/RelNotes-1.6.1.txt
@@ -59,7 +59,7 @@ on.
 
 * "git daemon" learned --max-connections=<count> option.
 
-* "git diff" learned to mimick --suppress-blank-empty from GNU diff via a
+* "git diff" learned to mimic --suppress-blank-empty from GNU diff via a
   configuration option.
 
 * "git diff" learned to put more sensible hunk headers for Python and
@@ -121,7 +121,7 @@ release, unless otherwise noted.
   is a path in it).
 
 * "git diff --stdin" used to take two trees on a line and compared them,
-  but we droppped support for such a use case long time ago.  This has
+  but we dropped support for such a use case long time ago.  This has
   been resurrected.
 
 * "git filter-branch" failed to rewrite a tag name with slashes in it.
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 309deac..7160fa1 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -212,7 +212,7 @@ output after two-tree merge.
 
 Case #3 is slightly tricky and needs explanation.  The result from this
 rule logically should be to remove the path if the user staged the removal
-of the path and then swiching to a new branch.  That however will prevent
+of the path and then switching to a new branch.  That however will prevent
 the initial checkout from happening, so the rule is modified to use M (new
 tree) only when the contents of the index is empty.  Otherwise the removal
 of the path is kept as long as $H and $M are the same.
-- 
1.6.0.1.309.g48068
