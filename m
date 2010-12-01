From: jari.aalto@cante.net
Subject: [PATCH] git-am.txt: order options alphabetically
Date: Wed,  1 Dec 2010 22:22:14 +0200
Organization: Private
Message-ID: <1291234934-21481-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 21:22:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNtC2-00059b-JE
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 21:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756618Ab0LAUWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 15:22:18 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:43112 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756300Ab0LAUWR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 15:22:17 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id F3DDA8C0D5
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 22:22:15 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A01ED0AF379; Wed, 01 Dec 2010 22:22:15 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id D6D83158A67
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 22:22:14 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNtBu-0005at-80; Wed, 01 Dec 2010 22:22:14 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162602>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-am.txt |  133 +++++++++++++++++++++++-----------------=
------
 1 files changed, 67 insertions(+), 66 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 51297d0..275ae8f 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -25,60 +25,42 @@ current branch.
=20
 OPTIONS
 -------
-(<mbox>|<Maildir>)...::
-	The list of mailbox files to read patches from. If you do not
-	supply this argument, the command reads from the standard input.
-	If you supply directories, they will be treated as Maildirs.
-
--s::
---signoff::
-	Add a `Signed-off-by:` line to the commit message, using
-	the committer identity of yourself.
=20
--k::
---keep::
-	Pass `-k` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
+-3::
+--3way::
+	When the patch does not apply cleanly, fall back on
+	3-way merge if the patch records the identity of blobs
+	it is supposed to apply to and we have those blobs
+	available locally.
=20
---keep-cr::
---no-keep-cr::
-	With `--keep-cr`, call 'git mailsplit' (see linkgit:git-mailsplit[1])
-	with the same option, to prevent it from stripping CR at the end of
-	lines. `am.keepcr` configuration variable can be used to specify the
-	default behaviour.  `--no-keep-cr` is useful to override `am.keepcr`.
+--abort::
+	Restore the original branch and abort the patching operation.
=20
 -c::
 --scissors::
+--no-scissors::
 	Remove everything in body before a scissors line (see
 	linkgit:git-mailinfo[1]).
=20
---no-scissors::
-	Ignore scissors lines (see linkgit:git-mailinfo[1]).
-
--q::
---quiet::
-	Be quiet. Only print error messages.
+	Alternatively ignore scissors lines (see linkgit:git-mailinfo[1]).
=20
--u::
---utf8::
-	Pass `-u` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
-	The proposed commit log message taken from the e-mail
-	is re-coded into UTF-8 encoding (configuration variable
-	`i18n.commitencoding` can be used to specify project's
-	preferred encoding if it is not UTF-8).
-+
-This was optional in prior versions of git, but now it is the
-default.   You can use `--no-utf8` to override this.
+--committer-date-is-author-date::
+	By default the command records the date from the e-mail
+	message as the commit author date, and uses the time of
+	commit creation as the committer date. This allows the
+	user to lie about the committer date by using the same
+	value as the author date.
=20
---no-utf8::
-	Pass `-n` flag to 'git mailinfo' (see
-	linkgit:git-mailinfo[1]).
+-i::
+--interactive::
+	Run interactively.
=20
--3::
---3way::
-	When the patch does not apply cleanly, fall back on
-	3-way merge if the patch records the identity of blobs
-	it is supposed to apply to and we have those blobs
-	available locally.
+--ignore-date::
+	By default the command records the date from the e-mail
+	message as the commit author date, and uses the time of
+	commit creation as the committer date. This allows the
+	user to lie about the author date by using the same
+	value as the committer date.
=20
 --ignore-date::
 --ignore-space-change::
@@ -91,32 +73,24 @@ default.   You can use `--no-utf8` to override this.
 	These flags are passed to the 'git apply' (see linkgit:git-apply[1])
 	program that applies
 	the patch.
+-k::
+--keep::
+	Pass `-k` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
=20
--i::
---interactive::
-	Run interactively.
-
---committer-date-is-author-date::
-	By default the command records the date from the e-mail
-	message as the commit author date, and uses the time of
-	commit creation as the committer date. This allows the
-	user to lie about the committer date by using the same
-	value as the author date.
-
---ignore-date::
-	By default the command records the date from the e-mail
-	message as the commit author date, and uses the time of
-	commit creation as the committer date. This allows the
-	user to lie about the author date by using the same
-	value as the committer date.
+--keep-cr::
+--no-keep-cr::
+	With `--keep-cr`, call 'git mailsplit' (see linkgit:git-mailsplit[1])
+	with the same option, to prevent it from stripping CR at the end of
+	lines. `am.keepcr` configuration variable can be used to specify the
+	default behaviour.  `--no-keep-cr` is useful to override `am.keepcr`.
=20
---skip::
-	Skip the current patch.  This is only meaningful when
-	restarting an aborted patch.
+-q::
+--quiet::
+	Be quiet. Only print error messages.
=20
---continue::
 -r::
 --resolved::
+--continue::
 	After a patch failure (e.g. attempting to apply
 	conflicting patch), the user has applied it by hand and
 	the index file stores the result of the application.
@@ -131,8 +105,35 @@ default.   You can use `--no-utf8` to override this.
 	or `--skip` to handle the failure.  This is solely
 	for internal use between 'git rebase' and 'git am'.
=20
---abort::
-	Restore the original branch and abort the patching operation.
+-s::
+--signoff::
+	Add a `Signed-off-by:` line to the commit message, using
+	the committer identity of yourself.
+
+-u::
+--utf8::
+--no-utf8::
+	Pass `-u` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
+	The proposed commit log message taken from the e-mail
+	is re-coded into UTF-8 encoding (configuration variable
+	`i18n.commitencoding` can be used to specify project's
+	preferred encoding if it is not UTF-8).
++
+This was optional in prior versions of git, but now it is the
+default.   You can use `--no-utf8` to override this.
+
+	With `--no-utf8', pass `-n` flag to 'git mailinfo' (see
+	linkgit:git-mailinfo[1]).
+
+--skip::
+	Skip the current patch.  This is only meaningful when
+	restarting an aborted patch.
+
+(<mbox>|<Maildir>)...::
+	The list of mailbox files to read patches from. If you do not
+	supply this argument, the command reads from the standard input.
+	If you supply directories, they will be treated as Maildirs.
+
=20
 DISCUSSION
 ----------
--=20
1.7.2.3
