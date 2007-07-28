From: Seth Falcon <sfalcon@fhcrc.org>
Subject: [PATCH] Rename git-rebase interactive buffer: todo => git-rebase-todo
Date: Sat, 28 Jul 2007 16:44:40 -0700
Message-ID: <m2zm1gqejb.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 29 01:44:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEvxu-0004Km-D2
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 01:44:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758155AbXG1Xou (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 19:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758179AbXG1Xot
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 19:44:49 -0400
Received: from MICA.FHCRC.ORG ([140.107.152.12]:55145 "EHLO mica.fhcrc.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758136AbXG1Xos (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 19:44:48 -0400
Received: from jade.fhcrc.org (JADE.FHCRC.ORG [140.107.42.223])
	by mica.fhcrc.org (8.12.11.20060308/8.12.11/SuSE Linux 0.7) with ESMTP id l6SNig9i028690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 28 Jul 2007 16:44:42 -0700
Received: from ziti.fhcrc.org (DORMOUSE.FHCRC.ORG [140.107.170.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jade.fhcrc.org (Postfix) with ESMTP id 85B0CF269;
	Sat, 28 Jul 2007 16:44:42 -0700 (PDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (darwin)
X-PMX-Version: 5.3.2.304607, Antispam-Engine: 2.5.1.298604, Antispam-Data: 2007.7.28.162245
X-FHCRC-SCANNED: Sat Jul 28 16:44:43 2007
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54068>


When using emacsclient or similar, a temporary buffer (file) named
'todo' could cause confusion with a pre-existing buffer of the same
name.

Signed-off-by: Seth Falcon <sethfalcon@gmail.com>
---
 git-rebase--interactive.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c987311..061cd0a 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -17,7 +17,7 @@ USAGE='(--continue | --abort | --skip | [--preserve-merges] [--verbose]
 require_work_tree
 
 DOTEST="$GIT_DIR/.dotest-merge"
-TODO="$DOTEST"/todo
+TODO="$DOTEST"/git-rebase-todo
 DONE="$DOTEST"/done
 MSG="$DOTEST"/message
 SQUASH_MSG="$DOTEST"/message-squash
-- 
1.5.3.rc3.24.g83b3d
