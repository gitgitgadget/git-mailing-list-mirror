From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/2] git.txt: document GIT_TRACE_PACKET
Date: Sun,  9 Jun 2013 12:22:49 +0700
Message-ID: <1370755369-30868-2-git-send-email-pclouds@gmail.com>
References: <1370755369-30868-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 07:21:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlY4i-00087z-BE
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 07:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220Ab3FIFVu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 01:21:50 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:42459 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007Ab3FIFVq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 01:21:46 -0400
Received: by mail-pd0-f181.google.com with SMTP id 14so3607063pdj.40
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 22:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=uXg1RtrxtpKeTtvAPs3xKv2k2cY7bVFJyp7N3PpF6CI=;
        b=Q9N86IsARTsbOlcbxr6eMBWQT+GxY5VP58UQigXV3pKmzp2rxK8Xdkcowc02qlV1fZ
         TA/bHYkwJWUqpMVnj2gEQohUy9Zik2jkgIPWXZ810wYA1So4SoMAZAYxcwDelljz+fp7
         tZPuxYAZqEY7N4rn/H3wxIAl4vDVZHH2Ei9W9FWrW2n3G23dTX6icfcSx82wteIuUAAM
         7djgZjVIMGIGc8hA+RsLHqIlY6QzqzehHJe31kh8kPtuclHoBCl7HheRAlCOcT4FtKYD
         1HZ0moxqmEWkH+BuYbDwXrC+D3CHIrTKn2Ew+sG+Unbap/wlVDFDFWNzEkbS+KlaC49F
         i6iA==
X-Received: by 10.68.107.225 with SMTP id hf1mr4942197pbb.130.1370755306123;
        Sat, 08 Jun 2013 22:21:46 -0700 (PDT)
Received: from lanh ([115.73.237.130])
        by mx.google.com with ESMTPSA id xe9sm5334026pbc.21.2013.06.08.22.21.43
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 08 Jun 2013 22:21:45 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 09 Jun 2013 12:23:17 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1370755369-30868-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226885>

"This can help with debugging object negotiation or other protocol
issues."

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index c760918..72e9045 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -845,6 +845,11 @@ for further details.
 	recorded. This may be helpful for troubleshooting some
 	pack-related performance problems.
=20
+'GIT_TRACE_PACKET'::
+	If this variable is set, it shows a trace of all packets
+	coming in or out of a given program. This can help with
+	debugging object negotiation or other protocol issues.
+
 GIT_LITERAL_PATHSPECS::
 	Setting this variable to `1` will cause Git to treat all
 	pathspecs literally, rather than as glob patterns. For example,
--=20
1.8.2.83.gc99314b
