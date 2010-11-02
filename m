From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 04/10] everyday.txt: change "tracking branch" to "remote-tracking branch"
Date: Tue,  2 Nov 2010 16:31:22 +0100
Message-ID: <1288711888-21528-5-git-send-email-Matthieu.Moy@imag.fr>
References: <1288711888-21528-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Nov 02 16:32:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDIqd-0003FI-Ao
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 16:32:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841Ab0KBPcW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 11:32:22 -0400
Received: from mx1.imag.fr ([129.88.30.5]:35344 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753808Ab0KBPcV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 11:32:21 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id oA2FGiRV006358
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 2 Nov 2010 16:16:44 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PDIps-00025m-3W; Tue, 02 Nov 2010 16:31:44 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1PDIps-0005cB-1c; Tue, 02 Nov 2010 16:31:44 +0100
X-Mailer: git-send-email 1.7.3.2.183.g2e7b0
In-Reply-To: <1288711888-21528-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 02 Nov 2010 16:16:44 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: oA2FGiRV006358
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1289315809.14692@ZRrxbtwTHhu9D3d1dWQ5NA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160527>


Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/everyday.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index e0ba8cc..ae413e5 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -180,12 +180,12 @@ directory; clone from it to start a repository on the satellite
 machine.
 <2> clone sets these configuration variables by default.
 It arranges `git pull` to fetch and store the branches of mothership
-machine to local `remotes/origin/*` tracking branches.
+machine to local `remotes/origin/*` remote-tracking branches.
 <3> arrange `git push` to push local `master` branch to
 `remotes/satellite/master` branch of the mothership machine.
 <4> push will stash our work away on `remotes/satellite/master`
-tracking branch on the mothership machine.  You could use this as
-a back-up method.
+remote-tracking branch on the mothership machine.  You could use this
+as a back-up method.
 <5> on mothership machine, merge the work done on the satellite
 machine into the master branch.
 
-- 
1.7.3.2.183.g2e7b0
