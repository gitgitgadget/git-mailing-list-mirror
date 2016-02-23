From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 05/25] upload-pack: remove unused variable "backup"
Date: Tue, 23 Feb 2016 20:44:43 +0700
Message-ID: <1456235103-26317-6-git-send-email-pclouds@gmail.com>
References: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 23 14:45:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYDHL-0008LL-8s
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 14:45:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbcBWNpV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2016 08:45:21 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:34881 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbcBWNpS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 08:45:18 -0500
Received: by mail-pf0-f182.google.com with SMTP id c10so116378350pfc.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 05:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=xz5eMPxg/FAuh1W+/NupCxQZ3HF++ox9l0LhDDLNa6s=;
        b=B3rui8OkUDpxlNZXCaltuO8i2sKakloM/L+aSH5H355PHj6Y0JZdbAPkBhydT+2Joa
         0Ws1eOP/V+5+ANiRzEpn3QaG4ziDk2Ps5W+wwFuUsOhTv5zWhuXYwzA92LevAoVx6+N4
         yJjhRDYOBbE6NYcgqpBSMdMrFxq/bnPMsB+lNR2GqiS8QlDCqyPHRHeBcrsHwscCn3JU
         8E5FEpq7/95Vn7HRhAaEC1ekF7RJ28n9K9+ZfDv9ZkDhy8f6dCj1QPKNOy6+tbm01eCK
         YQj+oxUBQ29LfDqyYc/N2d269LC42lc4KS/JkyvZ5zUgBBdLt66j4PF3jlAGRkbtIcoX
         9DcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=xz5eMPxg/FAuh1W+/NupCxQZ3HF++ox9l0LhDDLNa6s=;
        b=SC43z6UkZJhoSufc6BARX/bigH1JJNK+ON5wHFvrjMzKTA/K5hKRaN37TGrkMY2Pih
         ZxQgdNh9BkMz5CPbkgo8YWrubi4HJaftuEtlvokeNbtZQ28SZ/ciSI4TXOzfP0j46FZg
         beOlwHe06M/hmrArmQNH4RTdaLC9A/tnkhqvpVU1x0STm0XDTYZiZKPDoUsDctvNbkC/
         8A2aFRo4v0C5vljImIch9ZPK1BApFdH81Wl0shbgUehEgqI4i381Wj4kC4ppA3GoZrON
         qmbesxwhB5youHi/17k98JAJLhrS5HAdtbI1M/BFvr56QDirynMaIMmqixflHXWJX33S
         5O7w==
X-Gm-Message-State: AG10YOTSyY3TKSvvcX0AMp/bron00gWQtwePxA29m1Rn91YjftHPHTSZk3f0wIpIEE+jsw==
X-Received: by 10.98.40.5 with SMTP id o5mr46876479pfo.76.1456235117654;
        Tue, 23 Feb 2016 05:45:17 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id l21sm44441627pfi.63.2016.02.23.05.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Feb 2016 05:45:16 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Tue, 23 Feb 2016 20:45:46 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
In-Reply-To: <1456235103-26317-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287057>

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
2.7.1.532.gd9e3aaa
