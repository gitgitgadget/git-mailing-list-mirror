From: Kalle Valo <Kalle.Valo@iki.fi>
Subject: [PATCH] Fix debian doc-base
Date: Thu, 04 Aug 2005 02:39:48 +0300
Message-ID: <87pssur3nf.fsf@litku.valo.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Aug 04 01:42:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0Sqg-0003jy-2z
	for gcvg-git@gmane.org; Thu, 04 Aug 2005 01:40:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVHCXjt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 19:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVHCXjt
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 19:39:49 -0400
Received: from fep32-0.kolumbus.fi ([193.229.0.63]:9376 "EHLO
	fep32-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S261626AbVHCXjp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2005 19:39:45 -0400
Received: from litku.valo.iki.fi ([81.197.35.21]) by fep32-app.kolumbus.fi
          with ESMTP
          id <20050803233941.GBWR17771.fep32-app.kolumbus.fi@litku.valo.iki.fi>
          for <git@vger.kernel.org>; Thu, 4 Aug 2005 02:39:41 +0300
To: git@vger.kernel.org
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Fixed location of HTML documents in debian doc-base file.

Without this fix debian package won't install properly (complains
about missing /usr/share/doc/git-core/html directory).
---

 debian/git-core.doc-base |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

194759c0447f88804dfb43615bdf7a6e412c3240
diff --git a/debian/git-core.doc-base b/debian/git-core.doc-base
--- a/debian/git-core.doc-base
+++ b/debian/git-core.doc-base
@@ -5,8 +5,8 @@ Abstract: This manual describes git
 Section: Devel
 
 Format: HTML
-Index: /usr/share/doc/git-core/html/git.html
-Files: /usr/share/doc/git-core/html/*.html
+Index: /usr/share/doc/git-core/git.html
+Files: /usr/share/doc/git-core/*.html
 
 Format: text
 Files: /usr/share/doc/git-core/git-core.txt
