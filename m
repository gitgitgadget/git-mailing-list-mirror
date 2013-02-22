From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 1/2] index-format.txt: mention of v4 is missing in some places
Date: Fri, 22 Feb 2013 19:09:23 +0700
Message-ID: <1361534964-4232-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 22 13:09:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8rR2-0006Jh-PW
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 13:09:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978Ab3BVMIk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2013 07:08:40 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:64344 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754860Ab3BVMIj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 07:08:39 -0500
Received: by mail-pb0-f42.google.com with SMTP id xb4so373633pbc.29
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 04:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=x2xMlioiESgSxGSLBIX/sI2j+jm83BZikHhIIN+5deU=;
        b=VjqM0l1aDNaGr9KAVhzeP7A2mjx/F+WnnyXpP+FR8B5M2ngp0gV3hwfmXE4qOkn/lH
         cgeKlvnUAhGcXfKAE6wHx573U5tYvDOB/8XPMUBjJ4OLCKmh1OeeGGiLoBZgPOPCrj71
         fQU8SLcaeLgxskqDTL2Yn2tV+5RAl4B6qx0oXeYQzqYQcQ3qHyY6LpE8QREjQuOwU2ST
         C7cyJ6pZGw163iUGKxZ175oqNiFeSX+8H3z08mqRPh7onmbg7XJC4DipwTl0KafThyuL
         wqFS7GVIPlC9Z0rroIn0UB9I6MiJGhaZnMflhcXd9xc/sVWTEitY21Qk40MHh+f/OH54
         6qbw==
X-Received: by 10.66.19.229 with SMTP id i5mr3524972pae.220.1361534918584;
        Fri, 22 Feb 2013 04:08:38 -0800 (PST)
Received: from lanh ([115.74.55.130])
        by mx.google.com with ESMTPS id tm1sm2349314pbc.11.2013.02.22.04.08.35
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Feb 2013 04:08:37 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 22 Feb 2013 19:09:33 +0700
X-Mailer: git-send-email 1.8.1.2.536.gf441e6d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216831>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/index-format.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/t=
echnical/index-format.txt
index 27c716b..0810251 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -12,7 +12,7 @@ Git index format
        The signature is { 'D', 'I', 'R', 'C' } (stands for "dircache")
=20
      4-byte version number:
-       The current supported versions are 2 and 3.
+       The current supported versions are 2, 3 and 4.
=20
      32-bit number of index entries.
=20
@@ -93,8 +93,8 @@ Git index format
     12-bit name length if the length is less than 0xFFF; otherwise 0xF=
=46F
     is stored in this field.
=20
-  (Version 3) A 16-bit field, only applicable if the "extended flag"
-  above is 1, split into (high to low bits).
+  (Version 3 or later) A 16-bit field, only applicable if the
+  "extended flag" above is 1, split into (high to low bits).
=20
     1-bit reserved for future
=20
--=20
1.8.1.2.536.gf441e6d
