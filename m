From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 3/4] format-patch documentation: Fix formatting
Date: Sat, 07 Nov 2009 10:53:07 +0100
Message-ID: <4AF54383.70406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 07 10:53:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6hyy-0003CZ-UP
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 10:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbZKGJxK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Nov 2009 04:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbZKGJxJ
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 04:53:09 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:48614 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318AbZKGJxH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2009 04:53:07 -0500
Received: by ewy3 with SMTP id 3so1773004ewy.37
        for <git@vger.kernel.org>; Sat, 07 Nov 2009 01:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=PT2FNwwFyhHMiifOLgX1LLAWFnZ7gZeVeRHWn+x238g=;
        b=jOKyJ0v16q+q7oL9Bs7nXdKE4s3JWu/I63LNeXWyKybUZ5qm4neWSKvGTsHFhAmqn9
         XTtjeZ+OicaxYo/9mxnlBBVXZM1HsiQkC6keze3UaOjx95Rmf5zYh5wdxmheDzwyrPU4
         ZF46UeC/PtAhEYB8MidatIDlhpo2QxdGqVkHA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=YkeSscDGzh8rIpIP39puteagsUvXj4EARFVp5U/VKGa5BnRmmV7lsfWhm+Xz16XzFO
         kYv81lKLnSNxk+9WKcMb+vTdIWjy1VY8yFY3oY55I0X508LtxeRBOgkTKF0nHPd7OsWz
         YLwFHzX0ZMeDvHhlDmzWmR03uL/FceXwXcBWQ=
Received: by 10.213.23.204 with SMTP id s12mr6226763ebb.69.1257587590482;
        Sat, 07 Nov 2009 01:53:10 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 23sm826674eya.28.2009.11.07.01.53.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Nov 2009 01:53:09 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132357>

=46ormat git commands and options consistently using back quotes
(i.e. a fixed font in the resulting HTML document).

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 Documentation/diff-options.txt     |   36 ++++++++++++++--------------
 Documentation/git-format-patch.txt |   46 ++++++++++++++++++----------=
--------
 2 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index a03f1a7..9398329 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -29,7 +29,7 @@ endif::git-format-patch[]
 	Generate diffs with <n> lines of context instead of
 	the usual three.
 ifndef::git-format-patch[]
-	Implies "-p".
+	Implies `-p`.
 endif::git-format-patch[]
=20
 ifndef::git-format-patch[]
@@ -40,7 +40,7 @@ endif::git-format-patch[]
=20
 ifndef::git-format-patch[]
 --patch-with-raw::
-	Synonym for "-p --raw".
+	Synonym for `-p --raw`.
 endif::git-format-patch[]
=20
 --patience::
@@ -48,19 +48,19 @@ endif::git-format-patch[]
=20
 --stat[=3Dwidth[,name-width]]::
 	Generate a diffstat.  You can override the default
-	output width for 80-column terminal by "--stat=3Dwidth".
+	output width for 80-column terminal by `--stat=3Dwidth`.
 	The width of the filename part can be controlled by
 	giving another width to it separated by a comma.
=20
 --numstat::
-	Similar to \--stat, but shows number of added and
+	Similar to `\--stat`, but shows number of added and
 	deleted lines in decimal notation and pathname without
 	abbreviation, to make it more machine friendly.  For
 	binary files, outputs two `-` instead of saying
 	`0 0`.
=20
 --shortstat::
-	Output only the last line of the --stat format containing total
+	Output only the last line of the `--stat` format containing total
 	number of modified files, as well as number of added and deleted
 	lines.
=20
@@ -68,11 +68,11 @@ endif::git-format-patch[]
 	Output the distribution of relative amount of changes (number of line=
s added or
 	removed) for each sub-directory. Directories with changes below
 	a cut-off percent (3% by default) are not shown. The cut-off percent
-	can be set with "--dirstat=3Dlimit". Changes in a child directory is =
not
-	counted for the parent directory, unless "--cumulative" is used.
+	can be set with `--dirstat=3Dlimit`. Changes in a child directory is =
not
+	counted for the parent directory, unless `--cumulative` is used.
=20
 --dirstat-by-file[=3Dlimit]::
