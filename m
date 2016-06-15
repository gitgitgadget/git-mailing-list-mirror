From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH 2/7] Undocument deprecated alias 'push.default=tracking'
Date: Tue, 24 Apr 2012 09:50:01 +0200
Message-ID: <1335253806-9059-3-git-send-email-Matthieu.Moy@imag.fr>
References: <1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335253806-9059-1-git-send-email-Matthieu.Moy@imag.fr>
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Apr 24 09:51:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMaWc-0001nS-55
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 09:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786Ab2DXHuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 03:50:54 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46942 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754490Ab2DXHux (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 03:50:53 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q3O7i4FX023594
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 24 Apr 2012 09:44:06 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SMaW9-0007JR-7L; Tue, 24 Apr 2012 09:50:33 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1SMaW9-0002Na-5U; Tue, 24 Apr 2012 09:50:33 +0200
X-Mailer: git-send-email 1.7.10.234.g365b0
In-Reply-To: <1335253806-9059-1-git-send-email-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 24 Apr 2012 09:44:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q3O7i4FX023594
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1335858250.89468@1LNQ+wpIyWcUCMsB/oIusA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196195>

It's been deprecated since 53c4031 (Johan Herland, Wed Feb 16 2011,
push.default: Rename 'tracking' to 'upstream'), so it's OK to remove it
from documentation (even though it's still supported) to make the
explanations more readable.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 Documentation/config.txt |    1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5f14871..9617c53 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1690,7 +1690,6 @@ push.default::
   With this, `git push` will update the same remote ref as the one which
   is merged by `git pull`, making `push` and `pull` symmetrical.
   See "branch.<name>.merge" for how to configure the upstream branch.
-* `tracking` - deprecated synonym for `upstream`.
 * `current` - push the current branch to a branch of the same name.
   +
   The `current` and `upstream` modes are for those who want to
-- 
1.7.10.234.g365b0
