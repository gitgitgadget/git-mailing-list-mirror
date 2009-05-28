From: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
Subject: [PATCH] tg-update: fix user visible typo in info msg
Date: Thu, 28 May 2009 09:04:33 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0905280856460.10088@wrl-59.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-696208474-168678404-1243490673=:10088"
Cc: "=?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?=" 
	<u.kleine-koenig@pengutronix.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 08:04:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9YjO-0002BS-Ae
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 08:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758553AbZE1GEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 02:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757241AbZE1GEe
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 02:04:34 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:54395 "EHLO
	mail.cs.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756210AbZE1GEd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 02:04:33 -0400
Received: from wrl-59.cs.helsinki.fi (wrl-59.cs.helsinki.fi [128.214.166.179])
  (AUTH: PLAIN cs-relay, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by mail.cs.helsinki.fi with esmtp; Thu, 28 May 2009 09:04:34 +0300
  id 00063DCD.4A1E2972.00006DC7
Received: by wrl-59.cs.helsinki.fi (Postfix, from userid 50795)
	id BDD6C16B141; Thu, 28 May 2009 09:04:33 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
	by wrl-59.cs.helsinki.fi (Postfix) with ESMTP id AC86CA0091;
	Thu, 28 May 2009 09:04:33 +0300 (EEST)
X-X-Sender: ijjarvin@wrl-59.cs.helsinki.fi
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120153>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---696208474-168678404-1243490673=:10088
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT


Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@helsinki.fi>
---
 tg-update.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tg-update.sh b/tg-update.sh
index 288ec14..73280c6 100644
--- a/tg-update.sh
+++ b/tg-update.sh
@@ -59,7 +59,7 @@ if [ -s "$depcheck" ]; then
 					info "You are in a subshell. If you abort the merge,"
 					info "use \`exit 1\` to abort the recursive update altogether."
 					if ! sh -i </dev/tty; then
-						info "Ok, you aborated the merge. Now, you just need to"
+						info "Ok, you aborted the merge. Now, you just need to"
 						info "switch back to some sane branch using \`git checkout\`."
 						exit 3
 					fi
-- 
1.5.2.2

---696208474-168678404-1243490673=:10088--
