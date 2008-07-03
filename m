From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH 12/15] manpages: italicize gitk's name (where it was in
 teletype font)
Date: Thu, 3 Jul 2008 00:49:55 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807030045340.16085@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
 <7viqvqov01.fsf@gitster.siamese.dyndns.org> <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jonas Fonseca <fonseca@diku.dk>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Olivier Marin <dkr+ml.git@free.fr>,
	Jonas Fonseca <fonseca@diku.dk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 09:02:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEIpm-0003HF-E1
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 09:02:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbYGCG7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbYGCG6K
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:58:10 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:48351 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754931AbYGCFuF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 01:50:05 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m635ntlj023998;
	Thu, 3 Jul 2008 00:49:55 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m635ntFx019491;
	Thu, 3 Jul 2008 00:49:55 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87233>

The name `gitk` is sometimes meant to be entered at the command
prompt, but most uses are just referring to the program with that
name (not the incantation to start it).

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 Documentation/git-bisect.txt       |    2 +-
 Documentation/git-gui.txt          |    4 ++--
 Documentation/gitcore-tutorial.txt |    2 +-
 Documentation/gittutorial.txt      |    2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index c794914..c7981ef 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -98,7 +98,7 @@ During the bisection process, you can say
 $ git bisect visualize
 ------------
 
-to see the currently remaining suspects in `gitk`.  `visualize` is a bit
+to see the currently remaining suspects in 'gitk'.  `visualize` is a bit
 too long to type and `view` is provided as a synonym.
 
 If 'DISPLAY' environment variable is not set, 'git-log' is used
diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index f067772..a73201d 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -16,9 +16,9 @@ on allowing users to make changes to their repository by making
 new commits, amending existing ones, creating branches, performing
 local merges, and fetching/pushing to remote repositories.
 
-Unlike `gitk`, 'git-gui' focuses on commit generation
+Unlike 'gitk', 'git-gui' focuses on commit generation
 and single file annotation and does not show project history.
-It does however supply menu actions to start a `gitk` session from
+It does however supply menu actions to start a 'gitk' session from
 within 'git-gui'.
 
 'git-gui' is known to work on all popular UNIX systems, Mac OS X,
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index 2bbe7de..3eba973 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -878,7 +878,7 @@ means: normally it will just show you your current `HEAD`) and their
 histories. You can also see exactly how they came to be from a common
 source.
 
-Anyway, let's exit `gitk` (`^Q` or the File menu), and decide that we want
+Anyway, let's exit 'gitk' (`^Q` or the File menu), and decide that we want
 to merge the work we did on the `mybranch` branch into the `master`
 branch (which is currently our `HEAD` too). To do that, there's a nice
 script called 'git-merge', which wants to know which branches you want
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 930f690..85abc6e 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -554,7 +554,7 @@ then merged back together, the order in which 'git-log' presents
 those commits is meaningless.
 
 Most projects with multiple contributors (such as the linux kernel,
-or git itself) have frequent merges, and `gitk` does a better job of
+or git itself) have frequent merges, and 'gitk' does a better job of
 visualizing their history.  For example,
 
 -------------------------------------
-- 
1.5.5.GIT
