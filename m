From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH 1/3] t0050: known breakage vanished in merge (case change)
Date: Sat, 19 Jan 2013 08:19:04 +0100
Message-ID: <201301190819.05309.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 08:19:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwSiD-0003SF-KW
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 08:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940Ab3ASHTN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2013 02:19:13 -0500
Received: from mout.web.de ([212.227.17.11]:51935 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750864Ab3ASHTM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2013 02:19:12 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0LZeou-1TDX1u3V5I-00lLsa; Sat, 19 Jan 2013 08:19:10 +0100
X-Provags-ID: V02:K0:k2ARMyBgqb2o4sDOEScudVjvJy0oWrVrgmuGe/hT7rf
 CO0C3fowi61Qjz4jre7GskJMTBDQm6J4q2gq70QNb98peVTyYZ
 ycDb3gxcEoIaHtvw/noC8nr5Yy1WLigtAANp2NxxqskzmGAEv9
 A4VqjSlVM2YMTc/u0me19cW8YyDxkqhfjumICFEoSd08nMGbfZ
 Tz0BCuiI4vkZKx98YgptQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213958>

This test case has passed ever since:
commit 0047dd2fd1fc1980913901c5fa098357482c2842
Author: Steffen Prohaska <prohaska@zib.de>
Date:   Thu May 15 07:19:54 2008 +0200

    t0050: Fix merge test on case sensitive file systems

Demand it to pass by using test_expect_success

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
