From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 15/15] gettextize: git-shortlog basic messages
Date: Mon,  6 Sep 2010 12:21:44 +0000
Message-ID: <1283775704-29440-16-git-send-email-avarab@gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 14:23:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osaj0-0000aR-Cc
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 14:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754207Ab0IFMWx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 08:22:53 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62334 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981Ab0IFMWw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 08:22:52 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so6463612wwj.1
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 05:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=n0RKrJ59sXjviCByXsT2J0G9fm7soSXyOYIlvYrIvCA=;
        b=sbzGTABeKgm6ddcDA6CM59Cye4Va8suUAfLfwO5NsPzsHsMQF9zDbPvfXCCb7bUuiD
         WlsC748UcjoU7oQLuCo2NB7M3Z1Y3ORBTQHkFCNDALcJO+s8RhiK7qAWGAryZB4zYp/g
         4+JKJ31RonIJ8yxDBnYbWCQukmoO7T6EG8Lcc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kV7Fz4BjeXbb3lfpLvgob4olchj2LosOlXhkNI/0o5btkfRL/OKtCvNOdhxRGJhHK4
         zL3WMiYPYuOp3nrTVJi2GEucNZ8wHwAWClhC/ld8Sx1LBbQeYR93dDnHoL6r1mDDRJp4
         CqJ68817uVyXBrpr4KoJIZRBd05Ms0wgKj/10=
Received: by 10.216.1.12 with SMTP id 12mr675795wec.1.1283775767691;
        Mon, 06 Sep 2010 05:22:47 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p82sm3297372weq.3.2010.09.06.05.22.45
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 05:22:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155566>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/shortlog.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 2135b0d..f2cfe97 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -158,7 +158,7 @@ void shortlog_add_commit(struct shortlog *log, stru=
ct commit *commit)
 		buffer =3D eol;
 	}
 	if (!author)
-		die("Missing author: %s",
+		die(_("Missing author: %s"),
 		    sha1_to_hex(commit->object.sha1));
 	if (log->user_format) {
 		struct pretty_print_context ctx =3D {0};
@@ -181,7 +181,7 @@ static void get_from_rev(struct rev_info *rev, stru=
ct shortlog *log)
 	struct commit *commit;
=20
 	if (prepare_revision_walk(rev))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
 	while ((commit =3D get_revision(rev)) !=3D NULL)
 		shortlog_add_commit(log, commit);
 }
@@ -284,7 +284,7 @@ parse_done:
 	argc =3D parse_options_end(&ctx);
=20
 	if (setup_revisions(argc, argv, &rev, NULL) !=3D 1) {
-		error("unrecognized argument: %s", argv[1]);
+		error(_("unrecognized argument: %s"), argv[1]);
 		usage_with_options(shortlog_usage, options);
 	}
=20
@@ -296,7 +296,7 @@ parse_done:
 		add_head_to_pending(&rev);
 	if (rev.pending.nr =3D=3D 0) {
 		if (isatty(0))
-			fprintf(stderr, "(reading log message from standard input)\n");
+			fprintf(stderr, _("(reading log message from standard input)\n"));
 		read_from_stdin(&log);
 	}
 	else
--=20
1.7.2.3.313.gcd15
