From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.5.3
Date: Mon, 16 Nov 2009 19:18:05 -0800
Message-ID: <7v4ootltzm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754807AbZKQDSS@vger.kernel.org Tue Nov 17 04:20:19 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754807AbZKQDSS@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAEc6-0006Dr-OE
	for glk-linux-kernel-3@lo.gmane.org; Tue, 17 Nov 2009 04:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807AbZKQDSS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 16 Nov 2009 22:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753781AbZKQDSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Nov 2009 22:18:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64914 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754581AbZKQDSN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Nov 2009 22:18:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5C5829E752;
	Mon, 16 Nov 2009 22:18:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=GjZjOmxlFit34FU74UDpXq2hn
	UY=; b=ciWUbBILkR3Ah8LaZZjcik8+hg/dCwFgjga7fETwwlle5hwPThK5JCH6F
	RtYdCiIETFMJ7mD/VJwaWU20tQv1NlotLfDWmij3OfKSE3Jk1LgBiA0ed8opfC9l
	zhHcWLl+9tQPZ6pN6P4BLK6dZ+77zNJ9RCagmTR9lt0zthuZq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=sTuSr8l3AIZ2yoZeXof
	lksVjtf/UzDaGKT2sZxQaK8UgCkkWIGtYOjry08F15iGTMXFe3ltMmcEKWggkepV
	juLbvkI/VYaUj9CgJQk13RpSUltG9BwvLlRQnM/KkOusiS5JZO8TSC3WTiaL8by8
	QDPgoE4TIr6uf/5toCjDw2FM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1D2C69E751;
	Mon, 16 Nov 2009 22:18:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 11E3B9E750; Mon, 16 Nov 2009
 22:18:07 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D785E032-D327-11DE-9609-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133053>

The latest maintenance release GIT 1.6.5.3 is available at the
usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.5.3.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.5.3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.5.3.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are found in:

  RPMS/$arch/git-*-1.6.5.3-1.fc9.$arch.rpm	(RPM)

Git v1.6.5.3 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

=46ixes since v1.6.5.2
--------------------

 * info/grafts file didn't ignore trailing CR at the end of lines.

 * Packages generated on newer FC were unreadable by older versions of
   RPM as the new default is to use stronger hash.

 * output from "git blame" was unreadable when the file ended in an
   incomplete line.

 * "git add -i/-p" didn't handle deletion of empty files correctly.

 * "git clone" takes up to two parameters, but did not complain when
   given more arguments than necessary and silently ignored them.

 * "git cvsimport" did not read files given as command line arguments
   correctly when it is run from a subdirectory.

 * "git diff --color-words -U0" didn't work correctly.

 * The handling of blank lines at the end of file by "git diff/apply
   --whitespace" was inconsistent with the other kinds of errors.
   They are now colored, warned against, and fixed the same way as othe=
rs.

 * There was no way to allow blank lines at the end of file without
   allowing extra blanks at the end of lines.  You can use blank-at-eof
   and blank-at-eol whitespace error class to specify them separately.
   The old trailing-space error class is now a short-hand to set both.

 * "-p" option to "git format-patch" was supposed to suppress diffstat
   generation, but it was broken since 1.6.1.

 * "git imap-send" did not compile cleanly with newer OpenSSL.

 * "git help -a" outside of a git repository was broken.

 * "git ls-files -i" was supposed to be inverse of "git ls-files" witho=
ut -i
   with respect to exclude patterns, but it was broken since 1.6.5.2.

 * "git ls-remote" outside of a git repository over http was broken.

 * "git rebase -i" gave bogus error message when the command word was
   misspelled.

 * "git receive-pack" that is run in response to "git push" did not run
   garbage collection nor update-server-info, but in larger hosting sit=
es,
   these almost always need to be run.  To help site administrators, th=
e
   command now runs "gc --auto" and "u-s-i" by setting receive.autogc
   and receive.updateserverinfo configuration variables, respectively.

 * Release notes spelled the package name with incorrect capitalization=
