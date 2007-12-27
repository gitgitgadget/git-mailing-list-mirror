From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.5.4-rc2
Date: Wed, 26 Dec 2007 19:36:28 -0800
Message-ID: <7v1w98lsg3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 27 04:37:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7jYc-0005HA-Mf
	for gcvg-git-2@gmane.org; Thu, 27 Dec 2007 04:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752009AbXL0Dgq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Dec 2007 22:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751999AbXL0Dgq
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Dec 2007 22:36:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62644 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbXL0Dgp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Dec 2007 22:36:45 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B643599A;
	Wed, 26 Dec 2007 22:36:42 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9781D5999;
	Wed, 26 Dec 2007 22:36:40 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69255>

GIT 1.5.4-rc2 is available at the usual places:

  http://www.kernel.org/pub/software/scm/git/

  git-1.5.4.rc2.tar.{gz,bz2}			(tarball)
  git-htmldocs-1.5.4.rc2.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.5.4.rc2.tar.{gz,bz2}		(preformatted docs)
  testing/*-1.5.4.rc2-1.*.rpm			(RPM)

This round we still did not manage to keep non-fixes out, and
you can now tell "git commit" to keep the "# comment" lines in
the message, but otherwise the changes are all fixes, fixes and
fixes.

----------------------------------------------------------------

Changes since v1.5.4-rc1 are as follows:

Alex Riesen (1):
      Allow selection of different cleanup modes for commit messages

Arjen Laarhoven (1):
      Fix "git log --diff-filter" bug

Charles Bailey (1):
      Remove old generated files from .gitignore.

Gustaf Hendeby (2):
      Make git send-email accept $EDITOR with arguments
      shortlog manpage documentation: work around asciidoc markup issue=
s

Jakub Narebski (1):
      gitweb: fix whitespace in config_to_multi (indent with tab)

Jeff King (2):
      clean up 1.5.4 release notes
      cvsimport: die on cvsps errors

Jim Meyering (1):
      Don't dereference NULL upon lookup failure.

Johannes Schindelin (2):
      Teach diff machinery to display other prefixes than "a/" and "b/"
      Mention git-shell's "cvs" substitution in the RelNotes

Junio C Hamano (14):
      t4024: fix test script to use simpler sed pattern
      fix git commit --amend -m "new message"
      shell-scripts usage(): consistently exit with non-zero
      Documentation: ls-files -v is about "assume unchanged".
      Fix $EDITOR regression introduced by rewrite in C.
      t7005: do not exit inside test.
      builtin-commit: fix amending of the initial commit
      builtin-commit: avoid double-negation in the code.
      Documentation: describe 'union' low-level merge driver
      Fix documentation of --first-parent in git-log and copy it to git=
-rev-list
      combine-diff: Fix path quoting
      Fix rewrite_diff() name quoting.
      contrib: resurrect scripted git-revert.
      GIT 1.5.4-rc2

Linus Torvalds (1):
      Re(-re)*fix trim_common_tail()

Miklos Vajna (1):
      everyday: replace 'prune' and 'repack' with 'gc'

Pierre Habouzit (3):
      git-tag: fix -l switch handling regression.
      Force the sticked form for options with optional arguments.
      parse-options: Add a gitcli(5) man page.

Ren=C3=A9 Scharfe (1):
      Make "--pretty=3Dformat" parser a bit more careful.

Shawn O. Pearce (2):
      Reallow git-rebase --interactive --continue if commit is unnecess=
ary
      Improve error messages when int/long cannot be parsed from config

Stefan Sperling (1):
      Small comment fix for git-cvsimport.

Wincent Colaiuta (1):
      Emit helpful status for accidental "git stash" save
