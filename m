From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git 1.7.9.rc2
Date: Wed, 18 Jan 2012 17:16:36 -0800
Message-ID: <7vpqegjxu3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Thu Jan 19 02:16:50 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RngcT-0003IO-9O
	for glk-linux-kernel-3@lo.gmane.org; Thu, 19 Jan 2012 02:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755293Ab2ASBQk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 18 Jan 2012 20:16:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55319 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752193Ab2ASBQi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2012 20:16:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FC1565C5;
	Wed, 18 Jan 2012 20:16:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=a0ieGZZPhFn4UYZ6xUxinMNwn
	s0=; b=HLFl5IaiuCsYTJ3atVqHLhlRiR9X4ivfrCvd2R3b5YsmldA0l5lRaKKGA
	Dp1KBegGCpZYViteeMdkLIw9aURyB+u/R6jwxGvIXNSjJhdpuef38qrEl5VZxzN8
	WF9DR85ofN0e1SMwuoa0wy49749C+6tEC1OxNF2/zObBiuoiZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:cc:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=FtgJE0ZeLz8Gi64xu+Q
	ZOwSRSaMmyN7wrYNnEWrrzdQJaLJvEVgjsE44cPUnEStFYh5j4+g+MmRyB7tOtd4
	plyd+izfJJ1ymnDvhSYNM0xPQAzToGKOh2/JztV7zlEBTeT2ibe3hpyJDCEzYhXx
	LMeuaBnWmimG0PuuDGux5BjA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27CA965C4;
	Wed, 18 Jan 2012 20:16:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78AC665C0; Wed, 18 Jan 2012
 20:16:37 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C0153DC-423B-11E1-9DC5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188787>

A release candidate Git 1.7.9.rc2 is available for testing.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

4eeaaf8a73006f797e6c23455097684664bf256e  git-1.7.9.rc2.tar.gz
22aad76c146abe04e8f9bd89b2fbf4b575f434ce  git-htmldocs-1.7.9.rc2.tar.gz
8565f64f6227fcfba3f768dabdcd9d6037f08842  git-manpages-1.7.9.rc2.tar.gz

Also the following public repositories all have a copy of the v1.7.9.rc=
2
tag and the master branch that the tag points at:

  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git


Git v1.7.9 Release Notes (draft)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Updates since v1.7.8
--------------------

 * gitk updates accumulated since early 2011.

 * git-gui updated to 0.16.0.

 * git-p4 (in contrib/) updates.

 * Git uses gettext to translate its most common interface messages
   into the user's language if translations are available and the
   locale is appropriately set. Distributors can drop in new PO files
   in po/ to add new translations.

 * The code to handle username/password for HTTP transaction used in
   "git push" & "git fetch" learned to talk "credential API" to
   external programs to cache or store them, to allow integration with
   platform native keychain mechanisms.

 * The prompted input in the terminal use our own getpass() replacement
   when possible. HTTP transactions used to ask username without echoin=
g
   back what was typed, but with this change you will see it as you typ=
e.

 * The internal of "revert/cherry-pick" has been tweaked to prepare
   building more generic "sequencer" on top of the implementation that
   drives them.

 * "git rev-parse FETCH_HEAD" after "git fetch" without specifying
   what to fetch from the command line will now show the commit that
   would be merged if the command were "git pull".

 * "git add" learned to stream large files directly into a packfile
   instead of writing them into individual loose object files.

 * "git checkout -B <current branch> <elsewhere>" is a more intuitive
   way to spell "git reset --keep <elsewhere>".

 * "git checkout" and "git merge" learned "--no-overwrite-ignore" optio=
n
   to tell Git that untracked and ignored files are not expendable.

 * "git commit --amend" learned "--no-edit" option to say that the
   user is amending the tree being recorded, without updating the
   commit log message.

 * "git commit" and "git reset" re-learned the optimization to prime
   the cache-tree information in the index, which makes it faster to
   write a tree object out after the index entries are updated.

 * "git commit" detects and rejects an attempt to stuff NUL byte in
   the commit log message.

 * "git commit" learned "-S" to GPG-sign the commit; this can be shown
   with the "--show-signature" option to "git log".

 * fsck and prune are relatively lengthy operations that still go
   silent while making the end-user wait. They learned to give progress
   output like other slow operations.

 * The set of built-in function-header patterns for various languages
   knows MATLAB.

 * "git log --format=3D'<format>'" learned new %g[nNeE] specifiers to
   show information from the reflog entries when warlking the reflog
   (i.e. with "-g").

 * "git pull" can be used to fetch and merge an annotated/signed tag,
   instead of the tip of a topic branch. The GPG signature from the
   signed tag is recorded in the resulting merge commit for later
   auditing.

 * "git log" learned "--show-signature" option to show the signed tag
   that was merged that is embedded in the merge commit. It also can
   show the signature made on the commit with "git commit -S".

 * "git branch --edit-description" can be used to add descriptive text
   to explain what a topic branch is about.

 * "git fmt-merge-msg" learned to take the branch description into
   account when preparing a merge summary that "git merge" records
   when merging a local branch.

 * "git request-pull" has been updated to convey more information
   useful for integrators to decide if a topic is worth merging and
   what is pulled is indeed what the requestor asked to pull,
   including:

   - the tip of the branch being requested to be merged;
   - the branch description describing what the topic is about;
   - the contents of the annotated tag, when requesting to pull a tag.

 * "git pull" learned to notice 'pull.rebase' configuration variable,
   which serves as a global fallback for setting 'branch.<name>.rebase'
   configuration variable per branch.

 * "git tag" learned "--cleanup" option to control how the whitespaces
   and empty lines in tag message are cleaned up.

 * "gitweb" learned to show side-by-side diff.

Also contains minor documentation updates and code clean-ups.


=46ixes since v1.7.8
------------------

Unless otherwise noted, all the fixes since v1.7.8 in the maintenance
releases are contained in this release (see release notes to them for
details).


----------------------------------------------------------------

Changes since v1.7.9-rc1 are as follows:

Jakub Narebski (2):
      gitweb: Fix file links in "grep" search
      gitweb: Harden "grep" search against filenames with ':'

Jeff King (3):
      unix-socket: handle long socket pathnames
      credential-cache: report more daemon connection errors
      credential-cache: ignore "connection refused" errors

Jonathan Nieder (1):
      unix-socket: do not let close() or chdir() clobber errno during c=
leanup

Junio C Hamano (4):
      pulling signed tag: add howto document
      Git 1.7.7.6
      Git 1.7.8.4
      Git 1.7.9-rc2

Michael Haggerty (2):
      git-show-ref: fix escaping in asciidoc source
      git-show-ref doc: typeset regexp in fixed width font

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (3):
      Document limited recursion pathspec matching with wildcards
      diff-index: enable recursive pathspec matching in unpack_trees
      diff-index: enable recursive pathspec matching in unpack_trees

Thomas Rast (1):
      word-diff: ignore '\ No newline at eof' marker
