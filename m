From: Sergei Organov <osv@javad.com>
Subject: [PATCH] user-manual.txt: fix a few mistakes
Date: Tue, 13 Nov 2007 21:19:39 +0300
Message-ID: <87bq9x7w4d.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 21:02:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is1xj-0008Ne-1D
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 21:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759894AbXKMUBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 15:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759663AbXKMUBq
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 15:01:46 -0500
Received: from javad.com ([216.122.176.236]:1088 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759677AbXKMUBp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 15:01:45 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lADK1h067776;
	Tue, 13 Nov 2007 20:01:44 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1Is1x4-0005yi-At; Tue, 13 Nov 2007 23:01:38 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64844>


Signed-off-by: Sergei Organov <osv@javad.com>
---
 Documentation/user-manual.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index d99adc6..a169ef0 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -475,7 +475,7 @@ Bisecting: 3537 revisions left to test after this
 If you run "git branch" at this point, you'll see that git has
 temporarily moved you to a new branch named "bisect".  This branch
 points to a commit (with commit id 65934...) that is reachable from
-v2.6.19 but not from v2.6.18.  Compile and test it, and see whether
+"master" but not from v2.6.18.  Compile and test it, and see whether
 it crashes.  Assume it does crash.  Then:
 
 -------------------------------------------------
@@ -1367,7 +1367,7 @@ If you make a commit that you later wish you hadn't, there are two
 fundamentally different ways to fix the problem:
 
 	1. You can create a new commit that undoes whatever was done
-	by the previous commit.  This is the correct thing if your
+	by the old commit.  This is the correct thing if your
 	mistake has already been made public.
 
 	2. You can go back and modify the old commit.  You should
@@ -1567,8 +1567,8 @@ old history using, for example,
 $ git log master@{1}
 -------------------------------------------------
 
-This lists the commits reachable from the previous version of the head.
-This syntax can be used to with any git command that accepts a commit,
+This lists the commits reachable from the previous version of the branch.
+This syntax can be used with any git command that accepts a commit,
 not just with git log.  Some other examples:
 
 -------------------------------------------------
-- 
1.5.3.4
