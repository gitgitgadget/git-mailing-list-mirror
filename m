From: Torsten =?utf-8?q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH] t9501: Use PERL_PATH instead of perl
Date: Thu, 25 Apr 2013 20:49:08 +0200
Message-ID: <201304252049.09038.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 25 20:49:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVRES-0000N6-TU
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 20:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759469Ab3DYStO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Apr 2013 14:49:14 -0400
Received: from mout.web.de ([212.227.15.3]:54057 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759026Ab3DYStN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Apr 2013 14:49:13 -0400
Received: from appes.localnet ([195.67.191.23]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0Lylol-1UbEVD2VV9-015RRh for <git@vger.kernel.org>; Thu,
 25 Apr 2013 20:49:12 +0200
X-Provags-ID: V02:K0:jNe4HnljZjGYS7fhNert38lbwgTeSyit0Zc4Gt7VXWY
 s+ZMXQofizzold5JNj3lGkux7oI7m5vwvXE2ncbHVVaER7A/X0
 pbQSonhewWhObEl9CH4JSgiuRt58Fsz+DDhA6BDXFyPePl7qqJ
 oUumcBMLqgowYULHIydSvQj9HeSs8NAy2D70JND1oYxc2fbjFI
 nsSZwwm9XLq3//Hrrke1w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222414>

The prerequisite checker for DATE_PARSER should use
"$PERL_PATH" instead of perl

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t9501-gitweb-standalone-http-status.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-=
standalone-http-status.sh
index d3a5bac..98c870e 100755
--- a/t/t9501-gitweb-standalone-http-status.sh
+++ b/t/t9501-gitweb-standalone-http-status.sh
@@ -16,8 +16,8 @@ code and message.'
 # Gitweb only provides the functionality tested by the 'modification t=
imes'
 # tests if it can access a date parser from one of these modules:
 #
-perl -MHTTP::Date -e 0 >/dev/null 2>&1 && test_set_prereq DATE_PARSER
-perl -MTime::ParseDate -e 0 >/dev/null 2>&1 && test_set_prereq DATE_PA=
RSER
+"$PERL_PATH" -MHTTP::Date -e 0 >/dev/null 2>&1 && test_set_prereq DATE=
_PARSER
+"$PERL_PATH" -MTime::ParseDate -e 0 >/dev/null 2>&1 && test_set_prereq=
 DATE_PARSER
=20
 # --------------------------------------------------------------------=
--
 # snapshot settings
--=20
1.8.2.1.614.g66d7af5
