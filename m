From: Linus Torvalds <torvalds@osdl.org>
Subject: Fix typo in tutorial-2.txt
Date: Mon, 5 Jun 2006 12:47:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606051245470.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Jun 05 21:48:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnL3Q-0007tZ-HI
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 21:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWFETr5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 15:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWFETr5
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 15:47:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29628 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751332AbWFETr4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jun 2006 15:47:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k55Jlo2g006246
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 5 Jun 2006 12:47:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k55JlnpI022330;
	Mon, 5 Jun 2006 12:47:50 -0700
To: "J. Bruce Fields" <bfields@citi.umich.edu>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21332>


This should be obvious enough.

I didn't actually _test_ the tutorial, but if the old command worked, 
something is really wrong!

Signed-off-by: Linus "Duh!" Torvalds <torvalds@osdl.org>
---
 Documentation/tutorial-2.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/tutorial-2.txt b/Documentation/tutorial-2.txt
index 82c6922..894ca5e 100644
--- a/Documentation/tutorial-2.txt
+++ b/Documentation/tutorial-2.txt
@@ -136,7 +136,7 @@ The "tree" object here refers to the new
 ------------------------------------------------
 $ git ls-tree d0492b36
 100644 blob a0423896973644771497bdc03eb99d5281615b51    file.txt
-$ git cat-file commit a0423896
+$ git cat-file blob a0423896
 hello world!
 ------------------------------------------------
 
