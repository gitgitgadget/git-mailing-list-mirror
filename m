From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] filter-branch: a few more touch ups to the man page
Date: Wed, 4 Jul 2007 15:50:45 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707041546510.4071@racer.site>
References: <Pine.LNX.4.64.0707031746400.4071@racer.site>
 <20070703220540.GN12721@planck.djpig.de> <Pine.LNX.4.64.0707040004200.4071@racer.site>
 <20070704112900.GO12721@planck.djpig.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Wed Jul 04 16:50:59 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I66C2-0004t5-OR
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 16:50:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757130AbXGDOu4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 10:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758184AbXGDOu4
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 10:50:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:43753 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756276AbXGDOuz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 10:50:55 -0400
Received: (qmail invoked by alias); 04 Jul 2007 14:50:53 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 04 Jul 2007 16:50:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/tMix90NPtag73V05n7Iv9O1YY7s9Vt48555zLej
	tIahkiV1s5nMxE
X-X-Sender: gene099@racer.site
In-Reply-To: <20070704112900.GO12721@planck.djpig.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51618>


All based on comments from Frank Lichtenheld.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---


	On Wed, 4 Jul 2007, Frank Lichtenheld wrote:

	> On Wed, Jul 04, 2007 at 12:17:05AM +0100, Johannes Schindelin wrote:
	> > 
	> > On Wed, 4 Jul 2007, Frank Lichtenheld wrote:
	> > 
	> > > General note: All the stuff in all uppercase should probably 
	> > > also have some asciidoc emphasis.
	>
	> [...] it is used at least in the case of WARNING as a means of 
	> emphasis and this should be reflected in the end result as 
	> markup. So I still suggest changing it to *WARNING* or even 
	> *Warning* if you don't want to double the emphasis.
	> 
	> > Also, GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, GIT_AUTHOR_DATE, 
	> > GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL, and 
	> > GIT_COMMITTER_DATE is set according to the current commit.
	> 
	> "are" set. And yeah, it doesn't look pretty. I still prefer 
	> having the list somewhere in the text, though.
	> 
	> > > > +      Only regard the history, as seen by the given [...]
	> > >                                ^^^
	> > > Does this comma belong there?
	> > 
	> > This is my bad English. What I meant was this:
	> > 
	> > Only ever look at the history, which touches the given
	> > subdirectory.  The result will contain that directory as its
	> > project root.
	> 
	> I'm still not sure there should be a comma in this sentence, but 
	> my English grammar is a bit rusty.

	Better?

 Documentation/git-filter-branch.txt |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 2074f31..363287d 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -31,7 +31,7 @@ branch as your current branch.  Nevertheless, this may be useful in
 the future for compensating for some git bugs or such, therefore
 such a usage is permitted.
 
-WARNING! The rewritten history will have different object names for all
+*WARNING*! The rewritten history will have different object names for all
 the objects and will not converge with the original branch.  You will not
 be able to easily push and distribute the rewritten branch on top of the
 original branch.  Please do not use this command if you do not know the
@@ -54,7 +54,7 @@ argument is always evaluated in shell using the 'eval' command.
 Prior to that, the $GIT_COMMIT environment variable will be set to contain
 the id of the commit being rewritten.  Also, GIT_AUTHOR_NAME,
 GIT_AUTHOR_EMAIL, GIT_AUTHOR_DATE, GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL,
-and GIT_COMMITTER_DATE is set according to the current commit.
+and GIT_COMMITTER_DATE are set according to the current commit.
 
 A 'map' function is available that takes an "original sha1 id" argument
 and outputs a "rewritten sha1 id" if the commit has been already
@@ -78,7 +78,7 @@ OPTIONS
 	directory set to the root of the checked out tree.  The new tree
 	is then used as-is (new files are auto-added, disappeared files
 	are auto-removed - neither .gitignore files nor any other ignore
-	rules HAVE ANY EFFECT!).
+	rules *HAVE ANY EFFECT*!).
 
 --index-filter <command>::
 	This is the filter for rewriting the index.  It is similar to the
@@ -128,8 +128,9 @@ attached, the rewritten tag won't have it.  Sorry.  (It is by
 definition impossible to preserve signatures at any rate.)
 
 --subdirectory-filter <directory>::
-	Only ever look at the history, which touches the given subdirectory.
-	The result will contain that directory as its project root.
+	Only look at the history which touches the given subdirectory.
+	The result will contain that directory (and only that) as its
+	project root.
 
 -d <directory>::
 	Use this option to set the path to the temporary directory used for
-- 
1.5.3.rc0.2663.gfbb70