-	Same as --dirstat, but counts changed files instead of lines.
+	Same as `--dirstat`, but counts changed files instead of lines.
=20
 --summary::
 	Output a condensed summary of extended header information
@@ -80,14 +80,14 @@ endif::git-format-patch[]
=20
 ifndef::git-format-patch[]
 --patch-with-stat::
-	Synonym for "-p --stat".
+	Synonym for `-p --stat`.
 endif::git-format-patch[]
=20
 ifndef::git-format-patch[]
 -z::
-	NUL-line termination on output.  This affects the --raw
+	NUL-line termination on output.  This affects the `--raw`
 	output field terminator.  Also output from commands such
-	as "git-log" will be delimited with NUL between commits.
+	as `git-log` will be delimited with NUL between commits.
=20
 --name-only::
 	Show only names of changed files.
@@ -139,16 +139,16 @@ endif::git-format-patch[]
 	line when generating patch format output.
=20
 --binary::
-	In addition to --full-index, output "binary diff" that
-	can be applied with "git apply".
+	In addition to `--full-index`, output a binary diff that
+	can be applied with `git-apply`.
=20
 --abbrev[=3D<n>]::
 	Instead of showing the full 40-byte hexadecimal object
 	name in diff-raw format output and diff-tree header
 	lines, show only a partial prefix.  This is
-	independent of --full-index option above, which controls
+	independent of the `--full-index` option above, which controls
 	the diff-patch output format.  Non default number of
-	digits can be specified with --abbrev=3D<n>.
+	digits can be specified with `--abbrev=3D<n>`.
=20
 -B::
 	Break complete rewrite changes into pairs of delete and create.
@@ -183,7 +183,7 @@ endif::git-format-patch[]
 	`-C` option has the same effect.
=20
 -l<num>::
-	-M and -C options require O(n^2) processing time where n
+	The `-M` and `-C` options require O(n^2) processing time where n
 	is the number of potential rename/copy targets.  This
 	option prevents rename/copy detection from running if
 	the number of rename/copy targets exceeds the specified
@@ -197,7 +197,7 @@ ifndef::git-format-patch[]
 	linkgit:gitdiffcore[7] for more details.
=20
 --pickaxe-all::
-	When -S finds a change, show all the changes in that
+	When `-S` finds a change, show all the changes in that
 	changeset, not just the files that contain the change
 	in <string>.
=20
@@ -254,7 +254,7 @@ ifndef::git-format-patch[]
 	0 means no differences.
=20
 --quiet::
-	Disable all output of the program. Implies --exit-code.
+	Disable all output of the program. Implies `--exit-code`.
 endif::git-format-patch[]
=20
 --ext-diff::
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-for=
mat-patch.txt
index 687e667..f1fd0df 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -43,28 +43,28 @@ There are two ways to specify which commits to oper=
ate on.
=20
 The first rule takes precedence in the case of a single <commit>.  To
 apply the second rule, i.e., format everything since the beginning of
-history up until <commit>, use the '\--root' option: "git format-patch
-\--root <commit>".  If you want to format only <commit> itself, you
-can do this with "git format-patch -1 <commit>".
+history up until <commit>, use the '\--root' option: `git format-patch
+\--root <commit>`.  If you want to format only <commit> itself, you
+can do this with `git format-patch -1 <commit>`.
=20
 By default, each output file is numbered sequentially from 1, and uses=
 the
 first line of the commit message (massaged for pathname safety) as
-the filename. With the --numbered-files option, the output file names
+the filename. With the `--numbered-files` option, the output file name=
s
 will only be numbers, without the first line of the commit appended.
 The names of the output files are printed to standard
-output, unless the --stdout option is specified.
+output, unless the `--stdout` option is specified.
=20
-If -o is specified, output files are created in <dir>.  Otherwise
+If `-o` is specified, output files are created in <dir>.  Otherwise
 they are created in the current working directory.
