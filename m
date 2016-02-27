From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/3] sha1_file.c: mark strings for translation
Date: Sat, 27 Feb 2016 14:49:33 +0700
Message-ID: <1456559373-13589-1-git-send-email-pclouds@gmail.com>
References: <20160225142004.GA17678@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	d33tah@gmail.com,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 08:49:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZZd5-0005rT-If
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 08:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756207AbcB0HtS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 02:49:18 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:34233 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbcB0HtP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 02:49:15 -0500
Received: by mail-pf0-f169.google.com with SMTP id x65so64534749pfb.1
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 23:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p5nKjXq5pj7aaIRIFnp8e6VMf7Kor7Fc7YLVHjAHFjg=;
        b=NSLuS2D6u1NhIyTRA3ofGNz10bChxg70RVDmVQcdIDqdjNDcb1YRB/DV93BvlFL1mF
         JK3dgO4+qnP+jOJJZt/MNnrQr4gu5/t/y0wznNrJH6PyFHVJVCdMA2dzJxBEULg0//a8
         20uuzFfJz8/EdqqENUTcIgxrY7uPx346dQDhub7ZmkqbiLa554UanmxSjpv9GYwov/Hg
         lxIh22cdmCvXEa9zTMdLRK8D/Hz9gUP58BLM7dIVY9PR4Ok4LhrySMGCB2E4H+QHto4w
         Whzi9JfSbB4E8OmueVRTJehPtbRxP3nZcBLe8UQtIcgS7KZjNlkuPU5bn/pfq4MLrayS
         M+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p5nKjXq5pj7aaIRIFnp8e6VMf7Kor7Fc7YLVHjAHFjg=;
        b=jb0F1dRelpx2qvytQGcOLbdJn5oZZHOGY6qEZ6vU3/5ejwMG09axye4B87HKuwhhuA
         dR7wd4MmzEIfp1K0QU1lbHtBuuz7gsN/sHsRAlC6wOiepfQIornTQloc/+ZCXykSUHse
         f7yTxZ+9Iyra/ArWbpuyzntbQOOECUZmywae6o6wPvthTTTfSpihL5V4+sYXmWKLC0je
         JH4vKEIksblN9NeE9I9hmVWPoJGleazynGK5uGG2VgYP8lrEXJmgxiuSwqLIGQpMoPDL
         MfKZ1YF7meyHd4t1uDumO1G9nsomEpv2AnMP6drfguRgIy5LUuFK/+iaOcC/ZapriIUr
         FZ1Q==
X-Gm-Message-State: AD7BkJK/MvR3vL95o7ValclgMzYzgvrnU19z4s7+Kn7S89pYMg0GCIuuuDmt5lCM6wdQIg==
X-Received: by 10.98.16.198 with SMTP id 67mr7837220pfq.21.1456559355220;
        Fri, 26 Feb 2016 23:49:15 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id y68sm24007201pfi.6.2016.02.26.23.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2016 23:49:14 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Feb 2016 14:49:48 +0700
X-Mailer: git-send-email 2.8.0.rc0.205.g7ec8cf1
In-Reply-To: <20160225142004.GA17678@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287685>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Since jk/pack-idx-corruption-safety is already in 'next', can we add
 this patch on top? Surrounding strings are handled separately [1] by
 another series.

 [1] http://thread.gmane.org/gmane.comp.version-control.git/287661/focu=
s=3D287678

 sha1_file.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 4a3a032..b8da68b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1042,7 +1042,7 @@ unsigned char *use_pack(struct packed_git *p,
 	if (offset > (p->pack_size - 20))
 		die("offset beyond end of packfile (truncated pack?)");
 	if (offset < 0)
-		die("offset before end of packfile (broken .idx?)");
+		die(_("offset before end of packfile (broken .idx?)"));
=20
 	if (!win || !in_window(win, offset)) {
 		if (win)
@@ -2367,11 +2367,11 @@ void check_pack_index_ptr(const struct packed_g=
it *p, const void *vptr)
 	const unsigned char *start =3D p->index_data;
 	const unsigned char *end =3D start + p->index_size;
 	if (ptr < start)
-		die("offset before start of pack index for %s (corrupt index?)",
+		die(_("offset before start of pack index for %s (corrupt index?)"),
 		    p->pack_name);
 	/* No need to check for underflow; .idx files must be at least 8 byte=
s */
 	if (ptr >=3D end - 8)
-		die("offset beyond end of pack index for %s (truncated index?)",
+		die(_("offset beyond end of pack index for %s (truncated index?)"),
 		    p->pack_name);
 }
=20
--=20
2.8.0.rc0.205.g7ec8cf1
