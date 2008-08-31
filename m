From: Heikki Orsila <heikki.orsila@iki.fi>
Subject: [PATCH] Correct documentation wording for diff options -S and --pickaxe-all
Date: Mon, 1 Sep 2008 02:03:04 +0300
Message-ID: <20080831230304.GA30480@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 01 01:04:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZvxv-0007vV-8o
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 01:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755986AbYHaXDJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 19:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755529AbYHaXDI
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 19:03:08 -0400
Received: from zakalwe.fi ([80.83.5.154]:53803 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753521AbYHaXDH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 19:03:07 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 92EEA2BC68; Mon,  1 Sep 2008 02:03:04 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94513>

Signed-off-by: Heikki Orsila <heikki.orsila@iki.fi>
---
 Documentation/diff-options.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 1759386..062a8ae 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -160,12 +160,12 @@ endif::git-format-patch[]
 	number.
 
 -S<string>::
-	Look for differences that contain the change in <string>.
+	Look for differences that contain <string> in the change.
 
 --pickaxe-all::
 	When -S finds a change, show all the changes in that
-	changeset, not just the files that contain the change
-	in <string>.
+	changeset, not just the files that contain <string>
+	in the change.
 
 --pickaxe-regex::
 	Make the <string> not a plain string but an extended POSIX
-- 
1.6.0.1
