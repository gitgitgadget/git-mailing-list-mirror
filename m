From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 8/9] http-pull: documentation updates.
Date: Sat, 25 Jun 2005 02:25:57 -0700
Message-ID: <7vacle3hzu.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vaclgfynv.fsf@assigned-by-dhcp.cox.net>
	<7vvf439vdl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506241755280.11175@ppc970.osdl.org>
	<7vaclf6tw7.fsf@assigned-by-dhcp.cox.net>
	<7vmzpe4x08.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 25 11:21:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dm6qk-0002Jz-4U
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 11:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbVFYJ1s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Jun 2005 05:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbVFYJ1s
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jun 2005 05:27:48 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:48636 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S263380AbVFYJZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2005 05:25:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050625092558.FIJD17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Jun 2005 05:25:58 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vmzpe4x08.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 25 Jun 2005 02:16:23 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Describe -w option.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/git-http-pull.txt |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

bce3da4d8421812b0eb1d433b0af0fc3fc9bb54a
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

