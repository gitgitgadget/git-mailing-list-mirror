From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] completion: teach 'scissors' mode to 'git commit --cleanup='
Date: Mon,  8 Jun 2015 03:43:31 +0200
Message-ID: <1433727811-6094-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 03:43:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1m6Q-0004g9-6E
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 03:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbbFHBnq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Jun 2015 21:43:46 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:55020 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750872AbbFHBnp (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jun 2015 21:43:45 -0400
Received: from x590e3f67.dyn.telefonica.de ([89.14.63.103] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1Z1m6H-0003Uj-AE; Mon, 08 Jun 2015 03:43:42 +0200
X-Mailer: git-send-email 2.4.3.384.g605df7b
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1433727822.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270989>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index bfc74e9d57..a1098765f6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1108,7 +1108,7 @@ _git_commit ()
=20
 	case "$cur" in
 	--cleanup=3D*)
-		__gitcomp "default strip verbatim whitespace
+		__gitcomp "default scissors strip verbatim whitespace
 			" "" "${cur##--cleanup=3D}"
 		return
 		;;
--=20
2.4.3.384.g605df7b
