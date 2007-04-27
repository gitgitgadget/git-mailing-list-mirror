From: Michael <barra_cuda@katamail.com>
Subject: [PATCH] git shortlog documentation: add long options and fix a typo
Date: Fri, 27 Apr 2007 21:56:47 +0200
Message-ID: <200704272156.47722.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 27 21:54:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhWWO-0006QN-KX
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 21:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757175AbXD0TyS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 15:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757176AbXD0TyR
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 15:54:17 -0400
Received: from slim-3a.inet.it ([213.92.5.124]:46702 "EHLO slim-3a.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757170AbXD0TyP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 15:54:15 -0400
Received: from dial-up-mi-92.lombardiacom.it ([::ffff:212.34.225.92]) by slim-3a.inet.it via I-SMTP-5.4.4-547
	id ::ffff:212.34.225.92+baNgGPpDhxE; Fri, 27 Apr 2007 21:54:13 +0200
User-Agent: KMail/1.9.4
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45749>

Signed-off-by: Michael <barra_cuda@katamail.com>
---

This patch will probably be mangled somewhere by my mailserver. Sorry.

 Documentation/git-shortlog.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index 1c8c55e..15cc6f7 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 git-log --pretty=short | 'git-shortlog' [-h] [-n] [-s]
-git-shortlog [-n|--number] [-s|--summary] [<committish>...]
+git-shortlog [-n|--numbered] [-s|--summary] [<committish>...]
 
 DESCRIPTION
 -----------
@@ -22,14 +22,14 @@ Additionally, "[PATCH]" will be stripped from the commit description.
 OPTIONS
 -------
 
--h::
+-h, \--help::
 	Print a short usage message and exit.
 
--n::
+-n, \--numbered::
 	Sort output according to the number of commits per author instead
 	of author alphabetic order.
 
--s::
+-s, \--summary::
 	Suppress commit description and provide a commit count summary only.
 
 FILES
-- 
1.5.1.2
