From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 11/28] fetch-pack.h: one statement per bitfield declaration
Date: Thu,  5 Dec 2013 20:02:38 +0700
Message-ID: <1386248575-10206-12-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 13:59:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYWe-0001tu-PE
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 13:59:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156Ab3LEM7Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 07:59:25 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:35982 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756536Ab3LEM7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 07:59:24 -0500
Received: by mail-pb0-f46.google.com with SMTP id md12so25979285pbc.33
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 04:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=ezgU0xgT5FN3ewJYSWDgDXeSO78L6icUYRu8yIvb51s=;
        b=Q5cVarbs5lQLVcuQdh+SyQSV4CGiTSfb3D564PmUH5ytx3FXpfWlA2YntT3uz42tCB
         LkTRnU+ZgHrsgssK6Jg6YmaqSpJVKt96jICclhrZEnqG4KtC3YpFgc9MWmONwhUqUXs6
         N6iCrZ20mfSo6/OjQz/8WAoPXYHLYkWDn6w4sMoaYFbQR5rjWhIBzvER92rceEFCorDZ
         VrdZseZOHRAD9Dy2Xc98wa+op3JeTwalgWw+h7O27Xoiya8CEae8k3RRmqhTfvm9IIye
         Rs1SFEfjsg8Vw4Nsb3Zx41Bx3I+J5I81wF9fdB/n2vYxDHLvhq/ZowJHa3qDb5sJUrtK
         ZWAw==
X-Received: by 10.66.147.9 with SMTP id tg9mr88720997pab.5.1386248363936;
        Thu, 05 Dec 2013 04:59:23 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id hn5sm133533953pbb.25.2013.12.05.04.59.21
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 04:59:23 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:04:07 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238867>

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
1.8.5.1.25.g8667982
