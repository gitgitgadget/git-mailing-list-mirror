From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] diff.c: remove unnecessary typecast
Date: Mon, 22 Feb 2016 19:52:24 +0700
Message-ID: <1456145545-5374-2-git-send-email-pclouds@gmail.com>
References: <1456145545-5374-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 13:52:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXpyF-00061N-Bm
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 13:52:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023AbcBVMwG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2016 07:52:06 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35305 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbcBVMwF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 07:52:05 -0500
Received: by mail-pf0-f170.google.com with SMTP id c10so95520817pfc.2
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 04:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=SO8k0aBqbrIJjs9UvLmbutHleWWYVDfFq5mYNb7aJsc=;
        b=RqgXbzOQUTkpVt9P7/EU+fe4C+P8gjvbzxmW88u4oXnlUIboCaWX1V0/x3MWinhP1v
         ERSZi0MUNHD/N9gMBkV7W4MF3jWiKWJ5ay5Tkuv+PLkSvT6h2H4a0lVufVOTp/Tf3tjJ
         BfMDl5ZCY0vP1fUji4bUTZyRaDxt3nVraizZuUrW4ztftfjZRx51b+B0ejQGfpI8mnA5
         aSqw19jMUlUYDZIlKpeXcHNdq1GiYk0KPoBMDU925F0UttVIG0e3SE0acjKKP0zrCM/f
         kWYDsu4q/wClelNkh0Q/T+yK4vzM4QZvn9a2CEa6UCmdtXt25ScQXxzG51raPJGAwzVZ
         yGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=SO8k0aBqbrIJjs9UvLmbutHleWWYVDfFq5mYNb7aJsc=;
        b=CBATY24DCnAHKuj+a2C8JJicEhPbdjaSVFWhzZQcxZMgcAKa9BGdWbVcLCFVem3bhr
         8HJR5YvDLMGxcQoPvmAVRlkZZzY3kRGkPECgzZ3fvc7+sz5/sxnPde1JJVYn2p/iPtlE
         XAOdKiZZWm+ChYGK5wzeCp8IyNyDjjZ6nkhsXTVcMCewqaOCokKba9izsDZ8giD6ZDry
         9Kw24J9eMfjKQBjxGCD5IcRIay11a5FqV7fzxNR35OvKe6rX/3zk/KPG0xcdXgPRqZjz
         zqlzHMJYR+Hq2kN++tbrhdWgwbIjWTTm0+zsWbZju9qbToTGvHaBlo7QuXIuEP7131WB
         +W8A==
X-Gm-Message-State: AG10YOSD6ZxuzNaMMmjRGj26W6NeuUi+dAEPXN9i64f7BKiLIw+3NxGrFv+SLanUP1laww==
X-Received: by 10.98.70.80 with SMTP id t77mr37261255pfa.107.1456145524727;
        Mon, 22 Feb 2016 04:52:04 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id 6sm36788686pfo.58.2016.02.22.04.52.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Feb 2016 04:52:03 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 22 Feb 2016 19:52:33 +0700
X-Mailer: git-send-email 2.7.1.532.gd9e3aaa
In-Reply-To: <1456145545-5374-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286927>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 8b3a3db..5bdc3c0 100644
--- a/diff.c
+++ b/diff.c
@@ -717,8 +717,8 @@ static void emit_rewrite_diff(const char *name_a,
 	ecbdata.opt =3D o;
 	if (ecbdata.ws_rule & WS_BLANK_AT_EOF) {
 		mmfile_t mf1, mf2;
-		mf1.ptr =3D (char *)data_one;
-		mf2.ptr =3D (char *)data_two;
+		mf1.ptr =3D data_one;
+		mf2.ptr =3D data_two;
 		mf1.size =3D size_one;
 		mf2.size =3D size_two;
 		check_blank_at_eof(&mf1, &mf2, &ecbdata);
--=20
2.7.1.532.gd9e3aaa
