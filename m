From: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH] git-filter-branch: Clarify file removal example.
Date: Fri, 16 May 2008 14:43:50 -0500
Message-ID: <E1Jx5qI-0005Ts-LT@jdl.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 21:44:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx5rB-0000yN-L6
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 21:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbYEPTnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 15:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbYEPTnz
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 15:43:55 -0400
Received: from jdl.com ([208.123.74.7]:42592 "EHLO jdl.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751823AbYEPTnz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 15:43:55 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.63)
	(envelope-from <jdl@jdl.com>)
	id 1Jx5qI-0005Ts-LT
	for git@vger.kernel.org; Fri, 16 May 2008 14:43:54 -0500
X-Spam-Score: -2.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82314>


Signed-off-by: Jon Loeliger <jdl@jdl.com>
---
 Documentation/git-filter-branch.txt |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 8d80f0d..506c37a 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -183,6 +183,10 @@ or copyright violation) from all commits:
 git filter-branch --tree-filter 'rm filename' HEAD
 -------------------------------------------------------
 
+However, if the file is absent from the tree of some commit,
+a simple `rm filename` will fail for that tree and commit.
+Thus you may instead want to use `rm -f filename` as the script.
+
 A significantly faster version:
 
 --------------------------------------------------------------------------
-- 
1.5.5.1.147.g867f
