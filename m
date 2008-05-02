From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/3] Documentation: hooks: fix missing verb in
 pre-applypatch description
Date: Fri, 2 May 2008 05:30:41 +0200
Message-ID: <20080502053041.c526250c.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Manoj Srivastava <srivasta@ieee.org>,
	"Thomas Adam" <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 05:26:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrlv4-0002av-At
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 05:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755343AbYEBDZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 23:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754477AbYEBDZo
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 23:25:44 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:45832 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753971AbYEBDZo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 23:25:44 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id D8A1E1AB2B7;
	Fri,  2 May 2008 05:25:42 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 4AA321AB2AC;
	Fri,  2 May 2008 05:25:41 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80951>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/hooks.txt |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

	Here is a patch series with my current "Documentation"
	improvements.

	The changes since the last patches are the following:

	- move fix to "hooks" before other changes
	- fix links to the renamed "githooks" (patch 2/3)
	- rename and convert to man pages some tutorials
	(new patch 3/3)

diff --git a/Documentation/hooks.txt b/Documentation/hooks.txt
index 44fbe58..1283ab4 100644
--- a/Documentation/hooks.txt
+++ b/Documentation/hooks.txt
@@ -28,10 +28,11 @@ The default 'applypatch-msg' hook, when enabled, runs the
 pre-applypatch
 --------------
 
-This hook is invoked by `git-am`.  It takes no parameter,
-and is invoked after the patch is applied, but before a commit
-is made.  Exiting with non-zero status causes the working tree
-after application of the patch not committed.
+This hook is invoked by `git-am`.  It takes no parameter, and is
+invoked after the patch is applied, but before a commit is made.
+
+If it exits with non-zero status, then the working tree will not be
+committed after applying the patch.
 
 It can be used to inspect the current working tree and refuse to
 make a commit if it does not pass certain test.
-- 
1.5.5.1.124.g7e5fa.dirty
