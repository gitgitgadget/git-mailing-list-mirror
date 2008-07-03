From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH 06/15] Documentation: rewrap to prepare for "git-" vs "git
 " change
Date: Thu, 3 Jul 2008 00:20:21 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807030013570.16085@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
 <7viqvqov01.fsf@gitster.siamese.dyndns.org> <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 10:25:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEK7n-0002yW-Cg
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 10:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755579AbYGCG7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754746AbYGCG56
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:57:58 -0400
Received: from smtp01.uchicago.edu ([128.135.12.77]:39821 "EHLO
	smtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780AbYGCFUf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 01:20:35 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id m635KMiQ009129;
	Thu, 3 Jul 2008 00:20:22 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m635KL2N018832;
	Thu, 3 Jul 2008 00:20:21 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87241>

Rewrap lines in preparation for added dashes.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 Documentation/config.txt      |    4 ++--
 Documentation/user-manual.txt |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 52d01b8..498247a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -627,8 +627,8 @@ gc.autopacklimit::
 gc.packrefs::
 	`git gc` does not run `git pack-refs` in a bare repository by
 	default so that older dumb-transport clients can still fetch
-	from the repository.  Setting this to `true` lets `git
-	gc` to run `git pack-refs`.  Setting this to `false` tells
+	from the repository.  Setting this to `true` lets `git gc`
+	to run `git pack-refs`.  Setting this to `false` tells
 	`git gc` never to run `git pack-refs`. The default setting is
 	`notbare`. Enable it only when you know you do not have to
 	support such clients.  The default setting will change to `true`
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index cbfc5d0..61cf30f 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2443,8 +2443,8 @@ patches to the new mywork.  The result will look like:
 ................................................
 
 In the process, it may discover conflicts.  In that case it will stop
-and allow you to fix the conflicts; after fixing conflicts, use "git
-add" to update the index with those contents, and then, instead of
+and allow you to fix the conflicts; after fixing conflicts, use "git add"
+to update the index with those contents, and then, instead of
 running git-commit, just run
 
 -------------------------------------------------
@@ -2700,8 +2700,8 @@ master branch.  In more detail:
 git fetch and fast-forwards
 ---------------------------
 
-In the previous example, when updating an existing branch, "git
-fetch" checks to make sure that the most recent commit on the remote
+In the previous example, when updating an existing branch, "git fetch"
+checks to make sure that the most recent commit on the remote
 branch is a descendant of the most recent commit on your copy of the
 branch before updating your copy of the branch to point at the new
 commit.  Git calls this process a <<fast-forwards,fast forward>>.
-- 
1.5.5.GIT
