From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git clone -s documentation: force a new paragraph for the
	NOTE
Date: Tue, 12 Feb 2008 01:12:57 +0100
Message-ID: <20080212001257.GG25954@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 01:13:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOimY-0008U3-4V
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 01:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758961AbYBLANQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 19:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758418AbYBLANP
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 19:13:15 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53297 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757367AbYBLANM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 19:13:12 -0500
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1JOilj-0003pz-BJ
	from <vmiklos@frugalware.org>; Tue, 12 Feb 2008 01:13:11 +0100
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 8975E119050E; Tue, 12 Feb 2008 01:12:57 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.1 required=5.9 tests=BAYES_05 autolearn=no SpamAssassin version=3.2.3
	-1.1 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0117]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73609>

It should be loud and clear.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

I wanted this syntax when I added the NOTE but I tought it's not possible.
After Junio's patch to git pull --rebase, here is a similar fix for
git clone -s.

 Documentation/git-clone.txt |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 2341881..9758243 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -62,12 +62,13 @@ OPTIONS
 	.git/objects/info/alternates to share the objects
 	with the source repository.  The resulting repository
 	starts out without any object of its own.
-	*NOTE*: this is a possibly dangerous operation; do *not* use
-	it unless you understand what it does. If you clone your
-	repository using this option, then delete branches in the
-	source repository and then run linkgit:git-gc[1] using the
-	'--prune' option in the source repository, it may remove
-	objects which are referenced by the cloned repository.
++
+*NOTE*: this is a possibly dangerous operation; do *not* use
+it unless you understand what it does. If you clone your
+repository using this option, then delete branches in the
+source repository and then run linkgit:git-gc[1] using the
+'--prune' option in the source repository, it may remove
+objects which are referenced by the cloned repository.
 
 
 
-- 
1.5.4.1
