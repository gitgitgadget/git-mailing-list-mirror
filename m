From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 11/15] gettextize: git-revert basic messages
Date: Mon,  6 Sep 2010 12:21:40 +0000
Message-ID: <1283775704-29440-12-git-send-email-avarab@gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 14:23:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osaiw-0000aR-Jw
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 14:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753985Ab0IFMWl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 08:22:41 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42959 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753981Ab0IFMWj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 08:22:39 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so2884659wyf.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 05:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ywX0//m55RauNZpaP/EuhkNookbpqKbXH42cKjKKcmE=;
        b=v1IbyB9/B0uIKsEkysL6OKb5hejKTc1aqu1o5NGdeSonzQrdQ13Bd7oYdils721Ti/
         ZzcnPEQ5wYvIj86Zc4qRoXd3Lr4DM7g9tFx9M7T2eWmf2QDBnC5Y6ETEizntJ2qUeR7u
         BV1ykA6P5P1vnsyNr7JaQjHB8v9BiLULHEZjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=uQz9aNsVPrcLT8RXk7rb2Iwj9bLd3LCDw1344Y3/eE6U5zyoY1ZOHsHP+U34/qR1Sr
         2+vTFb8Hiv3ZrV9vkICfgmJTSLsZybSbXBGWW7gMBghka1YBrNhy26lyKpg0bEMlXHsL
         rOhzxRqyWDEF8+e9x0sNvLVBiVTludqylZS/o=
Received: by 10.216.235.104 with SMTP id t82mr2650164weq.103.1283775758635;
        Mon, 06 Sep 2010 05:22:38 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id p82sm3297372weq.3.2010.09.06.05.22.37
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Sep 2010 05:22:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
In-Reply-To: <1283638229-14199-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155565>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/revert.c |   42 +++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 4b47ace..ece0c0f 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -79,7 +79,7 @@ static void parse_args(int argc, const char **argv)
 			OPT_END(),
 		};
 		if (parse_options_concat(options, ARRAY_SIZE(options), cp_extra))
-			die("program error");
+			die(_("program error"));
 	}
