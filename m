From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 31/72] gettextize: git-fetch basic messages
Date: Sat, 19 Feb 2011 19:24:14 +0000
Message-ID: <1298143495-3681-32-git-send-email-avarab@gmail.com>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 19 20:28:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsTl-0003Eb-G0
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756040Ab1BST14 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:27:56 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39339 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755983Ab1BST1x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 14:27:53 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so2347149eye.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Q4ze5QBfUDCd45yV9Y3qd2TKCKyzLZpLvhshAnryMHk=;
        b=YCkrFkGz/Baszj+c10m27shmAaiQv7G+MQ/PAMbvwXiR+Q1puwbdEH1+KPVhoGn4M9
         RVFJzJTEgnlCqMhdZ4GtjvhUUeFNhYqDShGoUmRzdqFPVnnUvi9uFKi2AAI7IpzXZ1xa
         fA3/6trk7Qv2lsLix+fyyesxgx7z6IkHyWaXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=I1dkp70PIBCJJp/4GF7MdvXTrG+RtsrypB/UTfYEL6eNF8e0nDgeV8pIa/zQCCOjHu
         KlZYXIonJ9pBnKkv3qMTa9bKvfo76p68yK+n7mYT2hZF8lNpKHrUFDCRDIBR9TAAO/0s
         Zb1tDNxtnRdCU7AVoMVtrIDxb9hzUXArIG4D0=
Received: by 10.213.32.18 with SMTP id a18mr2533015ebd.60.1298143671065;
        Sat, 19 Feb 2011 11:27:51 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id b52sm3205790eei.7.2011.02.19.11.27.49
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 11:27:50 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1298143495-3681-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167332>

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
