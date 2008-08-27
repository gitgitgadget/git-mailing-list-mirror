From: Daniel White <daniel@whitehouse.id.au>
Subject: [StGit PATCH] Remove dashed form of git command still in comment
Date: Wed, 27 Aug 2008 16:38:11 +1000
Message-ID: <20080827163811.6e726491@whitehouse.id.au>
References: <20080827002827.14720.45394.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Karl =?UTF-8?B?SGFzc2Vsc3Ryw7Zt?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 08:48:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYEp2-0004WH-Iq
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 08:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbYH0Gqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 02:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753312AbYH0Gqz
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 02:46:55 -0400
Received: from smtpgw03.myhostguy.com ([216.10.240.249]:2096 "EHLO
	smtpgw03.myhostguy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752320AbYH0Gqy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 02:46:54 -0400
Received: from mx252n.mysite4now.com [216.10.248.252] by smtpgw03.myhostguy.com with SMTP;
   Tue, 26 Aug 2008 23:46:12 -0700
Received: from ppp118-208-103-94.lns3.bne4.internode.on.net [118.208.103.94] by mx252n.mysite4now.com with SMTP;
   Tue, 26 Aug 2008 23:46:05 -0700
In-Reply-To: <20080827002827.14720.45394.stgit@yoghurt>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.12.11; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93862>


Signed-off-by: Daniel White <daniel@whitehouse.id.au>

---

If this hasn't been pushed out yet, just squash into your patch.

 stgit/commands/common.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 780ff51..f6c6a35 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -57,7 +57,7 @@ def git_id(crt_series, rev):
 def git_commit(name, repository, branch_name = None):
     """Return the a Commit object if 'name' is a patch name or Git commit.
     The patch names allowed are in the form '<branch>:<patch>' and can
-    be followed by standard symbols used by git-rev-parse. If <patch>
+    be followed by standard symbols used by git rev-parse. If <patch>
     is '{base}', it represents the bottom of the stack.
     """
     # Try a [branch:]patch name first


-- 
Daniel White
