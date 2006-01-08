From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/7] Fix typo in debug stanza of t2001
Date: Sun, 8 Jan 2006 01:38:43 +0100
Message-ID: <20060108003843.GJ1113@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jan 08 01:36:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvOXZ-0007CV-EO
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 01:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086AbWAHAgG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 19:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbWAHAgG
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 19:36:06 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:35534 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1161086AbWAHAgF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 19:36:05 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id B351F95BD
	for <git@vger.kernel.org>; Sun,  8 Jan 2006 01:36:04 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1EvOa3-0003SC-VS
	for git@vger.kernel.org; Sun, 08 Jan 2006 01:38:44 +0100
To: GIT list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14290>

Signed-off-by: Yann Dirson <ydirson@altern.org>


---

 t/t2001-checkout-cache-clash.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

392df5563e13d8156f99cdabb29aaa579629cbd5
diff --git a/t/t2001-checkout-cache-clash.sh b/t/t2001-checkout-cache-clash.sh
index b1c5263..0dcab8f 100755
--- a/t/t2001-checkout-cache-clash.sh
+++ b/t/t2001-checkout-cache-clash.sh
@@ -74,7 +74,7 @@ test_debug 'show_files $tree3'
 test_expect_success \
     'read previously written tree and checkout.' \
     'git-read-tree $tree2 && git-checkout-index -f -a'
-test_debug show_files $tree2
+test_debug 'show_files $tree2'
 
 test_expect_success \
     'checking out conflicting path with -f' \
-- 
1.0.6-g8ecb

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
