From: Tommi Virtanen <tv@debian.org>
Subject: [PATCH] git bugfixes and cleanups, mainly Debian things
Date: Fri, 26 Aug 2005 14:00:04 +0300
Message-ID: <11250540042850-git-send-email-tv@debian.org>
References: <1125054003873-git-send-email-tv@debian.org>
Reply-To: Tommi Virtanen <tv@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tommi Virtanen <tv@debian.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 13:07:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8bwj-0006bq-Ie
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 13:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbVHZLAY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 07:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVHZLAV
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 07:00:21 -0400
Received: from i1.inoi.fi ([194.100.97.46]:56221 "EHLO mail.srv.inoi.fi")
	by vger.kernel.org with ESMTP id S1751544AbVHZLAR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 07:00:17 -0400
Received: from mail.srv.inoi.fi (localhost.localdomain [127.0.0.1])
	by mail.srv.inoi.fi (Postfix) with ESMTP id 086B4FF9DD;
	Fri, 26 Aug 2005 14:00:17 +0300 (EEST)
Received: from pooch.inoi.fi (GMMCMXXXIV.dsl.saunalahti.fi [85.76.243.135])
	by mail.srv.inoi.fi (Postfix) with ESMTP id B94D6FF7F9;
	Fri, 26 Aug 2005 14:00:17 +0300 (EEST)
Received: from pooch (pooch [127.0.0.1])
	by pooch.inoi.fi (Postfix) with SMTP id 32ADABA069;
	Fri, 26 Aug 2005 14:00:04 +0300 (EEST)
In-Reply-To: <1125054003873-git-send-email-tv@debian.org>
X-Mailer: git-send-email-script
To: git@vger.kernel.org
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7808>

Make the git deb conflict with cogito versions prior to 0.13, as those
versions used to contain git. Suggest cogito.

Signed-off-by: Tommi Virtanen <tv@debian.org>

---
commit 62e16702fdb0cdc13822470f3a19b36956fd0d78
tree bf96bcbdf1ca99390e6d6cb894da8384270c585f
parent c87030106cfbe39f0ab2ed095f30f576235328fc
author Tommi Virtanen <tv@debian.org> Fri, 26 Aug 2005 12:32:27 +0300
committer Tommi Virtanen <tv@debian.org> Fri, 26 Aug 2005 12:32:27 +0300

 debian/control |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/debian/control b/debian/control
--- a/debian/control
+++ b/debian/control
@@ -9,7 +9,8 @@ Package: git-core
 Architecture: any
 Depends: ${shlibs:Depends}, ${perl:Depends}, ${misc:Depends}, patch, rcs
 Recommends: rsync, curl, ssh, libmail-sendmail-perl, libemail-valid-perl
-Conflicts: git
+Suggests: cogito
+Conflicts: git, cogito (<< 0.13)
 Description: The git content addressable filesystem
  GIT comes in two layers. The bottom layer is merely an extremely fast
  and flexible filesystem-based database designed to store directory trees
