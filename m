From: jdl@freescale.com
Subject: PATCH Documentation/git-rev-list.txt typo fix
Date: Thu, 15 Sep 2005 17:40:13 -0500
Message-ID: <E1EG2Or-0005E2-Pw@jdl.com>
X-From: git-owner@vger.kernel.org Fri Sep 16 00:41:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EG2PA-0003jS-FI
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 00:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161034AbVIOWka (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 18:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161036AbVIOWka
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 18:40:30 -0400
Received: from www.jdl.com ([66.118.10.122]:61577 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1161034AbVIOWk3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 18:40:29 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EG2Or-0005E2-Pw
	for git@vger.kernel.org; Thu, 15 Sep 2005 17:40:14 -0500
To: git@vger.kernel.org
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8649>

I'm not positive what the doc conventions are, but I think
something like this patch fixes the "superscript" problem
on the git-rev-list doc page.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
---


diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -32,8 +32,8 @@ I have the commit object 'bar', but not

 The *--bisect* flag limits output to the one commit object which is
 roughly halfway between the included and excluded commits. Thus,
-if "git-rev-list --bisect foo ^bar ^baz" outputs 'midpoint', the output
-of "git-rev-list foo ^midpoint" and "git-rev-list midpoint ^bar ^baz"
+if 'git-rev-list --bisect foo ^bar ^baz' outputs 'midpoint', the output
+of 'git-rev-list foo ^midpoint' and 'git-rev-list midpoint ^bar ^baz'
 would be of roughly the same length. Finding the change which introduces
 a regression is thus reduced to a binary search: repeatedly generate and
 test new 'midpoint's until the commit chain is of length one.
