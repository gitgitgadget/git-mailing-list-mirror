From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 14/14] mention effect of "allow-tip-sha1-in-want" capability on git-upload-pack
Date: Wed, 11 Sep 2013 01:07:58 +0800
Message-ID: <1378832878-12811-15-git-send-email-rctay89@gmail.com>
References: <1255065768-10428-2-git-send-email-spearce@spearce.org>
 <1378832878-12811-1-git-send-email-rctay89@gmail.com>
 <1378832878-12811-2-git-send-email-rctay89@gmail.com>
 <1378832878-12811-3-git-send-email-rctay89@gmail.com>
 <1378832878-12811-4-git-send-email-rctay89@gmail.com>
 <1378832878-12811-5-git-send-email-rctay89@gmail.com>
 <1378832878-12811-6-git-send-email-rctay89@gmail.com>
 <1378832878-12811-7-git-send-email-rctay89@gmail.com>
 <1378832878-12811-8-git-send-email-rctay89@gmail.com>
 <1378832878-12811-9-git-send-email-rctay89@gmail.com>
 <1378832878-12811-10-git-send-email-rctay89@gmail.com>
 <1378832878-12811-11-git-send-email-rctay89@gmail.com>
 <1378832878-12811-12-git-send-email-rctay89@gmail.com>
 <1378832878-12811-13-git-send-email-rctay89@gmail.com>
 <1378832878-12811-14-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 10 19:09:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJRQs-0003Wj-6t
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 19:08:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788Ab3IJRIv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Sep 2013 13:08:51 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:43240 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754086Ab3IJRIt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 13:08:49 -0400
Received: by mail-pa0-f53.google.com with SMTP id lb1so7999827pab.26
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 10:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Zc2dBCTlYSVMElKL6QwEI7jXah7s34HO1q0n4KT98SM=;
        b=iPtX3jNt4U+12xJ9vbl98V5ruYXRNnEYSDOpmGE60Ue4mdBtd2y1+xDg2AoY+Tp4sC
         rWaTENq7H8deqVq5Hw6w/G7wDgP4oSYnKaESXhz3owG6SQOzP7Xlv5w4uJZNYIcX7n/h
         wXLdhCOzqHY0F4PmHQefG/XcY5/g5+Hg9Pi9dhqBGneq0137IigI0x0GcZ5SPGj8SQND
         HZzde0tm7p85kB3GB1EB9gTcF0/A4RhMEvh2kKnBfgO8eWC5diAtks6obmdW38U1jnmL
         ztKKH2+l6l80d2MFkPHEXw06jmh7HRsYmMYBpG5B14N94/ebxoSsrXTFC1zF/oZ6cw9j
         nMDA==
X-Received: by 10.66.142.230 with SMTP id rz6mr16080508pab.117.1378832928016;
        Tue, 10 Sep 2013 10:08:48 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg (bb42-60-75-197.singnet.com.sg. [42.60.75.197])
        by mx.google.com with ESMTPSA id tg7sm24173138pbc.36.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 10:08:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.527.g303b16c
In-Reply-To: <1378832878-12811-14-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234457>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
--

Subject crafted by Ray Chuan, Nguy=E1=BB=85n's s-o-b lifted from
<1377092713-25434-1-git-send-email-pclouds@gmail.com>.

---
 Documentation/technical/http-protocol.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/http-protocol.txt b/Documentation/=
technical/http-protocol.txt
index 3098aa4..acc68ac 100644
--- a/Documentation/technical/http-protocol.txt
+++ b/Documentation/technical/http-protocol.txt
@@ -304,7 +304,8 @@ Servers SHOULD support all capabilities defined her=
e.
=20
 Clients MUST send at least one 'want' command in the request body.
 Clients MUST NOT reference an id in a 'want' command which did not
-appear in the response obtained through ref discovery.
+appear in the response obtained through ref discovery unless the
+server advertises capability "allow-tip-sha1-in-want".
=20
   compute_request  =3D  want_list
 		      have_list
--=20
1.8.4.rc4.527.g303b16c
