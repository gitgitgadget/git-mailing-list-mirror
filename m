From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Minor doc fixes
Date: Mon, 29 May 2006 02:12:14 +0200
Message-ID: <20060529001214.GC2061@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 29 02:12:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkVN4-00086p-2Z
	for gcvg-git@gmane.org; Mon, 29 May 2006 02:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWE2AMU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 20:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbWE2AMU
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 20:12:20 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:51879 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751074AbWE2AMU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 May 2006 20:12:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id EA78E770026;
	Mon, 29 May 2006 02:12:18 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08620-03; Mon, 29 May 2006 02:12:14 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id B180C77002D;
	Mon, 29 May 2006 02:12:14 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id E36C76DF894; Mon, 29 May 2006 02:09:06 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 9FB346253D; Mon, 29 May 2006 02:12:14 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20911>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

1e376c11029a33deb811b77565fb558b6c192766
 README         |    2 +-
 README.osx     |    7 ++++---
 cogito.spec.in |    2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

1e376c11029a33deb811b77565fb558b6c192766
diff --git a/README b/README
index a53b466..e6e1119 100644
--- a/README
+++ b/README
@@ -60,7 +60,7 @@ The following tools are optional but rec
 Tool				Description
 -------------------------------------------------------------------------------
 rsync				For fetching files with the rsync backend.
-gnu coreutils			The gnu versions of stat, date and cp \
+GNU coreutils			The GNU versions of stat, date and cp \
 				are preferred over the BSD variants.
 asciidoc (>= 7.0), xmlto	For building documentation.
 -------------------------------------------------------------------------------
diff --git a/README.osx b/README.osx
index d8df872..912d9fe 100644
--- a/README.osx
+++ b/README.osx
@@ -2,8 +2,9 @@ This version of Cogito should work on OS
 
 To install on OS X:
 
-1) Install darwinports (http://darwinports.opendarwin.org/) 2) type
-"make Portfile" 3) type "sudo port install"
+ 1. Install darwinports (http://darwinports.opendarwin.org/)
+ 2. type "make Portfile"
+ 3. type "sudo port install"
 
 You may have to deal with md5 mismatches.  Either adjust the md5sum in
 your new Portfile or place the new tarball in
@@ -11,7 +12,7 @@ your new Portfile or place the new tarba
 
 Recommendations:
 
-The gnu versions of "stat" and "date" are preferred over their BSD
+The GNU versions of "stat" and "date" are preferred over their BSD
 variants.
 
 "patch", "diff", "merge", "curl" and "rsync" are required.  OS X.4
diff --git a/cogito.spec.in b/cogito.spec.in
index 5509d77..70274c1 100644
--- a/cogito.spec.in
+++ b/cogito.spec.in
@@ -70,7 +70,7 @@ rm -rf $RPM_BUILD_ROOT
 - Update summary and description
 - Make architecture-independent
 
-* Wed Jul 6 2005 Chris Wright <chris@osdl.org> 0.12-1
+* Wed Jul 6 2005 Chris Wright <chrisw@osdl.org> 0.12-1
 - update spec file
 
 * Thu Jun 9 2005 Chris Wright <chrisw@osdl.org> 0.11.3-1
-- 
1.3.3.gd882-dirty

-- 
Jonas Fonseca
