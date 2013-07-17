From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/7] transport.h: remove send_pack prototype, already defined in send-pack.h
Date: Wed, 17 Jul 2013 19:47:08 +0700
Message-ID: <1374065234-870-2-git-send-email-pclouds@gmail.com>
References: <1374065234-870-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 17 14:47:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzR8Y-0004sT-35
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 14:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708Ab3GQMrM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jul 2013 08:47:12 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:51919 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128Ab3GQMrL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 08:47:11 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf11so1911930pab.38
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 05:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Y+dDcI1x2MM2nKOpVq2EBAtMFHhnXxEQpDWeuXERaLI=;
        b=KCD+NBo/a3kU/nRee0KT+sIv4ISOiGmVQCFnIqG9LounCbY6sQ6i8mFWdt5nc9V8x0
         jz4ooWJGgnDN7jOa5HotaCpLlUhlGAu4nsLXXmmaZExED+nRamzHG0ok4VqOJWFjbrqW
         DncZO8p2zCuhlbqulV2JF72Oqx1wo2Bdr8BPMh1qAZhmXwdzxKy443leufTsocCvNrSH
         jDlZWvS0QWLpY88pUDsrTXelS9PyAsexhqbn+tABqI5DZgwiIEjRLH2Lh9UFx1MR1gIF
         lp5n5HJzOAWnzqOV/Q5WdHog92lHKUyOF2T/MzTc0y86lTNiFNBQIIPe4aBqz0OASC7l
         JL3g==
X-Received: by 10.68.228.201 with SMTP id sk9mr6755668pbc.4.1374065230933;
        Wed, 17 Jul 2013 05:47:10 -0700 (PDT)
Received: from lanh ([115.73.197.79])
        by mx.google.com with ESMTPSA id ys4sm7759039pbb.9.2013.07.17.05.47.08
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 17 Jul 2013 05:47:10 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 17 Jul 2013 19:47:26 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1374065234-870-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230613>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 transport.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/transport.h b/transport.h
index ea70ea7..3178dc9 100644
--- a/transport.h
+++ b/transport.h
@@ -182,10 +182,4 @@ void transport_print_push_status(const char *dest,=
 struct ref *refs,
=20
 typedef void alternate_ref_fn(const struct ref *, void *);
 extern void for_each_alternate_ref(alternate_ref_fn, void *);
-
-struct send_pack_args;
-extern int send_pack(struct send_pack_args *args,
-		     int fd[], struct child_process *conn,
-		     struct ref *remote_refs,
-		     struct extra_have_objects *extra_have);
 #endif
--=20
1.8.2.83.gc99314b
