From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] git-completion: add --autostash for 'git rebase'
Date: Wed,  7 Jan 2015 13:40:31 +0100
Message-ID: <1420634431-18830-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 07 14:10:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8qHz-0000sg-Du
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 14:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702AbbAGNEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 08:04:34 -0500
Received: from mx2.imag.fr ([129.88.30.17]:58660 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751861AbbAGNEd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 08:04:33 -0500
X-Greylist: delayed 1426 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Jan 2015 08:04:32 EST
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t07CebxL006243
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Jan 2015 13:40:37 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t07CecSC027152;
	Wed, 7 Jan 2015 13:40:38 +0100
Received: from moy by anie.imag.fr with local (Exim 4.80)
	(envelope-from <moy@imag.fr>)
	id 1Y8pug-0004ua-ER; Wed, 07 Jan 2015 13:40:38 +0100
X-Mailer: git-send-email 2.0.2.737.gfb43bde
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 07 Jan 2015 13:40:37 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t07CebxL006243
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1421239238.62063@j9Dd9imu5VxiCy8EMMjm1Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262131>

This option was added in 587947750bd73544 (not to be confused with
--autosquash).

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 contrib/completion/git-completion.bash | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 23988ec..5c369f7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1693,6 +1693,7 @@ _git_rebase ()
 			--committer-date-is-author-date --ignore-date
 			--ignore-whitespace --whitespace=
 			--autosquash --fork-point --no-fork-point
+			--autostash
 			"
 
 		return
-- 
2.0.2.737.gfb43bde
