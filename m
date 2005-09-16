From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: [PATCH] asciidoc gets confused by two '^' on the same line
Date: Fri, 16 Sep 2005 14:14:01 -0400
Message-ID: <200509161814.j8GIE14h016323@inti.inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Fri Sep 16 22:11:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGMXN-0005r0-T4
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 22:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161280AbVIPUJv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 16:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161281AbVIPUJv
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 16:09:51 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:1517 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1161280AbVIPUJv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 16:09:51 -0400
Received: from inti.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by inti.inf.utfsm.cl (8.13.4/8.13.1) with ESMTP id j8GIE14h016323
	for <git@vger.kernel.org>; Fri, 16 Sep 2005 14:14:01 -0400
To: git@vger.kernel.org
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8728>

Uglify Documentation/git-rev-list.txt to get decent output.

Signed-off-by: Horst H. von Brand <vonbrand@inf.utfsm.cl>


---

 Documentation/git-rev-list.txt |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

ceb9e143038dcf62311bc3514ae4d2d0f7854aa4
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -32,8 +32,11 @@ I have the commit object 'bar', but not 
 
 The *--bisect* flag limits output to the one commit object which is
 roughly halfway between the included and excluded commits. Thus,
-if 'git-rev-list --bisect foo ^bar ^baz' outputs 'midpoint', the output
-of 'git-rev-list foo ^midpoint' and 'git-rev-list midpoint ^bar ^baz'
+if 'git-rev-list --bisect foo ^bar
+^baz' outputs 'midpoint', the output
+of 'git-rev-list foo ^midpoint' and
+'git-rev-list midpoint ^bar
+^baz'
 would be of roughly the same length. Finding the change which introduces
 a regression is thus reduced to a binary search: repeatedly generate and
 test new 'midpoint's until the commit chain is of length one.
@@ -93,4 +96,3 @@ Documentation by David Greaves, Junio C 
 GIT
 ---
 Part of the link:git.html[git] suite
-
