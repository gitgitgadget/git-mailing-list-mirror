From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH] Documentation: Add missing git svn commands
Date: Tue, 20 May 2008 09:08:58 +0200
Message-ID: <1211267338-19057-1-git-send-email-hendeby@isy.liu.se>
References: <20080520020143.GB9904@hand.yhbt.net>
Cc: git@vger.kernel.org, normalperson@yhbt.net,
	Gustaf Hendeby <hendeby@isy.liu.se>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue May 20 09:09:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyLys-0005i4-Ve
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 09:09:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588AbYETHJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 03:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755182AbYETHJD
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 03:09:03 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:52425 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044AbYETHJB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 03:09:01 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id C16D2259B1;
	Tue, 20 May 2008 09:08:59 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 22679-04; Thu,  8 May 2008 07:37:08 +0200 (MEST)
Received: from pluring.isy.liu.se (pluring.isy.liu.se [130.236.56.134])
	by bogotron.isy.liu.se (Postfix) with ESMTP id F40CD2594F;
	Tue, 20 May 2008 09:08:58 +0200 (MEST)
Received: by pluring.isy.liu.se (Postfix, from userid 2087)
	id E45F4177A0; Tue, 20 May 2008 09:08:58 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.445.g65fa
In-Reply-To: <20080520020143.GB9904@hand.yhbt.net>
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82470>

Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
Acked-by: Eric Wong <normalperson@yhbt.net>
---

I'm sorry Junio, when resending the patch I simply did a forward of
the original post and it didn't cross my mind that it would mangle the
whitespaces.  This one should apply cleanly on top of master.

Thanks for the great job!

/Gustaf

 Documentation/git-svn.txt |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index f4ba105..c02f220 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -189,10 +189,10 @@ All arguments are passed directly to `git blame'.
 	independently of git-svn functions.
 
 'create-ignore'::
-
 	Recursively finds the svn:ignore property on directories and
 	creates matching .gitignore files. The resulting files are staged to
-	be committed, but are not committed.
+	be committed, but are not committed. Use -r/--revision to refer to a
+	specfic revision.
 
 'show-ignore'::
 	Recursively finds and lists the svn:ignore property on
@@ -216,6 +216,19 @@ All arguments are passed directly to `git blame'.
 	argument.  Use the --url option to output only the value of the
 	'URL:' field.
 
+'proplist'::
+	Lists the properties stored in the Subversion repository about a
+	given file or directory.  Use -r/--revision to refer to a specific
+	Subversion revision.
+
+'propget'::
+	Gets the Subversion property given as the first argument, for a
+	file.  A specific revision can be specified with -r/--revision.
+
+'show-externals'::
+	Shows the Subversion externals.  Use -r/--revision to specify a
+	specific revision.
+
 --
 
 OPTIONS
-- 
1.5.5.1.445.g65fa
