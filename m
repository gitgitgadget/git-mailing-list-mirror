From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git-merge: include missing options in OPTIONS_SPEC
Date: Mon, 12 May 2008 16:50:11 +0200
Message-ID: <1210603811-12613-1-git-send-email-vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 12 16:51:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvZMq-0007fR-Gr
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 16:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbYELOuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 10:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbYELOuR
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 10:50:17 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:56071 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbYELOuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 10:50:16 -0400
Received: from vmobile.example.net (dsl5401CA14.pool.t-online.hu [84.1.202.20])
	by yugo.frugalware.org (Postfix) with ESMTP id B81941DDC5B
	for <git@vger.kernel.org>; Mon, 12 May 2008 16:50:14 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 2C579185E19; Mon, 12 May 2008 16:50:11 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1.211.g65ea3.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81867>

--no-squash, --no-commit and --no-ff was missing from the output of
git-merge --help. This patch fixes the issue.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 git-merge.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-merge.sh b/git-merge.sh
index 69b35d8..09c002b 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -15,8 +15,11 @@ no-summary           (synonym to --no-stat)
 log                  add list of one-line log to merge commit message
 no-log               don't add list of one-line log to merge commit message
 squash               create a single commit instead of doing a merge
+no-squash            don't create a single commit instead of merging (default)
 commit               perform a commit if the merge sucesses (default)
+no-commit            don't perform a commit if the merge sucesses
 ff                   allow fast forward (default)
+no-ff                don't allow fast forward
 s,strategy=          merge strategy to use
 m,message=           message to be used for the merge commit (if any)
 "
-- 
1.5.5.1
