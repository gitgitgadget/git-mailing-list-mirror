From: Greg Price <price@MIT.EDU>
Subject: [PATCH] Small grammar fix
Date: Mon, 25 Feb 2013 00:27:20 -0500
Message-ID: <20130225052718.GG5688@biohazard-cafe.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 06:32:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9qgD-0005Xr-6U
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 06:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203Ab3BYFcY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 00:32:24 -0500
Received: from DMZ-MAILSEC-SCANNER-1.MIT.EDU ([18.9.25.12]:55480 "EHLO
	dmz-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751953Ab3BYFcY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2013 00:32:24 -0500
X-Greylist: delayed 300 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Feb 2013 00:32:23 EST
X-AuditID: 1209190c-b7f046d00000094c-c4-512af63a6145
Received: from mailhub-auth-1.mit.edu ( [18.9.21.35])
	by dmz-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 88.46.02380.A36FA215; Mon, 25 Feb 2013 00:27:22 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH-1.MIT.EDU [18.9.28.11])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id r1P5RMeZ025635;
	Mon, 25 Feb 2013 00:27:22 -0500
Received: from localhost (BIOHAZARD-CAFE.MIT.EDU [18.9.64.18])
	(authenticated bits=0)
        (User authenticated as price@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.8/8.12.4) with ESMTP id r1P5RKP8025265;
	Mon, 25 Feb 2013 00:27:21 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsUixCmqrGv1TSvQYP50S4uuK91MFg29V5gd
	mDwuXlL2+LxJLoApissmJTUnsyy1SN8ugStjzuGjbAX3uSo6enYyNzC+4+hi5OSQEDCR+Ni1
	mQnCFpO4cG89G4gtJLCPUWLzH7suRi4geyOjxMFDl6ESnxklTnZygtgsAqoSu2dvAGtmE1CQ
	+DF/HTOILSIgLvH2+Ex2EJtZQE2ifdMUVhBbWEBJYte224xdjBwcvAJWEvM++ICEeQUEJU7O
	fMICUa4lcePfSyaQEmYBaYnl/8DOFBVQkbi2v51tAiP/LCQds5B0zELoWMDIvIpRNiW3Sjc3
	MTOnODVZtzg5MS8vtUjXUC83s0QvNaV0EyM4CCV5djC+Oah0iFGAg1GJh7dhpVagEGtiWXFl
	7iFGSQ4mJVFe2VdAIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8mqFAOd6UxMqq1KJ8mJQ0B4uS
	OO/llJv+QgLpiSWp2ampBalFMFkZDg4lCd68r0CNgkWp6akVaZk5JQhpJg5OkOE8QMMzQGp4
	iwsSc4sz0yHypxh1OXr/PXvBKMSSl5+XKiXO2wlSJABSlFGaBzcHljxeMYoDvSXMWwZSxQNM
	PHCTXgEtYQJa8lBHHWRJSSJCSqqBceEukTk/Klz3HDVwMrnBfq6IK/bRsplOe9df+L9p5YOW
	wCv5n7bb7lSYmi6xtf7Nl1UzdVZb+1+b0zZXQKtKPcU1uPTP+qADVhzl+zgk9nw1qwyqW7mw
	en/D2hjzWbe1nPYJTePi3aF29pdLYN3NbU9W7Am+JH7i0UfjQ3n9P8Vm3X0r7/xG 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217028>

"Advice" is a mass noun, not a count noun; it's not
ordinarily pluralized.

(I've never seen "advices" before, and to double-check that this isn't
an idiosyncrasy of mine I checked the Google Ngram data:
  http://books.google.com/ngrams/graph?content=advice%2Cadvices
which shows "advices" is <1/100 as common as "advice".)

Signed-off-by: Greg Price <price@mit.edu>
---
 Documentation/config.txt | 2 +-
 t/t7512-status-help.sh   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e452ff8..dbb2faf 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -168,7 +168,7 @@ advice.*::
 		Advice shown when linkgit:git-merge[1] refuses to
 		merge to avoid overwriting local changes.
 	resolveConflict::
-		Advices shown by various commands when conflicts
+		Advice shown by various commands when conflicts
 		prevent the operation from being performed.
 	implicitIdentity::
 		Advice on how to set your identity configuration when
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index b3f6eb9..95d6510 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -5,7 +5,7 @@
 #		     Grenoble INP Ensimag
 #
 
-test_description='git status advices'
+test_description='git status advice'
 
 . ./test-lib.sh
 
-- 
1.7.11.3
