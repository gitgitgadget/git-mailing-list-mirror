From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] t3020: fix typo in test description
Date: Thu, 20 Aug 2015 15:58:55 +0200
Message-ID: <1440079135-25181-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 15:59:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSQN6-00023p-Jk
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 15:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbbHTN7H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Aug 2015 09:59:07 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:33160 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751467AbbHTN7H (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Aug 2015 09:59:07 -0400
Received: from x590d6ed3.dyn.telefonica.de ([89.13.110.211] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1ZSQMv-0006dL-V2; Thu, 20 Aug 2015 15:59:03 +0200
X-Mailer: git-send-email 2.5.0.415.g33d64ef
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1440079143.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276240>

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t3020-ls-files-error-unmatch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3020-ls-files-error-unmatch.sh b/t/t3020-ls-files-error=
-unmatch.sh
index ca01053bcc..124e73b8e6 100755
--- a/t/t3020-ls-files-error-unmatch.sh
+++ b/t/t3020-ls-files-error-unmatch.sh
@@ -22,7 +22,7 @@ test_expect_success \
     'test_must_fail git ls-files --error-unmatch foo bar-does-not-matc=
h'
=20
 test_expect_success \
-    'git ls-files --error-unmatch should succeed eith matched paths.' =
\
+    'git ls-files --error-unmatch should succeed with matched paths.' =
\
     'git ls-files --error-unmatch foo bar'
=20
 test_done
--=20
2.5.0.415.g33d64ef
