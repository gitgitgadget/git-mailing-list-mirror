From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: [PATCH] Fix some documentation typoes
Date: Mon, 29 May 2006 17:11:28 -0400
Message-ID: <200605292111.k4TLBSfg014284@laptop11.inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Mon May 29 23:11:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkp1Q-0002iT-Uv
	for gcvg-git@gmane.org; Mon, 29 May 2006 23:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWE2VLa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 17:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbWE2VLa
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 17:11:30 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:41682 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751302AbWE2VLa (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 17:11:30 -0400
Received: from laptop11.inf.utfsm.cl (laptop11.inf.utfsm.cl [200.1.19.198])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k4TLBSxc032042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 29 May 2006 17:11:28 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k4TLBSfg014284
	for <git@vger.kernel.org>; Mon, 29 May 2006 17:11:28 -0400
To: git@vger.kernel.org
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 29 May 2006 17:11:28 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20972>

Fix some typoes in Documentation/everyday.txt

Signed-off-by:  Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 Documentation/everyday.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index 3ab9b91..a3f3a65 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -65,7 +65,7 @@ Check health and remove cruft.::
 <1> running without "--full" is usually cheap and assures the
 repository health reasonably well.
 <2> check how many loose objects there are and how much
-diskspace is wasted by not repacking.
+disk space is wasted by not repacking.
 <3> without "-a" repacks incrementally.  repacking every 4-5MB
 of loose objects accumulation may be a good rule of thumb.
 <4> after repack, prune removes the duplicate loose objects.
@@ -86,7 +86,7 @@ Individual Developer (Standalone)[[Indiv
 ----------------------------------------------------------------------
 
 A standalone individual developer does not exchange patches with
-other poeple, and works alone in a single repository, using the
+other people, and works alone in a single repository, using the
 following commands.
 
   * gitlink:git-show-branch[1] to see where you are.
@@ -371,7 +371,7 @@ Examples
 Run git-daemon to serve /pub/scm from inetd.::
 +
 ------------
-$ grep git /etc/inet.conf
+$ grep git /etc/inetd.conf
 git	stream	tcp	nowait	nobody \
   /usr/bin/git-daemon git-daemon --inetd --syslog --export-all /pub/scm
 ------------
-- 
1.3.3.g0f0ac
