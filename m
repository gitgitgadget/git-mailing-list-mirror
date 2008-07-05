From: Nikolaus Schulz <microschulz@web.de>
Subject: [PATCH] Documentation: be precise about which date --pretty uses
Date: Sat, 5 Jul 2008 02:00:13 +0200
Message-ID: <20080705000011.GA6969@zorro.zusammrottung.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 14:19:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KF6jx-0007qs-Vg
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 14:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbYGEMSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 08:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752116AbYGEMSs
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 08:18:48 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:38210 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751684AbYGEMSr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 08:18:47 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 4AF9FE45963F
	for <git@vger.kernel.org>; Sat,  5 Jul 2008 14:18:46 +0200 (CEST)
Received: from [83.125.40.75] (helo=tunichtgut.zusammrottung.local)
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1KF6iz-0007Kz-00
	for git@vger.kernel.org; Sat, 05 Jul 2008 14:18:45 +0200
Received: from zorro.zusammrottung.local
	([192.168.178.206] helo=localhost ident=Debian-exim)
	by tunichtgut.zusammrottung.local with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nikolaus@zorro.zusammrottung.local>)
	id 1KF6iy-00037G-3Q
	for git@vger.kernel.org; Sat, 05 Jul 2008 14:18:44 +0200
Received: from nikolaus by localhost with local (Exim 4.69)
	(envelope-from <nikolaus@zorro.zusammrottung.local>)
	id 1KEvCH-0001od-KD
	for git@vger.kernel.org; Sat, 05 Jul 2008 02:00:13 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Sender: microschulz@web.de
X-Provags-ID: V01U2FsdGVkX1+RKNHnGk+pRpMWnZu717qqLoN0aQh27QI5eCV4
	TSvG14D2+q+xO9f1dFzo/W+WoJhbIw9iFUbztxx+Y+iBZNHLQk
	QPOLYqO9M=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87443>

This makes it explicit that the --pretty formats 'medium' and 'email' use the
author date (and ignore the committer date).
---
 Documentation/pretty-formats.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index ec37555..69e6d2f 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -30,7 +30,7 @@ This is designed to be as compact as possible.
 
 	  commit <sha1>
 	  Author: <author>
-	  Date: <date>
+	  Date: <author date>
 
 	      <title line>
 
@@ -50,9 +50,9 @@ This is designed to be as compact as possible.
 
 	  commit <sha1>
 	  Author: <author>
-	  AuthorDate: <date & time>
+	  AuthorDate: <author date>
 	  Commit: <committer>
-	  CommitDate: <date & time>
+	  CommitDate: <committer date>
 
 	       <title line>
 
@@ -62,7 +62,7 @@ This is designed to be as compact as possible.
 
 	  From <sha1> <date>
 	  From: <author>
-	  Date: <date & time>
+	  Date: <author date>
 	  Subject: [PATCH] <title line>
 
 	  <full commit message>
-- 
1.5.6
