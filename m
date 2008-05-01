From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2] Documentation: hooks: fix missing verb in pre-applypatch
 description
Date: Thu, 1 May 2008 13:02:30 +0200
Message-ID: <20080501130230.0a851d6a.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio Hamano <junkio@cox.net>, Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Manoj Srivastava <srivasta@ieee.org>,
	"Thomas Adam" <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 01 12:58:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrWUU-00055N-Pw
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 12:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754625AbYEAK5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 06:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753467AbYEAK5b
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 06:57:31 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:34969 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751899AbYEAK5a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 06:57:30 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 51DA81AB2F5;
	Thu,  1 May 2008 12:57:29 +0200 (CEST)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id CA6351AB2D8;
	Thu,  1 May 2008 12:57:27 +0200 (CEST)
X-Mailer: Sylpheed 2.5.0beta1 (GTK+ 2.12.9; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80899>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/githooks.txt |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 62ee065..67c0809 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -40,10 +40,11 @@ The default 'applypatch-msg' hook, when enabled, runs the
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
1.5.5.1.100.gc23d