=20
 By default, the subject of a single patch is "[PATCH] First Line" and
 the subject when multiple patches are output is "[PATCH n/m] First
-Line". To force 1/1 to be added for a single patch, use -n.  To omit
-patch numbers from the subject, use -N
+Line". To force 1/1 to be added for a single patch, use `-n`.  To omit
+patch numbers from the subject, use `-N`.
=20
-If given --thread, 'git-format-patch' will generate In-Reply-To and
-References headers to make the second and subsequent patch mails appea=
r
-as replies to the first mail; this also generates a Message-Id header =
to
+If given `--thread`, `git-format-patch` will generate `In-Reply-To` an=
d
+`References` headers to make the second and subsequent patch mails app=
ear
+as replies to the first mail; this also generates a `Message-Id` heade=
r to
 reference.
=20
 OPTIONS
@@ -112,7 +112,7 @@ include::diff-options.txt[]
 --attach[=3D<boundary>]::
 	Create multipart/mixed attachment, the first part of
 	which is the commit message and the patch itself in the
-	second part, with "Content-Disposition: attachment".
+	second part, with `Content-Disposition: attachment`.
=20
 --no-attach::
 	Disable the creation of an attachment, overriding the
@@ -121,13 +121,13 @@ include::diff-options.txt[]
 --inline[=3D<boundary>]::
 	Create multipart/mixed attachment, the first part of
 	which is the commit message and the patch itself in the
-	second part, with "Content-Disposition: inline".
+	second part, with `Content-Disposition: inline`.
=20
 --thread[=3D<style>]::
 --no-thread::
-	Controls addition of In-Reply-To and References headers to
+	Controls addition of `In-Reply-To` and `References` headers to
 	make the second and subsequent mails appear as replies to the
-	first.  Also controls generation of the Message-Id header to
+	first.  Also controls generation of the `Message-Id` header to
 	reference.
 +
 The optional <style> argument can be either `shallow` or `deep`.
@@ -136,16 +136,16 @@ series, where the head is chosen from the cover l=
etter, the
 `\--in-reply-to`, and the first patch mail, in this order.  'deep'
 threading makes every mail a reply to the previous one.
 +
-The default is --no-thread, unless the 'format.thread' configuration
-is set.  If --thread is specified without a style, it defaults to the
+The default is `--no-thread`, unless the 'format.thread' configuration
+is set.  If `--thread` is specified without a style, it defaults to th=
e
 style specified by 'format.thread' if any, or else `shallow`.
 +
 Beware that the default for 'git send-email' is to thread emails
-itself.  If you want 'git format-patch' to take care of hreading, you
-will want to ensure that threading is disabled for 'git send-email'.
+itself.  If you want `git format-patch` to take care of threading, you
+will want to ensure that threading is disabled for `git send-email`.
=20
 --in-reply-to=3DMessage-Id::
-	Make the first mail (or all the mails with --no-thread) appear as a
+	Make the first mail (or all the mails with `--no-thread`) appear as a
 	reply to the given Message-Id, which avoids breaking threads to
 	provide a new patch series.
=20
@@ -160,16 +160,16 @@ will want to ensure that threading is disabled fo=
r 'git send-email'.
 	Instead of the standard '[PATCH]' prefix in the subject
 	line, instead use '[<Subject-Prefix>]'. This
 	allows for useful naming of a patch series, and can be
-	combined with the --numbered option.
+	combined with the `--numbered` option.
=20
 --cc=3D<email>::
-	Add a "Cc:" header to the email headers. This is in addition
+	Add a `Cc:` header to the email headers. This is in addition
 	to any configured headers, and may be used multiple times.
=20
 --add-header=3D<header>::
 	Add an arbitrary header to the email headers.  This is in addition
 	to any configured headers, and may be used multiple times.
-	For example, --add-header=3D"Organization: git-foo"
+	For example, `--add-header=3D"Organization: git-foo"`
=20
 --cover-letter::
 	In addition to the patches, generate a cover letter file
--=20
1.6.5.1.69.g36942
