From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] for-each-ref: fix description of '--contains' in manpage
Date: Wed, 30 Mar 2016 15:48:30 +0200
Message-ID: <1459345710-8088-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 15:49:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alGUZ-0004vG-CR
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 15:49:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbcC3Ns6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Mar 2016 09:48:58 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:36648 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752836AbcC3Ns5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Mar 2016 09:48:57 -0400
Received: from x4db1c097.dyn.telefonica.de ([77.177.192.151] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1alGUN-00055a-L9; Wed, 30 Mar 2016 15:48:53 +0200
X-Mailer: git-send-email 2.8.0.46.gb821760
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1459345733.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290306>

'git for-each-ref's manpage says that '--contains' only lists tags,
but it lists all kinds of refs.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 Documentation/git-for-each-ref.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for=
-each-ref.txt
index 012e8f9a080d..c52578bb87cc 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -76,7 +76,7 @@ OPTIONS
 	specified commit (HEAD if not specified).
=20
 --contains [<object>]::
-	Only list tags which contain the specified commit (HEAD if not
+	Only list refs which contain the specified commit (HEAD if not
 	specified).
=20
 FIELD NAMES
--=20
2.8.0.46.gb821760
