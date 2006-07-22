From: Alexandre Julliard <julliard@winehq.org>
Subject: [PATCH 4/4] git.el: Put the git customize group in the 'tools' parent group.
Date: Sat, 22 Jul 2006 15:40:13 +0200
Message-ID: <87u059g3lu.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jul 22 15:40:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4HiP-0004xb-65
	for gcvg-git@gmane.org; Sat, 22 Jul 2006 15:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWGVNkR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Jul 2006 09:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWGVNkR
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Jul 2006 09:40:17 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:33733 "EHLO
	mail.codeweavers.com") by vger.kernel.org with ESMTP
	id S1751363AbWGVNkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Jul 2006 09:40:16 -0400
Received: from adsl-84-227-106-91.adslplus.ch ([84.227.106.91] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1G4HiJ-0003Dz-5A
	for git@vger.kernel.org; Sat, 22 Jul 2006 08:40:16 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id 0F81C4F904; Sat, 22 Jul 2006 15:40:13 +0200 (CEST)
To: git@vger.kernel.org
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24071>

Signed-off-by: Alexandre Julliard <julliard@winehq.org>
---
 contrib/emacs/git.el |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/contrib/emacs/git.el b/contrib/emacs/git.el
index 92cb2b9..68de9be 100644
--- a/contrib/emacs/git.el
+++ b/contrib/emacs/git.el
@@ -55,7 +55,8 @@ (require 'ewoc)
 ;;;; ------------------------------------------------------------
 
 (defgroup git nil
-  "Git user interface")
+  "A user interface for the git versioning system."
+  :group 'tools)
 
 (defcustom git-committer-name nil
   "User name to use for commits.
-- 
1.4.2.rc1.ge7a0

-- 
Alexandre Julliard
julliard@winehq.org
