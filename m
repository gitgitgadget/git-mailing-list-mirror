From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-fetch: fix a bashism (==)
Date: Tue, 11 Jul 2006 14:06:39 -0700
Message-ID: <11526519991197-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jul 11 23:06:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0PRQ-0001mC-5W
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 23:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWGKVGo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 17:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWGKVGo
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 17:06:44 -0400
Received: from hand.yhbt.net ([66.150.188.102]:18398 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S932121AbWGKVGo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Jul 2006 17:06:44 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 399BC7DC022;
	Tue, 11 Jul 2006 14:06:41 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 11 Jul 2006 14:06:39 -0700
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.1.g2155
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23734>

From: Eric Wong <normalperson@untitled.(none)>

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-fetch.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-fetch.sh b/git-fetch.sh
index c0d256c..ff17699 100755
--- a/git-fetch.sh
+++ b/git-fetch.sh
@@ -80,7 +80,7 @@ rref=
 rsync_slurped_objects=
 
 rloga="$rloga $remote_nick"
-test "$remote_nick" == "$remote" || rloga="$rloga $remote"
+test "$remote_nick" = "$remote" || rloga="$rloga $remote"
 
 if test "" = "$append"
 then
-- 
1.4.1.g2f48
