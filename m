From: Tommi Virtanen <tv@debian.org>
Subject: [PATCH] git bugfixes and cleanups, mainly Debian things
Date: Fri, 26 Aug 2005 14:00:03 +0300
Message-ID: <1125054003873-git-send-email-tv@debian.org>
Reply-To: Tommi Virtanen <tv@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Tommi Virtanen <tv@debian.org>
X-From: git-owner@vger.kernel.org Fri Aug 26 13:05:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8bwi-0006bq-Dl
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 13:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbVHZLAX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 07:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932552AbVHZLAW
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 07:00:22 -0400
Received: from i1.inoi.fi ([194.100.97.46]:56477 "EHLO mail.srv.inoi.fi")
	by vger.kernel.org with ESMTP id S1751547AbVHZLAR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 07:00:17 -0400
Received: from mail.srv.inoi.fi (localhost.localdomain [127.0.0.1])
	by mail.srv.inoi.fi (Postfix) with ESMTP id 00FFBFF9DB;
	Fri, 26 Aug 2005 14:00:17 +0300 (EEST)
Received: from pooch.inoi.fi (GMMCMXXXIV.dsl.saunalahti.fi [85.76.243.135])
	by mail.srv.inoi.fi (Postfix) with ESMTP id A94CFFEDD2;
	Fri, 26 Aug 2005 14:00:17 +0300 (EEST)
Received: from pooch (pooch [127.0.0.1])
	by pooch.inoi.fi (Postfix) with SMTP id 6D7C8BA067;
	Fri, 26 Aug 2005 14:00:03 +0300 (EEST)
In-Reply-To: 
X-Mailer: git-send-email-script
To: git@vger.kernel.org
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7803>

Fix syntax error in debian Build-Depends-Indep, dpkg-checkbuilddeps used
to give false ok results.

Signed-off-by: Tommi Virtanen <tv@debian.org>

---
commit c87030106cfbe39f0ab2ed095f30f576235328fc
tree ca572653ccd5a4c35f9479c079c8a904d6fce2d1
parent 248542ea9ae9125a7ccf214b979ada9908ea1358
author Tommi Virtanen <tv@debian.org> Fri, 26 Aug 2005 12:32:26 +0300
committer Tommi Virtanen <tv@debian.org> Fri, 26 Aug 2005 12:32:26 +0300

 debian/control |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/debian/control b/debian/control
--- a/debian/control
+++ b/debian/control
@@ -2,7 +2,7 @@ Source: git-core
 Section: devel
 Priority: optional
 Maintainer: Junio C Hamano <junkio@cox.net>
-Build-Depends-Indep: libz-dev, libssl-dev, libcurl3-dev, asciidoc > 6.0.3, xmlto, debhelper (>= 4.0.0)
+Build-Depends-Indep: libz-dev, libssl-dev, libcurl3-dev, asciidoc (>= 6.0.3), xmlto, debhelper (>= 4.0.0)
 Standards-Version: 3.6.1
 
 Package: git-core
