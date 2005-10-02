From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH Cogito] Fix README asciidoc formatting
Date: Sun, 2 Oct 2005 12:56:01 +0200
Message-ID: <20051002105601.GB9934@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 02 12:56:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EM1W7-0007Bw-L2
	for gcvg-git@gmane.org; Sun, 02 Oct 2005 12:56:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbVJBK4D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Oct 2005 06:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbVJBK4D
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Oct 2005 06:56:03 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:46565 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1751072AbVJBK4C (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Oct 2005 06:56:02 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 39D836DFFDB; Sun,  2 Oct 2005 12:55:58 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id F289F6DFF9D; Sun,  2 Oct 2005 12:55:57 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 6F7DA60EF6; Sun,  2 Oct 2005 12:56:01 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9614>

Add empty lines after code blocks to switch back to normal text.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

BTW, what about adding some notatation info for those boxes? It looks
very creative for an introduction document.

commit ca52918a9a6e02e55d878d8f5e68672432940337
tree 60d270e8b45beeee9361b13284ff2eefec746fd6
parent 9356837de630644323c800e2accad2618d7393f9
author Jonas Fonseca <fonseca@diku.dk> Sun, 02 Oct 2005 12:45:03 +0200
committer Jonas Fonseca <fonseca@antimatter.(none)> Sun, 02 Oct 2005 12:45:03 +0200

 README |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/README b/README
--- a/README
+++ b/README
@@ -305,11 +305,13 @@ will `cg-clone` do?
 
 	+--------+
 	+--------+
+
 First it creates an empty repository
 
 	+--------+
 	$  origin<
 	+--------+
+
 Then it creates an 'origin' head, and will copy all the history from the
 remote repository's 'master' head there. So this head exists to reflect
 the state of the remote repository. The important point is that it is
@@ -325,6 +327,7 @@ head and possibly push to it.
 	|  master<
 	$  origin<
 	+--------+
+
 Finally it copied over the 'origin' head to the 'master' head, which will
 from now as your current head represent your local development in the
 repository.
@@ -337,6 +340,7 @@ will it do?
 	|  master<
 	$  origin< < < < <
 	+--------+
+
 First, it will populate your 'origin' head with the new commits from the
 remote's 'master' head.
 
@@ -344,6 +348,7 @@ remote's 'master' head.
 	|  master<-M-.
 	$  origin>---'
 	+--------+
+
 Then, it will merge those new commits to your 'master' head.
 
 Now let's imagine that there is also another head 'unoji' on the other side

-- 
Jonas Fonseca
