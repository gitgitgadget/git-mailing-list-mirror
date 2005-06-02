From: Alexey Nezhdanov <snake@penza-gsm.ru>
Subject: Re: [PATCH] several typos in tutorial
Date: Thu, 2 Jun 2005 16:56:11 +0400
Message-ID: <200506021656.11180.snake@penza-gsm.ru>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org> <200506021645.15247.snake@penza-gsm.ru> <20050602125124.GA31680@snarc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Vincent Hanquez <tab@snarc.org>
X-From: git-owner@vger.kernel.org Thu Jun 02 14:57:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdpFe-00009o-9n
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 14:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVFBM72 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 08:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVFBM72
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 08:59:28 -0400
Received: from host-80-95-32-178.leasedlines.sura.ru ([80.95.32.178]:48610
	"HELO penza-gsm.ru") by vger.kernel.org with SMTP id S261408AbVFBM7K convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 08:59:10 -0400
Received: (qmail 24735 invoked from network); 2 Jun 2005 12:59:08 -0000
Received: from unknown (HELO nezhdanov.penza-gsm.ru) (192.168.4.99)
  by fileserver.penza-gsm.ru with SMTP; 2 Jun 2005 12:59:07 -0000
Received: (qmail 9845 invoked by uid 1000); 2 Jun 2005 12:59:06 -0000
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.7.2
In-Reply-To: <20050602125124.GA31680@snarc.org>
X-KMail-Link-Message: 239668
X-KMail-Link-Type: reply
X-KMail-Identity: 1411969544
Content-Disposition: inline
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on fileserver
X-Spam-Level: 
X-Spam-Status: No, score=-105.8 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	USER_IN_WHITELIST autolearn=unavailable version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alexey Nezhdanov <snake@penza-gsm.ru>
---
diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -298,7 +298,7 @@ have committed something, we can also le
 
 Unlike "git-diff-files", which showed the difference between the index
 file and the working directory, "git-diff-cache" shows the differences
-between a committed _tree_ and the index file.  In other words,
+between a committed _tree_ and the working directory.  In other words,
 git-diff-cache wants a tree to be diffed against, and before we did the
 commit, we couldn't do that, because we didn't have anything to diff
 against. 
@@ -423,10 +423,10 @@ With that, you should now be having some
 can explore on your own.
 
 
-	Copoying archives
-	-----------------
+	Copying archives
+	----------------
 
-Git arhives are normally totally self-sufficient, and it's worth noting
+Git archives are normally totally self-sufficient, and it's worth noting
 that unlike CVS, for example, there is no separate notion of
 "repository" and "working tree".  A git repository normally _is_ the
 working tree, with the local git information hidden in the ".git"

