From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Include diff options in the git-log manpage
Date: Thu,  1 Nov 2007 15:57:40 +0100
Message-ID: <1193929060-6183-2-git-send-email-vmiklos@frugalware.org>
References: <1193929060-6183-1-git-send-email-vmiklos@frugalware.org>
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 15:59:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InbW6-0004QH-80
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 15:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554AbXKAO7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 10:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754413AbXKAO7I
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 10:59:08 -0400
Received: from virgo.iok.hu ([193.202.89.103]:55128 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754297AbXKAO7F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 10:59:05 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E6CEB1B2518;
	Thu,  1 Nov 2007 15:59:01 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 66FF344664;
	Thu,  1 Nov 2007 15:58:35 +0100 (CET)
Received: from vmobile.example.net (dsl5401C90E.pool.t-online.hu [84.1.201.14])
	by genesis.frugalware.org (Postfix) with ESMTP id 4D77E13A40D4;
	Thu,  1 Nov 2007 15:59:01 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 76AA6186D6D; Thu,  1 Nov 2007 15:57:40 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <1193929060-6183-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62969>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Recently I wanted to see what git log -M does but actually I was not able to
find it in the manpage, finally figured out that all the diff options are
missing from here.

Removing -p as it's already in diff-options.txt.

If this patch OK, then I would like to send a similar patch to
git-rev-list.txt, too.

 Documentation/git-log.txt |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 5ec547c..4b1b982 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -27,6 +27,8 @@ OPTIONS
 
 include::pretty-options.txt[]
 
+include::diff-options.txt[]
+
 -<n>::
 	Limits the number of commits to show.
 
@@ -43,9 +45,6 @@ include::pretty-options.txt[]
 	commit.  This  option gives a better overview of the
 	evolution of a particular branch.
 
--p::
-	Show the change the commit introduces in a patch form.
-
 -g, \--walk-reflogs::
 	Show commits as they were recorded in the reflog. The log contains
 	a record about how the tip of a reference was changed.
-- 
1.5.3.5
