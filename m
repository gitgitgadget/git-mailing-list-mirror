From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] git-tag.txt: <commit> for --contains is optional
Date: Tue,  4 Feb 2014 09:56:26 +0700
Message-ID: <1391482586-26444-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 03:57:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAWCg-0000cq-CU
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 03:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbaBDC5N convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Feb 2014 21:57:13 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:41884 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbaBDC5M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 21:57:12 -0500
Received: by mail-pd0-f170.google.com with SMTP id p10so7650469pdj.15
        for <git@vger.kernel.org>; Mon, 03 Feb 2014 18:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=6cIp2nf93VoaHaxdeHXa7Dz2YkSDXCd8kDIzxlbuhLk=;
        b=pb0zyniwIbyAuAPhREaXFkc67fKVipkOwGWgnRHlRCNd1q2+FZPrGqSQ7fgAqhf0gR
         6H/c4xUf83DF9I7oE+/kMWcQJUHCs3Co9PBTMD6/TIxXHHPlcvvjyh6AvjUh8rBVOHx4
         Vli/NsaJm2OJyf5IBdUxxGn4Zdn6rTm4E+IinUGb713hrUYKwn8RHgCUQ9nOqKLBBFK+
         411SqJzuKACIERzh7OAPmvvhOe6zo8fOV8X/YgoH7vo3Pf0zycnNlIvEDzzOPb3xYedn
         6ja8djd2Pe/pB2yvnNeJbT59yNS349sh+J8Ywhe0qVUjIHOyu9TpvMK/Etbcy1g1TrdL
         607g==
X-Received: by 10.68.215.68 with SMTP id og4mr4628566pbc.112.1391482630973;
        Mon, 03 Feb 2014 18:57:10 -0800 (PST)
Received: from lanh ([115.73.225.58])
        by mx.google.com with ESMTPSA id tu3sm60905587pbc.40.2014.02.03.18.57.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 03 Feb 2014 18:57:08 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 04 Feb 2014 09:57:06 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241510>

This goes far back to e84fb2f (branch --contains: default to HEAD -
2008-07-08) where the same parsing code is shared with
builtin/tag.c. git-branch.txt correctly states that <commit> for
--contains is optional while git-tag.txt does not. Correct it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-tag.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index c418c44..404257d 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -103,8 +103,9 @@ OPTIONS
 +
 This option is only applicable when listing tags without annotation li=
nes.
=20
---contains <commit>::
-	Only list tags which contain the specified commit.
+--contains [<commit>]::
+	Only list tags which contain the specified commit (HEAD if not
+	specified).
=20
 --points-at <object>::
 	Only list tags of the given object.
--=20
1.8.5.2.240.g8478abd
