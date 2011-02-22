From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 73/73] gettextize: git-shortlog basic messages
Date: Tue, 22 Feb 2011 23:42:32 +0000
Message-ID: <1298418152-27789-74-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:45:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1vI-0000K1-Ew
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:45:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755643Ab1BVXoy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:54 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39209 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755624Ab1BVXow (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:52 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866615bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=W1LkcN7g4vHrn8EFRbf/2tC+H2QaZCpMCCG5z2RuvLU=;
        b=TWBs6G6dD/TX5dxo/2x0smMazbcpHArMDFCkwaci3G4mX3Sfhb32omxjmRE9V8crU5
         02yTYgxIe52YL5rctgivXns9gKJFNmsUp8bja4pFJ5NUmn74RE2hzVxSyBvJvSVoQcHI
         b7DH6/DEOrQiy9fRGTR7SKnjqyn80Tv8MGVqs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=o64lkIjxPG69+9zMBv/uzmUnRgIbmn+EsAk/jhJUXygCdjSEu4Ysw+x83YyB8+z4st
         c2I5JaBCIw8/EscrP8bUyi6+OpHEQ2tWLDXS6lTPoG5f0bQAifcGDlf/rngkHIhjH3B5
         IiKQ2LAAUTLMU/6nacQHlS+6YLKL5zAyrPiAM=
Received: by 10.204.31.69 with SMTP id x5mr423385bkc.66.1298418290806;
        Tue, 22 Feb 2011 15:44:50 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.50
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:50 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167617>

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
