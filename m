From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 31/73] gettextize: git-diff basic messages
Date: Tue, 22 Feb 2011 23:41:50 +0000
Message-ID: <1298418152-27789-32-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:46:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1w1-0000rs-KD
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:46:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755333Ab1BVXoG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:06 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39375 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256Ab1BVXoD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:03 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866600bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=MRVqplVSyOJXUTY5hVUVEVhxx0TppoFxoc85E+vonrI=;
        b=ITdNxhxeI5j18L4ZcoBEeU48FxfqkkpScMSyz5swy+aPdY4wGzQ6uIiTvOmU16J9r7
         aGutgPOY0qxrf/IxkniDZqxut6Mn8ahuQtIC6dtVzh34G62hyngDI3PR5YWzeEYLyTjg
         XY5PZhI7ylF4+nL6GOSTDknHZEr0uSQ5ZdEAA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=PVrVsmQh3zQYwPG91vXEXMnCsmfkn+l/s20c0U0LYeL6ePXM4LIHpKKV8jr5MA4ASZ
         4VRTFNY6IHM02gA4UQijJeIscI8PjDqFqJ+cxmmZW27Uhv+q2p+yAwJVwhuYFsze9vI5
         pjRkECb0kn2cqbLiOUQom5e05UeQKPpeWrcIs=
Received: by 10.204.60.76 with SMTP id o12mr3144874bkh.3.1298418242434;
        Tue, 22 Feb 2011 15:44:02 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.01
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:01 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167637>

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
