From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v2 1/3] t0050: known breakage vanished in merge (case change)
Date: Mon, 21 Jan 2013 17:45:43 +0100
Message-ID: <201301211745.43684.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 17:46:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxKVe-0006Eg-UM
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 17:46:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667Ab3AUQpu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2013 11:45:50 -0500
Received: from mout.web.de ([212.227.17.11]:60887 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752516Ab3AUQpt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2013 11:45:49 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0LjrYH-1TLntN18Qb-00bhcu; Mon, 21 Jan 2013 17:45:48 +0100
X-Provags-ID: V02:K0:zr210u3/64Jg5wYe2jsAB26E/aia3eN96/6+Q5ajBLy
 JCe2S1Nn6/Rk5sX1gKxvgQZDQgWw3EdnS77xcik8Px7MXupOxZ
 re6WbLHYTnftWHCEbMibpHp+ln1kFkZbhohGRwcP1QDQARrJmd
 Ha2DV0rd9jxwwgLKOwZwVFEyDQsgiV7ZULHqvE0vi9Cy83lZh1
 Aw8TJmLQZWSnXxALalS0w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214130>

This test case has passed since this commit:

  commit 0047dd2fd1fc1980913901c5fa098357482c2842
  Author: Steffen Prohaska <prohaska@zib.de>
  Date:   Thu May 15 07:19:54 2008 +0200

    t0050: Fix merge test on case sensitive file systems

Remove the known breakage by using test_expect_success

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
Changes since v1: Improved commit message
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
