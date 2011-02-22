From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 50/73] gettextize: git-tag basic messages
Date: Tue, 22 Feb 2011 23:42:09 +0000
Message-ID: <1298418152-27789-51-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:44:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1uL-0008HI-Fn
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755563Ab1BVXoa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:30 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:51284 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755546Ab1BVXoX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:23 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3867040bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=8JwDvMRNtwaWOSnSOL2o1vEeha0Myiz8TpUuKrxn8Uw=;
        b=k54l0uu/LthjEdF3zZzhdqdbskQklrEZEapWkEE5AmPjW2yQ4/vBXIaKbAfTx7MJyy
         pmNWg3+reLuZcsXZHXcJCa12R4GpsbwfIqAVNB2lFbp8doaE0Fqi/B2ai37qGGyqK7Ne
         70vv/B0ak9tG6A1i1HmK8a80ppHhQjPZ1O7bY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=SoKIJiuu8KCu2k5bsWDbz5OpguKAu/LIxX8nWhtUlZOEfbpB1mx3vUIwNgADStshAH
         Yr96Chn8j+MJ04WvGp/M8PnL+e6OMy9nUa3EEOHKvq6xApc9LLSNr8BVLLKKDXwwREJf
         hucN1/bWp7uZwOaIPVPrejWbpuW9yqJ/U+ADI=
