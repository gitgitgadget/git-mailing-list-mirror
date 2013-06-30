From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH] test: spell 'ls-files --delete' option correctly in test
 descriptions
Date: Sun, 30 Jun 2013 12:45:25 +0200
Message-ID: <1372589125-8529-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 30 12:45:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtF8k-0002wY-5G
	for gcvg-git-2@plane.gmane.org; Sun, 30 Jun 2013 12:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751626Ab3F3Kpf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Jun 2013 06:45:35 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:52693 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab3F3Kpe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jun 2013 06:45:34 -0400
Received: from localhost6.localdomain6 (f051032128.adsl.alicedsl.de [78.51.32.128])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0Lk9Jy-1UMvWC2It0-00bPN9; Sun, 30 Jun 2013 12:45:30 +0200
X-Mailer: git-send-email 1.8.3.1.684.g8c62402
X-Provags-ID: V02:K0:VEsV43w8XZpp/i38SABMu8u9YNg3GESm/+xf2VsQsNp
 Yyp2USBn5D1LnczZeUkz6j9TCal2vpev+ntIwQ2Oj50Sr15lMT
 ipKR6hSUiUJqa7sHkS85EJioMUR9m1kLu/GeTDNU/ryFI2bls/
 ZWohEkhDNQfq7QEClCi25328wFWNPdMQvLLcO+B2ugZgRO7K6/
 LohwI/niJL7VnYdhzs6n6AHeSHoAhoygVIXoZGb798op/mTmvU
 fC8Ab+SR8hJjMUr9aLdMPXn2MhXM/Vz7IGr3fsJ7eZ797E+nCu
 4ByGZn5jSDNRnVJ4McuWTkBpV7r0Jg+xB1Up765C5dzyRsS6JN
 y+PgZHjOKXGc3dzD87FjTebU6zPjexrlk6BEoxMCaFY9np5wR6
 6mcrGZ3dAkTNw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229263>

The option is spelled '--deleted'.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---
 t/t7011-skip-worktree-reading.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-r=
eading.sh
index 8f3b54d8..88d60c1c 100755
--- a/t/t7011-skip-worktree-reading.sh
+++ b/t/t7011-skip-worktree-reading.sh
@@ -91,12 +91,12 @@ test_expect_success 'update-index --remove' '
 	test_cmp expected 1
 '
=20
-test_expect_success 'ls-files --delete' '
+test_expect_success 'ls-files --deleted' '
 	setup_absent &&
 	test -z "$(git ls-files -d)"
 '
=20
-test_expect_success 'ls-files --delete' '
+test_expect_success 'ls-files --deleted' '
 	setup_dirty &&
 	test -z "$(git ls-files -d)"
 '
--=20
1.8.3.1.684.g8c62402
