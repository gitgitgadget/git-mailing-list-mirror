From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 01/28] transport.h: remove send_pack prototype, already defined in send-pack.h
Date: Mon, 25 Nov 2013 10:55:27 +0700
Message-ID: <1385351754-9954-2-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 04:52:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VknDK-0001fT-Qz
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 04:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949Ab3KYDvs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 22:51:48 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:44061 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647Ab3KYDvf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Nov 2013 22:51:35 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so4810967pbb.31
        for <git@vger.kernel.org>; Sun, 24 Nov 2013 19:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=TRYnPFnKs/gRW0DodGM/mzGewXCfyobYhpGoh58belk=;
        b=t1+OVw/+Vl978M+6GI0H7R28AW3Ovx6R10cSF83Ki0ehPsFEJv7GIio7KQ4pCIYIJR
         I5GSvG5lQqBsOLo2ATVSfD/U1uKiwX2RWpDHq0rgAhDJias7GNS1uv8tsP9YO9OS1wch
         /QCKDInPntMiwhN7XVAdgLcPXz39fLF4mMW/oJPB0fK8sx0torHvfcZ8nXssUTd/saTs
         lJ+/HWJQjPRiwnB74bilQb7Q6ECoMpDH/voaugmRVS3hH/mPuYI05sFH9X5qaz5jgeec
         bxT9pJk0SBomO5AHrT5XHeSnm4nTLE1kPxmqkwAnkhz6+thtC+DSAUYz3SqDAqnIQnpP
         hnOg==
X-Received: by 10.66.159.132 with SMTP id xc4mr25539313pab.27.1385351494709;
        Sun, 24 Nov 2013 19:51:34 -0800 (PST)
Received: from lanh ([115.73.213.240])
        by mx.google.com with ESMTPSA id jn12sm28349354pbd.37.2013.11.24.19.51.31
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 24 Nov 2013 19:51:33 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 25 Nov 2013 10:56:07 +0700
X-Mailer: git-send-email 1.8.2.83.gc99314b
In-Reply-To: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238276>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 transport.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/transport.h b/transport.h
index 8f96bed..b3679bb 100644
--- a/transport.h
+++ b/transport.h
@@ -193,10 +193,4 @@ void transport_print_push_status(const char *dest,=
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
