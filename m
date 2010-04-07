From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Remove --allow-empty from the git-commit synopsis
Date: Wed, 07 Apr 2010 15:25:36 -0700
Message-ID: <7vbpduc333.fsf@alter.siamese.dyndns.org>
References: <w2zfabb9a1e1004070829ob9da47e6oacf2703129be9107@mail.gmail.com>
 <1270661327-28078-1-git-send-email-avarab@gmail.com>
 <7vfx37cckf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 00:26:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nzdh9-0003JA-SY
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 00:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212Ab0DGWZz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Apr 2010 18:25:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63167 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186Ab0DGWZy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Apr 2010 18:25:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 10BD8A8F32;
	Wed,  7 Apr 2010 18:25:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6vKAW8Z+ROPF
	KnMX7AwGNjLH4Ts=; b=a9Ug0tICcV3pqYGjqNlRkzF0wSYoFsWCmwemPHSclOFU
	Wun837JxLAYxvQhGCeGdFIIbRUi96r4bx63vVLKDsc99h9o6hGcOYgBSUC5n+fZu
	4aBaUAp8dcqUSrai/ean2mfCi5/gORa8uC61Dv2lMEYZY3O/j2g5pnNDP6moBGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Sm5kgp
	/uAiOv3pkSMgOEY7DHyK27/XIY6KuL1/LNhgP6/FEnl/O1xD0quvBg8/GyFDLFR2
	oBCdE6UA1McE5aYKnAlw8pAg5v4EzRGfm2EPEi+vSby6xzhwXZQCpdPdD0AlmQw0
	iIxJjT9Dop6ySyqhYDAonvWft3+g5uT9L+Rnc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C266A8F2B;
	Wed,  7 Apr 2010 18:25:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8158DA8F1E; Wed,  7 Apr
 2010 18:25:38 -0400 (EDT)
In-Reply-To: <7vfx37cckf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 07 Apr 2010 12\:00\:48 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 846FE456-4294-11DF-9A28-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144293>

Junio C Hamano <gitster@pobox.com> writes:

> I do not think Jeff was against having a complete listing in the
> documentation.  Wasn't his suggestion about "git commit -h" output?

I'll amend the earlier "allow-empty-message" one from you to cover this
topic.

-- >8 --
=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Date: Tue, 6 Apr 2010 08:40:35 +0000
Subject: [PATCH] Add option to git-commit to allow empty log messages

Change git-commit(1) to accept the --allow-empty-message option
to allow a commit with an empty message.  This is analogous to the
existing --allow-empty option which allows a commit that records
no changes.  As these are mainly for interoperating with foreign SCM
systems, and are not meant for normal use, ensure that "git commit -h"
does not talk about them.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-commit.txt |    8 +++++++-
 builtin/commit.c             |   12 +++++++++---
 t/t7500-commit.sh            |   22 ++++++++++++++++++++++
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.tx=
t
index 64fb458..32c482f 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git commit' [-a | --interactive] [-s] [-v] [-u<mode>] [--amend] [--dr=
y-run]
 	   [(-c | -C) <commit>] [-F <file> | -m <msg>] [--reset-author]
-	   [--allow-empty] [--no-verify] [-e] [--author=3D<author>]
+	   [--allow-empty] [--allow-empty-message] [--no-verify] [-e] [--auth=
or=3D<author>]
 	   [--date=3D<date>] [--cleanup=3D<mode>] [--status | --no-status] [-=
-]
 	   [[-i | -o ]<file>...]
=20
@@ -131,6 +131,12 @@ OPTIONS
 	from making such a commit.  This option bypasses the safety, and
 	is primarily for use by foreign scm interface scripts.
=20
+--allow-empty-message::
+       Like --allow-empty this command is primarily for use by foreign
+       scm interface scripts. It allows you to create a commit with an
+       empty commit message without using plumbing commands like
+       linkgit:git-commit-tree[1].
+
 --cleanup=3D<mode>::
 	This option sets how the commit message is cleaned up.
 	The  '<mode>' can be one of 'verbatim', 'whitespace', 'strip',
diff --git a/builtin/commit.c b/builtin/commit.c
index c5ab683..821a49d 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -66,7 +66,7 @@ static char *edit_message, *use_message;
 static char *author_name, *author_email, *author_date;
 static int all, edit_flag, also, interactive, only, amend, signoff;
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_auth=
orship;
-static int no_post_rewrite;
+static int no_post_rewrite, allow_empty_message;
 static char *untracked_files_arg, *force_date;
 /*
  * The default commit message cleanup mode will remove the lines
@@ -140,9 +140,15 @@ static struct option builtin_commit_options[] =3D =
{
 	OPT_BOOLEAN(0, "amend", &amend, "amend previous commit"),
 	OPT_BOOLEAN(0, "no-post-rewrite", &no_post_rewrite, "bypass post-rewr=
ite hook"),
 	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode"=
, "show untracked files, optional modes: all, normal, no. (Default: all=
)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
-	OPT_BOOLEAN(0, "allow-empty", &allow_empty, "ok to record an empty ch=
ange"),
 	/* end commit contents options */
=20
+	{ OPTION_BOOLEAN, 0, "allow-empty", &allow_empty, NULL,
+	  "ok to record an empty change",
+	  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
+	{ OPTION_BOOLEAN, 0, "allow-empty-message", &allow_empty_message, NUL=
L,
+	  "ok to record a change with an empty message",
+	  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN },
+
 	OPT_END()
 };
=20
@@ -1293,7 +1299,7 @@ int cmd_commit(int argc, const char **argv, const=
 char *prefix)
=20
 	if (cleanup_mode !=3D CLEANUP_NONE)
 		stripspace(&sb, cleanup_mode =3D=3D CLEANUP_ALL);
-	if (message_is_empty(&sb)) {
+	if (message_is_empty(&sb) && !allow_empty_message) {
 		rollback_index_files();
 		fprintf(stderr, "Aborting commit due to empty commit message.\n");
 		exit(1);
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 9f5c3ed..aa9c577 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -193,4 +193,26 @@ test_expect_success 'commit -F overrides -t' '
 	commit_msg_is "-F log"
 '
=20
+test_expect_success 'Commit without message is allowed with --allow-em=
pty-message' '
+	echo "more content" >>foo &&
+	git add foo &&
+	>empty &&
+	git commit --allow-empty-message <empty &&
+	commit_msg_is ""
+'
+
+test_expect_success 'Commit without message is no-no without --allow-e=
mpty-message' '
+	echo "more content" >>foo &&
+	git add foo &&
+	>empty &&
+	test_must_fail git commit <empty
+'
+
+test_expect_success 'Commit a message with --allow-empty-message' '
+	echo "even more content" >>foo &&
+	git add foo &&
+	git commit --allow-empty-message -m"hello there" &&
+	commit_msg_is "hello there"
+'
+
 test_done
--=20
1.7.1.rc0.212.gbd88f