=2E

 * "gitweb" did not escape non-ascii characters correctly in the URL.

 * "gitweb" showed "patch" link even for merge commits.

 * "gitweb" showed incorrect links for blob line numbers in pathinfo mo=
de.

Other minor documentation updates are included.


----------------------------------------------------------------

Changes since v1.6.5.2 are as follows:

Bj=C3=B6rn Gustavsson (1):
      git-clone.txt: Fix grammar and formatting

Bj=C3=B6rn Steinbrink (1):
      pre-commit.sample: Diff against the empty tree when HEAD is inval=
id

Clemens Buchacher (1):
      modernize fetch/merge/pull examples

Daniel Barkalow (2):
      Require a struct remote in transport_get()
      Allow curl helper to work without a local repository

Dmitry V. Levin (1):
      Makefile: add compat/bswap.h to LIB_H

Gerrit Pape (1):
      help -i: properly error out if no info viewer can be found

Gisle Aas (2):
      More precise description of 'git describe --abbrev'
      Fix documentation grammar typo

Giuseppe Bilotta (1):
      gitweb: fix esc_param

Jakub Narebski (1):
      gitweb: Do not show 'patch' link for merge commits

Jan Kr=C3=BCger (1):
      rebase -i: more graceful handling of invalid commands

Jari Aalto (3):
      Documentation/fetch-options.txt: order options alphabetically
      Documentation/git-pull.txt: Add subtitles above included option f=
iles
      Documentation/merge-options.txt: order options in alphabetical gr=
oups

Jeff King (6):
      cvsimport: fix relative argument filenames
      push: always load default config
      add-interactive: handle deletion of empty files
      ls-files: unbreak "ls-files -i"
      push: fix typo in usage
      format-patch: make "-p" suppress diffstat

Johannes Schindelin (3):
      blame: make sure that the last line ends in an LF
      help -a: do not unnecessarily look for a repository
      diff --color-words -U0: fix the location of hunk headers

Jonathan Nieder (4):
      clone: detect extra arguments
      Add intermediate build products to .gitignore
      check-ref-format: update usage string
      merge: do not setup worktree twice

Junio C Hamano (22):
      apply --whitespace=3Dfix: fix handling of blank lines at the eof
      apply --whitespace=3Dfix: detect new blank lines at eof correctly
      apply.c: split check_whitespace() into two
      apply --whitespace=3Dwarn/error: diagnose blank at EOF
      apply --whitespace: warn blank but not necessarily empty lines at=
 EOF
      diff.c: the builtin_diff() deals with only two-file comparison
      diff --whitespace=3Dwarn/error: obey blank-at-eof
      diff --whitespace=3Dwarn/error: fix blank-at-eof check
      diff --color: color blank-at-eof
      core.whitespace: split trailing-space into blank-at-{eol,eof}
      diff --whitespace: fix blank lines at end
      diff.c: shuffling code around
      diff.c: split emit_line() from the first char and the rest of the=
 line
      diff.c: emit_add_line() takes only the rest of the line
      diff -B: colour whitespace errors
      info/grafts: allow trailing whitespaces at the end of line
      gc --auto --quiet: make the notice a bit less verboase
      receive-pack: run "gc --auto --quiet" and optionally "update-serv=
er-info"
      clone: fix help on options
      diff --color-words: bit of clean-up
      check-ref-format -h: it does not know the --print option yet
      Git 1.6.5.3

Markus Heidelberg (1):
      t4034-diff-words: add a test for word diff without context

Petr Baudis (1):
      gitweb: Fix blob linenr links in pathinfo mode

Sebastian Schuberth (1):
      Do not try to remove directories when removing old links

Stephen Boyd (1):
      git-add.txt: fix formatting of --patch section

Thomas Rast (1):
      Quote ' as \(aq in manpages

Todd Zullinger (1):
      Makefile: Ensure rpm packages can be read by older rpm versions

Vietor Liu (1):
      imap-send.c: fix compiler warnings for OpenSSL 1.0
