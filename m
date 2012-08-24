From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/6] Makefile: recreate git.pot if *.sh or *.perl changes
Date: Fri, 24 Aug 2012 12:43:02 +0700
Message-ID: <1345786986-10826-3-git-send-email-pclouds@gmail.com>
References: <1345786986-10826-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 24 07:44:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4mga-0000Kb-58
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 07:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111Ab2HXFny convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Aug 2012 01:43:54 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39005 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683Ab2HXFnx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 01:43:53 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so2795592pbb.19
        for <git@vger.kernel.org>; Thu, 23 Aug 2012 22:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=cTefGYQQAG1GqotGYv3mpZonzvCWtKDeA6VnIbzFfJs=;
        b=eNiUkue6+qiZWh+xfFniNdnLfi15uSevm6kjWdcdXS36w8meQ2+YscIA0JtXXsVWX0
         3JtuWnNtuRzzk0XbqUk/Lr32o19pZn+vj1YMzOLSUEK/xH7Iihx22SL1QFjIV2m4BlgD
         s0v+OFTw2buUVI8MuP3L3Mc40IImTrCh7XJxQCifV6xcaWhxgYf4KaIWITrhxbYWzoNX
         sKXcJaBc3wA3ZPFTDLcdUl66TkX+59iKDmS766OQ6wq8voQ/RN+fgxzL3+yIR4su+qv3
         L2aXNAlgaANkk2xL360wYDlJMZoYYQ7wVWvY5q9VJ9/A+nypQLk6dmIK8KqCvimHutDR
         pPWg==
Received: by 10.66.89.36 with SMTP id bl4mr8213034pab.58.1345787032749;
        Thu, 23 Aug 2012 22:43:52 -0700 (PDT)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id ka9sm7563439pbb.59.2012.08.23.22.43.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Aug 2012 22:43:52 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 24 Aug 2012 12:43:35 +0700
X-Mailer: git-send-email 1.7.12.rc2
In-Reply-To: <1345786986-10826-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204183>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index ddeb04d..485978f 100644
--- a/Makefile
+++ b/Makefile
@@ -2409,7 +2409,7 @@ LOCALIZED_SH +=3D t/t0200/test.sh
 LOCALIZED_PERL +=3D t/t0200/test.perl
 endif
=20
-po/git.pot: $(LOCALIZED_C)
+po/git.pot: $(LOCALIZED_C) $(LOCALIZED_SH) $(LOCALIZED_PERL)
 	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)
 	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_S=
H) \
 		$(LOCALIZED_SH)
--=20
1.7.12.rc2
