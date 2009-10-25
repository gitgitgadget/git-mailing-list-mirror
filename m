From: =?ISO-8859-1?Q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: [PATCH 2/3] format-patch documentation: Remove diff options that
 are not useful
Date: Sun, 25 Oct 2009 16:56:15 +0100
Message-ID: <4AE4751F.9060300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 16:56:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N25SH-0005fR-Uy
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 16:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbZJYP4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 11:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbZJYP4N
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 11:56:13 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:35140 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbZJYP4M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 11:56:12 -0400
Received: by mail-ew0-f208.google.com with SMTP id 4so2959953ewy.37
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 08:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=R8uoxMWhto176GJOhg2CtxPM5AXQOZHdsA1yu0EiTAI=;
        b=oUrdYHgWhls2gepeiikkFpo379hM9sWWEg22rkiKio5CWK37yEOqmIXxf5AU+EQARx
         Y7kAVMGhk0QvvnykU6J/gmTqLry1GvixSeBDon+ym2FgkCC2F82XE4h+cDM03g/DSmD1
         SiIB1QpYpuGdzdhYwDlWrI/GC2YQjtpvCzOGs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=BA4+tof7aFq6fRg1bqT6vvb/w6fTZ7Qs34Kl4K8GKgogAQmDcddvQ3AVtvCBjXJqP3
         Aaihs5tsGln833yvMuF1oKfUHTVTUCCrAvuX8fmUrdOWr4WENqHjBSsn7K4mlpWX7I7Y
         xKlYA8E+uljYkKYtCW+lv95m/VDq+ImP2zOkA=
Received: by 10.211.147.12 with SMTP id z12mr5320244ebn.37.1256486176610;
        Sun, 25 Oct 2009 08:56:16 -0700 (PDT)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 5sm10059552eyh.2.2009.10.25.08.56.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 08:56:16 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131217>

To simplify reading the documentation for format-patch, remove the
description of common diff options that are not useful for the
purpose of the command (i.e. "Prepare patches for e-mail submission").

Remove the description of the following options:

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
---
 Documentation/diff-options.txt |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 673fbb0..88e88d7 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -27,9 +27,11 @@ ifndef::git-format-patch[]
 	Implies "-p".
 endif::git-format-patch[]
 
+ifndef::git-format-patch[]
 --raw::
 	Generate the raw format.
 	{git-diff-core? This is the default.}
+endif::git-format-patch[]
 
 ifndef::git-format-patch[]
 --patch-with-raw::
@@ -76,20 +78,18 @@ ifndef::git-format-patch[]
 	Synonym for "-p --stat".
 endif::git-format-patch[]
 
+ifndef::git-format-patch[]
 -z::
 	NUL-line termination on output.  This affects the --raw
 	output field terminator.  Also output from commands such
 	as "git-log" will be delimited with NUL between commits.
 
-ifndef::git-format-patch[]
 --name-only::
 	Show only names of changed files.
 
 --name-status::
 	Show only names and status of changed files. See the description
 	of the `--diff-filter` option on what the status letters mean.
-endif::git-format-patch[]
-
 --color::
 	Show colored diff.
 
@@ -113,6 +113,7 @@ The regex can also be set via a diff driver or configuration option, see
 linkgit:gitattributes[1] or linkgit:git-config[1].  Giving it explicitly
 overrides any diff driver or configuration setting.  Diff drivers
 override configuration settings.
+endif::git-format-patch[]
 
 --no-renames::
 	Turn off rename detection, even when the configuration
@@ -152,6 +153,7 @@ endif::git-format-patch[]
 -C::
 	Detect copies as well as renames.  See also `--find-copies-harder`.
 
+ifndef::git-format-patch[]
 --diff-filter=[ACDMRTUXB*]::
 	Select only files that are Added (`A`), Copied (`C`),
 	Deleted (`D`), Modified (`M`), Renamed (`R`), have their
@@ -163,6 +165,7 @@ endif::git-format-patch[]
 	paths are selected if there is any file that matches
 	other criteria in the comparison; if there is no file
 	that matches other criteria, nothing is selected.
+endif::git-format-patch[]
 
 --find-copies-harder::
 	For performance reasons, by default, `-C` option finds copies only
@@ -180,6 +183,7 @@ endif::git-format-patch[]
 	the number of rename/copy targets exceeds the specified
 	number.
 
+ifndef::git-format-patch[]
 -S<string>::
 	Look for differences that introduce or remove an instance of
 	<string>. Note that this is different than the string simply
@@ -194,11 +198,13 @@ endif::git-format-patch[]
 --pickaxe-regex::
 	Make the <string> not a plain string but an extended POSIX
 	regex to match.
+endif::git-format-patch[]
 
 -O<orderfile>::
 	Output the patch in the order specified in the
 	<orderfile>, which has one shell glob pattern per line.
 
+ifndef::git-format-patch[]
 -R::
 	Swap two inputs; that is, show differences from index or
 	on-disk file to tree contents.
@@ -210,6 +216,7 @@ endif::git-format-patch[]
 	not in a subdirectory (e.g. in a bare repository), you
 	can name which subdirectory to make the output relative
 	to by giving a <path> as an argument.
+endif::git-format-patch[]
 
 -a::
 --text::
@@ -234,6 +241,7 @@ endif::git-format-patch[]
 	Show the context between diff hunks, up to the specified number
 	of lines, thereby fusing hunks that are close to each other.
 
+ifndef::git-format-patch[]
 --exit-code::
 	Make the program exit with codes similar to diff(1).
 	That is, it exits with 1 if there were differences and
@@ -241,6 +249,7 @@ endif::git-format-patch[]
 
 --quiet::
 	Disable all output of the program. Implies --exit-code.
+endif::git-format-patch[]
 
 --ext-diff::
 	Allow an external diff helper to be executed. If you set an
-- 
1.6.5.1.69.g36942
