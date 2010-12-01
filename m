From: jari.aalto@cante.net
Subject: [PATCH] git-commit.txt: Order options alphabetically
Date: Wed,  1 Dec 2010 17:52:11 +0200
Organization: Private
Message-ID: <1291218731-13931-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 16:52:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNoyi-0007Lv-Kf
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 16:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042Ab0LAPwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 10:52:15 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:46693 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752443Ab0LAPwO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 10:52:14 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id 602AB13BA11
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 17:52:13 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A02414287BD; Wed, 01 Dec 2010 17:52:13 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 3FA92E51A2
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 17:52:12 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNoyZ-0003d9-HY; Wed, 01 Dec 2010 17:52:11 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162539>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-commit.txt |  220 +++++++++++++++++++++---------------=
------
 1 files changed, 110 insertions(+), 110 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 42fb1f5..db9ed7e 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -59,73 +59,6 @@ OPTIONS
 	been modified and deleted, but new files you have not
 	told git about are not affected.
=20
--C <commit>::
---reuse-message=3D<commit>::
-	Take an existing commit object, and reuse the log message
-	and the authorship information (including the timestamp)
-	when creating the commit.
-
--c <commit>::
---reedit-message=3D<commit>::
-	Like '-C', but with '-c' the editor is invoked, so that
-	the user can further edit the commit message.
-
---reset-author::
-	When used with -C/-c/--amend options, declare that the
-	authorship of the resulting commit now belongs of the committer.
-	This also renews the author timestamp.
-
---short::
-	When doing a dry-run, give the output in the short-format. See
-	linkgit:git-status[1] for details. Implies `--dry-run`.
-
---porcelain::
-	When doing a dry-run, give the output in a porcelain-ready
-	format. See linkgit:git-status[1] for details. Implies
-	`--dry-run`.
-
--z::
-	When showing `short` or `porcelain` status output, terminate
-	entries in the status output with NUL, instead of LF. If no
-	format is given, implies the `--porcelain` output format.
-
--F <file>::
---file=3D<file>::
-	Take the commit message from the given file.  Use '-' to
-	read the message from the standard input.
-
---author=3D<author>::
-	Override the commit author. Specify an explicit author using the
-	standard `A U Thor <author@example.com>` format. Otherwise <author>
-	is assumed to be a pattern and is used to search for an existing
-	commit by that author (i.e. rev-list --all -i --author=3D<author>);
-	the commit author is then copied from the first such commit found.
-
---date=3D<date>::
-	Override the author date used in the commit.
-
--m <msg>::
---message=3D<msg>::
-	Use the given <msg> as the commit message.
-
--t <file>::
---template=3D<file>::
-	Use the contents of the given file as the initial version
-	of the commit message. The editor is invoked and you can
-	make subsequent changes. If a message is specified using
-	the `-m` or `-F` options, this option has no effect. This
-	overrides the `commit.template` configuration variable.
-
--s::
---signoff::
-	Add Signed-off-by line by the committer at the end of the commit
-	log message.
-
--n::
---no-verify::
-	This option bypasses the pre-commit and commit-msg hooks.
-	See also linkgit:githooks[5].
-
 --allow-empty::
 	Usually recording a commit that has the exact same tree as its
 	sole parent commit is a mistake, and the command prevents you
@@ -138,23 +71,6 @@ OPTIONS
        empty commit message without using plumbing commands like
        linkgit:git-commit-tree[1].
=20
---cleanup=3D<mode>::
-	This option sets how the commit message is cleaned up.
-	The  '<mode>' can be one of 'verbatim', 'whitespace', 'strip',
-	and 'default'. The 'default' mode will strip leading and
-	trailing empty lines and #commentary from the commit message
-	only if the message is to be edited. Otherwise only whitespace
-	removed. The 'verbatim' mode does not change message at all,
-	'whitespace' removes just leading/trailing whitespace lines
-	and 'strip' removes both whitespace and commentary.
-
--e::
---edit::
-	The message taken from file with `-F`, command line with
-	`-m`, and from file with `-C` are usually used as the
-	commit log message unmodified.  This option lets you
-	further edit the message taken from these sources.
-
 --amend::
 	Used to amend the tip of the current branch. Prepare the tree
 	object you would want to replace the latest commit as usual
