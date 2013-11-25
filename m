From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 11/28] fetch-pack.h: one statement per bitfield declaration
Date: Mon, 25 Nov 2013 10:55:37 +0700
Message-ID: <1385351754-9954-12-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:52:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknDw-0001qt-0P
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527Ab3KYDwc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:52:32 -0500
Received: from mail-pd0-f173.google.com ([209.85.192.173]:54731 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab3KYDwb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:52:31 -0500
Received: by mail-pd0-f173.google.com with SMTP id p10so4617728pdj.4
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=U6bof1IAfWgDjljhsMmC3yWz9/MBEklXOZGTNZBrrJQ=;
        b=PlgXPjxcWztpRdGOPsy22UKe/uu89D3ezGubdPHPLWOwL3tm/3ZwZ9BSCHWYsHaVKC
         cnTQ/OaMTOUcvmvQq7lhtjfEG+EIxBnU3J7T73K60xic+/2SsqhSYYHyTyiB0F3qNAYV
         DREcw8q4K6Mf82Axi2g9n0KUK73yZczd6ZIxpdUzVRz6T5ct1TN2xwBVHALxzFrnK68F
         LJOJ9ad9EdfXDFiBET21aqV2kLvE3DLtzaBsSdqJLDxv7zcrTKMJU4teFJu5YP47Dys8
         3HBdlh4BUIKp56a4J97wZFeyr3umjmtq/qi9f6y2J0ohSgUdKDRqxomRi4ZDQ5CFu8fs
         IL5Q==
X-Received: by 10.68.240.2 with SMTP id vw2mr15979935pbc.80.1385351551185;
        Sun, 24 Nov 2013 19:52:31 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id qv8sm69704645pbc.31.2013.11.24.19.52.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:52:30 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:57:04 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238283>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 fetch-pack.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fetch-pack.h b/fetch-pack.h
index 461cbf3..9b08388 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -8,18 +8,18 @@ struct fetch_pack_args {
 	const char *uploadpack;
 	int unpacklimit;
 	int depth;
-	unsigned quiet:1,
-		keep_pack:1,
-		lock_pack:1,
-		use_thin_pack:1,
-		fetch_all:1,
-		stdin_refs:1,
-		verbose:1,
-		no_progress:1,
-		include_tag:1,
-		stateless_rpc:1,
-		check_self_contained_and_connected:1,
-		self_contained_and_connected:1;
+	unsigned quiet:1;
+	unsigned keep_pack:1;
+	unsigned lock_pack:1;
+	unsigned use_thin_pack:1;
+	unsigned fetch_all:1;
+	unsigned stdin_refs:1;
+	unsigned verbose:1;
+	unsigned no_progress:1;
+	unsigned include_tag:1;
+	unsigned stateless_rpc:1;
+	unsigned check_self_contained_and_connected:1;
+	unsigned self_contained_and_connected:1;
 };
=20
 /*
--=20
1.8.2.83.gc99314b
