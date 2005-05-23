From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff-raw format update take #2.
Date: Mon, 23 May 2005 15:08:21 -0700
Message-ID: <7vr7fx1tpm.fsf@assigned-by-dhcp.cox.net>
References: <7vfywe769d.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505230736180.2307@ppc970.osdl.org>
	<7vwtpp3hsa.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505231156210.2307@ppc970.osdl.org>
	<7vy8a51uay.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 24 00:08:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaL4i-0002ay-SR
	for gcvg-git@gmane.org; Tue, 24 May 2005 00:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVEWWIa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 18:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVEWWIa
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 18:08:30 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:4807 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261151AbVEWWI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2005 18:08:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050523220821.JNFG22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 May 2005 18:08:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vy8a51uay.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Mon, 23 May 2005 14:55:33 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Addendum.

------------
Document the diff-helper changes.

Now diff-helper is simple diff-raw to patch format converter
that does not take -R/-M/-C, drop the description of these
options from the documentation. 

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
cd /opt/packrat/playpen/public/in-place/git/git.junio/
jit-diff
# - HEAD: diff-raw format update take #2.
# + (working tree)
diff --git a/Documentation/git-diff-helper.txt b/Documentation/git-diff-helper.txt
--- a/Documentation/git-diff-helper.txt
+++ b/Documentation/git-diff-helper.txt
@@ -9,7 +9,7 @@ git-diff-helper - Generates patch format
 
 SYNOPSIS
 --------
-'git-diff-helper' [-z] [-R] [-M] [-C] [-S<string>]
+'git-diff-helper' [-z] [-S<string>]
 
 DESCRIPTION
 -----------
@@ -21,22 +21,6 @@ OPTIONS
 -z::
 	\0 line termination on input
 
--R::
-	Output diff in reverse.  This is useful for displaying output from
-	"git-diff-cache" which always compares tree with cache or working
-	file.  E.g.
-
-		git-diff-cache <tree> | git-diff-helper -R file.c
-
-	would show a diff to bring the working file back to what
-	is in the <tree>.
-
--M::
-	Detect renames.
-
--C::
-	Detect copies as well as renames.
-
 -S<string>::
 	Look for differences that contains the change in <string>.
 

Compilation finished at Mon May 23 15:06:31

