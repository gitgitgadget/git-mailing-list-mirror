From: Sven Verdoolaege <skimo@kotnet.org>
Subject: git-cvsimport-script: clean up documentation
Date: Sun, 3 Jul 2005 12:37:54 +0200
Message-ID: <20050703103753.GL5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <20050630150239.GA20928@pc117b.liacs.nl> <20050630152125.GO10850@kiste.smurf.noris.de> <20050630154453.GA26808@pc117b.liacs.nl> <20050630161043.GR10850@kiste.smurf.noris.de> <20050630161423.GC26808@pc117b.liacs.nl> <20050630163000.GT10850@kiste.smurf.noris.de> <Pine.LNX.4.63.0506301321350.1667@localhost.localdomain> <pan.2005.07.01.09.43.24.106822@smurf.noris.de> <20050703103517.GJ5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jul 03 12:55:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dp285-0002xg-RS
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 12:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261280AbVGCKyg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 06:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVGCKyf
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 06:54:35 -0400
Received: from spoetnik.kulnet.kuleuven.ac.be ([134.58.240.46]:52413 "EHLO
	spoetnik.kulnet.kuleuven.ac.be") by vger.kernel.org with ESMTP
	id S261280AbVGCKyO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2005 06:54:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by spoetnik.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 026A333EEC
	for <git@vger.kernel.org>; Sun,  3 Jul 2005 12:54:13 +0200 (CEST)
Received: from octavianus.kulnet.kuleuven.ac.be (octavianus.kulnet.kuleuven.ac.be [134.58.240.71])
	by spoetnik.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 35C9C33EE8
	for <git@vger.kernel.org>; Sun,  3 Jul 2005 12:54:11 +0200 (CEST)
Received: from garage.linux.student.kuleuven.ac.be (garage.linux.student.kuleuven.be [193.190.253.84])
	by octavianus.kulnet.kuleuven.ac.be (Postfix) with ESMTP id 23A75AED86
	for <git@vger.kernel.org>; Sun,  3 Jul 2005 12:54:11 +0200 (CEST)
Received: (qmail 17746 invoked by uid 500); 3 Jul 2005 10:37:54 -0000
To: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
Mail-Followup-To: Matthias Urlichs <smurf@smurf.noris.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050703103517.GJ5992MdfPADPa@garage.linux.student.kuleuven.ac.be>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by KULeuven Antivirus Cluster
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

git-cvsimport-script: clean up documentation

Remove documentation of irrelevant "type" option.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>

---
commit a92bebe6978edaea2885a627e7bef6f7f8b208c2
tree 25e9a3324ac489b7987be562923fd8e81a5de358
parent f9714a4a0cd4ed0ccca3833743d98ea874a2232d
author Sven Verdoolaege <skimo@kotnet.org> Sun, 03 Jul 2005 11:38:06 +0200
committer Sven Verdoolaege <skimo@kotnet.org> Sun, 03 Jul 2005 11:40:45 +0200

 Documentation/git-cvsimport-script.txt |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-cvsimport-script.txt b/Documentation/git-cvsimport-script.txt
--- a/Documentation/git-cvsimport-script.txt
+++ b/Documentation/git-cvsimport-script.txt
@@ -48,14 +48,6 @@ OPTIONS
 <CVS_module>::
 	The CVS module you want to import. Relative to <CVSROOT>.
 
-<type>::
-	Typically this matches the real type of <object> but asking
-	for a type that can trivially dereferenced from the given
-	<object> is also permitted.  An example is to ask for a
-	"tree" with <object> being a commit object that contains it,
-	or to ask for a "blob" with <object> being a tag object that
-	points at it.
-
 -h::
 	Print a short usage message and exit.
 
