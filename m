From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/6] notes-merge: remove i18n legos in merge result message
Date: Thu,  7 Jun 2012 19:05:13 +0700
Message-ID: <1339070715-31417-4-git-send-email-pclouds@gmail.com>
References: <0001-Remove-i18n-legos-in-notifying-new-branch-tracking-s.patch>
 <1339070715-31417-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 07 14:10:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScbXe-0000tf-AP
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 14:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492Ab2FGMKL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 08:10:11 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35289 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361Ab2FGMKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 08:10:09 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so787685dad.19
        for <git@vger.kernel.org>; Thu, 07 Jun 2012 05:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=zo9YBDbABhQFUIbzgJVlSP6LReVITIPFzcJRjtBOZas=;
        b=qhU4UNMGpkrxrjyk/wKuBXv5BZQR1fYkhFynZzVuM1jE9D4tlNzzInxQmekHlt8Ncr
         2s4IeAGsmNCHFvNwsYAojyk695rakLMZ6Cgsc5ZSYx5PdYfG+4N3nEdmluiYTSJ1GSG1
         pvwMYYSn5f2yiD/mP5mFD8iY9razU0FZy02Ym5rapFnJbTKeC4rNqRgNRVwsOqDdDGk7
         qOZz2KJDgY268x8j9LOPFpDPt7KT6anowRT/zH4IwS3/cdRFvB4FDgk0DX0rDYwuj6hE
         zL/75xCxgaCnZMiWHCiX71h17iuSnShP0l3PgRm9iVCfxCKN9Ch49BLViGAT0oRZIzr3
         bqRA==
Received: by 10.68.233.193 with SMTP id ty1mr8942054pbc.47.1339071009676;
        Thu, 07 Jun 2012 05:10:09 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.55.113])
        by mx.google.com with ESMTPS id ny10sm1076027pbb.38.2012.06.07.05.10.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Jun 2012 05:10:08 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 07 Jun 2012 19:05:50 +0700
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1339070715-31417-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199398>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 notes-merge.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/notes-merge.c b/notes-merge.c
index 74aa77c..29c6411 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -524,8 +524,10 @@ static int merge_from_diffs(struct notes_merge_opt=
ions *o,
 	free(changes);
=20
 	if (o->verbosity >=3D 4)
-		printf("Merge result: %i unmerged notes and a %s notes tree\n",
-			conflicts, t->dirty ? "dirty" : "clean");
+		printf(t->dirty ?
+		       "Merge result: %i unmerged notes and a dirty notes tree\n" :
+		       "Merge result: %i unmerged notes and a clean notes tree\n",
+		       conflicts);
=20
 	return conflicts ? -1 : 1;
 }
--=20
1.7.8
