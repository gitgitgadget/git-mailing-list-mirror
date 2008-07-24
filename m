From: Daniel White <daniel@whitehouse.id.au>
Subject: [StGit PATCH] Fixed default install location
Date: Thu, 24 Jul 2008 20:20:31 +1000
Message-ID: <20080724202031.55dec8e8@whitehouse.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 12:46:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLyKx-0006Pp-Oa
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 12:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213AbYGXKpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 06:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbYGXKpO
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 06:45:14 -0400
Received: from smtpgw02.myhostguy.com ([216.10.240.252]:2449 "EHLO
	smtpgw02.myhostguy.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752901AbYGXKpN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 Jul 2008 06:45:13 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Jul 2008 06:45:13 EDT
Received: from mx252n.mysite4now.com [216.10.248.252] by smtpgw02.myhostguy.com with SMTP;
   Thu, 24 Jul 2008 03:28:23 -0700
Received: from ppp121-45-230-12.lns1.bne4.internode.on.net [121.45.230.12] by mx252n.mysite4now.com with SMTP;
   Thu, 24 Jul 2008 03:29:33 -0700
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89864>

Originally broken by addition of Debian package support.

Signed-off-by: Daniel White <daniel@whitehouse.id.au>
---

The default installation direction is actually /usr at present despite
what 'INSTALL' says.

The 'debian/rules' makefile specifies the prefix as /usr so doesn't
seem to depend on this. I've tested the resulting debian package and
everything is still installed correctly under /usr.

 setup.cfg |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/setup.cfg b/setup.cfg
index 1eb8e9b..4359033 100644
--- a/setup.cfg
+++ b/setup.cfg
@@ -1,2 +1,2 @@
 [install]
-prefix: /usr
+prefix: ~
-- 
1.5.6.2
