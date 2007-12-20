From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH] Remove old generated files from .gitignore.
Date: Thu, 20 Dec 2007 13:00:40 +0000
Message-ID: <20071220130040.GA5638@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 20 14:01:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5L1T-0000Fu-M8
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 14:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbXLTNAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 08:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752484AbXLTNAq
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 08:00:46 -0500
Received: from ptb-relay02.plus.net ([212.159.14.213]:38694 "EHLO
	ptb-relay02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752231AbXLTNAp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 08:00:45 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay02.plus.net with esmtp (Exim) id 1J5L11-0003lP-6c
	for git@vger.kernel.org; Thu, 20 Dec 2007 13:00:43 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id lBKD0esm005933
	for <git@vger.kernel.org>; Thu, 20 Dec 2007 13:00:40 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id lBKD0eCi005932
	for git@vger.kernel.org; Thu, 20 Dec 2007 13:00:40 GMT
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69003>

Some entries in .gitignore are obselete.  These should be cleaned up
just for the sake of general tidiness and so that any developers who
have a working tree that was moved forward without a clean know that
they have old stuff in their work tree.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 .gitignore |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/.gitignore b/.gitignore
index dab5bc2..7f8421d 100644
--- a/.gitignore
+++ b/.gitignore
@@ -41,7 +41,6 @@ git-fetch
 git-fetch--tool
 git-fetch-pack
 git-filter-branch
-git-findtags
 git-fmt-merge-msg
 git-for-each-ref
 git-format-patch
@@ -59,7 +58,6 @@ git-index-pack
 git-init
 git-init-db
 git-instaweb
-git-local-fetch
 git-log
 git-lost-found
 git-ls-files
@@ -120,10 +118,6 @@ git-show
 git-show-branch
 git-show-index
 git-show-ref
-git-ssh-fetch
-git-ssh-pull
-git-ssh-push
-git-ssh-upload
 git-stash
 git-status
 git-stripspace
-- 
1.5.4.rc0
