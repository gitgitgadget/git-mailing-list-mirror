From: Martin Atukunda <matlads@dsmagic.com>
Subject: [PATCH] Fix the usage strings for cg-clone and cg-log
Date: Thu, 22 Sep 2005 11:00:25 +0300
Message-ID: <20050922080025.GA22631@igloo.ds.co.ug>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 22 10:05:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIM3C-0001xU-1k
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 10:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbVIVIDX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 04:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbVIVIDW
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 04:03:22 -0400
Received: from mail1.imul.com ([217.113.72.31]:22354 "EHLO mail1.infocom.co.ug")
	by vger.kernel.org with ESMTP id S1751436AbVIVIDV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 04:03:21 -0400
Received: from entandikwa.ds.co.ug ([::ffff:217.113.73.39])
  by mail1.infocom.co.ug with esmtp; Thu, 22 Sep 2005 11:03:02 +0300
  id 000E9B63.43326536.00000B8A
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP id D6B3B4ED3
	for <git@vger.kernel.org>; Thu, 22 Sep 2005 11:04:29 +0300 (EAT)
Received: from matlads by igloo.ds.co.ug with local (Exim 4.52)
	id 1EIM0H-0006ML-Lw
	for git@vger.kernel.org; Thu, 22 Sep 2005 11:00:25 +0300
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9094>


Signed-Off-By: Martin Atukunda <matlads@dsmagic.com>

---

 cg-clone |    2 +-
 cg-log   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

1a32f441ba9650b90cfc08bb383bcb02eb9101df
diff --git a/cg-clone b/cg-clone
--- a/cg-clone
+++ b/cg-clone
@@ -27,7 +27,7 @@
 #	Clone in the current directory instead of creating a new one.
 #	Specifying both -s and a destination directory makes no sense.
 
-USAGE="cg-clone [-s] LOCATION [DESTDIR]"
+USAGE="cg-clone [-l] [-s] LOCATION [DESTDIR]"
 _git_repo_unneeded=1
 
 . ${COGITO_LIB}cg-Xlib || exit 1
diff --git a/cg-log b/cg-log
--- a/cg-log
+++ b/cg-log
@@ -78,7 +78,7 @@
 #
 #	$ cg-log -r releasetag-0.9:releasetag-0.10
 
-USAGE="cg-log [-c] [-f] [-m] [-s] [-uUSERNAME] [-r FROM_ID[:TO_ID]] FILE..."
+USAGE="cg-log [-c] [-f] [-m] [-s] [-uUSERNAME] [-d DATE] [-r FROM_ID[:TO_ID]] FILE..."
 
 . ${COGITO_LIB}cg-Xlib || exit 1
 # Try to fix the annoying "Broken pipe" output. May not help, but apparently
