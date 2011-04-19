From: Stefan Sperling <stsp@stsp.name>
Subject: [PATCH] remove noise and inaccuracies from git-svn docs
Date: Tue, 19 Apr 2011 11:06:46 +0200
Message-ID: <1303204006-24191-1-git-send-email-stsp@stsp.name>
References: <7v39lfa1h5.fsf@alter.siamese.dyndns.org>
Cc: Stefan Sperling <stsp@stsp.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 11:07:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QC6uG-0006sR-Ir
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 11:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836Ab1DSJHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 05:07:32 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:46478 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab1DSJHb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 05:07:31 -0400
X-Envelope-From: stsp@stsp.name
Received: from ted.stsp.name (ted.stsp.name [217.197.84.34])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p3J97T7h028780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 19 Apr 2011 11:07:29 +0200
Received: from ted.stsp.name (stsp@localhost [127.0.0.1])
	by ted.stsp.name (8.14.3/8.14.3) with ESMTP id p3J97T55026315;
	Tue, 19 Apr 2011 11:07:29 +0200 (CEST)
Received: (from stsp@localhost)
	by ted.stsp.name (8.14.3/8.14.3/Submit) id p3J97Ttq021710;
	Tue, 19 Apr 2011 11:07:29 +0200 (CEST)
X-Mailer: git-send-email 1.7.3.5
In-Reply-To: <7v39lfa1h5.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171783>

Signed-off-by: Stefan Sperling <stsp@stsp.name>
---
 Documentation/git-svn.txt |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 4aa6404..fedf310 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -767,10 +767,9 @@ use `git svn rebase` to update your work branch instead of `git pull` or
 when committing into SVN, which can lead to merge commits reversing
 previous commits in SVN.
 
-DESIGN PHILOSOPHY
------------------
-Merge tracking in Subversion is lacking and doing branched development
-with Subversion can be cumbersome as a result.  While 'git svn' can track
+MERGE TRACKING
+--------------
+While 'git svn' can track
 copy history (including branches and tags) for repositories adopting a
 standard layout, it cannot yet represent merge history that happened
 inside git back upstream to SVN users.  Therefore it is advised that
@@ -780,16 +779,15 @@ compatibility with SVN (see the CAVEATS section below).
 CAVEATS
 -------
 
-For the sake of simplicity and interoperating with a less-capable system
-(SVN), it is recommended that all 'git svn' users clone, fetch and dcommit
+For the sake of simplicity and interoperating with Subversion,
+it is recommended that all 'git svn' users clone, fetch and dcommit
 directly from the SVN server, and avoid all 'git clone'/'pull'/'merge'/'push'
 operations between git repositories and branches.  The recommended
 method of exchanging code between git branches and users is
 'git format-patch' and 'git am', or just 'dcommit'ing to the SVN repository.
 
 Running 'git merge' or 'git pull' is NOT recommended on a branch you
-plan to 'dcommit' from.  Subversion does not represent merges in any
-reasonable or useful fashion; so users using Subversion cannot see any
+plan to 'dcommit' from because Subversion users cannot see any
 merges you've made.  Furthermore, if you merge or pull from a git branch
 that is a mirror of an SVN branch, 'dcommit' may commit to the wrong
 branch.
@@ -839,7 +837,7 @@ Renamed and copied directories are not detected by git and hence not
 tracked when committing to SVN.  I do not plan on adding support for
 this as it's quite difficult and time-consuming to get working for all
 the possible corner cases (git doesn't do it, either).  Committing
-renamed and copied files are fully supported if they're similar enough
+renamed and copied files is fully supported if they're similar enough
 for git to detect them.
 
 CONFIGURATION
-- 
1.7.3.5
