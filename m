From: Matthias Kestenholz <matthias@spinlock.ch>
Subject: [PATCH] fix various typos in documentation
Date: Wed, 3 May 2006 12:51:40 +0200
Message-ID: <20060503105140.GA10627@spinlock.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-From: git-owner@vger.kernel.org Wed May 03 12:52:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbExg-00010R-7R
	for gcvg-git@gmane.org; Wed, 03 May 2006 12:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbWECKwA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 06:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbWECKwA
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 06:52:00 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:42521 "EHLO XSMTP0.ethz.ch")
	by vger.kernel.org with ESMTP id S965147AbWECKv7 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 May 2006 06:51:59 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.2499);
	 Wed, 3 May 2006 12:51:58 +0200
Received: from spinlock.ch ([129.132.210.205]) by xfe0.d.ethz.ch with Microsoft SMTPSVC(6.0.3790.2499);
	 Wed, 3 May 2006 12:51:57 +0200
Received: (nullmailer pid 10730 invoked by uid 1000);
	Wed, 03 May 2006 10:51:40 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Editor: Vim http://www.vim.org/
X-Operating-System: GNU/Linux 2.6.17-rc3-g532f57da (i686)
X-GPG-Fingerprint: 249B 3CE7 E6AE 4A1F F24A  DC44 B546 3304 690B 13F9
User-Agent: Mutt/1.5.11+cvs20060403
X-OriginalArrivalTime: 03 May 2006 10:51:57.0961 (UTC) FILETIME=[996DE790:01C66E9F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19468>

Signed-off-by: Matthias Kestenholz <matthias@spinlock.ch>

---

 Documentation/git-diff-tree.txt    |    2 +-
 Documentation/git-update-index.txt |    2 +-
 revision.c                         |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

3b68af9927782ef8b602cca0cdcc446c4dd468ca
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index 2169169..906830d 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -92,7 +92,7 @@ separated with a single space are given.
 	Furthermore, it lists only files which were modified
 	from all parents.
 
--cc::
+--cc::
 	This flag changes the way a merge commit patch is displayed,
 	in a similar way to the '-c' option. It implies the '-c'
 	and '-p' options and further compresses the patch output
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index d4137fc..74844d1 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git-update-index'
 	     [--add] [--remove | --force-remove] [--replace] 
-	     [--refresh [-q] [--unmerged] [--ignore-missing]]
+	     [--refresh] [-q] [--unmerged] [--ignore-missing]
 	     [--cacheinfo <mode> <object> <file>]\*
 	     [--chmod=(+|-)x]
 	     [--assume-unchanged | --no-assume-unchanged]
diff --git a/revision.c b/revision.c
index ad78efd..c6e8702 100644
--- a/revision.c
+++ b/revision.c
@@ -574,7 +574,7 @@ int setup_revisions(int argc, const char
 				revs->max_count = atoi(arg + 12);
 				continue;
 			}
-			/* accept -<digit>, like traditilnal "head" */
+			/* accept -<digit>, like traditional "head" */
 			if ((*arg == '-') && isdigit(arg[1])) {
 				revs->max_count = atoi(arg + 1);
 				continue;
-- 
1.3.1.g7464
