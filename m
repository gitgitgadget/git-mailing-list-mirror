From: Petr Stodulka <pstodulk@redhat.com>
Subject: Re: COPYING tabs vs whitespaces
Date: Tue, 9 Feb 2016 20:25:23 +0100
Message-ID: <56BA3D23.8050506@redhat.com>
References: <56B32BDA.4010909@redhat.com>
 <xmqqsi18i8xv.fsf@gitster.mtv.corp.google.com> <56B85ECE.4020607@redhat.com>
 <xmqqfux39kmz.fsf@gitster.mtv.corp.google.com> <56B91299.9060001@redhat.com>
 <CAGZ79kYaGDBunX8fFiEq0dD0Rq6vjZ3ttMnLZUmy3c7DhgfkOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="14tmBLku6QR6MkEuelfqNxUAlwJAD3gOj"
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 20:26:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTDvp-0005iu-A8
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 20:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754610AbcBITZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 14:25:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48126 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932069AbcBITZo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 14:25:44 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id F26F2C0A8483;
	Tue,  9 Feb 2016 19:25:43 +0000 (UTC)
Received: from [10.34.4.171] (unused-4-171.brq.redhat.com [10.34.4.171])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u19JPfcR022862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 9 Feb 2016 14:25:42 -0500
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <CAGZ79kYaGDBunX8fFiEq0dD0Rq6vjZ3ttMnLZUmy3c7DhgfkOw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285851>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--14tmBLku6QR6MkEuelfqNxUAlwJAD3gOj
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 9.2.2016 19:40, Stefan Beller wrote:
> As a reference for this discussion,
> see c376d96 in git.git or e00bfcbf04 in linux.git
> which deals with whitespaces in the developers certificate of origin.
>=20
> Just send a patch, I'd say.
>=20
> Thanks,
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

Just patch makes from whole thread more and more absurd discussion, no of=
fense.
Don't matter if it is used or not. For me it's significant previous respo=
nse from Junio.

I am not familiar with git send-email, so:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D[PAT=
CH 1/2]=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=46rom b2509773edf7e886513f450cb8e215a87278cdfc Mon Sep 17 00:00:00 2001
From: Petr Stodulka <pstodulk@redhat.com>
Date: Tue, 9 Feb 2016 19:52:28 +0100
Subject: [PATCH 1/2] COPYING: replace tabs by spaces in license file

GPLv2 license file presented in gnu.org has replaced all tabs by spaces.
Unify whitespaces to make equivalent files (except preamble).
---
 COPYING | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/COPYING b/COPYING
index 536e555..158a9b1 100644
--- a/COPYING
+++ b/COPYING
@@ -19,15 +19,16 @@
=20
 ----------------------------------------
=20
-		    GNU GENERAL PUBLIC LICENSE
-		       Version 2, June 1991
+
+                    GNU GENERAL PUBLIC LICENSE
+                       Version 2, June 1991
=20
  Copyright (C) 1989, 1991 Free Software Foundation, Inc.,
  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.
=20
-			    Preamble
+                            Preamble
=20
   The licenses for most software are designed to take away your
 freedom to share and change it.  By contrast, the GNU General Public
@@ -77,7 +78,7 @@ patent must be licensed for everyone's free use or not =
licensed at all.
   The precise terms and conditions for copying, distribution and
 modification follow.
=20
-		    GNU GENERAL PUBLIC LICENSE
+                    GNU GENERAL PUBLIC LICENSE
    TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
=20
   0. This License applies to any program or other work which contains
@@ -276,7 +277,7 @@ make exceptions for this.  Our decision will be guide=
d by the two goals
 of preserving the free status of all derivatives of our free software an=
d
 of promoting the sharing and reuse of software generally.
=20
-			    NO WARRANTY
+                            NO WARRANTY
=20
   11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRAN=
TY
 FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN=

@@ -298,9 +299,9 @@ YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO O=
PERATE WITH ANY OTHER
 PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGES.
=20
-		     END OF TERMS AND CONDITIONS
+                     END OF TERMS AND CONDITIONS
=20
-	    How to Apply These Terms to Your New Programs
+            How to Apply These Terms to Your New Programs
=20
   If you develop a new program, and you want it to be of the greatest
 possible use to the public, the best way to achieve this is to make it
--=20
2.4.3


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D[PAT=
CH 2/2]=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=46rom 5a7bfe0b05f35238c7bc8d2680b168ef729d0e91 Mon Sep 17 00:00:00 2001
From: Petr Stodulka <pstodulk@redhat.com>
Date: Tue, 9 Feb 2016 20:08:44 +0100
Subject: [PATCH 2/2] Unify tabs and spaces in preamble of COPYING file

---
 COPYING | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/COPYING b/COPYING
index 158a9b1..bc404d9 100644
--- a/COPYING
+++ b/COPYING
@@ -9,13 +9,13 @@
  decision, you might note so in your copyright message, ie something
  like
=20
-	This file is licensed under the GPL v2, or a later version
-	at the discretion of Linus.
+    This file is licensed under the GPL v2, or a later version
+    at the discretion of Linus.
=20
   might avoid issues. But we can also just decide to synchronize and
   contact all copyright holders on record if/when the occasion arises.
=20
-			Linus Torvalds
+            Linus Torvalds
=20
 ----------------------------------------
=20
--=20
2.4.3



--14tmBLku6QR6MkEuelfqNxUAlwJAD3gOj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWuj01AAoJEPiGu5hNgNqPpDAQALn4WfM1uWla61RKVQP/DRes
Z5eFbFXmPrurEVCQpCxlz9Q4Q3430TAVjQ5V2qHwA6J9+Qeq3LfmKweSgEGGxFdC
e0/iJ5E7XdtnVm/b2wdX9SJhepEQqrLvVn7aUZgxBoNtPJ/ZCs6PD0cswaPUXGLA
ErFyCzEm1lvAgn26wPz8eBIwu4uNewgDYA8xERac7LOI2jBF0B2gqWBAnhM2q/6c
bSIBg7BSLQwKPNtsVgXes19BRoow7qwaB6G9e4l7OgjEeBdiH6ANL+TrIjnMDL63
yhZjHanvoou47AG0HC1q0SXi+2WGw44Tp3HKDYiME66s0eE8u0QK34sgKOjmngo1
mbu1brnnnTnUvObbUHpzzvNPTL8H6+QAnAo2N0CU2yihJzLV81roOdsAOtUpNm15
mVHuQS59uJYvjUCiacddzxuAzyYkkH9I86IMjCyuhws450XkAPagG4nMbXYJeF/0
3s8U96HOOWETg3Ym93YiZfA2j+L5rbf5tiOI6/6pKEADNUKBamI96wajCI/r5FAg
xQtZikVu3HZ2ertCQvyjQmQBBgYJvpGfMRgh0yVMWhhiWn3T1z0NLmhs6qUwiYKh
fsrELdPRlWy2TtsRg0DqFGeK+RRtdJrvGUkSMP3vFuNZBhOk57EVJsBgvr7r1I3D
zU3ve6TLitcq6NdKhK0o
=yOTK
-----END PGP SIGNATURE-----

--14tmBLku6QR6MkEuelfqNxUAlwJAD3gOj--
