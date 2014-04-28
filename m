From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 02/32] ewah: delete unused ewah_read_mmap_native declaration
Date: Mon, 28 Apr 2014 17:55:23 +0700
Message-ID: <1398682553-11634-3-git-send-email-pclouds@gmail.com>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:58:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejGH-00053D-Bb
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244AbaD1Kys convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:54:48 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:52298 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755127AbaD1Kyn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:54:43 -0400
Received: by mail-pd0-f175.google.com with SMTP id fp1so3403663pdb.6
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TSsdme6+pUUnSLZvYTr4dnsmHOeH48Fr/wavkqKmJiU=;
        b=x5n/4lzShb1n+24yc1p7EdQJNMFB8eTdDLQ2hP+NpqLtA9vtyNkLUJfw46E5f0M2E/
         oaTxv8xu4AFQnDZ8ojsxN0bmZd+aLr4GtYKXJXvfS3lxunG1HdgHarMruTRn5yMgtlMK
         7NdJPrwJuPg6J94odOF2Ao2e78hh09gkw3Vr+fllGrixER8mBwwR1zZYCCLisgSMU2Pw
         7jL0CPZK7TiX+ndPIdnTaNLOhuky5tDM7geLlqzivBeVt39KC+0JaJuBCrnPVwkvA1/U
         /Vn+MDJI7Ms3cnf3FbI1MJKhXbbTE4qcgeYds66x2hGLOGeeFfV8DZuTK9jS/bLrdTnC
         XcIA==
X-Received: by 10.68.134.169 with SMTP id pl9mr7750428pbb.133.1398682483504;
        Mon, 28 Apr 2014 03:54:43 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id vf7sm34237963pbc.5.2014.04.28.03.54.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:54:42 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:56:11 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247300>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 ewah/ewok.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ewah/ewok.h b/ewah/ewok.h
index 0556ca5..f6ad190 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -100,7 +100,6 @@ int ewah_serialize_native(struct ewah_bitmap *self,=
 int fd);
=20
 int ewah_deserialize(struct ewah_bitmap *self, int fd);
 int ewah_read_mmap(struct ewah_bitmap *self, const void *map, size_t l=
en);
-int ewah_read_mmap_native(struct ewah_bitmap *self, void *map, size_t =
len);
=20
 uint32_t ewah_checksum(struct ewah_bitmap *self);
=20
--=20
1.9.1.346.ga2b5940
