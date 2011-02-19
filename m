From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 72/72] gettextize: git-shortlog basic messages
Date: Sat, 19 Feb 2011 19:24:55 +0000
Message-ID: <1298143495-3681-73-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:29:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsUU-0003dU-9v
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756237Ab1BST2l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:28:41 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56673 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756212Ab1BST2a (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:28:30 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1970368ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=W1LkcN7g4vHrn8EFRbf/2tC+H2QaZCpMCCG5z2RuvLU=;
        b=xof8LJdgA6QtebxgDFJQfsQx6DtpC7DL4YfIM824hKSR/rN3rUCDctprmnpwM2Q+B3
         HFj9Po/ebWhwd+Ga6o0WV+N/xn2Tvd5BIEYmEFfJjDQJuZHJwzC9ShwNMKXObmijleLY
         CEhGdE/jB+N18UPdBHolfpdmysqkv/kbtMLZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qwYEECyHVHFhoTUsmbIP/mC8GMJvq4ApOYn2B6b2SLoJ1eg0CDzdiGASRFscptPfgX
         h/xFesH8q/+eOT3IXi5tpT1KgYKm6yZVIkMasR1S6Hha3iANF25nuydWikNezRtUe+qX
         r2sSfgT5/1xs+8F6/ItQbG9nWolLeyJ/PL5rg=
Received: by 10.14.127.1 with SMTP id c1mr2445227eei.3.1298143709347;
        Sat, 19 Feb 2011 11:28:29 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.28.28
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:28:28 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167348>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/shortlog.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 1a21e4b..f5efc67 100644
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
1.7.2.3
