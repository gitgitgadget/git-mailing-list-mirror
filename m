From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH] git-clone.txt: Fix grammar and formatting
Date: Tue, 20 Oct 2009 22:38:38 +0200
Message-ID: <4ADE1FCE.5010209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 20 22:38:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0LTi-0002Ja-NJ
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 22:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949AbZJTUih convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 16:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752946AbZJTUih
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 16:38:37 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:39487 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929AbZJTUig (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 16:38:36 -0400
Received: by ewy3 with SMTP id 3so5265359ewy.17
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 13:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=h8lzfgb++CD5lhVo7seZLFhoRxbDHFyCE7meBSlGLAc=;
        b=ReTmCsDU2C0a87r8rTUtTu8O9uiiXlRchorlXtvYMLSOOStpBG334AyFU6JvRacz/T
         E1o9iDiebMpIx8wvruT6XjC0E6o/h85Ne5tVX+00uGAdb+DCtCFoFMBPtcsrD2oTMO73
         lMbZBsbxsywnbWHnBcJzcm2+kwmo3YiZT/5fE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=KXvVTmqqBoXLVUIyrQcmECjc/m8KUefzgdPKIKrxB2kYfHz48FS3biofItVi/G1KJE
         5O7+/2ZCDJeDnYGhEL/bK74V7Xoe+9qN4JObt8FWPAmD8spDiHNP/Tzcocb0hYTZMDXa
         Y/RuhuZj/MhILWWvgIJAFn3SG9Q5zh9EvepLA=
Received: by 10.211.128.6 with SMTP id f6mr7884496ebn.15.1256071119820;
        Tue, 20 Oct 2009 13:38:39 -0700 (PDT)
Received: from bitis.local (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 5sm104337eyh.18.2009.10.20.13.38.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Oct 2009 13:38:39 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130840>

Add the missing definite article ("the") in several places.

Change "note to..." to "note for...", since "note to" means that
that the note is addressed to someone (source: Google search).

Change "progressbar" to "progress bar" (source: Wikipedia).

=46ormat git commands, options, and file names consistently using
back quotes (i.e. a fixed font in the resulting HTML document).

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
I am not a native English speaker, so if my attempted corrections
of the grammar is wrong, please correct me!

 Documentation/git-clone.txt |   26 +++++++++++++-------------
 1 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 5ebcba1..7e7d9fc 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -39,7 +39,7 @@ OPTIONS
 --local::
 -l::
 	When the repository to clone from is on a local machine,
-	this flag bypasses normal "git aware" transport
+	this flag bypasses the normal "git aware" transport
 	mechanism and clones the repository by making a copy of
 	HEAD and everything under objects and refs directories.
 	The files under `.git/objects/` directory are hardlinked
@@ -60,7 +60,7 @@ OPTIONS
 -s::
 	When the repository to clone is on the local machine,
 	instead of using hard links, automatically setup
-	.git/objects/info/alternates to share the objects
+	`.git/objects/info/alternates` to share the objects
 	with the source repository.  The resulting repository
 	starts out without any object of its own.
 +
@@ -69,7 +69,7 @@ it unless you understand what it does. If you clone y=
our
 repository using this option and then delete branches (or use any
 other git command that makes any existing commit unreferenced) in the
 source repository, some objects may become unreferenced (or dangling).
-These objects may be removed by normal git operations (such as 'git-co=
mmit')
+These objects may be removed by normal git operations (such as `git co=
mmit`)
 which automatically call `git gc --auto`. (See linkgit:git-gc[1].)
 If these objects are removed and were referenced by the cloned reposit=
ory,
 then the cloned repository will become corrupt.
@@ -86,13 +86,13 @@ objects from the source repository into a pack in t=
he cloned repository.
=20
 --reference <repository>::
 	If the reference repository is on the local machine,
-	automatically setup .git/objects/info/alternates to
+	automatically setup `.git/objects/info/alternates` to
 	obtain objects from the reference repository.  Using
 	an already existing repository as an alternate will
 	require fewer objects to be copied from the repository
 	being cloned, reducing network and local storage costs.
 +
-*NOTE*: see NOTE to --shared option.
+*NOTE*: see the NOTE for the `--shared` option.
=20
 --quiet::
 -q::
@@ -101,7 +101,7 @@ objects from the source repository into a pack in t=
he cloned repository.
=20
 --verbose::
 -v::
-	Display the progressbar, even in case the standard output is not
+	Display the progress bar, even in case the standard output is not
 	a terminal.
=20
 --no-checkout::
@@ -121,17 +121,17 @@ objects from the source repository into a pack in=
 the cloned repository.
 	configuration variables are created.
=20
 --mirror::
-	Set up a mirror of the remote repository.  This implies --bare.
+	Set up a mirror of the remote repository.  This implies `--bare`.
=20
 --origin <name>::
 -o <name>::
-	Instead of using the remote name 'origin' to keep track
-	of the upstream repository, use <name>.
+	Instead of using the remote name `origin` to keep track
+	of the upstream repository, use `<name>`.
=20
 --branch <name>::
 -b <name>::
 	Instead of pointing the newly created HEAD to the branch pointed
-	to by the cloned repository's HEAD, point to <name> branch
+	to by the cloned repository's HEAD, point to `<name>` branch
 	instead. In a non-bare repository, this is the branch that will
 	be checked out.
=20
@@ -158,7 +158,7 @@ objects from the source repository into a pack in t=
he cloned repository.
 --recursive::
 	After the clone is created, initialize all submodules within,
 	using their default settings. This is equivalent to running
-	'git submodule update --init --recursive' immediately after
+	`git submodule update --init --recursive` immediately after
 	the clone is finished. This option is ignored if the cloned
 	repository does not have a worktree/checkout (i.e. if any of
 	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
@@ -171,8 +171,8 @@ objects from the source repository into a pack in t=
he cloned repository.
 <directory>::
 	The name of a new directory to clone into.  The "humanish"
 	part of the source repository is used if no directory is
-	explicitly given ("repo" for "/path/to/repo.git" and "foo"
-	for "host.xz:foo/.git").  Cloning into an existing directory
+	explicitly given (`repo` for `/path/to/repo.git` and `foo`
+	for `host.xz:foo/.git`).  Cloning into an existing directory
 	is only allowed if the directory is empty.
=20
 :git-clone: 1
--=20
1.6.5.1.2.g310c
