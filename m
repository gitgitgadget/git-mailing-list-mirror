From: tboegi@web.de
Subject: [PATCH v1 1/1] t5601: Remove trailing space in sed expression
Date: Mon,  9 May 2016 19:53:12 +0200
Message-ID: <1462816392-29561-1-git-send-email-tboegi@web.de>
References: <CALR6jEhTTo-6fgy3_TnGseXJr2OZM+cK+t4BCVEzpCZNfhn5Bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: megabreit@googlemail.com,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 09 19:48:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azpI1-0008Io-Vj
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 19:48:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbcEIRsO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2016 13:48:14 -0400
Received: from mout.web.de ([212.227.17.11]:52892 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751040AbcEIRsN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 13:48:13 -0400
Received: from tor.lan ([195.252.60.88]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0Lzb94-1bdozb0nkA-014ofC; Mon, 09 May 2016 19:48:09
 +0200
X-Mailer: git-send-email 2.0.0.rc1.6318.g0c2c796
In-Reply-To: <CALR6jEhTTo-6fgy3_TnGseXJr2OZM+cK+t4BCVEzpCZNfhn5Bg@mail.gmail.com>
X-Provags-ID: V03:K0:92/UvMgnv8QY2UqOIMi9246PrA6noOkd5S0qHxfL/qBB34QP2wO
 +werU/Jz2AK0+qMpcc4K3N2Q5M0pcoqK7QWFTXXeVb7ZG1JPUEVmOGV3x92F17ctHIrVyyO
 t4q3VbkWfZfpP5UG4KPAIJeLlnD5VSybbDYUgP0F8aS8bgX6vTqWwopvUULnN5CbDLtJ3hs
 0CsGUPMBp3Z+iJZOqvXwQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NdUFAKfEuhE=:cBcphugwYpfJieToBkPs+Y
 Lug5UFpklFHaGPLZSEjo8wsmcAmQ9CpkQnkfut9QtHrjEKYSZ+A7aJraUjZqXtgGJchdJmeYg
 FVLzLs2LZOdv3HjR+1EaLMup7VnNH+ugpjX0xVhyoBAVK5kg1WCitBBzEpqSMKN7uTGIHSkWK
 AAelm8CrhGvA8e7OgLuUbs7/B2XUdjIxAlMcHBlJiopbdf0Qu0V9o7ERXgbUEnY1W86moM3gz
 4jR+W5gIF86w3XaPjWoOh248srAEt5LtodCHSMLCHU+Nx5YoMX1E3BHnT5GvZt/m6/W16Fl3y
 r2ne3YBcbNBsF/Qp5KXsQXMbG/uhEW6lK9DLZTEieRkmPX3erkjpBbWEiaiAMpu6aGuGrJTbQ
 KpNPZxLzi98YhVlSCuG8EyWJU6j8mA1CWyeNoNoXBPBhgV6VejoIubVGHYVjxJlo3DrG98Lin
 ZtxVQ7NyAjJaktMufeJ2O0Guh9zSdzEK4lEcbWSsz3aoYYLaAi+CJUHImthhpb4RT1z8q5sJU
 4Psdwtz2cgfCFIi+F/CVv9kuv/5FTxRNWJSTA9BU3ngfLqWE/bN4MgaBBHmD+x2nOq4q6v6uo
 BhiTBSL8zpxC5dIMZkbakCSI13eOd53sWzAzEZHiLdy+sfwNqD9jaAwmY2LRmpZTl2GNT9X9P
 vCt/OFC7g5LC7vtbO93WGWDEoZAJCS2dtw1XGuNfTVR24EABtU5GvNdvj1jLkBta8k2TPCRup
 M8Bo3E9riNSgtdDuQHEBGOo3Lw1MnXkccnvMTwupADAd04bHrqSnLwkT38lflcvJzLmIyJtR 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294027>

=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>

The sed expression for IPv6, "Tested User And Host" or "tuah" used a wr=
ong
sed expression, which doesn't work under all versions of sed.

Reported-By: Armin Kunaschik <megabreit@googlemail.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
---
 t/t5601-clone.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 150aeaf..a433394 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -466,7 +466,7 @@ test_expect_success 'clone ssh://host.xz:22/~repo' =
'
 #IPv6
 for tuah in ::1 [::1] [::1]: user@::1 user@[::1] user@[::1]: [user@::1=
] [user@::1]:
 do
-	ehost=3D$(echo $tuah | sed -e "s/1]:/1]/ "| tr -d "[]")
+	ehost=3D$(echo $tuah | sed -e "s/1]:/1]/" | tr -d "[]")
 	test_expect_success "clone ssh://$tuah/home/user/repo" "
 	  test_clone_url ssh://$tuah/home/user/repo $ehost /home/user/repo
 	"
--=20
2.0.0.rc1.6318.g0c2c796
