From: Sergei Organov <osv@javad.com>
Subject: [PATCH] core-tutorial.txt: Fix argument mistake in an example.
Date: Sat, 10 Nov 2007 16:17:33 +0300
Message-ID: <87hcjp7w6c.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 21:00:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is1wQ-0007sd-4w
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 21:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761272AbXKMUAg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 15:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761254AbXKMUAg
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 15:00:36 -0500
Received: from javad.com ([216.122.176.236]:1047 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761124AbXKMUAf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 15:00:35 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lADK0X067647;
	Tue, 13 Nov 2007 20:00:34 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1Is1vv-0005xi-Oa; Tue, 13 Nov 2007 23:00:27 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64843>

One of examples has wrong output given the arguments provided.
Fix arguments to match the output.

Fix a minor syntax mistake in another place.

Signed-off-by: Sergei Organov <osv@javad.com>
---
 Documentation/core-tutorial.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 401d1de..d611854 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -1152,7 +1152,7 @@ back to the earlier repository with "hello" and "example" file,
 and bring ourselves back to the pre-merge state:
 
 ------------
-$ git show-branch --more=3 master mybranch
+$ git show-branch --more=2 master mybranch
 ! [master] Merge work in mybranch
  * [mybranch] Merge work in mybranch
 --
@@ -1215,7 +1215,7 @@ $ git-read-tree -m -u $mb HEAD mybranch
 This is the same `git-read-tree` command we have already seen,
 but it takes three trees, unlike previous examples.  This reads
 the contents of each tree into different 'stage' in the index
-file (the first tree goes to stage 1, the second stage 2,
+file (the first tree goes to stage 1, the second -- to stage 2,
 etc.).  After reading three trees into three stages, the paths
 that are the same in all three stages are 'collapsed' into stage
 0.  Also paths that are the same in two of three stages are
-- 
1.5.3.4