@@ -180,6 +96,68 @@ You should understand the implications of rewriting h=
istory if you
 amend a commit that has already been published.  (See the "RECOVERING
 FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
=20
+--author=3D<author>::
+	Override the commit author. Specify an explicit author using the
+	standard `A U Thor <author@example.com>` format. Otherwise <author>
+	is assumed to be a pattern and is used to search for an existing
+	commit by that author (i.e. rev-list --all -i --author=3D<author>);
+	the commit author is then copied from the first such commit found.
+
+-c <commit>::
+--reedit-message=3D<commit>::
+	Like '-C', but with '-c' the editor is invoked, so that
+	the user can further edit the commit message.
+
+-C <commit>::
+--reuse-message=3D<commit>::
+	Take an existing commit object, and reuse the log message
+	and the authorship information (including the timestamp)
+	when creating the commit.
+
+--cleanup=3D<mode>::
+	This option sets how the commit message is cleaned up.
+	The  '<mode>' can be one of 'verbatim', 'whitespace', 'strip',
+	and 'default'. The 'default' mode will strip leading and
+	trailing empty lines and #commentary from the commit message
+	only if the message is to be edited. Otherwise only whitespace
+	removed. The 'verbatim' mode does not change message at all,
+	'whitespace' removes just leading/trailing whitespace lines
+	and 'strip' removes both whitespace and commentary.
+
+--date=3D<date>::
+	Override the author date used in the commit.
+
+--dry-run::
+	Do not create a commit, but show a list of paths that are
+	to be committed, paths with local changes that will be left
+	uncommitted and paths that are untracked.
+
+-e::
+--edit::
+	The message taken from file with `-F`, command line with
+	`-m`, and from file with `-C` are usually used as the
+	commit log message unmodified.  This option lets you
+	further edit the message taken from these sources.
+
+-F <file>::
+--file=3D<file>::
+	Take the commit message from the given file.  Use '-' to
+	read the message from the standard input.
+
+-m <msg>::
+--message=3D<msg>::
+	Use the given <msg> as the commit message.
+
+-n::
+--no-verify::
+	This option bypasses the pre-commit and commit-msg hooks.
+	See also linkgit:githooks[5].
+
+--no-status::
+	Do not include the output of linkgit:git-status[1] in the
+	commit message template when using an editor to prepare the
+	default commit message.  See option `--status'.
+
 -i::
 --include::
 	Before making a commit out of staged contents so far,
@@ -199,6 +177,50 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[=
1].)
 	the last commit without committing changes that have
 	already been staged.
=20
+--porcelain::
+	When doing a dry-run, give the output in a porcelain-ready
+	format. See linkgit:git-status[1] for details. Implies
+	`--dry-run`.
+
+-q::
+--quiet::
+	Suppress commit summary message.
+
+--status::
+	Include the output of linkgit:git-status[1] in the commit
+	message template when using an editor to prepare the commit
+	message.  Defaults to on, but can be used to override
+	configuration variable commit.status.  See option `--no-status'.
+
+--reset-author::
+	When used with -C/-c/--amend options, declare that the
+	authorship of the resulting commit now belongs of the committer.
+	This also renews the author timestamp.
+
+-s::
+--signoff::
+	Add Signed-off-by line by the committer at the end of the commit
+	log message.
+
+--short::
+	When doing a dry-run, give the output in the short-format. See
+	linkgit:git-status[1] for details. Implies `--dry-run`.
+
+-t <file>::
+--template=3D<file>::
+	Use the contents of the given file as the initial version
+	of the commit message. The editor is invoked and you can
+	make subsequent changes. If a message is specified using
+	the `-m` or `-F` options, this option has no effect. This
+	overrides the `commit.template` configuration variable.
+
+-v::
+--verbose::
+	Show unified diff between the HEAD commit and what
+	would be committed at the bottom of the commit message
+	template.  Note that this diff output doesn't have its
+	lines prefixed with '#'.
+
 -u[<mode>]::
 --untracked-files[=3D<mode>]::
 	Show untracked files (Default: 'all').
@@ -216,32 +238,10 @@ See linkgit:git-config[1] for configuration variabl=
e
 used to change the default for when the option is not
 specified.
=20
--v::
---verbose::
-	Show unified diff between the HEAD commit and what
-	would be committed at the bottom of the commit message
-	template.  Note that this diff output doesn't have its
-	lines prefixed with '#'.
-
--q::
---quiet::
-	Suppress commit summary message.
-
---dry-run::
-	Do not create a commit, but show a list of paths that are
-	to be committed, paths with local changes that will be left
-	uncommitted and paths that are untracked.
-
---status::
-	Include the output of linkgit:git-status[1] in the commit
-	message template when using an editor to prepare the commit
-	message.  Defaults to on, but can be used to override
-	configuration variable commit.status.
-
---no-status::
-	Do not include the output of linkgit:git-status[1] in the
-	commit message template when using an editor to prepare the
-	default commit message.
+-z::
+	When showing `short` or `porcelain` status output, terminate
+	entries in the status output with NUL, instead of LF. If no
+	format is given, implies the `--porcelain` output format.
=20
 \--::
 	Do not interpret any more arguments as options.
--=20
1.7.2.3
