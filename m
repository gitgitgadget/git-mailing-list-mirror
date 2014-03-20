From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/8] ls_colors.c: a bit of document on print_color_indicator input
Date: Thu, 20 Mar 2014 17:15:45 +0700
Message-ID: <1395310551-23201-3-git-send-email-pclouds@gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 11:16:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQa11-0000sY-AB
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 11:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbaCTKPy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Mar 2014 06:15:54 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:50226 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbaCTKPy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 06:15:54 -0400
Received: by mail-pd0-f172.google.com with SMTP id p10so711579pdj.31
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 03:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=NUntTCbSAuzs63g03dVAVeEQENUTyfjko1Xzlj4DaL0=;
        b=lEHGoHmaThCP+e5+YI1bOcSygd+8rercWkiDl3YXMLKbIJvfsJcDMzVQaMOH21c7Gb
         tmJF194wJhe+WEk6Ops3R/mkQTjbRgAiAazN1pOCIOHyq85I3KfqJBDqxLzZQPd9AGEh
         s9vQW9LkNnHeZjuGZ229guUIE3uiOna3IPIYSYIiVld0RYglXLaB7+RCI4k3AyQw6F84
         u5buX/P9PMOtNSRlDNtg1vFsC3EognIUX42HfaQOwbc/jI4GQSWEYrmsAhn7jhtaD0wr
         o//5zzHOEUv4P1IzZsuuDUKTUa9eOvvwNvPLiXvC1lY4gy4gX/AE4570nUtl7EVsZjiY
         tAyA==
X-Received: by 10.66.13.138 with SMTP id h10mr23612393pac.148.1395310551049;
        Thu, 20 Mar 2014 03:15:51 -0700 (PDT)
Received: from lanh ([115.73.251.167])
        by mx.google.com with ESMTPSA id vh2sm2943515pbc.72.2014.03.20.03.15.48
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Mar 2014 03:15:50 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 20 Mar 2014 17:16:38 +0700
X-Mailer: git-send-email 1.9.0.40.gaa8c3ea
In-Reply-To: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244532>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 ls_colors.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/ls_colors.c b/ls_colors.c
index 6385446..d492ab3 100644
--- a/ls_colors.c
+++ b/ls_colors.c
@@ -401,6 +401,11 @@ static void put_indicator(const struct bin_str *in=
d)
 		putchar(*(p++));
 }
=20
+/*
+ * mode is only used if stat_ok is true, else filetype is used. if
+ * linkok is -1, shows broken link. If linkok is zero and mode says
+ * it's a link, then show orphan link.
+ */
 void print_color_indicator(const char *name, mode_t mode, int linkok,
 			   int stat_ok, enum filetype filetype)
 {
--=20
1.9.0.40.gaa8c3ea
