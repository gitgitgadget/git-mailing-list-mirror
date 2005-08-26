From: Tommi Virtanen <tv@debian.org>
Subject: [PATCH] cogito bugfixes and cleanups, mainly Debian things
Date: Fri, 26 Aug 2005 14:01:34 +0300
Message-ID: <11250540943597-git-send-email-tv@debian.org>
Reply-To: Tommi Virtanen <tv@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tommi Virtanen <tv@debian.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 13:05:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8bxx-0006xP-FO
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 13:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932543AbVHZLBm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 07:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbVHZLBm
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 07:01:42 -0400
Received: from i1.inoi.fi ([194.100.97.46]:57501 "EHLO mail.srv.inoi.fi")
	by vger.kernel.org with ESMTP id S932543AbVHZLBm (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 07:01:42 -0400
Received: from mail.srv.inoi.fi (localhost.localdomain [127.0.0.1])
	by mail.srv.inoi.fi (Postfix) with ESMTP id 84A1FFF7F9;
	Fri, 26 Aug 2005 14:01:48 +0300 (EEST)
Received: from pooch.inoi.fi (GMMCMXXXIV.dsl.saunalahti.fi [85.76.243.135])
	by mail.srv.inoi.fi (Postfix) with ESMTP id 5A560FEDD2;
	Fri, 26 Aug 2005 14:01:48 +0300 (EEST)
Received: from pooch (pooch [127.0.0.1])
	by pooch.inoi.fi (Postfix) with SMTP id 7A591BA067;
	Fri, 26 Aug 2005 14:01:34 +0300 (EEST)
In-Reply-To: 
X-Mailer: git-send-email-script
To: git@vger.kernel.org
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7806>

As cogito contains only shell scripts, make the deb Arch: all.

Signed-off-by: Tommi Virtanen <tv@debian.org>

---
commit 0b1227b120532fe2d8b48ad2d43b2f002241f8d9
tree 1e00c450a8eb96159f0f5545ce94aabd3a1fcd44
parent 1190649aaff433501d6e6c92deb8a0f201fdd8d0
author Tommi Virtanen <tv@debian.org> Fri, 26 Aug 2005 13:34:00 +0300
committer Tommi Virtanen <tv@debian.org> Fri, 26 Aug 2005 13:34:00 +0300

 debian/control |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/debian/control b/debian/control
--- a/debian/control
+++ b/debian/control
@@ -6,8 +6,8 @@ Build-Depends: debhelper (>= 4.0.0), dpa
 Standards-Version: 3.6.1
 
 Package: cogito
-Architecture: any
-Depends: git-core, ${shlibs:Depends}, patch, diff, rcs
+Architecture: all
+Depends: git-core, patch, diff, rcs
 Recommends: rsync, curl, wget, rsh-client
 Conflicts: cgvg
 Description: version control system
