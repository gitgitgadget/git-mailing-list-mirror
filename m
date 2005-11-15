From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 1/2] Cleanup: remove unused variable
Date: Tue, 15 Nov 2005 17:52:54 -0500
Message-ID: <20051115225254.16350.65938.stgit@dexter.citi.umich.edu>
References: <20051115225136.16350.96122.stgit@dexter.citi.umich.edu>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 23:54:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec9ff-0007k7-IB
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 23:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbVKOWwz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 17:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbVKOWwz
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 17:52:55 -0500
Received: from citi.umich.edu ([141.211.133.111]:42844 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S965059AbVKOWwy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 17:52:54 -0500
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 5360D1BACA;
	Tue, 15 Nov 2005 17:52:54 -0500 (EST)
To: catalin.marinas@gmail.com
In-Reply-To: <20051115225136.16350.96122.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11958>

Get rid of git.py:head_link , as it is no longer used by any part of
StGIT.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 stgit/git.py |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
index 9a07fa5..066a8f0 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -33,7 +33,6 @@ if 'GIT_DIR' in os.environ:
 else:
     base_dir = '.git'
 
-head_link = os.path.join(base_dir, 'HEAD')
 
 #
 # Classes
