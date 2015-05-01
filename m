From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] completion: fix and update 'git log --decorate=' options
Date: Fri,  1 May 2015 19:21:00 +0200
Message-ID: <1430500860-4664-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 01 19:21:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoEco-0004fA-SH
	for gcvg-git-2@plane.gmane.org; Fri, 01 May 2015 19:21:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbbEARVO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 May 2015 13:21:14 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:39943 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750923AbbEARVO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 May 2015 13:21:14 -0400
Received: from x590c27d8.dyn.telefonica.de ([89.12.39.216] helo=localhost)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1YoEcg-0006sZ-9A; Fri, 01 May 2015 19:21:11 +0200
X-Mailer: git-send-email 1.9.5.msysgit.0
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1430500871.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268160>

'git log --decorate=3D' understands the 'full', 'short' and 'no' option=
s.
=46rom these the completion script only offered 'short' and it offered
'long' instead of 'full'.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 8b0d2b4..b28a14e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1447,7 +1447,7 @@ _git_log ()
 		return
 		;;
 	--decorate=3D*)
-		__gitcomp "long short" "" "${cur##--decorate=3D}"
+		__gitcomp "full short no" "" "${cur##--decorate=3D}"
 		return
 		;;
 	--*)
--=20
1.9.5.msysgit.0
