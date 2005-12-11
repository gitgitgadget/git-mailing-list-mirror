From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Make the Cogito manpage references more colorful
Date: Sun, 11 Dec 2005 19:19:27 +0100
Message-ID: <20051211181927.GB2960@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Dec 11 19:19:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElVnI-0006Ry-A4
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 19:19:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbVLKSTa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 13:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbVLKSTa
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 13:19:30 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:40184 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1750769AbVLKST3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Dec 2005 13:19:29 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 4BD606DFECF; Sun, 11 Dec 2005 19:18:29 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 9CA406DFB7A; Sun, 11 Dec 2005 19:18:28 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 0A5F3615B3; Sun, 11 Dec 2005 19:19:28 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13500>

... by copying the gitlink macro from git.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
commit 3b8f92d921868da0af9195db03b277650147498f
tree 64f6668d5e12777811e65f7c5e4bcfd70b4e8714
parent c10cc1d2a99b01ed3bf45d5f2ad6157940a22365
author Jonas Fonseca <fonseca@diku.dk> Tue, 06 Dec 2005 23:56:24 +0100
committer Jonas Fonseca <fonseca@antimatter.localdomain> Tue, 06 Dec 2005 23:56:24 +0100

 Documentation/asciidoc.conf |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 9a1bbc5..baefb2f 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -9,7 +9,10 @@
 
 ifdef::backend-docbook[]
 [gitlink-inlinemacro]
-{target}{0?({0})}
+{0%{target}}
+{0#<citerefentry>}
+{0#<refentrytitle>{target}</refentrytitle><manvolnum>{0}</manvolnum>}
+{0#</citerefentry>}
 endif::backend-docbook[]
 
 ifdef::backend-xhtml11[]

-- 
Jonas Fonseca
