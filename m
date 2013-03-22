From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Git.pm with recent File::Temp fail
Date: Fri, 22 Mar 2013 20:57:58 +0100
Message-ID: <20130322205758.09ca9107@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/6h9s.cWRa+7SvtfLvLc_/QH"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 22 20:58:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ86n-0007yN-W2
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 20:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755283Ab3CVT6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 15:58:10 -0400
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:4096 "EHLO
	smtp-vbr4.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755071Ab3CVT6I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 15:58:08 -0400
Received: from pc09.procura.nl (adsl.procura.nl [82.95.216.30])
	(authenticated bits=0)
	by smtp-vbr4.xs4all.nl (8.13.8/8.13.8) with ESMTP id r2MJw6tw038685
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Fri, 22 Mar 2013 20:58:07 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
X-Mailer: Claws Mail 3.9.0-160-g6eabcd (GTK+ 2.24.10; x86_64-suse-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218841>

--MP_/6h9s.cWRa+7SvtfLvLc_/QH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

git-1.8.2, perl-5.16.3, File::Temp-0.23

Without patch:

$ git svn fetch
'tempfile' can't be called as a method at /pro/lib/perl5/site_perl/5.16.3/G=
it.pm line 1117.

After patch:

$ git svn fetch
        M       t/06virtual.t
r15506 =3D 6c65be7ff36ffc6fd9b960a4b470ca297103004e (refs/remotes/git-svn)
=E2=8B=AE

patch attached

--=20
H.Merijn Brand  http://tux.nl   Perl Monger  http://amsterdam.pm.org/
using perl5.00307 .. 5.17   porting perl5 on HP-UX, AIX, and openSUSE
http://mirrors.develooper.com/hpux/        http://www.test-smoke.org/
http://qa.perl.org   http://www.goldmark.org/jeff/stupid-disclaimers/

--MP_/6h9s.cWRa+7SvtfLvLc_/QH
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-Syntax-error-in-Git.pm-for-File-Temp-0.23.patch

>From e78bf3e99deb26050f8515076db63075f6d0d171 Mon Sep 17 00:00:00 2001
From: "H.Merijn Brand - Tux" <h.m.brand@xs4all.nl>
Date: Fri, 22 Mar 2013 20:56:53 +0100
Subject: [PATCH] Syntax error in Git.pm for File::Temp-0.23
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.8.2"

This is a multi-part message in MIME format.
--------------1.8.2
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


Testing with perl-5.16.3 and most recent File::Temp-0.23 revealed:

$ git svn fetch
'tempfile' can't be called as a method at /pro/lib/perl5/site_perl/5.16.3/Git.pm line 1117.
---
 perl/Git.pm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


--------------1.8.2
Content-Type: text/x-patch; name="0001-Syntax-error-in-Git.pm-for-File-Temp-0.23.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="0001-Syntax-error-in-Git.pm-for-File-Temp-0.23.patch"

diff --git a/perl/Git.pm b/perl/Git.pm
index 96cac39..cf4f54a 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -1265,7 +1265,7 @@ sub _temp_cache {
 			$tmpdir = $self->repo_path();
 		}
 
-		($$temp_fd, $fname) = File::Temp->tempfile(
+		($$temp_fd, $fname) = File::Temp::tempfile(
 			'Git_XXXXXX', UNLINK => 1, DIR => $tmpdir,
 			) or throw Error::Simple("couldn't open new temp file");
 

--------------1.8.2--



--MP_/6h9s.cWRa+7SvtfLvLc_/QH--
