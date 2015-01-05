From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] clean: style fix for 9f93e46 (git-clean: use a git-add-interactive ...)
Date: Mon,  5 Jan 2015 20:29:23 +0700
Message-ID: <1420464563-5579-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 05 14:29:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y87j1-00044B-I9
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 14:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbbAEN3b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Jan 2015 08:29:31 -0500
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36503 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbbAEN33 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2015 08:29:29 -0500
Received: by mail-pd0-f178.google.com with SMTP id r10so28025652pdi.23
        for <git@vger.kernel.org>; Mon, 05 Jan 2015 05:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=FOQhqpkzXBA+x4ew7vQMxR3O4wYhXDVMRDKsrviksoI=;
        b=qqI7EHE1t9k9RKDV+HdaBlwsPXshvFUAbh/iGhcm8+cyQjcKQhN5E6id8Qoxw8fcWr
         exhoARH/HtwNbudbixp9cbwX0Vw8drjBXJ0sI1FPLLbGv+pG+xmHMVzvq9dlAj3FDWTi
         5jAoP3xYsH/KVD7wlfVUNJ9K2Z+OBZHtPynW4Ugu0+TB7e5pmAAEHxSHw+F0Hw4Wcyjr
         3aqG+W/Tj7A2+vXGDQ8OwrlD0hn9sNtq8b+sx1pV6hb/LAaXN6YHBcvugYEsQFSaPHfs
         9F0aOI/gC8+jMiLz7f7jXfOvyREPuBWU5GBHYnUFoZT/p5nK1cVFQqywMInC9tpTdThh
         A59Q==
X-Received: by 10.67.3.100 with SMTP id bv4mr129968876pad.15.1420464569143;
        Mon, 05 Jan 2015 05:29:29 -0800 (PST)
Received: from lanh ([115.73.238.222])
        by mx.google.com with ESMTPSA id ni9sm54379965pdb.36.2015.01.05.05.29.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jan 2015 05:29:28 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 05 Jan 2015 20:29:24 +0700
X-Mailer: git-send-email 2.2.0.84.ge9c7a8a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262020>

=46rom: Junio C Hamano <gitster@pobox.com>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 This is in the SQUASH??? commit on nd/untracked-cache on 'pu', but it
 fixes a commit older than that series.

 builtin/clean.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 1032563..3beeea6 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -67,7 +67,7 @@ struct menu_item {
 	char hotkey;
 	const char *title;
 	int selected;
-	int (*fn)();
+	int (*fn)(void);
 };
=20
 enum menu_stuff_type {
--=20
2.2.0.84.ge9c7a8a
