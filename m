From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] tests: turn on test-lint-shell-syntax by default
Date: Sat, 12 Jan 2013 06:50:45 +0100
Message-ID: <201301120650.46479.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 12 06:51:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttu00-0007ZN-Hu
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 06:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669Ab3ALFuy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jan 2013 00:50:54 -0500
Received: from mout.web.de ([212.227.17.12]:51709 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485Ab3ALFux convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jan 2013 00:50:53 -0500
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0M6V1T-1T1V0y2Byt-00yJw5; Sat, 12 Jan 2013 06:50:51 +0100
X-Provags-ID: V02:K0:w/3Wydna0uVOmAalOfANSsHIBpxjpjMlUU6DBHkB0eF
 hYEOT6NGKklh9AXahFNWP6MwFXOhBH3h5XV1TiC5KSHzfDJ1j1
 PZq1IcJ4N03NNS0HiGFWS59hgEaaxTu47WUysxtcyN838cQ/sV
 lG2+SIarqrKkQbeHeBECMPwXuZx8uPXS7Zv0cudsW+5mOQDNRM
 5+pUh+dtoJxtGaOYWApgA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213264>

The test Makefile has a default set of lint tests which are run
as part of "make test".

The macro TEST_LINT defaults to "test-lint-duplicates test-lint-executa=
ble".

Add test-lint-shell-syntax here, to detect non-portable shell syntax ea=
rly.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/Makefile b/t/Makefile
index 1923cc1..6fa2b80 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -13,7 +13,7 @@ TAR ?=3D $(TAR)
 RM ?=3D rm -f
 PROVE ?=3D prove
 DEFAULT_TEST_TARGET ?=3D test
-TEST_LINT ?=3D test-lint-duplicates test-lint-executable
+TEST_LINT ?=3D test-lint-duplicates test-lint-executable test-lint-she=
ll-syntax
=20
 # Shell quote;
 SHELL_PATH_SQ =3D $(subst ','\'',$(SHELL_PATH))
--=20
1.8.0.197.g5a90748
