From: "Vitaly \"_Vi\" Shukela" <public_vi@tut.by>
Subject: [PATCH 2/3] git-svn: documented --ignore-paths
Date: Sun, 25 Jan 2009 21:49:03 +0200
Message-ID: <1232912944-27076-2-git-send-email-public_vi@tut.by>
References: <1232912944-27076-1-git-send-email-public_vi@tut.by>
Cc: git@vger.kernel.org, "Vitaly \"_Vi\" Shukela" <public_vi@tut.by>
To: trast@student.ethz.ch
X-From: git-owner@vger.kernel.org Sun Jan 25 20:51:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRB0s-0008Lv-Na
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 20:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbZAYTtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 14:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbZAYTtv
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 14:49:51 -0500
Received: from mail.tut.by ([195.137.160.40]:48493 "EHLO speedy.tutby.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015AbZAYTtu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 14:49:50 -0500
Received: from [93.125.21.130] (account public_vi@tut.by HELO localhost.localdomain)
  by speedy.tutby.com (CommuniGate Pro SMTP 5.1.12)
  with ESMTPSA id 136551232; Sun, 25 Jan 2009 21:49:37 +0200
X-Mailer: git-send-email 1.6.1.288.gff3b4
In-Reply-To: <1232912944-27076-1-git-send-email-public_vi@tut.by>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107090>


Signed-off-by: Vitaly "_Vi" Shukela <public_vi@tut.by>
---
 Documentation/git-svn.txt |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 63d2f5e..2215fcb 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -103,6 +103,19 @@ repository to be able to interoperate with someone else's local Git
 repository, either don't use this option or you should both use it in
 the same local timezone.
 
+--ignore-paths=<regex>;;
+	This allows one to specify Perl regular expression that will
+	cause skipping of all matching paths from checkout from SVN.
+	Examples: 
+
+	--ignore-paths="^doc" - skip "doc*" directory for every fetch.
+
+	--ignore-paths="^[^/]+/(?:branches|tags)" - skip "branches"
+	    and "tags" of first level directories.
+
+	Regular expression is not persistent, you should specify
+	it every time when fetching.
+
 'clone'::
 	Runs 'init' and 'fetch'.  It will automatically create a
 	directory based on the basename of the URL passed to it;
-- 
1.6.1.288.gff3b4
