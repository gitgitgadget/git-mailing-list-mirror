From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 14/16] git-clone.txt: remove shallow clone limitations
Date: Sat, 20 Jul 2013 16:58:08 +0700
Message-ID: <1374314290-5976-15-git-send-email-pclouds@gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
 <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 20 11:59:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Two-0001io-5S
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 11:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707Ab3GTJ70 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Jul 2013 05:59:26 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:49341 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684Ab3GTJ7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 05:59:25 -0400
Received: by mail-ie0-f178.google.com with SMTP id u16so11263576iet.23
        for <git@vger.kernel.org>; Sat, 20 Jul 2013 02:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=3K99sbrFi0x4Ns2z21364k96COwym+cW6V0eHmGo26Y=;
        b=J2epJb3VQ2w97orZVtZtHn3B2e8Vm13Cz3i7L8yo1SVRW6a96kmsI6F8sMz0Gi2bQ5
         3o7i9dkfSSJHy7hF8M/T8DaQ9EzUvA2wRV3lVKcghUV3y39ElhWJEA6AWmkyT76cV7GC
         UDWCYIqUcP+nNiBNneFQ71BzTMsCcIjpgqwN2iNDof0YUvikgFZs814Hmi+KMBCzpyKJ
         7f70Q+lzMMwPEMiHsQRHR53i/2bbf8i7riftyCvwbwQ1tW89maMxb26SxoUJjg1CjHOV
         eiaXlSwug/jCGzC+1gjke+9Z94kMBW03+ADta4HfkAxrTNaTrJ5/Wch+m8YZURFEJWRM
         glCQ==
X-Received: by 10.42.122.19 with SMTP id l19mr13230241icr.12.1374314365340;
        Sat, 20 Jul 2013 02:59:25 -0700 (PDT)
Received: from lanh ([115.73.248.127])
        by mx.google.com with ESMTPSA id ht10sm21112425igb.2.2013.07.20.02.59.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Jul 2013 02:59:24 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sat, 20 Jul 2013 16:59:44 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1374314290-5976-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230892>

Now that git supports push/pull from/to a shallow clone, these
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
1.8.2.83.gc99314b
