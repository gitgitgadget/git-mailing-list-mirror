From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=202/2=5D=20i18n=3A=20mark=20prefix=20=22warning=3A=22=20for=20translation?=
Date: Fri,  7 Sep 2012 21:05:05 +0200
Message-ID: <1347044705-17268-3-git-send-email-ralf.thielow@gmail.com>
References: <7vhar9ybgk.fsf@alter.siamese.dyndns.org>
 <1347044705-17268-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, worldhello.net@gmail.com, pclouds@gmail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 07 21:05:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA3ro-0005fn-1T
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 21:05:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737Ab2IGTFR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Sep 2012 15:05:17 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:57607 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753317Ab2IGTFP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 15:05:15 -0400
Received: by weyx8 with SMTP id x8so1968234wey.19
        for <git@vger.kernel.org>; Fri, 07 Sep 2012 12:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2uk2HRqBh7YL1gLTsxABzKNiKoKSyNPwebBGGufamyI=;
        b=VZs8LSJVK7X6Ze2RHTsbrE8t2f2I7cNlnPadyMhpi+4P+ZKyB4HZ8em2m+tVidUWU+
         gf/D9uldw6yh0XbwY2k2882Jy+Aw1BeEwmOBRVrbyA6DM3RUpWBAwSl2l9IT9NwS56Gm
         3rICqTjylCS8fOi3aZnKh6M3l8pRcd4qacBpwX9KNNAum8NTzXS14+hUva6vfQd/URJq
         at5KYh++/KZlnl04Yx43NftP2wecTbvwbZEMUblvlejg5AsCiIWbO1ZXnYuVT3CH3/Rt
         94nRbQGJMTde60y4FkA7kIyFDHgIkR/C7KQ6+iOOEgj8EsDak0OQRl0AuPVT5UEjqOSr
         r9SQ==
Received: by 10.216.239.207 with SMTP id c57mr3498057wer.3.1347044714113;
        Fri, 07 Sep 2012 12:05:14 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-138-170.pools.arcor-ip.net. [94.222.138.170])
        by mx.google.com with ESMTPS id cl8sm208337wib.10.2012.09.07.12.05.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Sep 2012 12:05:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.12.176.g3fc0e4c.dirty
In-Reply-To: <1347044705-17268-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204989>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 usage.c | 2 +-
 1 Datei ge=C3=A4ndert, 1 Zeile hinzugef=C3=BCgt(+), 1 Zeile entfernt(-=
)

diff --git a/usage.c b/usage.c
index a2a6678..162a4b2 100644
--- a/usage.c
+++ b/usage.c
@@ -44,7 +44,7 @@ static void error_builtin(const char *err, va_list pa=
rams)
=20
 static void warn_builtin(const char *warn, va_list params)
 {
-	vreportf("warning: ", warn, params);
+	print_with_prefix(_("warning:"), warn, params);
 }
=20
 /* If we are in a dlopen()ed .so write to a global variable would segf=
ault
--=20
1.7.12.176.g3fc0e4c.dirty
