From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 05/27] upload-pack: remove unused variable "backup"
Date: Sun, 12 Jun 2016 17:53:47 +0700
Message-ID: <20160612105409.22156-6-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
 <20160612105409.22156-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 12 12:55:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bC32z-00038J-6e
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jun 2016 12:55:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746AbcFLKzN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jun 2016 06:55:13 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34371 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbcFLKzL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2016 06:55:11 -0400
Received: by mail-pf0-f193.google.com with SMTP id 66so6636706pfy.1
        for <git@vger.kernel.org>; Sun, 12 Jun 2016 03:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=agQmgMps+OjXnv8WybH0F0WHX3smPfxbrK28w/tP3yk=;
        b=NVD16CmZTFKQbMQ0WOeG8Bk2syQxRXb87+uVMaOZRjQchMjt+8Dovy1N/oHMaFLq+0
         h74DNTUas3QsKvvJ1a3YLQE6dlCrtBvJTcU68sbERl72lT5PMf/Q+87NB4cu4Qrlh/aY
         M7mxywymE4fHD7t4JUqjxY+SCToISjxOYlM8WqIG4PA0xYFkQmF8n4hdYbsu+tRVN7Zl
         uk3IEB5T7/ySBpxpjGrXYzrgmeVRM+iZdLr+wlWhgpewUkoWTlM3AHMIUxdWIfFwLIsE
         7XLKMghjO+3ZQ+1eBzCfdR+b2H/Fti7Sa+oFOpv8amDy5wcl4F/JEPiuMxLLBoLVQ8p6
         HIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=agQmgMps+OjXnv8WybH0F0WHX3smPfxbrK28w/tP3yk=;
        b=Q4+2QVIQlv0yWFZwyVBoHpT0PnDHdOARIgnDDuvVQ42N0eiD0bnstCk8TFcbYKZxEA
         8VLhK/jdNs/d0o8sROsbes64rOvLYGdDNyin4aKAPtCk2QcN1qGCd4y3PMnRi4Lzhhr9
         5G3hUO9GVqWDdSKCRntB+BKTKxYHq9gsUFLYLpA3tFYkV9Bmonm6M5KrI5iiVc4kcVco
         XrJ0bysBkXJrk8v/nZyq2KCsf3bFTIKrqiVW7Vax61mNmuyWd9Uq/YuiKXq1SeH4D7+t
         2XHH1UFZpN8mnSXfoVfL4y1wGsaH+b5kNIwhTwb4BjvnqzVcNpPUmXodcv3S8AAJzvCv
         dxWQ==
X-Gm-Message-State: ALyK8tLcBXuA7vmzW9QM8x5vRse2ZDXtJ5eEHmZsGiuB+cDZhiG7TUotXJlY9P3+IEjynw==
X-Received: by 10.98.91.7 with SMTP id p7mr14357047pfb.8.1465728910702;
        Sun, 12 Jun 2016 03:55:10 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id 22sm29735093pfw.92.2016.06.12.03.55.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2016 03:55:10 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 12 Jun 2016 17:55:06 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160612105409.22156-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297111>

After the last patch, "result" and "backup" are the same. "result" used
to move, but the movement is now contained in send_shallow(). Delete
this redundant variable.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 0eb9a0b..ee5d20b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -554,7 +554,7 @@ static void send_shallow(struct commit_list *result=
)
=20
 static void deepen(int depth, const struct object_array *shallows)
 {
-	struct commit_list *result =3D NULL, *backup =3D NULL;
+	struct commit_list *result =3D NULL;
 	int i;
 	if (depth =3D=3D INFINITE_DEPTH && !is_repository_shallow())
 		for (i =3D 0; i < shallows->nr; i++) {
@@ -562,11 +562,10 @@ static void deepen(int depth, const struct object=
_array *shallows)
 			object->flags |=3D NOT_SHALLOW;
 		}
 	else
-		backup =3D result =3D
-			get_shallow_commits(&want_obj, depth,
-					    SHALLOW, NOT_SHALLOW);
+		result =3D get_shallow_commits(&want_obj, depth,
+					     SHALLOW, NOT_SHALLOW);
 	send_shallow(result);
-	free_commit_list(backup);
+	free_commit_list(result);
 	for (i =3D 0; i < shallows->nr; i++) {
 		struct object *object =3D shallows->objects[i].item;
 		if (object->flags & NOT_SHALLOW) {
--=20
2.8.2.524.g6ff3d78
