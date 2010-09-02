From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 18/25] gettextize: git-reset basic messages
Date: Thu,  2 Sep 2010 19:40:39 +0000
Message-ID: <1283456446-22577-19-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 02 21:42:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrFgS-0006jt-9y
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 21:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756676Ab0IBTm0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 15:42:26 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62423 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756672Ab0IBTmY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 15:42:24 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so1282223wwj.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 12:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=fZtgA3H00SYDWVj4m5SWHlCxW2hncy+dexPEWVsk/Js=;
        b=g3E2M5/Lyjtb/ZHaTjWeMYnHiH5LC6jAqMi7dAC6z6y/y1DMBAIEWzQ9kF4nZZ97hQ
         8VXIqSGfEHUkljhPpaoevl1JhGeKYEXcDR6iUPWvA7pTR3JZPrfo+l/xeGajEvDv1St9
         zRgMMqAU869Q93Hx4EQ+2z3Y7m2I/zc31kV+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OJvs9ZNj2WLQI1JkbImeT5ctUa8aIXqch4sp6nhIutM7vz1rlcqMWE56+39lRx3orc
         /Z0APRk76N5ygbJHhGD83ayyujIbCODVVg9MiXRpkJwHmrR3tYDFc9BPvPA6kTSMaLPN
         dWCjjCzAMxXUvurbEYZdSc4G98AqKsArFNQCo=
Received: by 10.227.146.73 with SMTP id g9mr290799wbv.188.1283456544232;
        Thu, 02 Sep 2010 12:42:24 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e31sm701885wbe.17.2010.09.02.12.42.23
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 12:42:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.614.g1dc9
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155176>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/reset.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index c198b8e..bf69444 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -92,20 +92,20 @@ static int reset_index_file(const unsigned char *sh=
a1, int reset_type, int quiet
 	if (reset_type =3D=3D KEEP) {
 		unsigned char head_sha1[20];
 		if (get_sha1("HEAD", head_sha1))
-			return error("You do not have a valid HEAD.");
+			return error(_("You do not have a valid HEAD."));
 		if (!fill_tree_descriptor(desc, head_sha1))
-			return error("Failed to find tree of HEAD.");
+			return error(_("Failed to find tree of HEAD."));
 		nr++;
 		opts.fn =3D twoway_merge;
 	}
=20
 	if (!fill_tree_descriptor(desc + nr - 1, sha1))
-		return error("Failed to find tree of %s.", sha1_to_hex(sha1));
+		return error(_("Failed to find tree of %s."), sha1_to_hex(sha1));
 	if (unpack_trees(nr, desc, &opts))
 		return -1;
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    commit_locked_index(lock))
-		return error("Could not write new index file.");
+		return error(_("Could not write new index file."));
=20
 	return 0;
 }
@@ -115,7 +115,7 @@ static void print_new_head_line(struct commit *comm=
it)
 	const char *hex, *body;
=20
 	hex =3D find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
-	printf("HEAD is now at %s", hex);
+	printf(_("HEAD is now at %s"), hex);
 	body =3D strstr(commit->buffer, "\n\n");
 	if (body) {
 		const char *eol;
@@ -139,10 +139,10 @@ static int update_index_refresh(int fd, struct lo=
ck_file *index_lock, int flags)
 	}
=20
 	if (read_cache() < 0)
-		return error("Could not read index");
+		return error(_("Could not read index"));
=20
 	result =3D refresh_index(&the_index, (flags), NULL, NULL,
-			       "Unstaged changes after reset:") ? 1 : 0;
+			       _("Unstaged changes after reset:")) ? 1 : 0;
 	if (write_cache(fd, active_cache, active_nr) ||
 			commit_locked_index(index_lock))
 		return error ("Could not refresh index");
@@ -167,7 +167,7 @@ static void update_index_from_diff(struct diff_queu=
e_struct *q,
 			ce =3D make_cache_entry(one->mode, one->sha1, one->path,
 				0, 0);
 			if (!ce)
-				die("make_cache_entry failed for path '%s'",
+				die(_("make_cache_entry failed for path '%s'"),
 				    one->path);
 			add_cache_entry(ce, ADD_CACHE_OK_TO_ADD |
 				ADD_CACHE_OK_TO_REPLACE);
@@ -222,7 +222,7 @@ static void prepend_reflog_action(const char *actio=
n, char *buf, size_t size)
 	if (!rla)
 		rla =3D sep =3D "";
 	if (snprintf(buf, size, "%s%s%s", rla, sep, action) >=3D size)
-		warning("Reflog action message too long: %.*s...", 50, buf);
+		warning(_("Reflog action message too long: %.*s..."), 50, buf);
 }
=20
 static void die_if_unmerged_cache(int reset_type)
@@ -300,16 +300,16 @@ int cmd_reset(int argc, const char **argv, const =
char *prefix)
 	}
=20
 	if (get_sha1(rev, sha1))
-		die("Failed to resolve '%s' as a valid ref.", rev);
+		die(_("Failed to resolve '%s' as a valid ref."), rev);
=20
 	commit =3D lookup_commit_reference(sha1);
 	if (!commit)
-		die("Could not parse object '%s'.", rev);
+		die(_("Could not parse object '%s'."), rev);
 	hashcpy(sha1, commit->object.sha1);
=20
 	if (patch_mode) {
 		if (reset_type !=3D NONE)
-			die("--patch is incompatible with --{hard,mixed,soft}");
+			die(_("--patch is incompatible with --{hard,mixed,soft}"));
 		return interactive_reset(rev, argv + i, prefix);
 	}
=20
@@ -318,9 +318,9 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 	 * affecting the working tree nor HEAD. */
 	if (i < argc) {
 		if (reset_type =3D=3D MIXED)
-			warning("--mixed with paths is deprecated; use 'git reset -- <paths=
>' instead.");
+			warning(_("--mixed with paths is deprecated; use 'git reset -- <pat=
hs>' instead."));
 		else if (reset_type !=3D NONE)
-			die("Cannot do %s reset with paths.",
+			die("Cannot do %s reset with paths."
 					reset_type_names[reset_type]);
 		return read_from_tree(prefix, argv + i, sha1,
 				quiet ? REFRESH_QUIET : REFRESH_IN_PORCELAIN);
@@ -348,7 +348,7 @@ int cmd_reset(int argc, const char **argv, const ch=
ar *prefix)
 		if (reset_type =3D=3D KEEP)
 			err =3D err || reset_index_file(sha1, MIXED, quiet);
 		if (err)
-			die("Could not reset index file to revision '%s'.", rev);
+			die(_("Could not reset index file to revision '%s'."), rev);
 	}
=20
 	/* Any resets update HEAD to the head being switched to,
--=20
1.7.2.2.614.g1dc9
