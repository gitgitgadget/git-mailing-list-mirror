From: Martin Atukunda <matlads@dsmagic.com>
Subject: [PATCH] Be elaborate when specifying the debs on the download page.
Date: Thu, 04 May 2006 14:37:24 +0300
Message-ID: <12477.7874014855$1146742720@news.gmane.org>
Reply-To: Martin Atukunda <matlads@dsmagic.com>
Cc: Martin Atukunda <matlads@igloo.ds.co.ug>
X-From: git-owner@vger.kernel.org Thu May 04 13:38:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fbc9x-0001YX-S6
	for gcvg-git@gmane.org; Thu, 04 May 2006 13:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932070AbWEDLiM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 07:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWEDLiM
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 07:38:12 -0400
Received: from metronet39.infocom.co.ug ([217.113.73.39]:15876 "EHLO
	entandikwa.ds.co.ug") by vger.kernel.org with ESMTP id S932070AbWEDLiL
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 4 May 2006 07:38:11 -0400
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP id 91B655255
	for <git@vger.kernel.org>; Thu,  4 May 2006 14:40:14 +0300 (EAT)
Received: from [127.0.0.1] (helo=localhost.localdomain)
	by igloo.ds.co.ug with esmtp (Exim 4.61)
	(envelope-from <matlads@dsmagic.com>)
	id 1Fbc97-0001S1-Hf
	for git@vger.kernel.org; Thu, 04 May 2006 14:37:25 +0300
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.1.g7464
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19565>

From: Martin Atukunda <matlads@igloo.ds.co.ug>

Junio hasn't done the debian packages for git in a while, and as
such the location specified on the site is outdated. Incidentally
git-core _is_ packaged for debian and versions of it are in unstable
and testing. There is a version for stable maintained at backports.org.

This commit modifies the downloads page to reflect these changes.

Signed-Off-By: Martin Atukunda <matlads@dsmagic.com>

---

 download.html |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

e3416893f5aaa3fe464bc1f8a0add75deb3fb0f5
diff --git a/download.html b/download.html
index 3a3d4e6..315dff1 100644
--- a/download.html
+++ b/download.html
@@ -56,7 +56,20 @@
 <dd><a href="http://kernel.org/pub/software/scm/git/RPMS/">http://kernel.org/pub/software/scm/git/RPMS/</a></dd>
 
 <dt>Debs</dt>
-<dd><a href="http://kernel.org/pub/software/scm/git/debian/">http://kernel.org/pub/software/scm/git/debian/</a></dd>
+<dd>
+	<dl>
+		<dt>Stable</dt>
+		<dd><a href="http://www.backports.org/debian/pool/g/git-core/">http://www.backports.org/debian/pool/main/g/git-core/</a></dd>
+	</dl>
+	<dl>
+		<dt>Testing</dt>
+		<dd><a href="http://packages.debian.org/testing/devel/git-core/">http://packages.debian.org/testing/devel/git-core/</a></dd>
+	</dl>
+	<dl>
+		<dt>Unstable</dt>
+		<dd><a href="http://packages.debian.org/unstable/devel/git-core/">http://packages.debian.org/unstable/devel/git-core/</a></dd>
+	</dl>
+</dd>
 
 </dl>
 
-- 
1.3.1.g7464
