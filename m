From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH 03/15] manpages: fix bogus whitespace
Date: Thu, 3 Jul 2008 00:03:54 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0807022354520.16085@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
 <7viqvqov01.fsf@gitster.siamese.dyndns.org> <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 09:02:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEIpd-0003HF-3R
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 09:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231AbYGCG7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753135AbYGCG5y
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:57:54 -0400
Received: from smtp01.uchicago.edu ([128.135.12.77]:59224 "EHLO
	smtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529AbYGCFER (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 01:04:17 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id m6353t8K008037;
	Thu, 3 Jul 2008 00:03:55 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m6353s0I018392;
	Thu, 3 Jul 2008 00:03:54 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0807022322380.16085@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87230>

It's distracting.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>
---
 Documentation/git-fast-import.txt  |    2 +-
 Documentation/git-format-patch.txt |    8 ++++----
 Documentation/git-gui.txt          |    4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 70cc8e8..9602764 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -86,7 +86,7 @@ OPTIONS
 
 --quiet::
 	Disable all non-fatal output, making fast-import silent when it
-	is successful.	This option disables the output shown by
+	is successful.  This option disables the output shown by
 	\--stats.
 
 --stats::
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 3c9192a..b990052 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -175,10 +175,10 @@ and file suffix, and number patches when outputting more than one.
 
 ------------
 [format]
-        headers = "Organization: git-foo\n"
-        subjectprefix = CHANGE
-        suffix = .txt
-        numbered = auto
+	headers = "Organization: git-foo\n"
+	subjectprefix = CHANGE
+	suffix = .txt
+	numbered = auto
 	cc = <email>
 ------------
 
diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index 940e43f..ea1e4ce 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -34,7 +34,7 @@ blame::
 
 browser::
 	Start a tree browser showing all files in the specified
-	commit (or 'HEAD' by default).	Files selected through the
+	commit (or 'HEAD' by default).  Files selected through the
 	browser are opened in the blame viewer.
 
 citool::
@@ -61,7 +61,7 @@ git gui blame Makefile::
 git gui blame v0.99.8 Makefile::
 
 	Show the contents of 'Makefile' in revision 'v0.99.8'
-	and provide annotations for each line.	Unlike the above
+	and provide annotations for each line.  Unlike the above
 	example the file is read from the object database and not
 	the working directory.
 
-- 
1.5.5.GIT
