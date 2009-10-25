From: =?ISO-8859-1?Q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: [PATCH 3/3] format-patch documentation: Fix formatting
Date: Sun, 25 Oct 2009 16:56:54 +0100
Message-ID: <4AE47546.6040804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 16:57:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N25Sp-0005vb-Bn
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 16:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbZJYP4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2009 11:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753221AbZJYP4x
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 11:56:53 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:42963 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbZJYP4w (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2009 11:56:52 -0400
Received: by ewy4 with SMTP id 4so2960488ewy.37
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 08:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=ah3or6yx7hV5H/EDsshjNgT+leezq+afoK8YCAmiVRs=;
        b=GuaO/6hhOEodZf7FRSKg42Tr8BHi63yuR3frPTyWPoMxHfOR7xdMLq1DaVMrqAY9eu
         g1PdqndVtETXPPj/UcOLAuSyJE/SLtUXh8tS6VzS1Ds8OrZRh5Pq+5yqoL6a7PRm/HA4
         O8AuR4AtD8B6a/efvuV0Cv8wy6AHuHbqI6KD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=gWX5yCEeky7nnKZQiYt0KwYYb2gFemT0RJTC6J+uYCyCQ3cu0orXLfIh8zSPJoWbSi
         YavsFerjk0jzhHQeTw83rXolkzLEGZ0/GhQAHNYzAhctjlJajEqumGSD9layykDkytCI
         elwIDVvAIt4UmcKVXgnsyMaTxwt8VgkfSXmVA=
Received: by 10.211.129.8 with SMTP id g8mr14820684ebn.71.1256486216266;
        Sun, 25 Oct 2009 08:56:56 -0700 (PDT)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 28sm1245844eye.39.2009.10.25.08.56.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Oct 2009 08:56:55 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131218>

Format git commands and options consistently using back quotes
(i.e. a fixed font in the resulting HTML document).
---
 Documentation/diff-options.txt     |   26 ++++++++++----------
 Documentation/git-format-patch.txt |   44 ++++++++++++++++++------------------
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 88e88d7..86d3d80 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -24,7 +24,7 @@ endif::git-format-patch[]
 	Generate diffs with <n> lines of context instead of
 	the usual three.
 ifndef::git-format-patch[]
-	Implies "-p".
+	Implies `-p`.
 endif::git-format-patch[]
 
 ifndef::git-format-patch[]
@@ -35,7 +35,7 @@ endif::git-format-patch[]
 
 ifndef::git-format-patch[]
 --patch-with-raw::
-	Synonym for "-p --raw".
+	Synonym for `-p --raw`.
 endif::git-format-patch[]
 
 --patience::
@@ -67,7 +67,7 @@ endif::git-format-patch[]
 	counted for the parent directory, unless "--cumulative" is used.
 
 --dirstat-by-file[=limit]::
-	Same as --dirstat, but counts changed files instead of lines.
+	Same as `--dirstat`, but counts changed files instead of lines.
 
 --summary::
 	Output a condensed summary of extended header information
@@ -75,14 +75,14 @@ endif::git-format-patch[]
 
 ifndef::git-format-patch[]
 --patch-with-stat::
-	Synonym for "-p --stat".
+	Synonym for `-p --stat`.
 endif::git-format-patch[]
 
 ifndef::git-format-patch[]
 -z::
-	NUL-line termination on output.  This affects the --raw
+	NUL-line termination on output.  This affects the `--raw`
 	output field terminator.  Also output from commands such
-	as "git-log" will be delimited with NUL between commits.
+	as `git-log` will be delimited with NUL between commits.
 
 --name-only::
 	Show only names of changed files.
@@ -133,16 +133,16 @@ endif::git-format-patch[]
 	line when generating patch format output.
 
 --binary::
-	In addition to --full-index, output "binary diff" that
-	can be applied with "git apply".
+	In addition to `--full-index`, output a binary diff that
+	can be applied with `git-apply`.
 
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
 	name in diff-raw format output and diff-tree header
 	lines, show only a partial prefix.  This is
-	independent of --full-index option above, which controls
+	independent of the `--full-index` option above, which controls
 	the diff-patch output format.  Non default number of
-	digits can be specified with --abbrev=<n>.
+	digits can be specified with `--abbrev=<n>`.
 
 -B::
 	Break complete rewrite changes into pairs of delete and create.
@@ -177,7 +177,7 @@ endif::git-format-patch[]
 	`-C` option has the same effect.
 
 -l<num>::
-	-M and -C options require O(n^2) processing time where n
+	The `-M` and `-C` options require O(n^2) processing time where n
 	is the number of potential rename/copy targets.  This
 	option prevents rename/copy detection from running if
 	the number of rename/copy targets exceeds the specified
@@ -191,7 +191,7 @@ ifndef::git-format-patch[]
 	linkgit:gitdiffcore[7] for more details.
 
 --pickaxe-all::
-	When -S finds a change, show all the changes in that
+	When `-S` finds a change, show all the changes in that
 	changeset, not just the files that contain the change
 	in <string>.
 
@@ -248,7 +248,7 @@ ifndef::git-format-patch[]
 	0 means no differences.
 
 --quiet::
-	Disable all output of the program. Implies --exit-code.
+	Disable all output of the program. Implies `--exit-code`.
 endif::git-format-patch[]
 
 --ext-diff::
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 687e667..79d77f7 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -43,28 +43,28 @@ There are two ways to specify which commits to operate on.
 
 The first rule takes precedence in the case of a single <commit>.  To
 apply the second rule, i.e., format everything since the beginning of
-history up until <commit>, use the '\--root' option: "git format-patch
-\--root <commit>".  If you want to format only <commit> itself, you
-can do this with "git format-patch -1 <commit>".
+history up until <commit>, use the '\--root' option: `git format-patch
+\--root <commit>`.  If you want to format only <commit> itself, you
+can do this with `git format-patch -1 <commit>`.
 
 By default, each output file is numbered sequentially from 1, and uses the
 first line of the commit message (massaged for pathname safety) as
-the filename. With the --numbered-files option, the output file names
+the filename. With the `--numbered-files` option, the output file names
 will only be numbers, without the first line of the commit appended.
 The names of the output files are printed to standard
-output, unless the --stdout option is specified.
+output, unless the `--stdout` option is specified.
 
-If -o is specified, output files are created in <dir>.  Otherwise
+If `-o` is specified, output files are created in <dir>.  Otherwise
 they are created in the current working directory.
 
 By default, the subject of a single patch is "[PATCH] First Line" and
 the subject when multiple patches are output is "[PATCH n/m] First
-Line". To force 1/1 to be added for a single patch, use -n.  To omit
-patch numbers from the subject, use -N
+Line". To force 1/1 to be added for a single patch, use `-n`.  To omit
+patch numbers from the subject, use `-N`.
 
-If given --thread, 'git-format-patch' will generate In-Reply-To and
-References headers to make the second and subsequent patch mails appear
-as replies to the first mail; this also generates a Message-Id header to
+If given `--thread`, `git-format-patch` will generate `In-Reply-To` and
+`References` headers to make the second and subsequent patch mails appear
+as replies to the first mail; this also generates a `Message-Id` header to
 reference.
 
 OPTIONS
@@ -112,7 +112,7 @@ include::diff-options.txt[]
 --attach[=<boundary>]::
 	Create multipart/mixed attachment, the first part of
 	which is the commit message and the patch itself in the
-	second part, with "Content-Disposition: attachment".
+	second part, with `Content-Disposition: attachment`.
 
 --no-attach::
 	Disable the creation of an attachment, overriding the
@@ -121,13 +121,13 @@ include::diff-options.txt[]
 --inline[=<boundary>]::
 	Create multipart/mixed attachment, the first part of
 	which is the commit message and the patch itself in the
-	second part, with "Content-Disposition: inline".
+	second part, with `Content-Disposition: inline`.
 
 --thread[=<style>]::
 --no-thread::
-	Controls addition of In-Reply-To and References headers to
+	Controls addition of `In-Reply-To` and `References` headers to
 	make the second and subsequent mails appear as replies to the
-	first.  Also controls generation of the Message-Id header to
+	first.  Also controls generation of the `Message-Id` header to
 	reference.
 +
 The optional <style> argument can be either `shallow` or `deep`.
@@ -136,16 +136,16 @@ series, where the head is chosen from the cover letter, the
 `\--in-reply-to`, and the first patch mail, in this order.  'deep'
 threading makes every mail a reply to the previous one.
 +
-The default is --no-thread, unless the 'format.thread' configuration
-is set.  If --thread is specified without a style, it defaults to the
+The default is `--no-thread`, unless the 'format.thread' configuration
+is set.  If `--thread` is specified without a style, it defaults to the
 style specified by 'format.thread' if any, or else `shallow`.
 +
 Beware that the default for 'git send-email' is to thread emails
-itself.  If you want 'git format-patch' to take care of hreading, you
-will want to ensure that threading is disabled for 'git send-email'.
+itself.  If you want `git format-patch` to take care of threading, you
+will want to ensure that threading is disabled for `git send-email`.
 
 --in-reply-to=Message-Id::
-	Make the first mail (or all the mails with --no-thread) appear as a
+	Make the first mail (or all the mails with `--no-thread`) appear as a
 	reply to the given Message-Id, which avoids breaking threads to
 	provide a new patch series.
 
@@ -163,13 +163,13 @@ will want to ensure that threading is disabled for 'git send-email'.
 	combined with the --numbered option.
 
 --cc=<email>::
-	Add a "Cc:" header to the email headers. This is in addition
+	Add a `Cc:` header to the email headers. This is in addition
 	to any configured headers, and may be used multiple times.
 
 --add-header=<header>::
 	Add an arbitrary header to the email headers.  This is in addition
 	to any configured headers, and may be used multiple times.
-	For example, --add-header="Organization: git-foo"
+	For example, `--add-header="Organization: git-foo"`
 
 --cover-letter::
 	In addition to the patches, generate a cover letter file
-- 
1.6.5.1.69.g36942
