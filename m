From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] glossary-content.txt: remove an obsolete paragrah
Date: Thu, 21 Nov 2013 13:44:19 +0700
Message-ID: <1385016260-9718-1-git-send-email-pclouds@gmail.com>
References: <1384910801-11125-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 21 07:44:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjO0A-000359-EZ
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 07:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079Ab3KUGoa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Nov 2013 01:44:30 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:38234 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab3KUGoa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 01:44:30 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so3888306pab.35
        for <git@vger.kernel.org>; Wed, 20 Nov 2013 22:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=vfKLFI4Hq1zy7Y7+CaapunAGrk2L8e9InDQksU7sTnQ=;
        b=hZih7aj3xDslFg8cXE90FrkH1aW6Y7hte4xED30bBRshj+HAmO6Yuz5JegHAhzb2ls
         z9XFTxokFkK1+SUZDmjdX7rZA9a/GBZq+K1fV/lP0q6ELt/Mz8wCCFCJnMeCPW+u6Dls
         LEfD5/z8J+za2dSqP4FU6jo7SMl26G8yGUedoA5KUxOJPrGezZSYHrbFtwVwqI0xMM8B
         fMFmyuNrOnHA3P818ueOs6CJEpiHt6iVKe+lcicl/qI6TitYx11AzNhIjK0r6D1fGTFR
         SPVicPYoaCdmoqvmXp/4nATy20yDQx4gi6moLDGN9vDYI2V32sAK/vMsiI+R2O5AeFgw
         +fvQ==
X-Received: by 10.66.19.202 with SMTP id h10mr115031pae.187.1385016269425;
        Wed, 20 Nov 2013 22:44:29 -0800 (PST)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id xs1sm48800271pac.7.2013.11.20.22.44.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 20 Nov 2013 22:44:28 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 21 Nov 2013 13:44:23 +0700
X-Mailer: git-send-email 1.8.2.82.gc24b958
In-Reply-To: <1384910801-11125-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238110>

With the introduction of :(literal), :(glob) and :(icase), :(top) is
no longer the only recognized magic signature.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .. on top of nd/magic-pathspec..

 Documentation/glossary-content.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossar=
y-content.txt
index e470661..e22b524 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -379,10 +379,6 @@ full pathname may have special meaning:
 Glob magic is incompatible with literal magic.
 --
 +
-Currently only the slash `/` is recognized as the "magic signature",
-but it is envisioned that we will support more types of magic in later
-versions of Git.
-+
 A pathspec with only a colon means "there is no pathspec". This form
 should not be combined with other pathspec.
=20
--=20
1.8.2.82.gc24b958
