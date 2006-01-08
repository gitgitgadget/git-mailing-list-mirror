From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/7] Fix git-formatpatch usage string wrt output modes
Date: Sun, 8 Jan 2006 01:39:16 +0100
Message-ID: <20060108003916.GK1113@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Jan 08 01:36:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvOY5-0007Mb-TU
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 01:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbWAHAgj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jan 2006 19:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161089AbWAHAgj
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jan 2006 19:36:39 -0500
Received: from smtp4-g19.free.fr ([212.27.42.30]:3227 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S1161087AbWAHAgj (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Jan 2006 19:36:39 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id 123094E410
	for <git@vger.kernel.org>; Sun,  8 Jan 2006 01:36:38 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1EvOab-0003SU-4U
	for git@vger.kernel.org; Sun, 08 Jan 2006 01:39:17 +0100
To: GIT list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14291>

--stdout was not mentionned, and the description for the case where -o
was not given was thus incomplete.

Signed-off-by: Yann Dirson <ydirson@altern.org>


---

 git-format-patch.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

8a6d4a039ff4ffd75d5eeddbd6801787a8479b05
diff --git a/git-format-patch.sh b/git-format-patch.sh
index daa3cae..0948f1f 100755
--- a/git-format-patch.sh
+++ b/git-format-patch.sh
@@ -9,8 +9,10 @@ one file per patch, for e-mail submissio
 numbered sequentially from 1, and uses the first line of the commit
 message (massaged for pathname safety) as the filename.
 
-When -o is specified, output files are created in that directory; otherwise in
-the current working directory.
+There are three output modes.  By default, output files are created in
+the current working directory; when -o is specified, they are created
+in that directory instead; when --stdout is specified, they are spit
+on standard output, and can be piped to git-am.
 
 When -n is specified, instead of "[PATCH] Subject", the first line is formatted
 as "[PATCH N/M] Subject", unless you have only one patch.
-- 
1.0.6-g8ecb

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
