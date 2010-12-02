From: Sylvain Rabot <sylvain.rabot@f-secure.com>
Subject: [PATCH] documentation: escape '~' in git revert
Date: Thu,  2 Dec 2010 18:36:33 +0100
Message-ID: <1291311393-31843-1-git-send-email-sylvain.rabot@f-secure.com>
Cc: Sylvain Rabot <sylvain.rabot@f-secure.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 18:46:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PODEg-0005D4-QZ
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 18:46:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757573Ab0LBRqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 12:46:21 -0500
Received: from fsmail-out.f-secure.com ([193.110.108.171]:35898 "EHLO
	fsmail-out.f-secure.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757303Ab0LBRqV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 12:46:21 -0500
X-Greylist: delayed 570 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 Dec 2010 12:46:20 EST
Received: from fsav4im2 (fsav4im2.f-secure.com [193.110.108.82])
	by fsmail-out.f-secure.com (Postfix) with SMTP id 130F1340AA
	for <git@vger.kernel.org>; Thu,  2 Dec 2010 19:36:49 +0200 (EET)
Received: from fsintra.f-secure.com (unknown [10.128.128.79])
 by fsav4im2 ([193.110.108.82]:25) (F-Secure Anti-Virus for Internet Mail 6.61.110 Release)
 with SMTP; Thu, 2 Dec 2010 17:36:22 -0000
 (envelope-from <sylvain.rabot@f-secure.com>)
Received: from isis.agematis.loc (unknown [10.121.180.18])
	by fsintra.f-secure.com (Postfix) with ESMTP id 6B60826064;
	Thu,  2 Dec 2010 19:36:46 +0200 (EET)
X-Mailer: git-send-email 1.7.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162716>

backslashing '~' characters do not have any effect, quoting with +++ has.

Signed-off-by: Sylvain Rabot <sylvain.rabot@f-secure.com>
---
 Documentation/git-revert.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index f40984d..9368892 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -82,12 +82,12 @@ effect to your index in a row.
 
 EXAMPLES
 --------
-git revert HEAD~3::
+git revert HEAD+++~+++3::
 
 	Revert the changes specified by the fourth last commit in HEAD
 	and create a new commit with the reverted changes.
 
-git revert -n master\~5..master~2::
+git revert -n master+++~+++5..master+++~+++2::
 
 	Revert the changes done by commits from the fifth last commit
 	in master (included) to the third last commit in master
-- 
1.7.3.2
