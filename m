From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 05/27] upload-pack: remove unused variable "backup"
Date: Fri, 10 Jun 2016 19:26:52 +0700
Message-ID: <20160610122714.3341-6-pclouds@gmail.com>
References: <20160610122714.3341-1-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 10 14:28:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bBLXy-0000bH-Nw
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 14:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbcFJM2S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Jun 2016 08:28:18 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36269 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932150AbcFJM2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jun 2016 08:28:16 -0400
Received: by mail-pa0-f67.google.com with SMTP id fg1so5021068pad.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2016 05:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=agQmgMps+OjXnv8WybH0F0WHX3smPfxbrK28w/tP3yk=;
        b=gqwlCrK0VUPAq8YtM+nTt0XQuD0tJ84GjYvMiqfFm6TvLMLsqH2tUp7EWm9U0x5BZO
         v/B7oA1KKA7ZebtznTefQQKtgIAKo3DovQ7IkhKo8t9Qn1rxdJabePnKjycMefBsyMbx
         iapvjZ6Hz4x+wLv35KqXG5KPwXBOOJ7WBQw2UGrakyy3KPV6g7AwxjhnhzFZXvy+EUOE
         IUUF/btTDrbg0DUFp+2TLyO/NF6mPlTJjRVCkZbjBGYHZ3ndyD9Nt9zMsMoEIhpILavc
         lpgf+QE3Qk8JFnzH11mNVCmsFqvAednCGlawf88+61GDcDoo2GlgDm4caQqvEYB47o2X
         u5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=agQmgMps+OjXnv8WybH0F0WHX3smPfxbrK28w/tP3yk=;
        b=mATtOfSEvWlI7x27dswPVMbjbiCFZmbYDtSO1E9TmEmQ+eLYwbdWAFYFs8s9pqSil2
         8VcN5tsp6jeu10MQRmwsYOsFee54rqf+NdoWWeHEYytiw9liprGY6dp5YOB5RiCrILvP
         g5MedRoK5j/2rtfi6JBY9FWUl/tDTUJeROTgwpVghKd/kSVKqTIs6aLe++1yIFPl8BUq
         08DbdZBFXvaid51x0Apd6RR3wOlIqICKWR5Q6YId6hPCWYHYDTIZxHnS+iyWlm8m9bt5
         KTNmaGl6tA2ycARxTmGble0guKPHlJyFkRf1WPH0ZEBi6+DIp17VgW4A5N98/XHZJGq5
         naMA==
X-Gm-Message-State: ALyK8tJKjnszLQmefMVa+NLZSjjqDHP0lzyXjBCsW6JMTzJn/dSFvrIxOkBew0Lm9BROJg==
X-Received: by 10.66.126.47 with SMTP id mv15mr2153972pab.74.1465561695579;
        Fri, 10 Jun 2016 05:28:15 -0700 (PDT)
Received: from ash ([115.76.211.1])
        by smtp.gmail.com with ESMTPSA id m65sm17446557pfm.91.2016.06.10.05.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 05:28:14 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 10 Jun 2016 19:28:10 +0700
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160610122714.3341-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296976>

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
