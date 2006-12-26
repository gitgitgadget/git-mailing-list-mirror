From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] add git-reflog to .gitignore
Date: Tue, 26 Dec 2006 14:08:08 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612261405420.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 26 20:08:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzHen-0005nE-7I
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 20:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932745AbWLZTIK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Dec 2006 14:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932757AbWLZTIK
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 14:08:10 -0500
Received: from relais.videotron.ca ([24.201.245.36]:40582 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932745AbWLZTIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 14:08:09 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JAW00908AHKCMF0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 26 Dec 2006 14:08:08 -0500 (EST)
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35428>


... and move git-blame with the other commands.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
diff --git a/.gitignore b/.gitignore
index 91e6966..60e5002 100644
--- a/.gitignore
+++ b/.gitignore
@@ -11,6 +11,7 @@ git-applypatch
 git-archimport
 git-archive
 git-bisect
+git-blame
 git-branch
 git-cat-file
 git-check-ref-format
@@ -88,6 +89,7 @@ git-quiltimport
 git-read-tree
 git-rebase
 git-receive-pack
+git-reflog
 git-relink
 git-repack
 git-repo-config
@@ -153,4 +155,3 @@ config.status
 config.mak.autogen
 config.mak.append
 configure
-git-blame
