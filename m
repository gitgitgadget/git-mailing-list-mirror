From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] README: point to Documentation/SubmittingPatches
Date: Thu, 23 Feb 2012 13:52:06 +0100
Message-ID: <1330001526-23772-1-git-send-email-Matthieu.Moy@imag.fr>
References: <CAAUd643RHOrhm+gfW5UeXfjcG0Xr+q0nxzAVqYsh8VxhhP_m1g@mail.gmail.com>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 23 13:53:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0YAl-0003fI-DU
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 13:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550Ab2BWMxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Feb 2012 07:53:10 -0500
Received: from mx2.imag.fr ([129.88.30.17]:57277 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752328Ab2BWMxI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2012 07:53:08 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q1NCmKO0003565
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 23 Feb 2012 13:48:20 +0100
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1S0Y9X-0008Mm-Tf; Thu, 23 Feb 2012 13:52:07 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1S0Y9X-0006C5-QH; Thu, 23 Feb 2012 13:52:07 +0100
X-Mailer: git-send-email 1.7.9.111.gf3fb0.dirty
In-Reply-To: <CAAUd643RHOrhm+gfW5UeXfjcG0Xr+q0nxzAVqYsh8VxhhP_m1g@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 23 Feb 2012 13:48:20 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q1NCmKO0003565
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1330606102.60269@EFMyPxdYtvNpUHIRdpjryg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191360>

It was indeed not obvious for new contributors to find this document in
the source tree, since there were no reference to it outside the
Documentation/ directory.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
> Thank you for the advice, I read README file (couldn't find a HACKING
> one) and the git website, and neither of those had a reference to
> SubmittingPatches..

Indeed. As a bonnus, here's a submission that should match the
guidelines (above --- is the commit message, and here is the place for
free comments).

 README |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/README b/README
index 67cfeb2..d2690ec 100644
--- a/README
+++ b/README
@@ -42,10 +42,12 @@ including full documentation and Git related tools.
 
 The user discussion and development of Git take place on the Git
 mailing list -- everyone is welcome to post bug reports, feature
-requests, comments and patches to git@vger.kernel.org. To subscribe
-to the list, send an email with just "subscribe git" in the body to
-majordomo@vger.kernel.org. The mailing list archives are available at
-http://marc.theaimsgroup.com/?l=git and other archival sites.
+requests, comments and patches to git@vger.kernel.org (read
+Documentation/SubmittingPatches for instructions on patch submission).
+To subscribe to the list, send an email with just "subscribe git" in
+the body to majordomo@vger.kernel.org. The mailing list archives are
+available at http://marc.theaimsgroup.com/?l=git and other archival
+sites.
 
 The messages titled "A note from the maintainer", "What's in
 git.git (stable)" and "What's cooking in git.git (topics)" and
-- 
1.7.9.111.gf3fb0.dirty
