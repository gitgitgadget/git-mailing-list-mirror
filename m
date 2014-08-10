From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/8] mv: mark strings for translations
Date: Sun, 10 Aug 2014 09:29:29 +0700
Message-ID: <1407637776-19794-2-git-send-email-pclouds@gmail.com>
References: <1407637776-19794-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 04:29:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGItQ-0003Nh-Sy
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 04:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbaHJC3t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Aug 2014 22:29:49 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:65227 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbaHJC3s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2014 22:29:48 -0400
Received: by mail-pa0-f45.google.com with SMTP id eu11so9228484pac.18
        for <git@vger.kernel.org>; Sat, 09 Aug 2014 19:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mui7YT3B1oqWrPpE67hbbwO1c83VNplMWF/fLkT0+uw=;
        b=q5h8ceMBsG5O/Qb6sDKo26PcyNszyT3RfMsaSn+xhF84fr2/AOqZPFtoobPeQMWdcm
         k3hcdpmuWwoHURLm90WcV8+jkldhv9rUaivbRkUJdO4sduOeLMY7vgG+LDSb9/qNjdWp
         iDRS7D4JsutFxrn1A01knQK5q340LfnvYOd1cWWWnVdwtyNFEWm/rO+k3+d3Pp6/8oia
         IDNeK1nw8jKFUvlG+rR4V8O/zJjO/eKmUjVfDzcuJZkrEvVE7C3+s2aSm6+4o8MfCo1Y
         F+Q6PLf1SINW+HpswwXLwFel1w8wvwi5WlgE3xO0fSwjOpZpKc1z5NP86LxORPb7X6aT
         crCw==
X-Received: by 10.66.240.140 with SMTP id wa12mr32946216pac.99.1407637787730;
        Sat, 09 Aug 2014 19:29:47 -0700 (PDT)
Received: from lanh ([115.73.228.225])
        by mx.google.com with ESMTPSA id wt2sm7206046pbc.93.2014.08.09.19.29.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Aug 2014 19:29:47 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 10 Aug 2014 09:29:50 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1407637776-19794-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255077>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/mv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 6ffe540..b892f63 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -108,7 +108,7 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
 		destination =3D internal_copy_pathspec(dest_path[0], argv, argc, DUP=
_BASENAME);
 	} else {
 		if (argc !=3D 1)
-			die("destination '%s' is not a directory", dest_path[0]);
+			die(_("destination '%s' is not a directory"), dest_path[0]);
 		destination =3D dest_path;
 	}
=20
--=20
2.1.0.rc0.78.gc0d8480
