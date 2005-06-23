From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] http-pull: documentation updates.
Date: Thu, 23 Jun 2005 16:23:56 -0700
Message-ID: <7vslz8ejxv.fsf@assigned-by-dhcp.cox.net>
References: <7vfyv8fyqn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 01:18:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlaxA-0003cC-Ng
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 01:17:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262734AbVFWXYH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 19:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262743AbVFWXYH
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 19:24:07 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:63410 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262734AbVFWXX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2005 19:23:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050623232356.VCMV16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 23 Jun 2005 19:23:56 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vfyv8fyqn.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Thu, 23 Jun 2005 16:18:56 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Describe -w option.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/git-http-pull.txt |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-http-pull.txt b/Documentation/git-http-pull.txt
--- a/Documentation/git-http-pull.txt
+++ b/Documentation/git-http-pull.txt
@@ -9,7 +9,7 @@ git-http-pull - Downloads a remote GIT r
 
 SYNOPSIS
 --------
-'git-http-pull' [-c] [-t] [-a] [-v] [-d] [--recover] commit-id url
+'git-http-pull' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] commit-id url
 
 DESCRIPTION
 -----------
@@ -30,7 +30,9 @@ Downloads a remote GIT repository via HT
 	usual, to recover after earlier pull that was interrupted.
 -v::
 	Report what is downloaded.
-
+-w::
+        Writes the commit-id into the filename under $GIT_DIR/refs/ on
+        the local end after the transfer is complete.
 
 Author
 ------
------------

