From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v1.8.4.2
Date: Mon, 28 Oct 2013 12:21:34 -0700
Message-ID: <xmqqvc0hdww1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Mon Oct 28 20:21:50 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1VasNo-0002gW-F7
	for glk-linux-kernel-3@plane.gmane.org; Mon, 28 Oct 2013 20:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756554Ab3J1TVk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 28 Oct 2013 15:21:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49576 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456Ab3J1TVi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Oct 2013 15:21:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A56414E208;
	Mon, 28 Oct 2013 19:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=d6OjK4z3pL8UGJtc9YCjIu1IV
	TU=; b=g6XsTQIq9mfKA5oy7V5Fili8hrvCuhZHI9RlHPabGmkUdEpvOY8lGpoR7
	HQXjw4R/l9zPSECRq+dHLq8p+d8y14+SmAU4+HR5N5EjNY4iq0eddFAfmL8aaJfp
	hwPPye96sD2RvunjApbn684vJnw4YgflOntTWYSIiNBzs5q5Lw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=TDaGYPq9qMH0yxEkZlM
	3S4+dk5k+jCfdw8ux9y1LrJ22h5u3bQgQkVkq5PHvuqqOODci+wH5LUK7wpxU25o
	ultzEJ210YbjpnVkveoerOifSd7bv0G6gUxeW7OzeNx54FxpK2i4Rxf/3dwJMfin
	HO2EHp0YCXGu2ehhPQGQZnW0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96E3B4E207;
	Mon, 28 Oct 2013 19:21:37 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BEF2B4E204;
	Mon, 28 Oct 2013 19:21:36 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 29E20ADC-4006-11E3-8547-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236850>

The latest maintenance release Git v1.8.4.2 is now available at
the usual places.

The release tarballs are found at:

    http://code.google.com/p/git-core/downloads/list

and their SHA-1 checksums are:

f2e9317703553b4215700605c15d0f3a30623a9d  git-1.8.4.2.tar.gz
b0d5e7e24aba1af4a8e1a4fa9c894c3a673bf5d8  git-htmldocs-1.8.4.2.tar.gz
aebbb6dc8bca979f8d54bdef51b128deba195c94  git-manpages-1.8.4.2.tar.gz

The following public repositories all have a copy of the v1.8.4.2
tag and the maint branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D https://code.google.com/p/git-core/
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

Also, http://www.kernel.org/pub/software/scm/git/ has copies of the
release tarballs.

Git v1.8.4.2 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v1.8.4.1
--------------------

 * "git clone" gave some progress messages to the standard output, not
   to the standard error, and did not allow suppressing them with the
   "--no-progress" option.

 * "format-patch --from=3D<whom>" forgot to omit unnecessary in-body
   from line, i.e. when <whom> is the same as the real author.

 * "git shortlog" used to choke and die when there is a malformed
   commit (e.g. missing authors); it now simply ignore such a commit
   and keeps going.

 * "git merge-recursive" did not parse its "--diff-algorithm=3D" comman=
d
   line option correctly.

 * "git branch --track" had a minor regression in v1.8.3.2 and later
   that made it impossible to base your local work on anything but a
   local branch of the upstream repository you are tracking from.

 * "git ls-files -k" needs to crawl only the part of the working tree
   that may overlap the paths in the index to find killed files, but
   shared code with the logic to find all the untracked files, which
   made it unnecessarily inefficient.

 * When there is no sufficient overlap between old and new history
   during a "git fetch" into a shallow repository, objects that the
   sending side knows the receiving end has were unnecessarily sent.

 * When running "fetch -q", a long silence while the sender side
   computes the set of objects to send can be mistaken by proxies as
   dropped connection.  The server side has been taught to send a
   small empty messages to keep the connection alive.

 * When the webserver responds with "405 Method Not Allowed", "git
   http-backend" should tell the client what methods are allowed with
   the "Allow" header.

 * "git cvsserver" computed the permission mode bits incorrectly for
   executable files.

 * The implementation of "add -i" has a crippling code to work around
   ActiveState Perl limitation but it by mistake also triggered on Git
   for Windows where MSYS perl is used.

 * We made sure that we notice the user-supplied GIT_DIR is actually a
   gitfile, but did not do the same when the default ".git" is a
   gitfile.

 * When an object is not found after checking the packfiles and then
   loose object directory, read_sha1_file() re-checks the packfiles to
   prevent racing with a concurrent repacker; teach the same logic to
   has_sha1_file().

 * "git commit --author=3D$name", when $name is not in the canonical
   "A. U. Thor <au.thor@example.xz>" format, looks for a matching name
   from existing history, but did not consult mailmap to grab the
   preferred author name.

 * The commit object names in the insn sheet that was prepared at the
   beginning of "rebase -i" session can become ambiguous as the
   rebasing progresses and the repository gains more commits. Make
   sure the internal record is kept with full 40-hex object names.

 * "git rebase --preserve-merges" internally used the merge machinery
   and as a side effect, left merge summary message in the log, but
   when rebasing, there should not be a need for merge summary.

 * "git rebase -i" forgot that the comment character can be
   configurable while reading its insn sheet.

