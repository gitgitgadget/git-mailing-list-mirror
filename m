From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 01/28] transport.h: remove send_pack prototype, already defined in send-pack.h
Date: Thu,  5 Dec 2013 20:02:28 +0700
Message-ID: <1386248575-10206-2-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 13:58:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYVi-0001EA-NJ
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 13:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102Ab3LEM6Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 07:58:24 -0500
Received: from mail-pb0-f47.google.com ([209.85.160.47]:63786 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932090Ab3LEM6W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 07:58:22 -0500
Received: by mail-pb0-f47.google.com with SMTP id um1so25828858pbc.34
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 04:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=XgYFOH2zjhkHUj7qPKHcnJxlqGDuRPUCbZrKfUuSEOU=;
        b=G6d91vugYU+99y4xxLaJ24UdZpXKhcDuCilZOtfmlbZllaghCgXubAQl7M4P+oxY3T
         Umhlp87v/CHe021yTp9gUOKaIma6WZf7Q+JXP5XTI/2mJDrvMnWChxyp07uGDnYyznhB
         19nBDeE6pcRiXn8DC3YrOEAQi69+ZpLv5hjp4srQxpgAEYoK/6DGdh2eGyptK3dguLu+
         n6CdWrXHAR2x/ZqYVi5wLfNdCrIWPYZTkdFSOkQ1GoWMXZbmZE8alyVv+eiyWYJApAG/
         xr7uZR9ZDLsTRfSUmY8X087loKjo7tO7WtAf2ZscmCbeMRYDudtbcNYAVs/3S962vn3h
         t9GQ==
X-Received: by 10.66.161.1 with SMTP id xo1mr24400104pab.146.1386248302480;
        Thu, 05 Dec 2013 04:58:22 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id vf7sm29293348pbc.5.2013.12.05.04.58.19
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 04:58:21 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:03:06 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238858>

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
1.8.5.1.25.g8667982
