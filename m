From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 06/13] gettextize: git-branch basic messages
Date: Wed,  1 Sep 2010 20:43:58 +0000
Message-ID: <1283373845-2022-7-git-send-email-avarab@gmail.com>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 01 22:45:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OquBW-000790-S5
	for gcvg-git-2@lo.gmane.org; Wed, 01 Sep 2010 22:45:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308Ab0IAUo4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Sep 2010 16:44:56 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47495 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754206Ab0IAUoi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Sep 2010 16:44:38 -0400
Received: by eyb6 with SMTP id 6so858728eyb.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 13:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=GWGQTlC+DCao8ow1ln0ENWgzjQWWpshBGDWxj0X+omU=;
        b=tIGbVpHJKz6iKVm3+/YdlPaMyKbSZpYxoDuTL2rfMM6e8zyrU+4fgk5xGpGrKz31uh
         4KmNjHsd5En5Nemuwsfm6GT+zPe3bF6Ftf8Xhc6P++VxubPE2x9FiUofMhjfiGWmqkf2
         XqCbx8PjpK1kHVL3TjptbDsX4hc2NDnMkSY8A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Yf8Y1TtTKQjaId5rqzXqtMEI2hqusUzMQyyIMaTh+HSq67a2aN98xO3ao7GfckIrdO
         p7qSNy08ZWthJto2XilhXJZFUZ00Eg/UC4H6QSSuPoTl9IXz5pvoNTCuEaBrpbaABHyn
         SqaARbJfGF+LBnU/8E020E3hGOtvatXil0vtQ=
