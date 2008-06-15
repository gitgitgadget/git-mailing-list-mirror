From: Johan Herland <johan@herland.net>
Subject: [PATCH 1/3] cpio is no longer used by git-clone
Date: Sun, 15 Jun 2008 12:13:22 +0200
Message-ID: <200806151213.22624.johan@herland.net>
References: <200806120920.31161.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 12:15:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7pGd-0003OD-F8
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 12:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757011AbYFOKNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 06:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757006AbYFOKNz
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 06:13:55 -0400
Received: from smtp.getmail.no ([84.208.20.33]:59619 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756992AbYFOKNy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 06:13:54 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K2I0080X1QUO500@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 12:13:42 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2I00LJQ1QAKJ90@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 12:13:22 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K2I00IO61QAQDF0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 15 Jun 2008 12:13:22 +0200 (CEST)
In-reply-to: <200806120920.31161.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85074>

Signed-off-by: Johan Herland <johan@herland.net>
---
 INSTALL |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/INSTALL b/INSTALL
index d9b425f..9888f25 100644
--- a/INSTALL
+++ b/INSTALL
@@ -83,9 +83,6 @@ Issues of note:
 	- "perl" and POSIX-compliant shells are needed to use most of
 	  the barebone Porcelainish scripts.
 
-	- "cpio" is used by git-clone when doing a local (possibly
-	  hardlinked) clone.
-
  - Some platform specific issues are dealt with Makefile rules,
    but depending on your specific installation, you may not
    have all the libraries/tools needed, or you may have
-- 
1.5.6.rc2.128.gf64ae
