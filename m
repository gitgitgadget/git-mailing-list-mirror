From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 1/6] worktree.c: fix indentation
Date: Mon, 18 Jan 2016 18:21:29 +0700
Message-ID: <1453116094-4987-2-git-send-email-pclouds@gmail.com>
References: <1453116094-4987-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 18 12:03:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aL7bA-0003uN-Do
	for gcvg-git-2@plane.gmane.org; Mon, 18 Jan 2016 12:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483AbcARLDn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 Jan 2016 06:03:43 -0500
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36077 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754482AbcARLDm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 06:03:42 -0500
Received: by mail-pa0-f68.google.com with SMTP id a20so27400853pag.3
        for <git@vger.kernel.org>; Mon, 18 Jan 2016 03:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=/h8payXC2JtSesJ86I1oNY47lDaytaOr6dypVt31MSY=;
        b=wQ92h0/rsIxQwDcDl8jBN/PlCfTnXWOztdLGXrNRuASX3WR1jQ32Pn33jKlJnEY5qz
         XaaUoSVlJRSJ+plrjKQVB2AXHUsLDed2LrS5HXvN22xHqcAevaa1qXK+4HZVknoZTbMv
         aPokNpI4IMP+CElhCx84lpegEe87APA+oPoBPSot+IJqIMvQD5KdYElz12eE2tF6VFVU
         uQzAMRwrdwBI1sSVGw90zQ2F3+3yZbwK7TAgdi2nuVUaSqQ2LmngH5l2q7faEym1LFS9
         o7nNvSqgqHPZQ4o9IeWNgNnwG93v5CZ9dnBOQH1tSqwiZ8wS1nLLSasNmfSDUxQNmwFU
         kpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=/h8payXC2JtSesJ86I1oNY47lDaytaOr6dypVt31MSY=;
        b=dIHTI15efGKvYFtxkw4f3K+TTI/+/XQczzfzcnrdQmF2PacMZLmH05r7SJNrc0+xgR
         VwGBi7B1Z5FjgHsBFdM0gQVixgYnONtcfPTeq3QPiL2xdFW/mwPbdvrmz44V+TY7tCr/
         EHwMk/S73XW4NGr1UqzEFxYnO370dBjTqyuktOa4/yUGL8lT6bAKR5XHMYIljjYhjef2
         kZH2VqAPqFR0G+7l8gE4urHn17nv2j3B8C/k/c3KhlsPf0T0gcHGk+A6S1jBywSwbbMt
         ZnGRKypmqBNjaheSgXm6wrGZ59tJcxcDz/FBw13GjT9YokxziWcs5wUP9QdFsJD3Do/9
         xzng==
X-Gm-Message-State: ALoCoQn+QmCTtBwJOTdYqO4JKFcJ7JG+hhIWPO86/69WQzmKONSRbSG3QYPf9/ln49mqEdf0OcAXdBPd8vL1zQC5Bog+fxxIPA==
X-Received: by 10.66.222.129 with SMTP id qm1mr35072533pac.10.1453115022217;
        Mon, 18 Jan 2016 03:03:42 -0800 (PST)
Received: from lanh ([115.72.43.83])
        by smtp.gmail.com with ESMTPSA id wa17sm33246809pac.38.2016.01.18.03.03.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2016 03:03:41 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 18 Jan 2016 18:21:43 +0700
X-Mailer: git-send-email 2.7.0.96.g5373197
In-Reply-To: <1453116094-4987-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284285>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 worktree.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/worktree.c b/worktree.c
index 981f810..6181a66 100644
--- a/worktree.c
+++ b/worktree.c
@@ -176,10 +176,10 @@ struct worktree **get_worktrees(void)
 			if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
 				continue;
=20
-				if ((linked =3D get_linked_worktree(d->d_name))) {
-					ALLOC_GROW(list, counter + 1, alloc);
-					list[counter++] =3D linked;
-				}
+			if ((linked =3D get_linked_worktree(d->d_name))) {
+				ALLOC_GROW(list, counter + 1, alloc);
+				list[counter++] =3D linked;
+			}
 		}
 		closedir(dir);
 	}
--=20
2.7.0.96.g5373197
