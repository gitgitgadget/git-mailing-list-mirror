From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] t0050: mark TC merge (case change) as success
Date: Sun, 13 Jan 2013 21:38:21 +0100
Message-ID: <201301132138.22186.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 13 21:39:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuUKd-0002Mq-A9
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 21:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348Ab3AMUin convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 15:38:43 -0500
Received: from mout.web.de ([212.227.17.11]:60169 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751825Ab3AMUim convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jan 2013 15:38:42 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0MOzrj-1TqLag15bL-006Arn; Sun, 13 Jan 2013 21:38:41 +0100
X-Provags-ID: V02:K0:iWtquE/zc8YZywekniSeEdVtKcJFV7cXoYKwyJF8UvC
 qI+tUkHuP9gwZQPQMKZuE6APHEN7Zizd0p3/GM+jhnLWEm0KQJ
 7mOZxnRNgW8hQ19cowBliAkJIZFe0Jpz8vaiGRoV+7J7fHpoLj
 pOKARph85ggEgU5n70MPfOSbzJa9TMsrTQt71qWOMFc22wVlSB
 SxKbDErLlw0HyoQ50/4ZQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213400>

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
