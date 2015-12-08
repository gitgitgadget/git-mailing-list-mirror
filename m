From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.6.4
Date: Tue, 08 Dec 2015 15:09:16 -0800
Message-ID: <xmqqa8pkk06b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Wed Dec 09 00:09:33 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1a6RNz-0003PC-8t
	for glk-linux-kernel-3@plane.gmane.org; Wed, 09 Dec 2015 00:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbbLHXJV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 8 Dec 2015 18:09:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53392 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750752AbbLHXJT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Dec 2015 18:09:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AFF783061B;
	Tue,  8 Dec 2015 18:09:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=FVUuml8W2L3BBktUSBuOhQNar
	4w=; b=M1gSo9m9NUsNYBrgYA1f2KDzx+GbTVHS3n+LkVuRIZZ4iVMvAaV6/fitD
	vLcqRLWWVWWEto1DazNYv4My8E6v/1vkbR1v/FQX7dDNiAs4WELOBCs7tP21mk04
	8L4BViKz6vMfFFFwMKX3O756rdHC6L43U7a9SdywSR3FKO9RP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=GrHW74lV9ZHqJXT9Apy
	qEyedFaT6mziK4WOf/zq1WbhHpC07f1M8F5GGVl9U9id5FjP5dyT8UKmOwiolUeK
	jUU6PRbOn7rHOVwdazF1oMC8vXtBRb0VRMATCHJRpQK3M4FMCC/3mT4AesmrCVNx
	EtD0tqPLhf1t6NEj72dBh+fE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A778D3061A;
	Tue,  8 Dec 2015 18:09:18 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 18D8230617;
	Tue,  8 Dec 2015 18:09:18 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B527C136-9E00-11E5-83D5-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282179>

The latest maintenance release Git v2.6.4 is now available at
the usual places, with a handful of fixes that are already in
the 'master' front.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.6.4'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.6.4 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.6.3
------------------

 * The "configure" script did not test for -lpthread correctly, which
   upset some linkers.

 * Add support for talking http/https over socks proxy.

 * Portability fix for Windows, which may rewrite $SHELL variable using
   non-POSIX paths.

 * We now consistently allow all hooks to ignore their standard input,
   rather than having git complain of SIGPIPE.

 * Fix shell quoting in contrib script.

 * Test portability fix for a topic in v2.6.1.

 * Allow tilde-expansion in some http config variables.

 * Give a useful special case "diff/show --word-diff-regex=3D." as an
   example in the documentation.

 * Fix for a corner case in filter-branch.

 * Make git-p4 work on a detached head.

 * Documentation clarification for "check-ignore" without "--verbose".

 * Just like the working tree is cleaned up when the user cancelled
   submission in P4Submit.applyCommit(), clean up the mess if "p4
   submit" fails.

 * Having a leftover .idx file without corresponding .pack file in
   the repository hurts performance; "git gc" learned to prune them.

 * The code to prepare the working tree side of temporary directory
   for the "dir-diff" feature forgot that symbolic links need not be
   copied (or symlinked) to the temporary area, as the code already
   special cases and overwrites them.  Besides, it was wrong to try
   computing the object name of the target of symbolic link, which may
   not even exist or may be a directory.

 * There was no way to defeat a configured rebase.autostash variable
   from the command line, as "git rebase --no-autostash" was missing.

 * Allow "git interpret-trailers" to run outside of a Git repository.

 * Produce correct "dirty" marker for shell prompts, even when we
   are on an orphan or an unborn branch.

 * Some corner cases have been fixed in string-matching done in "git
   status".

 * Apple's common crypto implementation of SHA1_Update() does not take
   more than 4GB at a time, and we now have a compile-time workaround
   for it.

Also contains typofixes, documentation updates and trivial code
clean-ups.

----------------------------------------------------------------

Changes since v2.6.3 are as follows:

Atousa Pahlevan Duprat (2):
      sha1: provide another level of indirection for the SHA-1 function=
s
      sha1: allow limiting the size of the data passed to SHA1_Update()

Charles Bailey (1):
      http: treat config options sslCAPath and sslCAInfo as paths

Christian Couder (1):
      Documentation/git-update-index: add missing opts to synopsys

Clemens Buchacher (1):
      allow hooks to ignore their standard input stream

Daniel Knittl-Frank (1):
      Escape Git's exec path in contrib/rerere-train.sh script

David Aguilar (1):
      difftool: ignore symbolic links in use_wt_file

Dennis Kaarsemaker (2):
      t5813: avoid creating urls that break on cygwin
      check-ignore: correct documentation about output

Doug Kelly (2):
      t5304: test cleaning pack garbage
      gc: remove garbage .idx files from pack dir

=46redrik Medley (1):
      rebase-i-exec: Allow space in SHELL_PATH

GIRARD Etienne (1):
      git-p4: clean up after p4 submit failure

John Keeping (3):
      interpret-trailers: allow running outside a repository
      rebase: support --no-autostash
      Documentation/git-rebase: fix --no-autostash formatting

Junio C Hamano (3):
      prepare_packed_git(): refactor garbage reporting in pack director=
y
      Prepare for 2.6.4
      Git 2.6.4

Luke Diamand (3):
      git-p4: add failing test for submit from detached head
      git-p4: add option to system() to return subshell status
      git-p4: work with a detached head

Michael J Gruber (1):
      Documentation/diff: give --word-diff-regex=3D. example

Pat Thoyts (1):
      remote-http(s): support SOCKS proxies

Rainer M. Canavan (1):
      configure.ac: use $LIBS not $CFLAGS when testing -lpthread

Ren=C3=A9 Scharfe (1):
      wt-status: correct and simplify check for detached HEAD

SZEDER G=C3=A1bor (4):
      bash prompt: test dirty index and worktree while on an orphan bra=
nch
      bash prompt: remove a redundant 'git diff' option
      bash prompt: indicate dirty index even on orphan branches
      filter-branch: deal with object name vs. pathname ambiguity in tr=
ee-filter

=D0=90=D0=BD=D0=B4=D1=80=D0=B5=D0=B9 =D0=A0=D1=8B=D0=B1=D0=B0=D0=BA (1)=
:
      Documentation: make environment variable formatting more consiste=
nt
