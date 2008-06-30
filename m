From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH 3/7] Documentation: complicate example of "man git-command"
Date: Mon, 30 Jun 2008 17:10:25 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0806301706090.7190@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jon Loeliger <jdl@jdl.com>,
	"J. Bruce Fields" <bfields@fieldses.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 00:12:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDRbW-0005Of-5q
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 00:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762913AbYF3WLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 18:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756029AbYF3WLM
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 18:11:12 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:40866 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754682AbYF3WLL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 18:11:11 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m5UMAPhg023660;
	Mon, 30 Jun 2008 17:10:26 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m5UMAPHD007836;
	Mon, 30 Jun 2008 17:10:25 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86944>

The manual page for the command invoked as "git clone" is named
git-clone(1), and similarly for the rest of the git commands.
Make sure our first example of this in tutorials makes it clear
that it is the first two words of a command line that make up the
command's name (that is: for example, the effect of "git svn
dcommit" is described in git-svn(1)).

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
	If I didn't make this change, consistency would mean
	saying "you can get documentation for a command such
	as `git-diff` with `man git-diff`", which might not be
	very enlightening.

 Documentation/gittutorial.txt |    4 ++--
 Documentation/user-manual.txt |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 3d16e3d..b833167 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -20,10 +20,10 @@ for example, to test the latest version, you may prefer to start with
 the first two chapters of link:user-manual.html[The Git User's Manual].
 
 First, note that you can get documentation for a command such as "git
-diff" with:
+log --graph" with:
 
 ------------------------------------------------
-$ man git-diff
+$ man git-log
 ------------------------------------------------
 
 It is a good idea to introduce yourself to git with your name and
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index ca4363f..36ab372 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -18,7 +18,7 @@ People needing to do actual development will also want to read
 Further chapters cover more specialized topics.
 
 Comprehensive reference documentation is available through the man
-pages.  For a command such as "git clone", just use
+pages.  For a command such as "git clone <repo>", just use
 
 ------------------------------------------------
 $ man git-clone
-- 
1.5.5.GIT
