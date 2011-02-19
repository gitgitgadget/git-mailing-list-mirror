From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 30/72] gettextize: git-diff basic messages
Date: Sat, 19 Feb 2011 19:24:13 +0000
Message-ID: <1298143495-3681-31-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:28:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsTk-0003Eb-UL
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756032Ab1BST1y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:27:54 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56673 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755863Ab1BST1u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:50 -0500
Received: by mail-ew0-f46.google.com with SMTP id 5so1970368ewy.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=MRVqplVSyOJXUTY5hVUVEVhxx0TppoFxoc85E+vonrI=;
        b=rkdgw9kUvxtjAk9ws85O3FPMKwXrcq3YDF858pFmNcvvrDqMwYVNnh7afJTZ5emxgK
         +VdR0f0MblbCfJQz88T/wd7f673MFa0ziNX5DuiuZPgsHpEY7ajd/LKW5cCI+dF+uoIE
         NambRC4Zp8LlpIyaJBSi4RvTTvivTIlHCRtXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=IglqvpoSrCcS9hwIC/7ryoNM2dz/eSB7o7im09Ju/g2qDNJ0zqwk7749DjmHghulEP
         IZxKI1ms74oRNcQ2/fmWIJRqOnulac142/SXOCH4J/6xvO3362p0WJg6U8K/1ppzOgWP
         mC/MHryI0etqY8t5+kulPRtNNfI4pwNf5TExM=
Received: by 10.213.7.138 with SMTP id d10mr2539492ebd.55.1298143669872;
        Sat, 19 Feb 2011 11:27:49 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.49
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:49 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167331>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/diff.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 42822cd..0034273 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -71,9 +71,9 @@ static int builtin_diff_b_f(struct rev_info *revs,
 		usage(builtin_diff_usage);
=20
 	if (lstat(path, &st))
-		die_errno("failed to stat '%s'", path);
+		die_errno(_("failed to stat '%s'"), path);
 	if (!(S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)))
-		die("'%s': not a regular file or symlink", path);
+		die(_("'%s': not a regular file or symlink"), path);
=20
 	diff_set_mnemonic_prefix(&revs->diffopt, "o/", "w/");
=20
@@ -222,7 +222,7 @@ static int builtin_diff_files(struct rev_info *revs=
, int argc, const char **argv
 		else if (!strcmp(argv[1], "-h"))
 			usage(builtin_diff_usage);
 		else
-			return error("invalid option: %s", argv[1]);
+			return error(_("invalid option: %s"), argv[1]);
 		argv++; argc--;
 	}
=20
@@ -299,12 +299,12 @@ int cmd_diff(int argc, const char **argv, const c=
har *prefix)
 	DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
=20
 	if (nongit)
-		die("Not a git repository");
+		die(_("Not a git repository"));
 	argc =3D setup_revisions(argc, argv, &rev, NULL);
 	if (!rev.diffopt.output_format) {
 		rev.diffopt.output_format =3D DIFF_FORMAT_PATCH;
 		if (diff_setup_done(&rev.diffopt) < 0)
-			die("diff_setup_done failed");
+			die(_("diff_setup_done failed"));
 	}
=20
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
@@ -349,12 +349,12 @@ int cmd_diff(int argc, const char **argv, const c=
har *prefix)
 			obj =3D parse_object(obj->sha1);
 		obj =3D deref_tag(obj, NULL, 0);
 		if (!obj)
-			die("invalid object '%s' given.", name);
+			die(_("invalid object '%s' given."), name);
 		if (obj->type =3D=3D OBJ_COMMIT)
 			obj =3D &((struct commit *)obj)->tree->object;
 		if (obj->type =3D=3D OBJ_TREE) {
 			if (ARRAY_SIZE(ent) <=3D ents)
-				die("more than %d trees given: '%s'",
+				die(_("more than %d trees given: '%s'"),
 				    (int) ARRAY_SIZE(ent), name);
 			obj->flags |=3D flags;
 			ent[ents].item =3D obj;
@@ -364,7 +364,7 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 		}
 		if (obj->type =3D=3D OBJ_BLOB) {
 			if (2 <=3D blobs)
-				die("more than two blobs given: '%s'", name);
+				die(_("more than two blobs given: '%s'"), name);
 			hashcpy(blob[blobs].sha1, obj->sha1);
 			blob[blobs].name =3D name;
 			blob[blobs].mode =3D list->mode;
@@ -372,7 +372,7 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 			continue;
=20
 		}
-		die("unhandled object '%s' given.", name);
+		die(_("unhandled object '%s' given."), name);
 	}
 	if (rev.prune_data) {
 		const char **pathspec =3D rev.prune_data;
--=20
1.7.2.3
