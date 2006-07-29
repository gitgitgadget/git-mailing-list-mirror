From: Gerrit Pape <pape@smarden.org>
Subject: [PATCH] Build on Debian GNU/kFreeBSD
Date: Sat, 29 Jul 2006 16:26:18 +0000
Message-ID: <20060729162618.14286.qmail@811d2f195f286e.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jul 29 18:26:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6rdb-0001i4-VU
	for gcvg-git@gmane.org; Sat, 29 Jul 2006 18:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWG2QZ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Jul 2006 12:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWG2QZ7
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Jul 2006 12:25:59 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:51870 "HELO a.mx.smarden.org")
	by vger.kernel.org with SMTP id S1751252AbWG2QZ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jul 2006 12:25:58 -0400
Received: (qmail 14287 invoked by uid 1000); 29 Jul 2006 16:26:18 -0000
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24427>

Patch from Petr Salinger to make the build process detect and support the
Debian GNU/kFreeBSD architecture, see
 http://bugs.debian.org/380209

Signed-off-by: Gerrit Pape <pape@smarden.org>

---
 Makefile |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 8349e3d..91ba183 100644
--- a/Makefile
+++ b/Makefile
@@ -264,6 +264,9 @@ # we had "elif" things would have been m
 ifeq ($(uname_S),Linux)
 	NO_STRLCPY = YesPlease
 endif
+ifeq ($(uname_S),GNU/kFreeBSD)
+	NO_STRLCPY = YesPlease
+endif
 ifeq ($(uname_S),Darwin)
 	NEEDS_SSL_WITH_CRYPTO = YesPlease
 	NEEDS_LIBICONV = YesPlease
-- 
1.4.1
