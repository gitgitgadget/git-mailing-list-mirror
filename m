From: Ping Yin <pkufranky@gmail.com>
Subject: [PATCH] git-submodule: Make update verbose for up to date path
Date: Tue,  4 Mar 2008 22:58:11 +0800
Message-ID: <1204642691-3220-1-git-send-email-pkufranky@gmail.com>
Cc: git@vger.kernel.org, Ping Yin <pkufranky@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Mar 04 15:59:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWYbU-0006CP-Lw
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 15:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756431AbYCDO6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 09:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756418AbYCDO6O
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 09:58:14 -0500
Received: from mail.qikoo.org ([60.28.205.235]:39766 "EHLO mail.qikoo.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756161AbYCDO6O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 09:58:14 -0500
Received: by mail.qikoo.org (Postfix, from userid 1029)
	id BE0D4470B0; Tue,  4 Mar 2008 22:58:11 +0800 (CST)
X-Mailer: git-send-email 1.5.4.3.347.g5314c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76092>

When 'git submodule update' runs for multiple modules, give 'up to date'
info for up to date modules should be a good idea to show the progress.
---
 git-submodule.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 67d3224..94e3db7 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -305,6 +305,8 @@ cmd_update()
 			die "Unable to checkout '$sha1' in submodule path '$path'"
 
 			say "Submodule path '$path': checked out '$sha1'"
+		else
+			say "Up to date: $path"
 		fi
 	done
 }
-- 
1.5.4.3.347.g5314c

