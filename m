From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Improved autocrlf description in RelNotes-1.7.2.txt
Date: Fri, 2 Jul 2010 09:58:44 +0200
Message-ID: <20100702075844.GA14583@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 09:58:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUb9B-00065h-NO
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 09:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754394Ab0GBH6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 03:58:48 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:59637 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396Ab0GBH6r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 03:58:47 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OUb92-00057m-5E; Fri, 02 Jul 2010 09:58:44 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150113>

---
I think RelNotes should be rewritten along these lines..

 Documentation/RelNotes-1.7.2.txt |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/RelNotes-1.7.2.txt b/Documentation/RelNotes-1.7.2.txt
index aa79f06..92f0da3 100644
--- a/Documentation/RelNotes-1.7.2.txt
+++ b/Documentation/RelNotes-1.7.2.txt
@@ -4,11 +4,14 @@ Git v1.7.2 Release Notes (draft)
 Updates since v1.7.1
 --------------------
 
- * core.eol configuration and eol attribute are the new way to control
-   the end of line conventions for files in the working tree;
-   core.autocrlf overrides it, keeping the traditional behaviour by
-   default.
-
+ * core.eol configuration and text/eol attributes are the new way to control
+   the end of line conventions for files in the working tree.
+
+ * core.autocrlf has been made safer - it will now only handle line
+   endings for new files and files that are LF-only in the
+   repository. To normalize content that has been checked in with
+   CRLF, use the new eol/text attributes.
+   
  * The whitespace rules used in "git apply --whitespace" and "git diff"
    gained a new member in the family (tab-in-indent) to help projects with
    policy to indent only with spaces.
-- 
1.7.2.rc1
