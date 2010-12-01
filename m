From: jari.aalto@cante.net
Subject: [PATCH] git-ls-files.txt: order options alphabetically
Date: Wed,  1 Dec 2010 22:31:29 +0200
Organization: Private
Message-ID: <1291235489-21802-1-git-send-email-jari.aalto@cante.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Cc: Jari Aalto <jari.aalto@cante.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 21:31:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNtLH-0000uN-Hz
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 21:31:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756960Ab0LAUbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 15:31:33 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:54517 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755529Ab0LAUbc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 15:31:32 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 04A178C6A6
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 22:31:31 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A024C401269; Wed, 01 Dec 2010 22:31:31 +0200
Received: from picasso.cante.net (a91-155-187-216.elisa-laajakaista.fi [91.155.187.216])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id D8AEE41BE5
	for <git@vger.kernel.org>; Wed,  1 Dec 2010 22:31:29 +0200 (EET)
Received: from [192.168.1.5] (helo=picasso.cante.net)
	by picasso.cante.net with esmtp (Exim 4.72)
	(envelope-from <jari.aalto@cante.net>)
	id 1PNtKr-0005g4-9p; Wed, 01 Dec 2010 22:31:29 +0200
X-Mailer: git-send-email 1.7.2.3
X-SA-Exim-Connect-IP: 192.168.1.5
X-SA-Exim-Mail-From: jari.aalto@cante.net
X-SA-Exim-Scanned: No (on picasso.cante.net); SAEximRunCond expanded to false
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162604>

From: Jari Aalto <jari.aalto@cante.net>


Signed-off-by: Jari Aalto <jari.aalto@cante.net>
---
 Documentation/git-ls-files.txt |  123 ++++++++++++++++++++--------------=
------
 1 files changed, 62 insertions(+), 61 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.=
txt
index 86abd13..4b88940 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -30,6 +30,15 @@ shown:
=20
 OPTIONS
 -------
+
+\--::
+	Do not interpret any more arguments as options.
+
+--abbrev[=3D<n>]::
+	Instead of showing the full 40-byte hexadecimal object
+	lines, show only a partial prefix.
+	Non default number of digits can be specified with --abbrev=3D<n>.
+
 -c::
 --cached::
 	Show cached files in the output (default)
@@ -38,53 +47,32 @@ OPTIONS
 --deleted::
 	Show deleted files in the output
=20
--m::
---modified::
-	Show modified files in the output
-
--o::
---others::
-	Show other (i.e. untracked) files in the output
-
--i::
---ignored::
-	Show only ignored files in the output. When showing files in the
-	index, print only those matched by an exclude pattern. When
-	showing "other" files, show only those matched by an exclude
-	pattern.
-
--s::
---stage::
-	Show staged contents' object name, mode bits and stage number in the ou=
tput.
+--debug::
+	After each line that describes a file, add more data about its
+	cache entry.  This is intended to show as much information as
+	possible for manual inspection; the exact format may change at
+	any time.
=20
 --directory::
+--no-empty-directory::
 	If a whole directory is classified as "other", show just its
 	name (with a trailing slash) and not its whole contents.
=20
---no-empty-directory::
-	Do not list empty directories. Has no effect without --directory.
-
--u::
---unmerged::
-	Show unmerged files in the output (forces --stage)
+	Alternatively do not list empty directories. Has no effect
+	without `--directory'.
=20
--k::
---killed::
-	Show files on the filesystem that need to be removed due
-	to file/directory conflicts for checkout-index to
-	succeed.
-
--z::
-	\0 line termination on output.
+--error-unmatch::
+	If any <file> does not appear in the index, treat this as an
+	error (return 1).
=20
--x <pattern>::
 --exclude=3D<pattern>::
+-x <pattern>::
 	Skip untracked files matching pattern.
 	Note that pattern is a shell wildcard pattern. See EXCLUDE PATTERNS
 	below for more information.
=20
--X <file>::
 --exclude-from=3D<file>::
+-X <file>::
 	Read exclude patterns from <file>; 1 per line.
=20
 --exclude-per-directory=3D<file>::
@@ -95,16 +83,36 @@ OPTIONS
 	Add the standard git exclusions: .git/info/exclude, .gitignore
 	in each directory, and the user's global exclusion file.
=20
---error-unmatch::
-	If any <file> does not appear in the index, treat this as an
-	error (return 1).
+--full-name::
+	When run from a subdirectory, the command usually
+	outputs paths relative to the current directory.  This
+	option forces paths to be output relative to the project
+	top directory.
=20
---with-tree=3D<tree-ish>::
-	When using --error-unmatch to expand the user supplied
-	<file> (i.e. path pattern) arguments to paths, pretend
-	that paths which were removed in the index since the
-	named <tree-ish> are still present.  Using this option
-	with `-s` or `-u` options does not make any sense.
+-i::
+--ignored::
+	Show only ignored files in the output. When showing files in the
+	index, print only those matched by an exclude pattern. When
+	showing "other" files, show only those matched by an exclude
+	pattern.
+
+-k::
+--killed::
+	Show files on the filesystem that need to be removed due
+	to file/directory conflicts for checkout-index to
+	succeed.
+
+-m::
+--modified::
+	Show modified files in the output
+
+-o::
+--others::
+	Show other (i.e. untracked) files in the output
+
+-s::
+--stage::
+	Show staged contents' object name, mode bits and stage number in the ou=
tput.
=20
 -t::
 	This feature is semi-deprecated. For scripting purpose,
@@ -124,31 +132,24 @@ a space) at the start of each line:
 	C::	modified/changed
 	K::	to be killed
 	?::	other
+-u::
+--unmerged::
+	Show unmerged files in the output (forces --stage)
=20
 -v::
 	Similar to `-t`, but use lowercase letters for files
 	that are marked as 'assume unchanged' (see
 	linkgit:git-update-index[1]).
=20
---full-name::
-	When run from a subdirectory, the command usually
-	outputs paths relative to the current directory.  This
-	option forces paths to be output relative to the project
-	top directory.
-
---abbrev[=3D<n>]::
-	Instead of showing the full 40-byte hexadecimal object
-	lines, show only a partial prefix.
-	Non default number of digits can be specified with --abbrev=3D<n>.
-
---debug::
-	After each line that describes a file, add more data about its
-	cache entry.  This is intended to show as much information as
-	possible for manual inspection; the exact format may change at
-	any time.
+--with-tree=3D<tree-ish>::
+	When using --error-unmatch to expand the user supplied
+	<file> (i.e. path pattern) arguments to paths, pretend
+	that paths which were removed in the index since the
+	named <tree-ish> are still present.  Using this option
+	with `-s` or `-u` options does not make any sense.
=20
-\--::
-	Do not interpret any more arguments as options.
+-z::
+	\0 line termination on output.
=20
 <file>::
 	Files to show. If no files are given all files which match the other
--=20
1.7.2.3
