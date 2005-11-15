From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Fix git(1) link to git-index-pack
Date: Tue, 15 Nov 2005 13:29:18 +0100
Message-ID: <20051115122918.GC13925@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 13:32:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbzwB-0006Mm-7d
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 13:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbVKOM3U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 07:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbVKOM3U
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 07:29:20 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:8158 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S932420AbVKOM3U (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 07:29:20 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 1A76D6DFD6D; Tue, 15 Nov 2005 13:28:54 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id DBBD76DF8C8; Tue, 15 Nov 2005 13:28:53 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id EEF5A6133A; Tue, 15 Nov 2005 13:29:18 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11902>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 I noticed this broken link in the git docs @ kernel.org ...

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 7045f3f..bd389bd 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -67,7 +67,7 @@ gitlink:git-commit-tree[1]::
 gitlink:git-hash-object[1]::
 	Computes the object ID from a file.
 
-gitlink:git-index-pack.html[1]::
+gitlink:git-index-pack[1]::
 	Build pack index file for an existing packed archive.
 
 gitlink:git-init-db[1]::
-- 
Jonas Fonseca
