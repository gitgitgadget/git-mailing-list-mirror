From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] Update the documentation for git-merge-base
Date: Tue, 16 May 2006 07:58:15 +0200
Message-ID: <20060516055815.GA4572@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 07:58:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfsZh-0001dm-TV
	for gcvg-git@gmane.org; Tue, 16 May 2006 07:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbWEPF6R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 01:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWEPF6R
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 01:58:17 -0400
Received: from mxfep01.bredband.com ([195.54.107.70]:63875 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1751512AbWEPF6R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 01:58:17 -0400
Received: from c165 ([213.114.27.63] [213.114.27.63])
          by mxfep01.bredband.com with ESMTP
          id <20060516055815.OHNJ19930.mxfep01.bredband.com@c165>;
          Tue, 16 May 2006 07:58:15 +0200
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FfsZT-0001NM-00; Tue, 16 May 2006 07:58:15 +0200
To: junkio@cox.net
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20102>


Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

Is the code guaranteed to return a least common ancestor? If that is
the case we should probably mention it in the documentation.


 Documentation/git-merge-base.txt |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index d1d56f1..6099be2 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -8,16 +8,26 @@ git-merge-base - Finds as good a common 
 
 SYNOPSIS
 --------
-'git-merge-base' <commit> <commit>
+'git-merge-base' [--all] <commit> <commit>
 
 DESCRIPTION
 -----------
-"git-merge-base" finds as good a common ancestor as possible. Given a
-selection of equally good common ancestors it should not be relied on
-to decide in any particular way.
+
+"git-merge-base" finds as good a common ancestor as possible between
+the two commits. That is, given two commits A and B 'git-merge-base A
+B' will output a commit which is reachable from both A and B through
+the parent relationship.
+
+Given a selection of equally good common ancestors it should not be
+relied on to decide in any particular way.
 
 The "git-merge-base" algorithm is still in flux - use the source...
 
+OPTIONS
+-------
+--all::
+	Output all common ancestors for the two commits instead of
+	just one.
 
 Author
 ------
