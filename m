From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] git-rerere.txt: Mention rr-cache directory
Date: Wed,  9 Jul 2008 02:17:33 +0200
Message-ID: <1215562653-5043-1-git-send-email-s-beyer@gmx.net>
Cc: git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 02:18:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGNOM-0005Uz-MR
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 02:18:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbYGIARp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 20:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751297AbYGIARo
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 20:17:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:51862 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751251AbYGIARo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 20:17:44 -0400
Received: (qmail invoked by alias); 09 Jul 2008 00:17:42 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp026) with SMTP; 09 Jul 2008 02:17:42 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/Gv2IuPaTG21B3C3KqvuZl6f7HhV88rSHHgeENg5
	8rRqjMh04qpdDg
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KGNNF-0001Ji-Cs; Wed, 09 Jul 2008 02:17:33 +0200
X-Mailer: git-send-email 1.5.6.2.574.gd4568
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87817>

If a user reads the rerere documentation, he or she is not told to
create the $GIT_DIR/rr-cache directory to be able to use git-rerere.
This patch adds such a remark.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
 Documentation/git-rerere.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 678bfd3..667505c 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -23,8 +23,8 @@ initial manual merge, and later by noticing the same automerge
 results and applying the previously recorded hand resolution.
 
 [NOTE]
-You need to set the configuration variable rerere.enabled to
-enable this command.
+You need to set the configuration variable `rerere.enabled` and create
+the `rr-cache` directory under `$GIT_DIR` to enable this command.
 
 
 COMMANDS
@@ -170,8 +170,8 @@ As a convenience measure, 'git-merge' automatically invokes
 records it if it is a new conflict, or reuses the earlier hand
 resolve when it is not.  'git-commit' also invokes 'git-rerere'
 when recording a merge result.  What this means is that you do
-not have to do anything special yourself (Note: you still have
-to set the config variable rerere.enabled to enable this command).
+not have to do anything special yourself, except making sure
+that `rerere.enabled` is set and `$GIT_DIR/rr-cache` exists.
 
 In our example, when you did the test merge, the manual
 resolution is recorded, and it will be reused when you do the
-- 
1.5.6.2.574.gd4568
