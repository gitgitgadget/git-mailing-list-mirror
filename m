From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 06/25] upload-pack: remove unused variable "backup"
Date: Thu,  4 Feb 2016 16:03:42 +0700
Message-ID: <1454576641-29615-7-git-send-email-pclouds@gmail.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 04 10:05:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRFqT-0005jX-IW
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 10:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965414AbcBDJEt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 04:04:49 -0500
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36245 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965407AbcBDJEr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 04:04:47 -0500
Received: by mail-pf0-f181.google.com with SMTP id n128so38147966pfn.3
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 01:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=WbhQIWqzESKupsMco0OWKhgdxYX+hDlsnBxmJ1okRrA=;
        b=N3LBu1c8zPv9r1qdB5hn+frPoz3sJZgD4FciNpQl1tpsiulK90ByuN1AtIfpSc06o4
         ctrE1xgWnFA0CvnbhgHRft2SIVZyRUCAa3R5MGSwTTnQMDoNVJ3Q2fjY7GejDsiENyyI
         X9EXGRKx5DRS7vhf3NxPSc/j5juRcP8TSv1JH9b1Igy8WOZFkxBegZnjt3hnhFI1DKS3
         v1QPM6q0QgjpNNEaIEJGBTCH34qyT6UfkJPnT4biXkDDUde4Q98Y2Lx0GRek1oNbTWrv
         vDz3gKVr+Fmu2lpFBkW6fstxfVF7eLvvQtR7vfLEqumqW49Va1Rc5ZdI7nGNSB4gDqoF
         o+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=WbhQIWqzESKupsMco0OWKhgdxYX+hDlsnBxmJ1okRrA=;
        b=RIoIBMLehkKmxeeNftqBgFcwp1jkkNdXEBU+JdaDRbGJaAC37bdaJw8Eh5ROP0Lx5J
         Da1Yv5V5KfAyyrtkdVOokjRZd17s5KBcR0V9QtLEM5AVkv7gqrXNIN4kFAch5jlFjir/
         onm2J8qtRUxmIDHmTfIt/N88nToKnzzO/rolomnIzIrjxqufINJJVw54zMcOd8qTa4aW
         OJlHFSMunngslF6il6NZZp+0RLedlQ7Vxr4m/JrSGjybV1XTDgWop+2Bm0YHbBt/b7dB
         sKposU9Br5G/bhUOWXOyQ7ikLD/4KxG0wAUmSWQ1NCwuB6W3n1v63QnzgARrV+GlDgBE
         slmw==
X-Gm-Message-State: AG10YORAoIGMQ8F722TbA9oOfWTN+pH7GiqNBkEFDRmPboRUh2BbSUADGijv2KxdgSqsIA==
X-Received: by 10.66.156.134 with SMTP id we6mr9305835pab.92.1454576686930;
        Thu, 04 Feb 2016 01:04:46 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id z3sm15374363par.17.2016.02.04.01.04.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 01:04:45 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 04 Feb 2016 16:04:59 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285420>

After the last patch, "result" and "backup" are the same. "result" used
to move, but the movement is now contained in send_shallow(). Delete
this redundant variable.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
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
2.7.0.377.g4cd97dd
