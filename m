From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 28/28] git-clone.txt: remove shallow clone limitations
Date: Thu,  5 Dec 2013 20:02:55 +0700
Message-ID: <1386248575-10206-29-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 14:01:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYYV-0003FP-5D
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 14:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267Ab3LENBS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 08:01:18 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:46487 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932215Ab3LENBR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 08:01:17 -0500
Received: by mail-pd0-f172.google.com with SMTP id g10so24681527pdj.3
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 05:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=pu3RjKUF0hn11mjsscV/jZia5JLzHrP90Y5TDWMFE6U=;
        b=jDmRhJ1kmkb9GaQNXTPVoO7/FG0C4xzgllBRsSnU9nG3WR0W9WGm2YMqJfsluMxIQ4
         fRlNMqkJ1BAUPJCyb/pX2DzN37/D0cpKX7CfQ2mBwUtaLuZg8Hxw7dI0ac/qKay/MHBB
         n8d/fglSPc1KrlKBzrlAwLAFg6sIQTjweodsecEKzwqcRF2DOl69zJetXb2f/G5HpFcF
         cWB2oxdzGwq7xO8WrDwSAaH6swjupr4TtKYHyjx6hiOAVdop+v0Xz5OIkxva93r1bHCK
         zpyq5drqhoLl0s/Us5tiP8XNk5hxMg/K2Ypicy2fKsbR2xtwyNEzCKCtVGlov/the2G4
         GyQA==
X-Received: by 10.68.251.133 with SMTP id zk5mr52302255pbc.69.1386248476920;
        Thu, 05 Dec 2013 05:01:16 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id qf7sm167055578pac.14.2013.12.05.05.01.13
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 05:01:16 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:06:00 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238884>

Now that git supports data transfer from or to a shallow clone, these
limitations are not true anymore.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/git-clone.txt | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 450f158..4987857 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -181,12 +181,7 @@ objects from the source repository into a pack in =
the cloned repository.
=20
 --depth <depth>::
 	Create a 'shallow' clone with a history truncated to the
-	specified number of revisions.  A shallow repository has a
-	number of limitations (you cannot clone or fetch from
-	it, nor push from nor into it), but is adequate if you
-	are only interested in the recent history of a large project
-	with a long history, and would want to send in fixes
-	as patches.
+	specified number of revisions.
=20
 --[no-]single-branch::
 	Clone only the history leading to the tip of a single branch,
--=20
1.8.5.1.25.g8667982
