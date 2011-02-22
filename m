From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 32/73] gettextize: git-fetch basic messages
Date: Tue, 22 Feb 2011 23:41:51 +0000
Message-ID: <1298418152-27789-33-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:44:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1uH-0008HI-Va
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422Ab1BVXoL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:11 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:52041 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755360Ab1BVXoH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:07 -0500
Received: by bwz10 with SMTP id 10so3867035bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=Q4ze5QBfUDCd45yV9Y3qd2TKCKyzLZpLvhshAnryMHk=;
        b=KLRX4dLp0xbpRlvu02Phis2k6jy8oVyBC2S9IgblEtFgw+Sq86SFHrBmsgkek111W/
         fHORWjECLxxv3w7JHABHGVX4dAjJs8hqD58Z+bIc9/Uh7boFIhs1GgkyPS3ssZgHu2Nj
         nU7RhrLx8f/TcWDaQ6qlsTJGQfdKCVqArI91s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=bLC/aBAVu7dKLyHFKUHKS0DZ/nT4KIdkxck6QXQvkvzbHhFdwag4bsuDLIX6Y4liw6
         PMH5yUs3Aqh6RZRqLtAueMDIHaVFEw4FerkK/8203GliY+6EVhfgybuoGMDx7HQD2L1o
         fPX5aPtQ469PIh3J586sDCxmCzmKJHiGMNc20=
Received: by 10.204.76.1 with SMTP id a1mr3136254bkk.5.1298418243402;
        Tue, 22 Feb 2011 15:44:03 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.02
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:02 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167601>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/fetch.c |   46 +++++++++++++++++++++++-----------------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 357f3cd..c27c3e9 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -184,7 +184,7 @@ static struct ref *get_ref_map(struct transport *tr=
ansport,
 		} else {
 			ref_map =3D get_remote_ref(remote_refs, "HEAD");
 			if (!ref_map)
-				die("Couldn't find remote ref HEAD");
+				die(_("Couldn't find remote ref HEAD"));
 			ref_map->merge =3D 1;
 			tail =3D &ref_map->next;
 		}
@@ -237,7 +237,7 @@ static int update_local_ref(struct ref *ref,
 	*display =3D 0;
 	type =3D sha1_object_info(ref->new_sha1, NULL);
 	if (type < 0)
-		die("object %s not found", sha1_to_hex(ref->new_sha1));
+		die(_("object %s not found"), sha1_to_hex(ref->new_sha1));
=20
 	if (!hashcmp(ref->old_sha1, ref->new_sha1)) {
 		if (verbosity > 0)
@@ -337,7 +337,7 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
=20
 	fp =3D fopen(filename, "a");
 	if (!fp)
-		return error("cannot open %s: %s\n", filename, strerror(errno));
+		return error(_("cannot open %s: %s\n"), filename, strerror(errno));
=20
 	if (raw_url)
 		url =3D transport_anonymize_url(raw_url);
@@ -426,9 +426,9 @@ static int store_updated_refs(const char *raw_url, =
const char *remote_name,
 	free(url);
 	fclose(fp);
 	if (rc & STORE_REF_ERROR_DF_CONFLICT)
-		error("some local refs could not be updated; try running\n"
+		error(_("some local refs could not be updated; try running\n"
 		      " 'git remote prune %s' to remove any old, conflicting "
-		      "branches", remote_name);
+		      "branches"), remote_name);
 	return rc;
 }
=20
@@ -476,7 +476,7 @@ static int quickfetch(struct ref *ref_map)
=20
 	err =3D start_command(&revlist);
 	if (err) {
-		error("could not run rev-list");
+		error(_("could not run rev-list"));
 		return err;
 	}
=20
@@ -490,14 +490,14 @@ static int quickfetch(struct ref *ref_map)
 		if (write_in_full(revlist.in, sha1_to_hex(ref->old_sha1), 40) < 0 ||
 		    write_str_in_full(revlist.in, "\n") < 0) {
 			if (errno !=3D EPIPE && errno !=3D EINVAL)
-				error("failed write to rev-list: %s", strerror(errno));
+				error(_("failed write to rev-list: %s"), strerror(errno));
 			err =3D -1;
 			break;
 		}
 	}
=20
 	if (close(revlist.in)) {
-		error("failed to close rev-list's stdin: %s", strerror(errno));
+		error(_("failed to close rev-list's stdin: %s"), strerror(errno));
 		err =3D -1;
 	}
=20
@@ -650,8 +650,8 @@ static void check_not_current_branch(struct ref *re=
f_map)
 	for (; ref_map; ref_map =3D ref_map->next)
 		if (ref_map->peer_ref && !strcmp(current_branch->refname,
 					ref_map->peer_ref->name))
-			die("Refusing to fetch into current branch %s "
-			    "of non-bare repository", current_branch->refname);
+			die(_("Refusing to fetch into current branch %s "
+			    "of non-bare repository"), current_branch->refname);
 }
