From: Junio C Hamano <gitster@pobox.com>
Subject: [ANNOUNCE] GIT 1.6.0-rc3
Date: Wed, 13 Aug 2008 01:39:54 -0700
Message-ID: <7viqu5nw9x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 10:41:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTBux-0007ja-97
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 10:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513AbYHMIkP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Aug 2008 04:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755864AbYHMIkO
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 04:40:14 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50455 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755513AbYHMIkE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Aug 2008 04:40:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id DF12257324;
	Wed, 13 Aug 2008 04:40:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 427CF57323; Wed, 13 Aug 2008 04:39:56 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6B73D5D6-6913-11DD-B98C-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92193>

The last rc before the final, 1.6.0-rc3, can be found at the usual plac=
es:

  http://www.kernel.org/pub/software/scm/git/

  git-1.6.0.rc3.tar.{gz,bz2}			(source tarball)
  git-htmldocs-1.6.0.rc3.tar.{gz,bz2}		(preformatted docs)
  git-manpages-1.6.0.rc3.tar.{gz,bz2}		(preformatted docs)

The RPM binary packages for a few architectures are also provided
as courtesy.

  testing/git-*-1.6.0.rc3-1.fc9.$arch.rpm	(RPM)

Hopefully the real 1.6.0 will appear over the weekend.

----------------------------------------------------------------

Changes since v1.6.0-rc2 are as follows:

Brandon Casey (2):
      Makefile: set SHELL to value of SHELL_PATH
      Makefile: add a target which will abort compilation with ancient =
shells

Eric Wong (2):
      git-svn: add ability to specify --commit-url for dcommit
      git-svn: wrap long lines in a few places

=46rancis Moreau (1):
      git-bisect: fix wrong usage of read(1)

Gustaf Hendeby (2):
      gitattributes: Document built in hunk header patterns
      Teach git diff about BibTeX head hunk patterns

Ivan Stankovic (1):
      Documentation: fix invalid reference to 'mybranch' in user manual

Johannes Schindelin (1):
      clone --mirror: avoid storing repeated tags

Jonathan Nieder (1):
      Documentation: user-manual: "git commit -a" doesn't motivate .git=
ignore

Junio C Hamano (9):
      asciidoc markup fixes
      GIT-VERSION-GEN: mark the version 'dirty' only if there are modif=
ied files
      mailinfo: fix MIME multi-part message boundary handling
      Update draft RelNotes for 1.6.0
      Fix deleting reflog entries from HEAD reflog
      Re-fix rev-list-options documentation
      diff --check: do not unconditionally complain about trailing empt=
y lines
      Do not talk about "diff" in rev-list documentation.
      GIT 1.6.0-rc3

Marcus Griep (5):
      Fix multi-glob assertion in git-svn
      git-svn: Allow deep branch names by supporting multi-globs
      Git.pm: Add faculties to allow temp files to be cached
      git-svn: Make it incrementally faster by minimizing temp files
      git-svn: Reduce temp file usage when dealing with non-links

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
      Fix typo in comments of longest_ancestor_length()

Petr Baudis (2):
      Fail properly when cloning from invalid HTTP URL
      Adjust for the new way of enabling the default post-update hook

Pieter de Bie (2):
      builtin-rm: Add a --force flag
      reflog test: add more tests for 'reflog delete'

SZEDER G=C3=A1bor (1):
      bash: remove redundant check for 'git stash apply' options

Stephen R. van den Berg (1):
      git-daemon: SysV needs the signal handler reinstated.

Thomas Rast (6):
      Documentation: commit-tree: remove 16 parents restriction
      Documentation: filter-branch: document how to filter all refs
      filter-branch: be more helpful when an annotated tag changes
      Documentation: rev-list-options: Fix -g paragraph formatting
      Documentation: rev-list-options: Fix a typo
      Documentation: rev-list-options: Rewrite simplification descripti=
ons for clarity
