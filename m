From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH FYI] t9301-fast-export.sh: don't unset config variable while
 we're skipping test 4
Date: Mon, 18 Aug 2008 19:20:44 -0500
Message-ID: <vGteI3DnC7lCPEEY8NLHOpwB6QEGihg6tXMEhCKrvrD3WSJ6OM1o-A@cipher.nrlssc.navy.mil>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 19 02:21:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVEys-0006tM-CZ
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 02:21:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754265AbYHSAUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 20:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754061AbYHSAUq
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 20:20:46 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:39949 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037AbYHSAUp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 20:20:45 -0400
Received: by mail.nrlssc.navy.mil id m7J0KjMc001446; Mon, 18 Aug 2008 19:20:45 -0500
In-Reply-To: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 19 Aug 2008 00:20:44.0852 (UTC) FILETIME=[6BE05740:01C90191]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92789>

---


Necessary if using my compile script which included t9301.4 in GIT_SKIP_TESTS
environment variable.

-brandon


 t/t9301-fast-export.sh |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index c19b4a2..475aadd 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -190,7 +190,6 @@ export GIT_COMMITTER_NAME='C O Mitter'
 
 test_expect_success 'setup copies' '
 
-	git config --unset i18n.commitencoding &&
 	git checkout -b copy rein &&
 	git mv file file3 &&
 	git commit -m move1 &&
-- 
1.6.0.11.gecc7e
