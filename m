From: Andrew Ruder <andy@aeruder.net>
Subject: [PATCH] Update git-am documentation
Date: Mon, 16 Apr 2007 07:47:31 -0500
Message-ID: <20070416124731.GA23429@localdomain>
References: <7vy7ksvjxt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 14:47:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdQcK-0007eT-GM
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 14:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030503AbXDPMrd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 08:47:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030510AbXDPMrd
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 08:47:33 -0400
Received: from www.aeruder.net ([65.254.53.245]:1858 "EHLO aeruder.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030503AbXDPMrd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 08:47:33 -0400
Received: from aeruder.net (localhost [127.0.0.1])
	by aeruder.net (Postfix) with ESMTP id 569844025E;
	Mon, 16 Apr 2007 07:47:32 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <7vy7ksvjxt.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44643>

Documentation/git-am.txt missing several short versions
of options.

Signed-off-by: Andrew Ruder <andy@aeruder.net>
---
 Ah, I misunderstood your first reply.  If this is truly only for
 internal usage, it should definitely not be in the manpage as
 abuse *will* occur. :)  Let's just hope that nobody finds this thread
 via the mailing list archives.

 Documentation/git-am.txt |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 148ce40..759e3a5 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -26,18 +26,18 @@ OPTIONS
 	The list of mailbox files to read patches from. If you do not
 	supply this argument, reads from the standard input.
 
---signoff::
+-s, --signoff::
 	Add `Signed-off-by:` line to the commit message, using
 	the committer identity of yourself.
 
---dotest=<dir>::
+-d=<dir>, --dotest=<dir>::
 	Instead of `.dotest` directory, use <dir> as a working
 	area to store extracted patches.
 
---keep::
+-k, --keep::
 	Pass `-k` flag to `git-mailinfo` (see gitlink:git-mailinfo[1]).
 
---utf8::
+-u, --utf8::
 	Pass `-u` flag to `git-mailinfo` (see gitlink:git-mailinfo[1]).
 	The proposed commit log message taken from the e-mail
 	are re-coded into UTF-8 encoding (configuration variable
@@ -48,14 +48,14 @@ This was optional in prior versions of git, but now it is the
 default.   You could use `--no-utf8` to override this.
 
 --no-utf8::
-	Do not pass `-u` flag to `git-mailinfo` (see
+	Pass `-n` flag to `git-mailinfo` (see
 	gitlink:git-mailinfo[1]).
 
---binary::
+-b, --binary::
 	Pass `--allow-binary-replacement` flag to `git-apply`
 	(see gitlink:git-apply[1]).
 
---3way::
+-3, --3way::
 	When the patch does not apply cleanly, fall back on
 	3-way merge, if the patch records the identity of blobs
 	it is supposed to apply to, and we have those blobs
@@ -73,10 +73,10 @@ default.   You could use `--no-utf8` to override this.
 	These flags are passed to the `git-apply` program that applies
 	the patch.
 
---interactive::
+-i, --interactive::
 	Run interactively, just like git-applymbox.
 
---resolved::
+-r, --resolved::
 	After a patch failure (e.g. attempting to apply
 	conflicting patch), the user has applied it by hand and
 	the index file stores the result of the application.
-- 
1.5.1.1.98.gedb4f-dirty
