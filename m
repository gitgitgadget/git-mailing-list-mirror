From: "Vitaly \"_Vi\" Shukela" <public_vi@tut.by>
Subject: [PATCH] git-svn: documented --ignore-paths
Date: Mon, 26 Jan 2009 00:21:41 +0200
Message-ID: <1232922102-6144-2-git-send-email-public_vi@tut.by>
References: <1232922102-6144-1-git-send-email-public_vi@tut.by>
Cc: "Vitaly \"_Vi\" Shukela" <public_vi@tut.by>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 23:26:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRDR5-0003cx-L0
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 23:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbZAYWZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 17:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbZAYWZE
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 17:25:04 -0500
Received: from mail.tut.by ([195.137.160.40]:53381 "EHLO speedy.tutby.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769AbZAYWZD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 17:25:03 -0500
Received: from [91.149.148.191] (account public_vi@tut.by HELO localhost.localdomain)
  by speedy.tutby.com (CommuniGate Pro SMTP 5.1.12)
  with ESMTPSA id 136627226; Mon, 26 Jan 2009 00:22:15 +0200
X-Mailer: git-send-email 1.6.1.288.gff3b4
In-Reply-To: <1232922102-6144-1-git-send-email-public_vi@tut.by>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107112>

Documented --ignore-paths option of git-svn to inform users about
the feature and provide some examples.

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
1.5.6.5
