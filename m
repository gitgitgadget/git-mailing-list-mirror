From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 6/6] user-manual: install user manual stylesheet with other web documents
Date: Sat, 10 Mar 2007 23:35:31 -0500
Message-ID: <11735877403014-git-send-email-bfields@citi.umich.edu>
References: <7vr6s42xgm.fsf@assigned-by-dhcp.cox.net> <11735877311383-git-send-email-bfields@citi.umich.edu> <11735877321525-git-send-email-bfields@citi.umich.edu> <11735877332438-git-send-email-bfields@citi.umich.edu> <11735877331883-git-send-email-bfields@citi.umich.edu> <11735877343565-git-send-email-bfields@citi.umich.edu> <1173587735398-git-send-email-bfields@citi.umich.edu>
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 05:36:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQFmu-0000sT-E5
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 05:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933120AbXCKEfz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 23:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933122AbXCKEfy
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 23:35:54 -0500
Received: from pool-138-88-140-139.esr.east.verizon.net ([138.88.140.139]:50481
	"EHLO pad.fieldses.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933120AbXCKEfx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 23:35:53 -0500
Received: from pad.fieldses.org (pad.fieldses.org [127.0.0.1])
	by pad.fieldses.org (8.13.8/8.13.8) with ESMTP id l2B4ZeFr022241;
	Sat, 10 Mar 2007 23:35:41 -0500
Received: (from bfields@localhost)
	by pad.fieldses.org (8.13.8/8.13.8/Submit) id l2B4Ze0g022240;
	Sat, 10 Mar 2007 23:35:40 -0500
X-Mailer: git-send-email 1.5.0.gb75812-dirty
In-Reply-To: <1173587735398-git-send-email-bfields@citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41909>

From: J. Bruce Fields <bfields@citi.umich.edu>

Install the stylesheet needed for the user manual.  This should solve
the problem of, e.g.,

	http://www.kernel.org/pub/software/scm/git/docs/user-manual.html

lacking a lot of formatting.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/install-webdoc.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/install-webdoc.sh b/Documentation/install-webdoc.sh
index b398193..cd3a18e 100755
--- a/Documentation/install-webdoc.sh
+++ b/Documentation/install-webdoc.sh
@@ -2,7 +2,7 @@
 
 T="$1"
 
-for h in *.html *.txt howto/*.txt howto/*.html RelNotes-*.txt
+for h in *.html *.txt howto/*.txt howto/*.html RelNotes-*.txt *.css
 do
 	if test -f "$T/$h" &&
 	   diff -u -I'Last updated [0-9][0-9]-[A-Z][a-z][a-z]-' "$T/$h" "$h"
-- 
1.5.0.gb75812-dirty
