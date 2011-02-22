From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 15/73] gettextize: git-branch basic messages
Date: Tue, 22 Feb 2011 23:41:34 +0000
Message-ID: <1298418152-27789-16-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:47:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1ww-0001H8-U5
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755798Ab1BVXrN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:47:13 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:33701 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754813Ab1BVXnq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:43:46 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866742bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ZDZNestsVuKPRg1uYHpmvWw8wCfu/W7kkW5K/gzieUc=;
        b=KpxeonN9qjR1RHTVaEkZ2+6k6j3gV9m9jFzq5oY86m9Kn13ad78laYJ21HOgA+vKgL
         5aQ5oUpONkM91iTowASEdriLeHDsRM801IHVLa3Vx3xV40hNj0F8DTqk5doC4UOF7i+9
         PidbW1SK/3vsWIu2B1c+djsgoZ56Fo21VtWyE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=AIg3qT0U9YAwQ5VerPsVs9u8ZOH/5nn/5+k/oh5Bw4J7Vi8nKhOsIWqNVAQyvNSBlU
         w0Da4Q8N/FDb+llHV3HRKTlPMQjCu6OVYOhYHjcpVMypAIMNk9wBVQFZUec9PI3hEjbt
         wCwdf3sSiZqMXbbp88ntIWMP8aPaHnAEQVGvk=
Received: by 10.204.124.20 with SMTP id s20mr3166605bkr.194.1298418225797;
        Tue, 22 Feb 2011 15:43:45 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.43.44
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:43:45 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167656>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/branch.c |   56 +++++++++++++++++++++++++++-------------------=
--------
 1 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 9e546e4..6695db4 100644
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
@@ -194,21 +194,21 @@ static int delete_branches(int argc, const char *=
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
@@ -218,7 +218,7 @@ static int delete_branches(int argc, const char **a=
rgv, int force, int kinds)
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
@@ -535,7 +535,7 @@ static int print_ref_list(int kinds, int detached, =
int verbose, int abbrev, stru
 	free_ref_list(&ref_list);
=20
 	if (cb.ret)
-		error("some refs could not be read");
+		error(_("some refs could not be read"));
=20
 	return cb.ret;
 }
@@ -548,7 +548,7 @@ static void rename_branch(const char *oldname, cons=
t char *newname, int force)
 	int recovery =3D 0;
=20
 	if (!oldname)
-		die("cannot rename the current branch while not on any.");
+		die(_("cannot rename the current branch while not on any."));
=20
 	if (strbuf_check_branch_ref(&oldref, oldname)) {
 		/*
@@ -558,35 +558,35 @@ static void rename_branch(const char *oldname, co=
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
@@ -601,7 +601,7 @@ static int opt_parse_merge_filter(const struct opti=
on *opt, const char *arg, int
 	if (!arg)
 		arg =3D "HEAD";
 	if (get_sha1(arg, merge_filter_ref))
-		die("malformed object name %s", arg);
+		die(_("malformed object name %s"), arg);
 	return 0;
 }
=20
@@ -675,13 +675,13 @@ int cmd_branch(int argc, const char **argv, const=
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
@@ -701,7 +701,7 @@ int cmd_branch(int argc, const char **argv, const c=
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
1.7.2.3
