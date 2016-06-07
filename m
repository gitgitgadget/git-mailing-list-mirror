From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] Git v2.8.4
Date: Mon, 06 Jun 2016 22:57:53 -0700
Message-ID: <xmqq4m95tuam.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: git@vger.kernel.org
X-From: linux-kernel-owner@vger.kernel.org Tue Jun 07 07:58:04 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1bAA1b-00059k-6z
	for glk-linux-kernel-3@plane.gmane.org; Tue, 07 Jun 2016 07:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753311AbcFGF57 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 7 Jun 2016 01:57:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59766 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751412AbcFGF55 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2016 01:57:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EBEA91A901;
	Tue,  7 Jun 2016 01:57:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=x6f9D4fy1oSsJUfacMxuPaapv
	fY=; b=iAtJgnNyTqdNAmq9qeQS5HyRURYj5bHy/reIDva9KqhDMjtLWCUq2H0oY
	YXXXE7ZIu5o6n6nUFIjQEfRJf8rAQDVNWz0UoRUHEYNCHXUNiJ8Ho3XqhOYRnOOV
	cDuZd34A3soc1gkI8bGyQ+YPw9ag91hU8ufgQLQHS3A/XWu7hk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=TlHqQS1/I+csljDoqaj
	i+8JGl3TTbmLg9v1qcqsqMOd6xC5WKxyyfx9LWOLQARt8qBeaRbLtCsPh+EEi1FC
	RfGnLA/Xx9rsIKFxyUvEnuMTqvPwoE8IOTsqMh1KjTwAlmatbs6m9FToQqHDjaVh
	34A1EYTs2HvZnle5ltR6Noto=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DD94C1A8FF;
	Tue,  7 Jun 2016 01:57:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 55C641A8FE;
	Tue,  7 Jun 2016 01:57:55 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C7575422-2C74-11E6-BF5F-89D312518317-77302942!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296597>

The latest maintenance release Git v2.8.4 is now available at
the usual places.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.8.4'
tag and the 'maint' branch that the tag points at:

  url =3D https://kernel.googlesource.com/pub/scm/git/git
  url =3D git://repo.or.cz/alt-git.git
  url =3D git://git.sourceforge.jp/gitroot/git-core/git.git
  url =3D git://git-core.git.sourceforge.net/gitroot/git-core/git-core
  url =3D https://github.com/gitster/git

----------------------------------------------------------------

Git v2.8.4 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46ixes since v2.8.3
------------------

 * Documentation for "git merge --verify-signatures" has been updated
   to clarify that the signature of only the commit at the tip is
   verified.  Also the phrasing used for signature and key validity is
   adjusted to align with that used by OpenPGP.

 * On Windows, .git and optionally any files whose name starts with a
   dot are now marked as hidden, with a core.hideDotFiles knob to
   customize this behaviour.

 * Portability enhancement for "rebase -i" to help platforms whose
   shell does not like "for i in <empty>" (which is not POSIX-kosher).

 * "git fsck" learned to catch NUL byte in a commit object as
   potential error and warn.

 * CI test was taught to build documentation pages.

 * Many 'linkgit:<git documentation page>' references were broken,
   which are all fixed with this.

 * "git describe --contains" often made a hard-to-justify choice of
   tag to give name to a given commit, because it tried to come up
   with a name with smallest number of hops from a tag, causing an old
   commit whose close descendant that is recently tagged were not
   described with respect to an old tag but with a newer tag.  It did
   not help that its computation of "hop" count was further tweaked to
   penalize being on a side branch of a merge.  The logic has been
   updated to favor using the tag with the oldest tagger date, which
   is a lot easier to explain to the end users: "We describe a commit
   in terms of the (chronologically) oldest tag that contains the
   commit."

 * Running tests with '-x' option to trace the individual command
   executions is a useful way to debug test scripts, but some tests
   that capture the standard error stream and check what the command
   said can be broken with the trace output mixed in.  When running
   our tests under "bash", however, we can redirect the trace output
   to another file descriptor to keep the standard error of programs
   being tested intact.

 * "http.cookieFile" configuration variable clearly wants a pathname,
   but we forgot to treat it as such by e.g. applying tilde expansion.

 * When de-initialising all submodules, "git submodule deinit" gave a
   faulty recommendation to use "git submodule deinit .", which would
   result in a strange error message in a pathological corner case.
   This has been corrected to suggest "submodule deinit --all" instead.

 * Many commands normalize command line arguments from NFD to NFC
   variant of UTF-8 on OSX, but commands in the "diff" family did
   not, causing "git diff $path" to complain that no such path is
   known to Git.  They have been taught to do the normalization.

 * A couple of bugs around core.autocrlf have been fixed.

 * "git difftool" learned to handle unmerged paths correctly in
   dir-diff mode.

 * The "are we talking with TTY, doing an interactive session?"
   detection has been updated to work better for "Git for Windows".