=20
 	commit_argc =3D parse_options(argc, argv, NULL, options, usage_str,
@@ -151,7 +151,7 @@ static char *get_encoding(const char *message)
 	const char *p =3D message, *eol;
=20
 	if (!p)
-		die ("Could not read commit message of %s",
+		die (_("Could not read commit message of %s"),
 				sha1_to_hex(commit->object.sha1));
 	while (*p && *p !=3D '\n') {
 		for (eol =3D p + 1; *eol && *eol !=3D '\n'; eol++)
@@ -185,7 +185,7 @@ static void set_author_ident_env(const char *messag=
e)
 {
 	const char *p =3D message;
 	if (!p)
-		die ("Could not read commit message of %s",
+		die (_("Could not read commit message of %s"),
 				sha1_to_hex(commit->object.sha1));
 	while (*p && *p !=3D '\n') {
 		const char *eol;
@@ -199,7 +199,7 @@ static void set_author_ident_env(const char *messag=
e)
 			line =3D xmemdupz(p, eol - p);
 			email =3D strchr(line, '<');
 			if (!email)
-				die ("Could not extract author email from %s",
+				die (_("Could not extract author email from %s"),
 					sha1_to_hex(commit->object.sha1));
 			if (email =3D=3D line)
 				pend =3D line;
@@ -211,7 +211,7 @@ static void set_author_ident_env(const char *messag=
e)
 			email++;
 			timestamp =3D strchr(email, '>');
 			if (!timestamp)
-				die ("Could not extract author time from %s",
+				die (_("Could not extract author time from %s"),
 					sha1_to_hex(commit->object.sha1));
 			*timestamp =3D '\0';
 			for (timestamp++; *timestamp && isspace(*timestamp);
@@ -227,7 +227,7 @@ static void set_author_ident_env(const char *messag=
e)
 		if (*p =3D=3D '\n')
 			p++;
 	}
-	die ("No author information found in %s",
+	die (_("No author information found in %s"),
 			sha1_to_hex(commit->object.sha1));
 }
=20
@@ -264,10 +264,10 @@ static void write_message(struct strbuf *msgbuf, =
const char *filename)
 	int msg_fd =3D hold_lock_file_for_update(&msg_file, filename,
 					       LOCK_DIE_ON_ERROR);
 	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
-		die_errno("Could not write to %s.", filename);
+		die_errno(_("Could not write to %s."), filename);
 	strbuf_release(msgbuf);
 	if (commit_lock_file(&msg_file) < 0)
-		die("Error wrapping up %s", filename);
+		die(_("Error wrapping up %s"), filename);
 }
=20
 static struct tree *empty_tree(void)
@@ -405,10 +405,10 @@ static int do_pick_commit(void)
 		 * to work on.
 		 */
 		if (write_cache_as_tree(head, 0, NULL))
-			die ("Your index file is unmerged.");
+			die (_("Your index file is unmerged."));
 	} else {
 		if (get_sha1("HEAD", head))
-			die ("You do not have a valid HEAD");
+			die (_("You do not have a valid HEAD"));
 		if (index_differs_from("HEAD", 0))
 			die_dirty_index(me);
 	}
@@ -416,7 +416,7 @@ static int do_pick_commit(void)
=20
 	if (!commit->parents) {
 		if (action =3D=3D REVERT)
-			die ("Cannot revert a root commit");
+			die (_("Cannot revert a root commit"));
 		parent =3D NULL;
 	}
 	else if (commit->parents->next) {
@@ -425,7 +425,7 @@ static int do_pick_commit(void)
 		struct commit_list *p;
=20
 		if (!mainline)
-			die("Commit %s is a merge but no -m option was given.",
+			die(_("Commit %s is a merge but no -m option was given."),
 			    sha1_to_hex(commit->object.sha1));
=20
 		for (cnt =3D 1, p =3D commit->parents;
@@ -433,11 +433,11 @@ static int do_pick_commit(void)
 		     cnt++)
 			p =3D p->next;
 		if (cnt !=3D mainline || !p)
-			die("Commit %s does not have parent %d",
+			die(_("Commit %s does not have parent %d"),
 			    sha1_to_hex(commit->object.sha1), mainline);
 		parent =3D p->item;
 	} else if (0 < mainline)
-		die("Mainline was specified but commit %s is not a merge.",
+		die(_("Mainline was specified but commit %s is not a merge."),
 		    sha1_to_hex(commit->object.sha1));
 	else
 		parent =3D commit->parents->item;
@@ -450,7 +450,7 @@ static int do_pick_commit(void)
 		    me, sha1_to_hex(parent->object.sha1));
=20
 	if (get_message(commit->buffer, &msg) !=3D 0)
-		die("Cannot get commit message for %s",
+		die(_("Cannot get commit message for %s"),
 				sha1_to_hex(commit->object.sha1));
=20
 	/*
@@ -541,10 +541,10 @@ static void prepare_revs(struct rev_info *revs)
 		usage(*revert_or_cherry_pick_usage());
=20
 	if (prepare_revision_walk(revs))
-		die("revision walk setup failed");
+		die(_("revision walk setup failed"));
=20
 	if (!revs->commits)
-		die("empty commit set passed");
+		die(_("empty commit set passed"));
 }
=20
 static int revert_or_cherry_pick(int argc, const char **argv)
@@ -558,13 +558,13 @@ static int revert_or_cherry_pick(int argc, const =
char **argv)
=20
 	if (allow_ff) {
 		if (signoff)
-			die("cherry-pick --ff cannot be used with --signoff");
+			die(_("cherry-pick --ff cannot be used with --signoff"));
 		if (no_commit)
-			die("cherry-pick --ff cannot be used with --no-commit");
+			die(_("cherry-pick --ff cannot be used with --no-commit"));
 		if (no_replay)
-			die("cherry-pick --ff cannot be used with -x");
+			die(_("cherry-pick --ff cannot be used with -x"));
 		if (edit)
-			die("cherry-pick --ff cannot be used with --edit");
+			die(_("cherry-pick --ff cannot be used with --edit"));
 	}
=20
 	if (read_cache() < 0)
--=20
1.7.2.3.313.gcd15
