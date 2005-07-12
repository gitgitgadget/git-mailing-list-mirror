From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: [PATCH] document CVS vs. git tags
Date: Tue, 12 Jul 2005 09:29:33 +0200
Message-ID: <20050712072933.GA28506@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
X-From: git-owner@vger.kernel.org Tue Jul 12 09:31:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsFEH-0006Me-Ed
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 09:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVGLHas (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jul 2005 03:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVGLHas
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jul 2005 03:30:48 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:23938 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261223AbVGLHaq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jul 2005 03:30:46 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DsFCw-0005I9-1C; Tue, 12 Jul 2005 09:29:46 +0200
Received: (nullmailer pid 28522 invoked by uid 501);
	Tue, 12 Jul 2005 07:29:33 -0000
To: torvalds@osdl.org, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

CVS uses tags for lots of things.
Git doesn't.
Document that, so people may understand.

diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -230,3 +230,33 @@ that contain this changed "if" statement
 [ Side note.  This option is called "--pickaxe-all" because -S
   option is internally called "pickaxe", a tool for software
   archaeologists.]
+
+
+
+Tagging, Branching and Merging
+------------------------------
+
+In CVS, you need tags for three different (and conflicting) use cases:
+
+* Mark the state of you repository at a given point in time.
+
+  "This is version 0.2."
+
+* Name a branch, i.e. semi-separate line of development.
+
+  "I'm now working on what's going to be version 0.3."
+
+* Remember where you last merged from so that you won't mess up your
+  changes later.
+  
+  "Did we integrate that important bugfix from 0.2.1 into 0.3 yet?"
+
+
+Git has different features for each of these uses.
+
+* You mark the current (actually, last-checked-in) state with "git tag".
+
+* You start a new branch with "git checkout -b <name>".
+
+* Git keeps track of what-got-merged-to-where internally.
+