Also contains other minor documentation updates and code clean-ups.

----------------------------------------------------------------

Changes since v2.8.3 are as follows:

Alexander Rinass (1):
      diff: run arguments through precompose_argv

Armin Kunaschik (1):
      t4151: make sure argument to 'test -z' is given

Brian Norris (3):
      Documentation: config: improve word ordering for http.cookieFile
      http: expand http.cookieFile as a path
      config: consistently format $variables in monospaced font

David Aguilar (2):
      difftool: initialize variables for readability
      difftool: handle unmerged files in dir-diff mode

Jeff King (3):
      rebase--interactive: avoid empty list in shell for-loop
      test-lib: set BASH_XTRACEFD automatically
      archive-tar: convert snprintf to xsnprintf

Johannes Schindelin (3):
      name-rev: include taggerdate in considering the best name
      mingw: introduce the 'core.hideDotFiles' setting
      mingw: remove unnecessary definition

Junio C Hamano (9):
      fsck_commit_buffer(): do not special case the last validation
      config: describe 'pathname' value type
      test-lib-functions.sh: remove misleading comment on test_seq
      test-lib-functions.sh: rewrite test_seq without Perl
      Documentation: fix linkgit references
      fsck: detect and warn a commit with embedded NUL
      Start preparing for 2.8.4
      More topics for 2.8.4
      Git 2.8.4

Karsten Blees (1):
      mingw: make isatty() recognize MSYS2's pseudo terminals (/dev/pty=
*)

Keller Fuchs (1):
      Documentation: clarify signature verification

Lars Schneider (1):
      travis-ci: build documentation

Li Peng (1):
      typofix: assorted typofixes in comments, documentation and messag=
es

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      remote.c: specify correct plural form in "commit diverge" message

Stefan Beller (3):
      submodule deinit: require '--all' instead of '.' for all submodul=
es
      t3513: do not compress backup tar file
      t6041: do not compress backup tar file

Torsten B=C3=B6gershausen (5):
      t0027: make commit_chk_wrnNNO() reliable
      convert: allow core.autocrlf=3Dinput and core.eol=3Dcrlf
      t0027: test cases for combined attributes
      convert.c: ident + core.autocrlf didn't work
      t5601: Remove trailing space in sed expression

Vasco Almeida (12):
      i18n: index-pack: use plural string instead of normal one
      i18n: builtin/branch.c: mark option for translation
      i18n: unpack-trees: mark strings for translation
      i18n: builtin/rm.c: remove a comma ',' from string
      i18n: branch: unmark string for translation
      i18n: branch: move comment for translators
      i18n: git-parse-remote.sh: mark strings for translation
      i18n: builtin/pull.c: mark placeholders for translation
      i18n: builtin/pull.c: split strings marked for translation
      i18n: remote: add comment for translators
      Documentation/git-mailinfo: fix typo
      i18n: unpack-trees: avoid substituting only a verb in sentences
