From: Alex Vandiver <alex@chmrr.net>
Subject: [PATCH 5/5] git-svn: Correct a copy-and-pasted misleading comment
Date: Wed,  2 Dec 2009 14:07:54 -0500
Message-ID: <1259780874-14706-6-git-send-email-alex@chmrr.net>
References: <1259780874-14706-1-git-send-email-alex@chmrr.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 02 20:38:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFv21-0007t6-60
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 20:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755587AbZLBThl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 14:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755582AbZLBThk
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 14:37:40 -0500
Received: from chmrr.net ([209.67.253.66]:56890 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755560AbZLBThg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 14:37:36 -0500
Received: from 75-147-59-54-newengland.hfc.comcastbusiness.net ([75.147.59.54] helo=localhost.localdomain)
	by utwig.chmrr.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <alex@chmrr.net>)
	id 1NFuYu-0004Rd-G2
	for git@vger.kernel.org; Wed, 02 Dec 2009 14:08:32 -0500
X-Mailer: git-send-email 1.6.6.rc0.327.g032bc
In-Reply-To: <1259780874-14706-1-git-send-email-alex@chmrr.net>
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Exim-Version: 4.69 (build at 07-Feb-2009 20:08:51)
X-Date: 2009-12-02 14:08:32
X-Connected-IP: 75.147.59.54:47077
X-Message-Linecount: 31
X-Body-Linecount: 22
X-Message-Size: 1028
X-Body-Size: 617
X-Received-Count: 1
X-Recipient-Count: 1
X-Local-Recipient-Count: 1
X-Local-Recipient-Defer-Count: 0
X-Local-Recipient-Fail-Count: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134387>


Signed-off-by: Alex Vandiver <alex@chmrr.net>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 87462c9..804a26c 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2973,7 +2973,7 @@ sub find_extra_svk_parents {
 # have actually changed
 sub find_extra_svn_parents {
 	my ($self, $ed, $mergeinfo, $parents) = @_;
-	# aha!  svk:merge property changed...
+	# aha!  svn:mergeinfo property changed...
 
 	# We first search for merged tips which are not in our
 	# history.  Then, we figure out which git revisions are in
-- 
1.6.6.rc0.327.g032bc
