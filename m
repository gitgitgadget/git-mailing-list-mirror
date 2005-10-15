From: Kalle Valo <Kalle.Valo@iki.fi>
Subject: svnimport: fixed Makefile entry
Date: Sat, 15 Oct 2005 23:44:09 +0300
Message-ID: <874q7ildd2.fsf_-_@litku.valo.iki.fi>
References: <pan.2005.08.19.10.00.49.401829@smurf.noris.de>
	<pan.2005.10.10.09.45.00.468989@smurf.noris.de>
	<878xwuldvx.fsf@litku.valo.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 22:45:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQstO-0001ge-1d
	for gcvg-git@gmane.org; Sat, 15 Oct 2005 22:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbVJOUoM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 16:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbVJOUoM
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 16:44:12 -0400
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:40056 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S1751236AbVJOUoL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2005 16:44:11 -0400
Received: from litku.valo.iki.fi ([81.197.35.21]) by fep01-app.kolumbus.fi
          with ESMTP
          id <20051015204409.BLQV24578.fep01-app.kolumbus.fi@litku.valo.iki.fi>;
          Sat, 15 Oct 2005 23:44:09 +0300
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <878xwuldvx.fsf@litku.valo.iki.fi> (Kalle Valo's message of "Sat,
	15 Oct 2005 23:32:50 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10144>

Makefile entry for git-svnimport contained a small typo.

---

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: b5467f815f8de270a755099df924bff5ed98512e
bce2921cf6fe774ba4f8edffe35ef914c2a836e6
diff --git a/Makefile b/Makefile
index 8f2dfb2..1cca928 100644
--- a/Makefile
+++ b/Makefile
@@ -94,7 +94,7 @@ SCRIPT_SH = \
 SCRIPT_PERL = \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
 	git-rename.perl git-shortlog.perl git-fmt-merge-msg.perl \
-	git-findtags.perl git-svnimport-perl
+	git-findtags.perl git-svnimport.perl
 
 SCRIPT_PYTHON = \
 	git-merge-recursive.py
---
0.99.8.GIT
