From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] Document some default values in config.txt
Date: Fri, 11 Jan 2008 22:11:13 +0100
Message-ID: <200801112211.13816.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 11 22:04:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDR30-0007lf-R7
	for gcvg-git-2@gmane.org; Fri, 11 Jan 2008 22:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760646AbYAKVDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 16:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759304AbYAKVDm
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 16:03:42 -0500
Received: from slim-3a.inet.it ([213.92.5.124]:39226 "EHLO slim-3a.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760157AbYAKVDl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 16:03:41 -0500
Received: from host224-57-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.57.224]) by slim-3a.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.57.224+8d6eLOojtiS; Fri, 11 Jan 2008 22:03:36 +0100
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70200>

This documents the default values of gc.auto, gc.autopacklimit
fetch.unpacklimit, receive.unpacklimit and transfer.unpacklimit.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 Documentation/config.txt |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1b6d6d6..6f09fee 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -473,7 +473,9 @@ fetch.unpackLimit::
 	exceeds this limit then the received pack will be stored as
 	a pack, after adding any missing delta bases.  Storing the
 	pack from a push can make the push operation complete faster,
-	especially on slow filesystems.
+	especially on slow filesystems.  If not set, the value of
+	`transfer.unpackLimit` (which in turn defaults to 100) is
+	used instead.
 
 format.numbered::
 	A boolean which can enable sequence numbers in patch subjects.
@@ -499,14 +501,14 @@ gc.auto::
 	When there are approximately more than this many loose
 	objects in the repository, `git gc --auto` will pack them.
 	Some Porcelain commands use this command to perform a
-	light-weight garbage collection from time to time.  Setting
-	this to 0 disables it.
+	light-weight garbage collection from time to time.  The
+	default value is 6700.  Setting this to 0 disables it.
 
 gc.autopacklimit::
 	When there are more than this many packs that are not
 	marked with `*.keep` file in the repository, `git gc
-	--auto` consolidates them into one larger pack.  Setting
-	this to 0 disables this.
+	--auto` consolidates them into one larger pack.  The
+	default	value is 20.  Setting this to 0 disables it.
 
 gc.packrefs::
 	`git gc` does not run `git pack-refs` in a bare repository by
@@ -861,7 +863,9 @@ receive.unpackLimit::
 	exceeds this limit then the received pack will be stored as
 	a pack, after adding any missing delta bases.  Storing the
 	pack from a push can make the push operation complete faster,
-	especially on slow filesystems.
+	especially on slow filesystems.  If not set, the value of
+	`transfer.unpackLimit` (which in turn defaults to 100) is
+	used instead.
 
 receive.denyNonFastForwards::
 	If set to true, git-receive-pack will deny a ref update which is
@@ -872,6 +876,7 @@ receive.denyNonFastForwards::
 transfer.unpackLimit::
 	When `fetch.unpackLimit` or `receive.unpackLimit` are
 	not set, the value of this variable is used instead.
+	The default value is 100.
 
 web.browser::
 	Specify a web browser that may be used by some commands.
-- 
1.5.3.5
