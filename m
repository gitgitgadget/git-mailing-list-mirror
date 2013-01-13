From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] t0050: mark TC merge (case change) as success
Date: Sun, 13 Jan 2013 21:38:36 +0100
Message-ID: <201301132138.37154.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 21:39:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuUKi-0002Uy-N2
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 21:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755922Ab3AMUis convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 15:38:48 -0500
Received: from mout.web.de ([212.227.15.4]:50543 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751825Ab3AMUir convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jan 2013 15:38:47 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0MCqmp-1TktYU3ql9-009Pyd; Sun, 13 Jan 2013 21:38:46 +0100
X-Provags-ID: V02:K0:89/AiGO1iMFclXCoCFEnwYanjUV1RLkiQHm1wBsHjA1
 VtMSqdxkoSI5FmG4x4dqD+b9H+IU0OvFN58+H5HT+WmZEOBJhR
 NKKhTKaAdKiNn5+nMoI0UQxhNLVXxGsjOp+Q8CI1kqLE0oEywY
 vWzHHHm17LzkD8To1mougpnOWRb0Lq0dyg6xVnPWwqtpRck69Z
 4yLasTFHGRNnRu0XP2wPA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213401>

The test "merge (case change)" passes on a case ignoring file system

Use test_expect_success to remove the "known breakage vanished"

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t0050-filesystem.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 78816d9..ccd685d 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -77,7 +77,7 @@ $test_case 'rename (case change)' '
=20
 '
=20
-$test_case 'merge (case change)' '
+test_expect_success 'merge (case change)' '
=20
 	rm -f CamelCase &&
 	rm -f camelcase &&
--=20
1.8.0.197.g5a90748