Received: by 10.204.52.134 with SMTP id i6mr3106120bkg.36.1298418262208;
        Tue, 22 Feb 2011 15:44:22 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.21
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:21 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167607>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/tag.c |   60 ++++++++++++++++++++++++++++---------------------=
-------
 1 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 246a2bc..4bed7c2 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -118,12 +118,12 @@ static int for_each_tag_name(const char **argv, e=
ach_tag_name_fn fn)
 	for (p =3D argv; *p; p++) {
 		if (snprintf(ref, sizeof(ref), "refs/tags/%s", *p)
 					>=3D sizeof(ref)) {
-			error("tag name too long: %.*s...", 50, *p);
+			error(_("tag name too long: %.*s..."), 50, *p);
 			had_error =3D 1;
 			continue;
 		}
 		if (!resolve_ref(ref, sha1, 1, NULL)) {
-			error("tag '%s' not found.", *p);
+			error(_("tag '%s' not found."), *p);
 			had_error =3D 1;
 			continue;
 		}
@@ -138,7 +138,7 @@ static int delete_tag(const char *name, const char =
*ref,
 {
 	if (delete_ref(ref, sha1, 0))
 		return 1;
-	printf("Deleted tag '%s' (was %s)\n", name, find_unique_abbrev(sha1, =
DEFAULT_ABBREV));
+	printf(_("Deleted tag '%s' (was %s)\n"), name, find_unique_abbrev(sha=
1, DEFAULT_ABBREV));
 	return 0;
 }
=20
@@ -150,7 +150,7 @@ static int verify_tag(const char *name, const char =
*ref,
 	argv_verify_tag[2] =3D sha1_to_hex(sha1);
=20
 	if (run_command_v_opt(argv_verify_tag, RUN_GIT_CMD))
-		return error("could not verify the tag '%s'", name);
+		return error(_("could not verify the tag '%s'"), name);
 	return 0;
 }
=20
@@ -165,7 +165,7 @@ static int do_sign(struct strbuf *buffer)
 	if (!*signingkey) {
 		if (strlcpy(signingkey, git_committer_info(IDENT_ERROR_ON_NO_NAME),
 				sizeof(signingkey)) > sizeof(signingkey) - 1)
-			return error("committer info too long.");
+			return error(_("committer info too long."));
 		bracket =3D strchr(signingkey, '>');
 		if (bracket)
 			bracket[1] =3D '\0';
@@ -185,20 +185,20 @@ static int do_sign(struct strbuf *buffer)
 	args[3] =3D NULL;
=20
 	if (start_command(&gpg))
-		return error("could not run gpg.");
+		return error(_("could not run gpg."));
=20
 	if (write_in_full(gpg.in, buffer->buf, buffer->len) !=3D buffer->len)=
 {
 		close(gpg.in);
 		close(gpg.out);
 		finish_command(&gpg);
-		return error("gpg did not accept the tag data");
+		return error(_("gpg did not accept the tag data"));
 	}
 	close(gpg.in);
 	len =3D strbuf_read(buffer, gpg.out, 1024);
 	close(gpg.out);
=20
 	if (finish_command(&gpg) || !len || len < 0)
-		return error("gpg failed to sign the tag");
+		return error(_("gpg failed to sign the tag"));
=20
 	/* Strip CR from the line endings, in case we are on Windows. */
 	for (i =3D j =3D 0; i < buffer->len; i++)
@@ -221,7 +221,7 @@ static const char tag_template[] =3D
 static void set_signingkey(const char *value)
 {
 	if (strlcpy(signingkey, value, sizeof(signingkey)) >=3D sizeof(signin=
gkey))
-		die("signing key value too long (%.10s...)", value);
+		die(_("signing key value too long (%.10s...)"), value);
 }
=20
 static int git_tag_config(const char *var, const char *value, void *cb=
)
@@ -261,9 +261,9 @@ static void write_tag_body(int fd, const unsigned c=
har *sha1)
 static int build_tag_object(struct strbuf *buf, int sign, unsigned cha=
r *result)
 {
 	if (sign && do_sign(buf) < 0)
-		return error("unable to sign the tag");
+		return error(_("unable to sign the tag"));
 	if (write_sha1_file(buf->buf, buf->len, tag_type, result) < 0)
-		return error("unable to write tag file");
+		return error(_("unable to write tag file"));
 	return 0;
 }
=20
@@ -278,7 +278,7 @@ static void create_tag(const unsigned char *object,=
 const char *tag,
=20
 	type =3D sha1_object_info(object, NULL);
 	if (type <=3D OBJ_NONE)
-	    die("bad object type.");
+	    die(_("bad object type."));
=20
 	header_len =3D snprintf(header_buf, sizeof(header_buf),
 			  "object %s\n"
@@ -291,7 +291,7 @@ static void create_tag(const unsigned char *object,=
 const char *tag,
 			  git_committer_info(IDENT_ERROR_ON_NO_NAME));
=20
 	if (header_len > sizeof(header_buf) - 1)
-		die("tag header too big.");
+		die(_("tag header too big."));
=20
 	if (!message) {
 		int fd;
@@ -300,7 +300,7 @@ static void create_tag(const unsigned char *object,=
 const char *tag,
 		path =3D git_pathdup("TAG_EDITMSG");
 		fd =3D open(path, O_CREAT | O_TRUNC | O_WRONLY, 0600);
 		if (fd < 0)
-			die_errno("could not create file '%s'", path);
+			die_errno(_("could not create file '%s'"), path);
=20
 		if (!is_null_sha1(prev))
 			write_tag_body(fd, prev);
@@ -310,7 +310,7 @@ static void create_tag(const unsigned char *object,=
 const char *tag,
=20
 		if (launch_editor(path, buf, NULL)) {
 			fprintf(stderr,
-			"Please supply the message using either -m or -F option.\n");
+			_("Please supply the message using either -m or -F option.\n"));
 			exit(1);
 		}
 	}
@@ -318,13 +318,13 @@ static void create_tag(const unsigned char *objec=
t, const char *tag,
 	stripspace(buf, 1);
=20
 	if (!message && !buf->len)
-		die("no tag message?");
+		die(_("no tag message?"));
=20
 	strbuf_insert(buf, 0, header_buf, header_len);
=20
 	if (build_tag_object(buf, sign, result) < 0) {
 		if (path)
-			fprintf(stderr, "The tag message has been left in %s\n",
+			fprintf(stderr, _("The tag message has been left in %s\n"),
 				path);
 		exit(128);
 	}
@@ -417,9 +417,9 @@ int cmd_tag(int argc, const char **argv, const char=
 *prefix)
 		return list_tags(argv[0], lines =3D=3D -1 ? 0 : lines,
 				 with_commit);
 	if (lines !=3D -1)
-		die("-n option is only allowed with -l.");
+		die(_("-n option is only allowed with -l."));
 	if (with_commit)
-		die("--contains option is only allowed with -l.");
+		die(_("--contains option is only allowed with -l."));
 	if (delete)
 		return for_each_tag_name(argv, delete_tag);
 	if (verify)
@@ -427,17 +427,17 @@ int cmd_tag(int argc, const char **argv, const ch=
ar *prefix)
=20
 	if (msg.given || msgfile) {
 		if (msg.given && msgfile)
-			die("only one -F or -m option is allowed.");
+			die(_("only one -F or -m option is allowed."));
 		annotate =3D 1;
 		if (msg.given)
 			strbuf_addbuf(&buf, &(msg.buf));
 		else {
 			if (!strcmp(msgfile, "-")) {
 				if (strbuf_read(&buf, 0, 1024) < 0)
-					die_errno("cannot read '%s'", msgfile);
+					die_errno(_("cannot read '%s'"), msgfile);
 			} else {
 				if (strbuf_read_file(&buf, msgfile, 1024) < 0)
-					die_errno("could not open or read '%s'",
+					die_errno(_("could not open or read '%s'"),
 						msgfile);
 			}
 		}
@@ -447,20 +447,20 @@ int cmd_tag(int argc, const char **argv, const ch=
ar *prefix)
=20
 	object_ref =3D argc =3D=3D 2 ? argv[1] : "HEAD";
 	if (argc > 2)
-		die("too many params");
+		die(_("too many params"));
=20
 	if (get_sha1(object_ref, object))
-		die("Failed to resolve '%s' as a valid ref.", object_ref);
+		die(_("Failed to resolve '%s' as a valid ref."), object_ref);
=20
 	if (snprintf(ref, sizeof(ref), "refs/tags/%s", tag) > sizeof(ref) - 1=
)
-		die("tag name too long: %.*s...", 50, tag);
+		die(_("tag name too long: %.*s..."), 50, tag);
 	if (check_ref_format(ref))
-		die("'%s' is not a valid tag name.", tag);
+		die(_("'%s' is not a valid tag name."), tag);
=20
 	if (!resolve_ref(ref, prev, 1, NULL))
 		hashclr(prev);
 	else if (!force)
-		die("tag '%s' already exists", tag);
+		die(_("tag '%s' already exists"), tag);
=20
 	if (annotate)
 		create_tag(object, tag, &buf, msg.given || msgfile,
@@ -468,11 +468,11 @@ int cmd_tag(int argc, const char **argv, const ch=
ar *prefix)
=20
 	lock =3D lock_any_ref_for_update(ref, prev, 0);
 	if (!lock)
-		die("%s: cannot lock the ref", ref);
+		die(_("%s: cannot lock the ref"), ref);
 	if (write_ref_sha1(lock, object, NULL) < 0)
-		die("%s: cannot update the ref", ref);
+		die(_("%s: cannot update the ref"), ref);
 	if (force && hashcmp(prev, object))
-		printf("Updated tag '%s' (was %s)\n", tag, find_unique_abbrev(prev, =
DEFAULT_ABBREV));
+		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(pre=
v, DEFAULT_ABBREV));
=20
 	strbuf_release(&buf);
 	return 0;
--=20
1.7.2.3