Received: by 10.216.167.205 with SMTP id i55mr755494wel.17.1283373877201;
        Wed, 01 Sep 2010 13:44:37 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm6461150weq.16.2010.09.01.13.44.36
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 13:44:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.579.g2183d
In-Reply-To: <1283373845-2022-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155090>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/branch.c |   58 +++++++++++++++++++++++++++-------------------=
--------
 1 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 87976f0..50c15c1 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -133,12 +133,12 @@ static int branch_merged(int kind, const char *na=
me,
 	if ((head_rev !=3D reference_rev) &&
 	    in_merge_bases(rev, &head_rev, 1) !=3D merged) {
 		if (merged)
-			warning("deleting branch '%s' that has been merged to\n"
-				"         '%s', but it is not yet merged to HEAD.",
+			warning(_("deleting branch '%s' that has been merged to\n"
+				"         '%s', but it is not yet merged to HEAD."),
 				name, reference_name);
 		else
-			warning("not deleting branch '%s' that is not yet merged to\n"
-				"         '%s', even though it is merged to HEAD.",
+			warning(_("not deleting branch '%s' that is not yet merged to\n"
+				"         '%s', even though it is merged to HEAD."),
 				name, reference_name);
 	}
 	return merged;
@@ -165,19 +165,19 @@ static int delete_branches(int argc, const char *=
*argv, int force, int kinds)
 		remote =3D "";
 		break;
 	default:
-		die("cannot use -a with -d");
+		die(_("cannot use -a with -d"));
 	}
=20
 	if (!force) {
 		head_rev =3D lookup_commit_reference(head_sha1);
 		if (!head_rev)
-			die("Couldn't look up commit object for HEAD");
+			die(_("Couldn't look up commit object for HEAD"));
 	}
 	for (i =3D 0; i < argc; i++, strbuf_release(&bname)) {
 		strbuf_branchname(&bname, argv[i]);
 		if (kinds =3D=3D REF_LOCAL_BRANCH && !strcmp(head, bname.buf)) {
-			error("Cannot delete the branch '%s' "
-			      "which you are currently on.", bname.buf);
+			error(_("Cannot delete the branch '%s' "
+			      "which you are currently on."), bname.buf);
 			ret =3D 1;
 			continue;
 		}
@@ -186,7 +186,7 @@ static int delete_branches(int argc, const char **a=
rgv, int force, int kinds)
=20
 		name =3D xstrdup(mkpath(fmt, bname.buf));
 		if (!resolve_ref(name, sha1, 1, NULL)) {
-			error("%sbranch '%s' not found.",
+			error(_("%sbranch '%s' not found."),
 					remote, bname.buf);
 			ret =3D 1;
 			continue;
@@ -194,31 +194,31 @@ static int delete_branches(int argc, const char *=
*argv, int force, int kinds)
=20
 		rev =3D lookup_commit_reference(sha1);
 		if (!rev) {
-			error("Couldn't look up commit object for '%s'", name);
+			error(_("Couldn't look up commit object for '%s'"), name);
 			ret =3D 1;
 			continue;
 		}
=20
 		if (!force && !branch_merged(kinds, bname.buf, rev, head_rev)) {
-			error("The branch '%s' is not fully merged.\n"
+			error(_("The branch '%s' is not fully merged.\n"
 			      "If you are sure you want to delete it, "
-			      "run 'git branch -D %s'.", bname.buf, bname.buf);
+			      "run 'git branch -D %s'."), bname.buf, bname.buf);
 			ret =3D 1;
 			continue;
 		}
=20
 		if (delete_ref(name, sha1, 0)) {
-			error("Error deleting %sbranch '%s'", remote,
+			error(_("Error deleting %sbranch '%s'"), remote,
 			      bname.buf);
 			ret =3D 1;
 		} else {
 			struct strbuf buf =3D STRBUF_INIT;
-			printf("Deleted %sbranch %s (was %s).\n", remote,
+			printf(_("Deleted %sbranch %s (was %s).\n"), remote,
 			       bname.buf,
 			       find_unique_abbrev(sha1, DEFAULT_ABBREV));
 			strbuf_addf(&buf, "branch.%s", bname.buf);
 			if (git_config_rename_section(buf.buf, NULL) < 0)
-				warning("Update of config-file failed");
+				warning(_("Update of config-file failed"));
 			strbuf_release(&buf);
 		}
 	}
@@ -300,7 +300,7 @@ static int append_ref(const char *refname, const un=
signed char *sha1, int flags,
 	if (ref_list->verbose || ref_list->with_commit || merge_filter !=3D N=
O_FILTER) {
 		commit =3D lookup_commit_reference_gently(sha1, 1);
 		if (!commit) {
-			cb->ret =3D error("branch '%s' does not point at a commit", refname=
);
+			cb->ret =3D error(_("branch '%s' does not point at a commit"), refn=
ame);
 			return 0;
 		}
=20
@@ -540,7 +540,7 @@ static int print_ref_list(int kinds, int detached, =
int verbose, int abbrev, stru
 	free_ref_list(&ref_list);
=20
 	if (cb.ret)
-		error("some refs could not be read");
+		error(_("some refs could not be read"));
=20
 	return cb.ret;
 }
@@ -553,7 +553,7 @@ static void rename_branch(const char *oldname, cons=
t char *newname, int force)
 	int recovery =3D 0;
=20
 	if (!oldname)
-		die("cannot rename the current branch while not on any.");
+		die(_("cannot rename the current branch while not on any."));
=20
 	if (strbuf_check_branch_ref(&oldref, oldname)) {
 		/*
@@ -563,35 +563,35 @@ static void rename_branch(const char *oldname, co=
nst char *newname, int force)
 		if (resolve_ref(oldref.buf, sha1, 1, NULL))
 			recovery =3D 1;
 		else
-			die("Invalid branch name: '%s'", oldname);
+			die(_("Invalid branch name: '%s'"), oldname);
 	}
=20
 	if (strbuf_check_branch_ref(&newref, newname))
-		die("Invalid branch name: '%s'", newname);
+		die(_("Invalid branch name: '%s'"), newname);
=20
 	if (resolve_ref(newref.buf, sha1, 1, NULL) && !force)
-		die("A branch named '%s' already exists.", newref.buf + 11);
+		die(_("A branch named '%s' already exists."), newref.buf + 11);
=20
 	strbuf_addf(&logmsg, "Branch: renamed %s to %s",
 		 oldref.buf, newref.buf);
=20
 	if (rename_ref(oldref.buf, newref.buf, logmsg.buf))
-		die("Branch rename failed");
+		die(_("Branch rename failed"));
 	strbuf_release(&logmsg);
=20
 	if (recovery)
-		warning("Renamed a misnamed branch '%s' away", oldref.buf + 11);
+		warning(_("Renamed a misnamed branch '%s' away"), oldref.buf + 11);
=20
 	/* no need to pass logmsg here as HEAD didn't really move */
 	if (!strcmp(oldname, head) && create_symref("HEAD", newref.buf, NULL)=
)
-		die("Branch renamed to %s, but HEAD is not updated!", newname);
+		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
=20
 	strbuf_addf(&oldsection, "branch.%s", oldref.buf + 11);
 	strbuf_release(&oldref);
 	strbuf_addf(&newsection, "branch.%s", newref.buf + 11);
 	strbuf_release(&newref);
 	if (git_config_rename_section(oldsection.buf, newsection.buf) < 0)
-		die("Branch is renamed, but update of config-file failed");
+		die(_("Branch is renamed, but update of config-file failed"));
 	strbuf_release(&oldsection);
 	strbuf_release(&newsection);
 }
@@ -606,7 +606,7 @@ static int opt_parse_merge_filter(const struct opti=
on *opt, const char *arg, int
 	if (!arg)
 		arg =3D "HEAD";
 	if (get_sha1(arg, merge_filter_ref))
-		die("malformed object name %s", arg);
+		die(_("malformed object name %s"), arg);
 	return 0;
 }
=20
@@ -676,13 +676,13 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
=20
 	head =3D resolve_ref("HEAD", head_sha1, 0, NULL);
 	if (!head)
-		die("Failed to resolve HEAD as a valid ref.");
+		die(_("Failed to resolve HEAD as a valid ref."));
 	head =3D xstrdup(head);
 	if (!strcmp(head, "HEAD")) {
 		detached =3D 1;
 	} else {
 		if (prefixcmp(head, "refs/heads/"))
-			die("HEAD not found below refs/heads!");
+			die(_("HEAD not found below refs/heads!"));
 		head +=3D 11;
 	}
 	hashcpy(merge_filter_ref, head_sha1);
@@ -702,7 +702,7 @@ int cmd_branch(int argc, const char **argv, const c=
har *prefix)
 		rename_branch(argv[0], argv[1], rename > 1);
 	else if (argc <=3D 2) {
 		if (kinds !=3D REF_LOCAL_BRANCH)
-			die("-a and -r options to 'git branch' do not make sense with a bra=
nch name");
+			die(_("-a and -r options to 'git branch' do not make sense with a b=
ranch name"));
 		create_branch(head, argv[0], (argc =3D=3D 2) ? argv[1] : head,
 			      force_create, reflog, track);
 	} else
--=20
1.7.2.2.579.g2183d
