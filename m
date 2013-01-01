From: "David A. Greene" <greened@obbligato.org>
Subject: [PATCH 4/8] Fix Synopsis
Date: Mon, 31 Dec 2012 21:57:31 -0600
Message-ID: <1357012655-24974-5-git-send-email-greened@obbligato.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
Cc: "David A. Greene" <greened@obbligato.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 01 04:59:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tpt0C-00006e-SY
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 04:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751889Ab3AAD60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2012 22:58:26 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:48325 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751609Ab3AAD6X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2012 22:58:23 -0500
Received: from c-75-73-20-8.hsd1.mn.comcast.net ([75.73.20.8] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
	(Exim 4.80)
	(envelope-from <greened@obbligato.org>)
	id 1Tpt6j-0005na-IE; Mon, 31 Dec 2012 22:05:42 -0600
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1357012655-24974-1-git-send-email-greened@obbligato.org>
X-Filter-Spam-Score: -2.9 (--)
X-Filter-Spam-Report: Spam detection software, running on the system "johnson.obbligato.org", has
 identified this incoming email as possible spam.  The original message
 has been attached to this so you can view it (if it isn't spam) or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  From: "David A. Greene" <greened@obbligato.org> Fix the documentation
    of add to show that a repository can be specified along with a commit. Change
    "commit" to "refspec" in the synopsis for add. [...] 
 Content analysis details:   (-2.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                    
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212405>

From: "David A. Greene" <greened@obbligato.org>

Fix the documentation of add to show that a repository can be
specified along with a commit.

Change "commit" to "refspec" in the synopsis for add.

Suggested by Yann Dirson <dirson@bertin.fr>.

Signed-off-by: David A. Greene <greened@obbligato.org>
---
 contrib/subtree/git-subtree.sh  |    3 ++-
 contrib/subtree/git-subtree.txt |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index b8a807a..ad62dfb 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -8,7 +8,8 @@ if [ $# -eq 0 ]; then
     set -- -h
 fi
 OPTS_SPEC="\
-git subtree add   --prefix=<prefix> <commit>
+git subtree add   --prefix=<prefix> <refspec>
+git subtree add   --prefix=<prefix> <repository> <refspec>
 git subtree merge --prefix=<prefix> <commit>
 git subtree pull  --prefix=<prefix> <repository> <refspec...>
 git subtree push  --prefix=<prefix> <repository> <refspec...>
diff --git a/contrib/subtree/git-subtree.txt b/contrib/subtree/git-subtree.txt
index ae420aa..89c2d6e 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -9,7 +9,8 @@ git-subtree - Merge subtrees together and split repository into subtrees
 SYNOPSIS
 --------
 [verse]
-'git subtree' add   -P <prefix> <commit>
+'git subtree' add   -P <prefix> <refspec>
+'git subtree' add   -P <prefix> <repository> <refspec>
 'git subtree' pull  -P <prefix> <repository> <refspec...>
 'git subtree' push  -P <prefix> <repository> <refspec...>
 'git subtree' merge -P <prefix> <commit>
-- 
1.7.10.4
