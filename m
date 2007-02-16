From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] Link git-bundle and git-unbundle docs from git(7).
Date: Thu, 15 Feb 2007 19:19:57 -0500
Message-ID: <1171585197120-git-send-email-mdl123@verizon.net>
References: <11715851974102-git-send-email-mdl123@verizon.net>
 <11715851972838-git-send-email-mdl123@verizon.net>
 <11715851973802-git-send-email-mdl123@verizon.net>
 <11715851973121-git-send-email-mdl123@verizon.net>
 <11715851973628-git-send-email-mdl123@verizon.net>
 <1171585197833-git-send-email-mdl123@verizon.net>
Cc: Mark Levedahl <mdl123@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 16 01:20:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHqpl-0000rW-LE
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 01:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422838AbXBPAUK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 19:20:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422839AbXBPAUJ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 19:20:09 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:39631 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422838AbXBPAUE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 19:20:04 -0500
Received: from fal-l07294-lp.us.ray.com ([71.246.235.75])
 by vms044.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JDJ00A1N4XCP9Z6@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 15 Feb 2007 18:20:01 -0600 (CST)
In-reply-to: <1171585197833-git-send-email-mdl123@verizon.net>
X-Mailer: git-send-email 1.5.0.rc4.375.gd0938-dirty
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39869>

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 Documentation/cmd-list.perl |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 Documentation/cmd-list.perl

diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
old mode 100755
new mode 100644
index a2d6268..3a22083
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -70,6 +70,7 @@ git-archive                             mainporcelain
 git-bisect                              mainporcelain
 git-blame                               ancillaryinterrogators
 git-branch                              mainporcelain
+git-bundle                              mainporcelain
 git-cat-file                            plumbinginterrogators
 git-checkout-index                      plumbingmanipulators
 git-checkout                            mainporcelain
@@ -172,6 +173,7 @@ git-svnimport                           foreignscminterface
 git-symbolic-ref                        plumbingmanipulators
 git-tag                                 mainporcelain
 git-tar-tree                            plumbinginterrogators
+git-unbundle                            mainporcelain
 git-unpack-file                         plumbinginterrogators
 git-unpack-objects                      plumbingmanipulators
 git-update-index                        plumbingmanipulators
-- 
1.5.0.34.g6afaa
