From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-init: remove .git/HEAD symlink creation
Date: Tue, 31 May 2005 22:47:45 +0200
Message-ID: <20050531204745.GA27243@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 22:47:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdDcu-0000Cw-0u
	for gcvg-git@gmane.org; Tue, 31 May 2005 22:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261295AbVEaUsl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 16:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVEaUsk
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 16:48:40 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:4835 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261295AbVEaUrr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 16:47:47 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id F10886E188B; Tue, 31 May 2005 22:47:11 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 5ED5E6E175C; Tue, 31 May 2005 22:47:11 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id C9A1A61FE0; Tue, 31 May 2005 22:47:45 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
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

Remove symlink creation which git-init-db now creates.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---

 cg-init |    1 -
 1 files changed, 1 deletion(-)

diff --git a/cg-init b/cg-init
--- a/cg-init
+++ b/cg-init
@@ -24,7 +24,6 @@ trap "rm -rf $_git" SIGTERM EXIT
 git-init-db
 mkdir $_git/branches
 touch $_git/refs/heads/master
-ln -s refs/heads/master $_git/HEAD
 
 if [ "$uri" ]; then
 	echo "$uri" >$_git/branches/origin
-- 
Jonas Fonseca
