From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: [PATCH] Documentation: Add missing git svn commands
Date: Tue, 20 May 2008 00:47:28 +0200
Message-ID: <48320380.6090200@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: junio@pobox.com, normalperson@yhbt.net
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 20 00:48:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyE9V-0007ng-Ii
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 00:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756918AbYESWrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2008 18:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756438AbYESWrc
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 18:47:32 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:64552 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455AbYESWrb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 18:47:31 -0400
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 038FE24F8F;
	Tue, 20 May 2008 00:47:30 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 20666-02; Thu,  8 May 2008 07:37:08 +0200 (MEST)
Received: from [192.168.13.13] (85.8.6.119.static.se.wasadata.net [85.8.6.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 46B4C24F8D;
	Tue, 20 May 2008 00:47:29 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82455>

Signed-off-by: Gustaf Hendeby <hendeby@isy.liu.se>
---

I sent this one out about a week ago and haven't heard anything about 
it.  Did it just get lost in the noise, or is it just not 
interesting/incorrect in some way?

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
1.5.5.1.328.g4377c
