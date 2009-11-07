From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 2/4] format-patch documentation: Remove diff options that
 are not useful
Date: Sat, 07 Nov 2009 10:52:29 +0100
Message-ID: <4AF5435D.9050702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 07 10:52:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6hyL-0002vU-Qp
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 10:52:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbZKGJw1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Nov 2009 04:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbZKGJw1
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Nov 2009 04:52:27 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:38072 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbZKGJw0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2009 04:52:26 -0500
Received: by ewy3 with SMTP id 3so1772791ewy.37
        for <git@vger.kernel.org>; Sat, 07 Nov 2009 01:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=9HgIE6y4yJ2dXEkUM4F3LP+YoCuM9UjIiNxZCtO5wCI=;
        b=bS7zVdYpX5D6DunqX8VwkoDToheiwDGsvll5sdUgnX2Hj/QbeXJtsTCU/FTytm6iie
         j04taVn6qOmqh7nssCIhvFPKCMEZB6TCwnYELafF+/uBzTfZ9AfoK9dp7eqSUNHyiZFL
         NWAR7EC0jQfbfN2u/aOdt2EMZh7NobG8UTJfs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=CI4OO8q1wzqlO1+yQVgGkQlmQNzRlODmc75DVLDvlGFqecXSb2LBY4Nh54Nzqdz8bt
         L4Nry6WPVJ6M64BP2pEwfcViL/5NCqVP44aHQxml02/71jwZ9CxLUbStm49RPbl6v2e1
         bM8wDzCVnjzPNjV6Y0r8Y4or5AwqcwsPejaFs=
Received: by 10.213.55.70 with SMTP id t6mr589117ebg.11.1257587550640;
        Sat, 07 Nov 2009 01:52:30 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 23sm816836eya.44.2009.11.07.01.52.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Nov 2009 01:52:30 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132356>

To simplify reading the documentation for format-patch, remove the
description of common diff options that are not useful for the
purpose of the command (i.e. "Prepare patches for e-mail submission").

Specifically, this removes the description of the following options:

  --raw
  -z
  --color
  --no-color
  --color-words
  --diff-filter
  -S
  --pickaxe-all
  --pickaxe-regex
  -R
  --relative
  --exit-code
  --quiet

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 Documentation/diff-options.txt |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
index c58d085..a03f1a7 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -32,9 +32,11 @@ ifndef::git-format-patch[]
 	Implies "-p".
 endif::git-format-patch[]
=20
+ifndef::git-format-patch[]
 --raw::
 	Generate the raw format.
 	{git-diff-core? This is the default.}
+endif::git-format-patch[]
=20
 ifndef::git-format-patch[]
 --patch-with-raw::
@@ -81,19 +83,18 @@ ifndef::git-format-patch[]
 	Synonym for "-p --stat".
 endif::git-format-patch[]
=20
+ifndef::git-format-patch[]
 -z::
 	NUL-line termination on output.  This affects the --raw
 	output field terminator.  Also output from commands such
 	as "git-log" will be delimited with NUL between commits.
=20
-ifndef::git-format-patch[]
 --name-only::
 	Show only names of changed files.
=20
 --name-status::
 	Show only names and status of changed files. See the description
 	of the `--diff-filter` option on what the status letters mean.
-endif::git-format-patch[]
=20
 --color::
 	Show colored diff.
@@ -118,6 +119,7 @@ The regex can also be set via a diff driver or conf=
iguration option, see
 linkgit:gitattributes[1] or linkgit:git-config[1].  Giving it explicit=
ly
 overrides any diff driver or configuration setting.  Diff drivers
 override configuration settings.
+endif::git-format-patch[]
=20
 --no-renames::
 	Turn off rename detection, even when the configuration
@@ -157,6 +159,7 @@ endif::git-format-patch[]
 -C::
 	Detect copies as well as renames.  See also `--find-copies-harder`.
=20
+ifndef::git-format-patch[]
 --diff-filter=3D[ACDMRTUXB*]::
 	Select only files that are Added (`A`), Copied (`C`),
 	Deleted (`D`), Modified (`M`), Renamed (`R`), have their
@@ -168,6 +171,7 @@ endif::git-format-patch[]
 	paths are selected if there is any file that matches
 	other criteria in the comparison; if there is no file
 	that matches other criteria, nothing is selected.
+endif::git-format-patch[]
=20
 --find-copies-harder::
 	For performance reasons, by default, `-C` option finds copies only
@@ -185,6 +189,7 @@ endif::git-format-patch[]
 	the number of rename/copy targets exceeds the specified
 	number.
=20
+ifndef::git-format-patch[]
 -S<string>::
 	Look for differences that introduce or remove an instance of
 	<string>. Note that this is different than the string simply
@@ -199,11 +204,13 @@ endif::git-format-patch[]
 --pickaxe-regex::
 	Make the <string> not a plain string but an extended POSIX
 	regex to match.
+endif::git-format-patch[]
=20
 -O<orderfile>::
 	Output the patch in the order specified in the
 	<orderfile>, which has one shell glob pattern per line.
=20
+ifndef::git-format-patch[]
 -R::
 	Swap two inputs; that is, show differences from index or
 	on-disk file to tree contents.
@@ -215,6 +222,7 @@ endif::git-format-patch[]
 	not in a subdirectory (e.g. in a bare repository), you
 	can name which subdirectory to make the output relative
 	to by giving a <path> as an argument.
+endif::git-format-patch[]
=20
 -a::
 --text::
@@ -239,6 +247,7 @@ endif::git-format-patch[]
 	Show the context between diff hunks, up to the specified number
 	of lines, thereby fusing hunks that are close to each other.
=20
+ifndef::git-format-patch[]
 --exit-code::
 	Make the program exit with codes similar to diff(1).
 	That is, it exits with 1 if there were differences and
@@ -246,6 +255,7 @@ endif::git-format-patch[]
=20
 --quiet::
 	Disable all output of the program. Implies --exit-code.
+endif::git-format-patch[]
=20
 --ext-diff::
 	Allow an external diff helper to be executed. If you set an
--=20
1.6.5.1.69.g36942
