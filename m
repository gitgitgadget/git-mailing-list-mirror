From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] WinGit: included /bin/start in the installer
Date: Sat, 29 Sep 2007 18:05:52 +0200
Message-ID: <11910819531200-git-send-email-prohaska@zib.de>
References: <A835C8E8-8EC5-43B7-9252-8709214DE7AD@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 29 18:06:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbepQ-0007q8-6v
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 18:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898AbXI2QF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 12:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756036AbXI2QF4
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 12:05:56 -0400
Received: from mailer.zib.de ([130.73.108.11]:62292 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755118AbXI2QFz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 12:05:55 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l8TG5svv009030
	for <git@vger.kernel.org>; Sat, 29 Sep 2007 18:05:54 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l8TG5rQt010394;
	Sat, 29 Sep 2007 18:05:53 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <A835C8E8-8EC5-43B7-9252-8709214DE7AD@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

/bin/start is needed to tell Windows to open html pages.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 share/WinGit/release.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/share/WinGit/release.sh b/share/WinGit/release.sh
index 67d0725..5ab876a 100644
--- a/share/WinGit/release.sh
+++ b/share/WinGit/release.sh
@@ -29,7 +29,7 @@ ls.exe,md5sum.exe,mkdir.exe,msys-1.0.dll,msysltdl-3.dll,mv.exe,patch.exe,\
 patch.exe.manifest,perl.exe,printf,ps.exe,pwd,rm.exe,rmdir.exe,rxvt.exe,\
 scp.exe,sed.exe,sh.exe,sleep.exe,sort.exe,split.exe,ssh-agent.exe,ssh.exe,\
 tail.exe,tar.exe,tee.exe,touch.exe,tr.exe,true.exe,uname.exe,uniq.exe,vi,\
-vim.exe,wc.exe,which,xargs.exe,ssh-add.exe} lib/perl5/ share/git* share/vim) |
+vim.exe,wc.exe,which,xargs.exe,ssh-add.exe,start} lib/perl5/ share/git* share/vim) |
 tar xvf - &&
 mkdir lib/perl5/site_perl &&
 cp /lib/{Error.pm,Git.pm} lib/perl5/site_perl/ &&
-- 
1.5.3.mingw.1.3.g195850
