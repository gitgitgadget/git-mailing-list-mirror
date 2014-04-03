From: git-patch@agt-the-walker.net
Subject: [PATCH] gitweb.conf.txt: fix typo
Date: Thu,  3 Apr 2014 22:49:47 +0200
Message-ID: <1396558187-5674-1-git-send-email-git-patch@agt-the-walker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Zago?= <git-patch@agt-the-walker.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 22:50:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVoar-0004wI-09
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 22:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581AbaDCUuc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Apr 2014 16:50:32 -0400
Received: from mail-we0-f171.google.com ([74.125.82.171]:58836 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866AbaDCUub (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2014 16:50:31 -0400
Received: by mail-we0-f171.google.com with SMTP id t61so2476370wes.16
        for <git@vger.kernel.org>; Thu, 03 Apr 2014 13:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=vhYOuO4jZE4ytmSqp0uKsJ+HdAr1eeiBufWHykSeOAU=;
        b=pSJJNOtNKAEqWBq2V9LviVJxuswXncnve37uUIF2OZSiYdorlbBAe0VpSBrbCt1Dfo
         Ugnps8W7LP3JRf9mdMVMMk/djeVh9nGXc9LHN+9az93/uBRbLl0SaHlY1CNYvEwjeMBo
         0IivZ70sYwxA/utoHvLc94HSFqybMAf/7EHaW3tymqBVWBw1A84GX4nSpTEa4BJa9kDM
         2gwJSwkBYyGqh4PQzGjrOJf/FGBMYcswcR4TpTlRf1xogC7TnMzoao4eviKJYfpzzjps
         fwkVBL5WbgwOY158FzmFOth2dlW0SYkgzGM/0WVcoX+1PA1FGBPnErAqygBVaBETp6rl
         imgA==
X-Received: by 10.194.57.38 with SMTP id f6mr13520805wjq.59.1396558230659;
        Thu, 03 Apr 2014 13:50:30 -0700 (PDT)
Received: from localhost.localdomain (adsl-89-217-15-16.adslplus.ch. [89.217.15.16])
        by mx.google.com with ESMTPSA id 48sm14557970eei.24.2014.04.03.13.50.29
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Apr 2014 13:50:29 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245751>

=46rom: J=C3=A9r=C3=B4me Zago <git-patch@agt-the-walker.net>

"build-time" is used everywhere else.

Signed-off-by: J=C3=A9r=C3=B4me Zago <git-patch@agt-the-walker.net>
---
 Documentation/gitweb.conf.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.=
txt
index 952f503..8b25a2f 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -482,7 +482,7 @@ project config.  Per-repository configuration takes=
 precedence over value
 composed from `@git_base_url_list` elements and project name.
 +
 You can setup one single value (single entry/item in this list) at bui=
ld
-time by setting the `GITWEB_BASE_URL` built-time configuration variabl=
e.
+time by setting the `GITWEB_BASE_URL` build-time configuration variabl=
e.
 By default it is set to (), i.e. an empty list.  This means that gitwe=
b
 would not try to create project URL (to fetch) from project name.
=20
--=20
1.9.1
