From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: [PATCH] Update of unicode_width.h to Unicode Version 7.0
Date: Tue, 17 Jun 2014 21:56:08 +0200
Message-ID: <53A09D58.4090806@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 21:56:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WwzUU-0004xZ-Jv
	for gcvg-git-2@plane.gmane.org; Tue, 17 Jun 2014 21:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbaFQT4N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Jun 2014 15:56:13 -0400
Received: from mout.web.de ([212.227.17.12]:59402 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932992AbaFQT4L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2014 15:56:11 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MYvxn-1XB6Mc3FQ3-00VdqA; Tue, 17 Jun 2014 21:56:09
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Provags-ID: V03:K0:6xEZL0NOM5p1Pc74RhfQ2VD/KztwdwLJ3x9ucrERzI8Y7vxVOpK
 UASxaULCvEPbb+7am2f31VQSTGbMzGM/B2f/+vsA//sSM59eiq9HiyFZfriSy/iyHzZsaUd
 ZQOPHVza5q4ZGT9XMJ0UfO30TZivNAOmYiFfaarACF+i9Irz1CgOALAYMADYHxVS2GdFtJf
 Lu5BC30dRBQk+c/+paNPw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251945>

Unicode Version 7.0 was released yesterday.
Run ./update_unicode.sh to update the zero_width table.
Note: the double_width is unchanged.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 unicode_width.h | 49 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/unicode_width.h b/unicode_width.h
index 4db7803..47cdd23 100644
--- a/unicode_width.h
+++ b/unicode_width.h
@@ -6,7 +6,7 @@ static const struct interval zero_width[] =3D {
 { 0x05C1, 0x05C2 },
 { 0x05C4, 0x05C5 },
 { 0x05C7, 0x05C7 },
-{ 0x0600, 0x0604 },
+{ 0x0600, 0x0605 },
 { 0x0610, 0x061A },
 { 0x061C, 0x061C },
 { 0x064B, 0x065F },
@@ -25,8 +25,7 @@ static const struct interval zero_width[] =3D {
 { 0x0825, 0x0827 },
 { 0x0829, 0x082D },
 { 0x0859, 0x085B },
-{ 0x08E4, 0x08FE },
-{ 0x0900, 0x0902 },
+{ 0x08E4, 0x0902 },
 { 0x093A, 0x093A },
 { 0x093C, 0x093C },
 { 0x0941, 0x0948 },
@@ -62,16 +61,19 @@ static const struct interval zero_width[] =3D {
 { 0x0B82, 0x0B82 },
 { 0x0BC0, 0x0BC0 },
 { 0x0BCD, 0x0BCD },
+{ 0x0C00, 0x0C00 },
 { 0x0C3E, 0x0C40 },
 { 0x0C46, 0x0C48 },
 { 0x0C4A, 0x0C4D },
 { 0x0C55, 0x0C56 },
 { 0x0C62, 0x0C63 },
+{ 0x0C81, 0x0C81 },
 { 0x0CBC, 0x0CBC },
 { 0x0CBF, 0x0CBF },
 { 0x0CC6, 0x0CC6 },
 { 0x0CCC, 0x0CCD },
 { 0x0CE2, 0x0CE3 },
+{ 0x0D01, 0x0D01 },
 { 0x0D41, 0x0D44 },
 { 0x0D4D, 0x0D4D },
 { 0x0D62, 0x0D63 },
@@ -132,6 +134,7 @@ static const struct interval zero_width[] =3D {
 { 0x1A65, 0x1A6C },
 { 0x1A73, 0x1A7C },
 { 0x1A7F, 0x1A7F },
+{ 0x1AB0, 0x1ABE },
 { 0x1B00, 0x1B03 },
 { 0x1B34, 0x1B34 },
 { 0x1B36, 0x1B3A },
@@ -141,7 +144,7 @@ static const struct interval zero_width[] =3D {
 { 0x1B80, 0x1B81 },
 { 0x1BA2, 0x1BA5 },
 { 0x1BA8, 0x1BA9 },
-{ 0x1BAB, 0x1BAB },
+{ 0x1BAB, 0x1BAD },
 { 0x1BE6, 0x1BE6 },
 { 0x1BE8, 0x1BE9 },
 { 0x1BED, 0x1BED },
@@ -153,7 +156,8 @@ static const struct interval zero_width[] =3D {
 { 0x1CE2, 0x1CE8 },
 { 0x1CED, 0x1CED },
 { 0x1CF4, 0x1CF4 },
-{ 0x1DC0, 0x1DE6 },
+{ 0x1CF8, 0x1CF9 },
+{ 0x1DC0, 0x1DF5 },
 { 0x1DFC, 0x1DFF },
 { 0x200B, 0x200F },
 { 0x202A, 0x202E },
@@ -181,11 +185,13 @@ static const struct interval zero_width[] =3D {
 { 0xA9B3, 0xA9B3 },
 { 0xA9B6, 0xA9B9 },
 { 0xA9BC, 0xA9BC },
+{ 0xA9E5, 0xA9E5 },
 { 0xAA29, 0xAA2E },
 { 0xAA31, 0xAA32 },
 { 0xAA35, 0xAA36 },
 { 0xAA43, 0xAA43 },
 { 0xAA4C, 0xAA4C },
+{ 0xAA7C, 0xAA7C },
 { 0xAAB0, 0xAAB0 },
 { 0xAAB2, 0xAAB4 },
 { 0xAAB7, 0xAAB8 },
@@ -198,36 +204,65 @@ static const struct interval zero_width[] =3D {
 { 0xABED, 0xABED },
 { 0xFB1E, 0xFB1E },
 { 0xFE00, 0xFE0F },
-{ 0xFE20, 0xFE26 },
+{ 0xFE20, 0xFE2D },
 { 0xFEFF, 0xFEFF },
 { 0xFFF9, 0xFFFB },
 { 0x101FD, 0x101FD },
+{ 0x102E0, 0x102E0 },
+{ 0x10376, 0x1037A },
 { 0x10A01, 0x10A03 },
 { 0x10A05, 0x10A06 },
 { 0x10A0C, 0x10A0F },
 { 0x10A38, 0x10A3A },
 { 0x10A3F, 0x10A3F },
+{ 0x10AE5, 0x10AE6 },
 { 0x11001, 0x11001 },
 { 0x11038, 0x11046 },
-{ 0x11080, 0x11081 },
+{ 0x1107F, 0x11081 },
 { 0x110B3, 0x110B6 },
 { 0x110B9, 0x110BA },
 { 0x110BD, 0x110BD },
 { 0x11100, 0x11102 },
 { 0x11127, 0x1112B },
 { 0x1112D, 0x11134 },
+{ 0x11173, 0x11173 },
 { 0x11180, 0x11181 },
 { 0x111B6, 0x111BE },
+{ 0x1122F, 0x11231 },
+{ 0x11234, 0x11234 },
+{ 0x11236, 0x11237 },
+{ 0x112DF, 0x112DF },
+{ 0x112E3, 0x112EA },
+{ 0x11301, 0x11301 },
+{ 0x1133C, 0x1133C },
+{ 0x11340, 0x11340 },
+{ 0x11366, 0x1136C },
+{ 0x11370, 0x11374 },
+{ 0x114B3, 0x114B8 },
+{ 0x114BA, 0x114BA },
+{ 0x114BF, 0x114C0 },
+{ 0x114C2, 0x114C3 },
+{ 0x115B2, 0x115B5 },
+{ 0x115BC, 0x115BD },
+{ 0x115BF, 0x115C0 },
+{ 0x11633, 0x1163A },
+{ 0x1163D, 0x1163D },
+{ 0x1163F, 0x11640 },
 { 0x116AB, 0x116AB },
 { 0x116AD, 0x116AD },
 { 0x116B0, 0x116B5 },
 { 0x116B7, 0x116B7 },
+{ 0x16AF0, 0x16AF4 },
+{ 0x16B30, 0x16B36 },
 { 0x16F8F, 0x16F92 },
+{ 0x1BC9D, 0x1BC9E },
+{ 0x1BCA0, 0x1BCA3 },
 { 0x1D167, 0x1D169 },
 { 0x1D173, 0x1D182 },
 { 0x1D185, 0x1D18B },
 { 0x1D1AA, 0x1D1AD },
 { 0x1D242, 0x1D244 },
+{ 0x1E8D0, 0x1E8D6 },
 { 0xE0001, 0xE0001 },
 { 0xE0020, 0xE007F },
 { 0xE0100, 0xE01EF }
--=20
2.0.0.622.g9478935
