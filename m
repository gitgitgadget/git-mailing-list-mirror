From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/8] mv: mark strings for translations
Date: Fri,  8 Aug 2014 20:10:55 +0700
Message-ID: <1407503462-32632-2-git-send-email-pclouds@gmail.com>
References: <1407503462-32632-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 15:11:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFjx2-0000UQ-JJ
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 15:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756660AbaHHNLO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2014 09:11:14 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:52428 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756649AbaHHNLN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 09:11:13 -0400
Received: by mail-pd0-f176.google.com with SMTP id y10so7029905pdj.35
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 06:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=mui7YT3B1oqWrPpE67hbbwO1c83VNplMWF/fLkT0+uw=;
        b=tZ1AKvH40iwhDoMJJAeCyTje8F0QWNws0WKl2rvTk91hMcF/QtcPbe++qmAHTLTqs4
         Q0YS1Lbtq71cV3eybG1IPH3VzCISkyrIbBkem9v7UnXyycKOYsOU3OY+WANhAznJSSAZ
         co99+tLfhL8O+POjZ4V+q5sLxu3HC1xhPxRYAGRrl0Nx3aey7SBHBkrwM2BOR20RhrwR
         erNG0aRi01UMB8X321SSi2dy64KAY3GKlHhBDRuUJp7U46u/qziSlMuwpT/78YY8uOvs
         6K50R1QIVHlEhqivMiM7TuJuQuIkZOvyGeVQHWi5tM/Eles2+/aW1Irdfe+/69roSsNg
         hGpQ==
X-Received: by 10.68.138.13 with SMTP id qm13mr24349982pbb.46.1407503473461;
        Fri, 08 Aug 2014 06:11:13 -0700 (PDT)
Received: from lanh ([115.73.206.39])
        by mx.google.com with ESMTPSA id br1sm3009811pbc.6.2014.08.08.06.11.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Aug 2014 06:11:12 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 08 Aug 2014 20:11:15 +0700
X-Mailer: git-send-email 2.1.0.rc0.78.gc0d8480
In-Reply-To: <1407503462-32632-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255007>

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
