From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: [PATCH] documentation: replace wrongly evalutated backslashed '~' characters
Date: Thu,  2 Dec 2010 20:15:24 +0100
Message-ID: <1291317324-19594-1-git-send-email-sylvain@abstraction.fr>
References: <7vzksoqbjd.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sylvain Rabot <sylvain.rabot@f-secure.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sylvain Rabot <sylvain@abstraction.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 20:15:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POEdC-0006eq-10
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 20:15:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758038Ab0LBTPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 14:15:33 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55913 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757322Ab0LBTPc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 14:15:32 -0500
Received: by wyb28 with SMTP id 28so8553636wyb.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 11:15:31 -0800 (PST)
Received: by 10.227.138.129 with SMTP id a1mr744699wbu.6.1291317331019;
        Thu, 02 Dec 2010 11:15:31 -0800 (PST)
Received: from localhost.localdomain (85-168-196-51.rev.numericable.fr [85.168.196.51])
        by mx.google.com with ESMTPS id f35sm644364wbf.2.2010.12.02.11.15.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Dec 2010 11:15:29 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <7vzksoqbjd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162735>

Sometimes when there is more than one '~' on a line
it gets evaluated even if being backslashed and cause
'~' characters to be removed in the man pages.

Signed-off-by: Sylvain Rabot <sylvain@abstraction.fr>
---
 Documentation/git-cherry-pick.txt |    2 +-
 Documentation/git-revert.txt      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 3c96fa8..7300870 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -92,7 +92,7 @@ git cherry-pick ^HEAD master::
 	Apply the changes introduced by all commits that are ancestors
 	of master but not of HEAD to produce new commits.
 
-git cherry-pick master\~4 master~2::
+git cherry-pick master{tilde}4 master{tilde}2::
 
 	Apply the changes introduced by the fifth and third last
 	commits pointed to by master and create 2 new commits with
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index f40984d..752fc88 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -87,7 +87,7 @@ git revert HEAD~3::
 	Revert the changes specified by the fourth last commit in HEAD
 	and create a new commit with the reverted changes.
 
-git revert -n master\~5..master~2::
+git revert -n master{tilde}5..master{tilde}2::
 
 	Revert the changes done by commits from the fifth last commit
 	in master (included) to the third last commit in master
-- 
1.7.3.2