=20
 static int truncate_fetch_head(void)
@@ -660,7 +660,7 @@ static int truncate_fetch_head(void)
 	FILE *fp =3D fopen(filename, "w");
=20
 	if (!fp)
-		return error("cannot open %s: %s\n", filename, strerror(errno));
+		return error(_("cannot open %s: %s\n"), filename, strerror(errno));
 	fclose(fp);
 	return 0;
 }
@@ -684,7 +684,7 @@ static int do_fetch(struct transport *transport,
 	}
=20
 	if (!transport->get_refs_list || !transport->fetch)
-		die("Don't know how to fetch from %s", transport->url);
+		die(_("Don't know how to fetch from %s"), transport->url);
=20
 	/* if not appending, truncate FETCH_HEAD */
 	if (!append && !dry_run) {
@@ -738,10 +738,10 @@ static void set_option(const char *name, const ch=
ar *value)
 {
 	int r =3D transport_set_option(transport, name, value);
 	if (r < 0)
-		die("Option \"%s\" value \"%s\" is not valid for %s",
+		die(_("Option \"%s\" value \"%s\" is not valid for %s"),
 			name, value, transport->url);
 	if (r > 0)
-		warning("Option \"%s\" is ignored for %s\n",
+		warning(_("Option \"%s\" is ignored for %s\n"),
 			name, transport->url);
 }
=20
@@ -838,9 +838,9 @@ static int fetch_multiple(struct string_list *list)
 		argv[argc] =3D name;
 		argv[argc + 1] =3D NULL;
 		if (verbosity >=3D 0)
-			printf("Fetching %s\n", name);
+			printf(_("Fetching %s\n"), name);
 		if (run_command_v_opt(argv, RUN_GIT_CMD)) {
-			error("Could not fetch %s", name);
+			error(_("Could not fetch %s"), name);
 			result =3D 1;
 		}
 	}
@@ -856,8 +856,8 @@ static int fetch_one(struct remote *remote, int arg=
c, const char **argv)
 	int exit_code;
=20
 	if (!remote)
-		die("No remote repository specified.  Please, specify either a URL o=
r a\n"
-		    "remote name from which new revisions should be fetched.");
+		die(_("No remote repository specified.  Please, specify either a URL=
 or a\n"
+		    "remote name from which new revisions should be fetched."));
=20
 	transport =3D transport_get(remote, NULL);
 	transport_set_verbosity(transport, verbosity, progress);
@@ -876,7 +876,7 @@ static int fetch_one(struct remote *remote, int arg=
c, const char **argv)
 				char *ref;
 				i++;
 				if (i >=3D argc)
-					die("You need to specify a tag name.");
+					die(_("You need to specify a tag name."));
 				ref =3D xmalloc(strlen(argv[i]) * 2 + 22);
 				strcpy(ref, "refs/tags/");
 				strcat(ref, argv[i]);
@@ -916,9 +916,9 @@ int cmd_fetch(int argc, const char **argv, const ch=
ar *prefix)
=20
 	if (all) {
 		if (argc =3D=3D 1)
-			die("fetch --all does not take a repository argument");
+			die(_("fetch --all does not take a repository argument"));
 		else if (argc > 1)
-			die("fetch --all does not make sense with refspecs");
+			die(_("fetch --all does not make sense with refspecs"));
 		(void) for_each_remote(get_one_remote_for_fetch, &list);
 		result =3D fetch_multiple(&list);
 	} else if (argc =3D=3D 0) {
@@ -929,7 +929,7 @@ int cmd_fetch(int argc, const char **argv, const ch=
ar *prefix)
 		/* All arguments are assumed to be remotes or groups */
 		for (i =3D 0; i < argc; i++)
 			if (!add_remote_or_group(argv[i], &list))
-				die("No such remote or remote group: %s", argv[i]);
+				die(_("No such remote or remote group: %s"), argv[i]);
 		result =3D fetch_multiple(&list);
 	} else {
 		/* Single remote or group */
@@ -937,7 +937,7 @@ int cmd_fetch(int argc, const char **argv, const ch=
ar *prefix)
 		if (list.nr > 1) {
 			/* More than one remote */
 			if (argc > 1)
-				die("Fetching a group and specifying refspecs does not make sense"=
);
+				die(_("Fetching a group and specifying refspecs does not make sens=
e"));
 			result =3D fetch_multiple(&list);
 		} else {
 			/* Zero or one remotes */
--=20
1.7.2.3
