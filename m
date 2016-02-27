From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 03/22] builtin/checkout.c: mark strings for translation
Date: Sat, 27 Feb 2016 13:41:54 +0700
Message-ID: <1456555333-5853-4-git-send-email-pclouds@gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 07:42:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZYZw-0002mv-4e
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 07:42:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755557AbcB0GmH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Feb 2016 01:42:07 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:36449 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754536AbcB0GmF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 01:42:05 -0500
Received: by mail-pf0-f173.google.com with SMTP id e127so64356388pfe.3
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 22:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vS0ecEzcl2ZConl23kF0/Dtn9wKpNT3gVIayhTDaTVI=;
        b=oadSgIQSqtIDzGdoPzoO7quZa73VesH6ZrJVUpbq/e52yy/UzqWagvt6Cs96KKwxn+
         9aE8TVujer4rAqGa1yl9/t+dLfJcc3w57wAt8DsQBOHNML81aGnqS5IznWr2pm4n26Jq
         pnomcomIeLgtFg1vSvOKPnhFXW9G4A4ig2SlWEkvJ1mEC33GRMdT+5yMyohyHX3wPohM
         NDDVC04awEF8LP/x/d3IK/KzChhHaP8p0L43c96itiAy8WiMYSRRnDmneUHYEKoEnHLN
         T7Dmw+mX9rqCX4eMWwOwP07oUflc1YrybNWrM2HpMakDpoBexWXQdK/V0daHbyzq9lrg
         WU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vS0ecEzcl2ZConl23kF0/Dtn9wKpNT3gVIayhTDaTVI=;
        b=TZOQuWr3IpD/ISIxJmn5gtLHhADHRuWMrbOkw8/Uvlz6JjqMnUvE3+Et9KJrua3koX
         g8Ol1dfsDUq9Cwe/UHC7tX0Ys9dDuKUngzrQ0L6sjDxhkoj/brLJlUzE7ayIBLmFTazK
         G0DbjApotcPs+dt5bsMD+LQ57Fh1t5uzYDYMCIGS827N1uIBZoJjYZNKXFIX7DRjoRd2
         fIyNjis6zEhR8mb5vmKDvBBZgTizmZp+UQWFRn58JHpe2jUUmsV5v1ZJzZB8uYUY0+Ob
         wGFZfUNV5WIeAzTdG94MLwlOKAza5+6hqQaHnoC6n9e2YgdKfWYqsat7Ix+hCnnBWUae
         98ew==
X-Gm-Message-State: AD7BkJJ3vqjQrdBRusJOn8YK1MfeLv7/+L82QtsOthPVa0VIcnjn541+njaLaYf02dg96Q==
X-Received: by 10.98.75.79 with SMTP id y76mr7661566pfa.147.1456555325059;
        Fri, 26 Feb 2016 22:42:05 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id w69sm8479218pfi.55.2016.02.26.22.42.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Feb 2016 22:42:03 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sat, 27 Feb 2016 13:42:37 +0700
X-Mailer: git-send-email 2.8.0.rc0.205.g7ec8cf1
In-Reply-To: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287664>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index cfa66e2..efcbd8f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -662,7 +662,7 @@ static void update_refs_for_switch(const struct che=
ckout_opts *opts,
 		}
 	} else if (new->path) {	/* Switch branches. */
 		if (create_symref("HEAD", new->path, msg.buf) < 0)
-			die("unable to update HEAD");
+			die(_("unable to update HEAD"));
 		if (!opts->quiet) {
 			if (old->path && !strcmp(new->path, old->path)) {
 				if (opts->new_branch_force)
--=20
2.8.0.rc0.205.g7ec8cf1