Also contains a handful of trivial code clean-ups, documentation
updates, updates to the test suite, etc.

----------------------------------------------------------------

Changes since v1.8.4.1 are as follows:

Antoine Pelisse (1):
      commit: search author pattern against mailmap

Christian Couder (1):
      sha1_file: move comment about return value where it belongs

Eric Sunshine (5):
      rebase -i: fix cases ignoring core.commentchar
      dir.c::test_one_path(): work around directory_exists_in_index_ica=
se() breakage
      t3404: make tests more self-contained
      t3404: rebase -i: demonstrate short SHA-1 collision
      t3200: fix failure on case-insensitive filesystems

Jeff King (8):
      has_sha1_file: re-check pack directory before giving up
      upload-pack: send keepalive packets during pack computation
      upload-pack: bump keepalive default to 5 seconds
      clone: send diagnostic messages to stderr
      clone: treat "checking connectivity" like other progress
      clone: always set transport options
      shortlog: ignore commits with missing authors
      format-patch: print in-body "From" only when needed

Johan Herland (4):
      t2024: Fix &&-chaining and a couple of typos
      t3200: Minor fix when preparing for tracking failure
      Refer to branch.<name>.remote/merge when documenting --track
      t3200: Add test demonstrating minor regression in 41c21f2

Johannes Sixt (1):
      add--interactive: fix external command invocation on Windows

John Keeping (1):
      merge-recursive: fix parsing of "diff-algorithm" option

Junio C Hamano (8):
      dir.c: use the cache_* macro to access the current index
      ls-files -k: a directory only can be killed if the index has a no=
n-directory
      t3010: update to demonstrate "ls-files -k" optimization pitfalls
      rebase -i: fix short SHA-1 collision
      cvsserver: pick up the right mode bits
      Start preparing for 1.8.4.2
      Almost 1.8.4.2 ;-)
      Git 1.8.4.2

Matthijs Kooijman (1):
      Add testcase for needless objects during a shallow fetch

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (7):
      move setup_alternate_shallow and write_shallow_commits to shallow=
=2Ec
      shallow: only add shallow graft points to new shallow file
      shallow: add setup_temporary_shallow()
      upload-pack: delegate rev walking in shallow fetch to pack-object=
s
      list-objects: reduce one argument in mark_edges_uninteresting
      list-objects: mark more commits as edges in mark_edges_uninterest=
ing
      Make setup_git_env() resolve .git file when $GIT_DIR is not speci=
fied

Nicolas Vigier (1):
      git-merge: document the -S option

Per Cederqvist (1):
      branch.c: Relax unnecessary requirement on upstream's remote ref =
name

Ralf Thielow (2):
      rebase --preserve-merges: ignore "merge.log" config
      clone --branch: refuse to clone if upstream repo is empty

SZEDER G=C3=A1bor (1):
      t4254: modernize tests

Steffen Prohaska (1):
      git-prune-packed.txt: fix reference to GIT_OBJECT_DIRECTORY

Torstein Hegge (1):
      test-lib: fix typo in comment

brian m. carlson (1):
      http-backend: provide Allow header for 405
