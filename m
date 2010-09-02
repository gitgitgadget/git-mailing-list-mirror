From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 04/25] gettextize: git-diff basic messages
Date: Thu,  2 Sep 2010 19:40:25 +0000
Message-ID: <1283456446-22577-5-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 21:41:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFf7-0005iA-RH
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756340Ab0IBTlT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:41:19 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61967 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505Ab0IBTlS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:41:18 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so1282023wwj.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=dIbUwumjkAxgJJiuqZWqVezaweD8Nu+RJQRYfD50Myg=;
        b=hjZS6hkl8IY4fVRx95qSzssQeSp4HiXOltuYaK+qpCE/iO5Ow3EWmX7/GZ7ZkXcKub
         VWwQTTxoS6+wkdt7Jb5GpvUWG9tYgdnm/X1CUKffqVXiEGbqbmCb8qGn8/P5HppHXhNT
         9sMY6HQToL9D13XKG7DTp1ka2DdWhtqTyNHh4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=oiZlzktfsyh52CydtAl4X7TzgtQkoygID+3WxoIbnBEHGkaWPf2mmCobv1JN1EGbVd
         QprNvIQvdUu4Ws4pI9vs+9Jx0rYTd/MLbU1wQGYX9omQxJFyX3BQy4FGnvrwqFgeguRg
         xMr5QIKrBouSIZBNZMAX8ctMwovYgMq0+LhWc=
Received: by 10.227.69.134 with SMTP id z6mr9563158wbi.201.1283456477258;
        Thu, 02 Sep 2010 12:41:17 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm701885wbe.17.2010.09.02.12.41.13
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:41:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.614.g1dc9
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155165>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/diff.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index a43d326..3ae5715 100644
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
@@ -331,7 +331,7 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 				 !strcmp(arg, "--staged")) {
 				add_head_to_pending(&rev);
 				if (!rev.pending.nr)
-					die("No HEAD commit to compare with (yet)");
+					die(_("No HEAD commit to compare with (yet)"));
 				break;
 			}
 		}
@@ -346,12 +346,12 @@ int cmd_diff(int argc, const char **argv, const c=
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
@@ -361,7 +361,7 @@ int cmd_diff(int argc, const char **argv, const cha=
r *prefix)
 		}
 		if (obj->type =3D=3D OBJ_BLOB) {
 			if (2 <=3D blobs)
-				die("more than two blobs given: '%s'", name);
+				die(_("more than two blobs given: '%s'"), name);
 			hashcpy(blob[blobs].sha1, obj->sha1);
 			blob[blobs].name =3D name;
 			blob[blobs].mode =3D list->mode;
@@ -369,7 +369,7 @@ int cmd_diff(int argc, const char **argv, const cha=
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
1.7.2.2.614.g1dc9
