From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Mar 2009, #03; Fri, 06)
Date: Fri, 06 Mar 2009 00:26:34 -0800
Message-ID: <7vocwft5tx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 09:28:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfVPd-000461-Kg
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 09:28:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbZCFI0l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2009 03:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751792AbZCFI0k
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 03:26:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46199 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbZCFI0j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2009 03:26:39 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id BAB733F44;
	Fri,  6 Mar 2009 03:26:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0F6693F43; Fri, 
 6 Mar 2009 03:26:35 -0500 (EST)
X-maint-at: bdfd739dac4c109ce360d38d0572d8717a46e795
X-master-at: 8cc3fe45c92a2e85400a6ee83c3b3a4a8ca1d6c7
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 82D361D6-0A28-11DE-8B21-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112404>

Quite a many topics that have been scheduled for 'master' for some time
have all graduated.  With this pace we may be able to have a very short
cycle for a change before 1.6.3 final ;-).

* The 'master' branch has these since the last announcement.

Arjen Laarhoven (2):
  Clean up use of ANSI color sequences
  builtin-branch.c: Rename branch category color names

Deskin Miller (1):
  add -i: revisit hunk on editor failure

Elijah Newren (1):
  Ensure proper setup of git_dir for git-hash-object

=46elipe Contreras (3):
  config: Add new option to open an editor.
  git config: codestyle cleanups
  Add tests for git log --pretty, --format and --oneline.

=46inn Arne Gangstad (1):
  Support "\" in non-wildcard exclusion entries

Jay Soffian (6):
  builtin-branch: improve output when displaying remote branches
  send-email: allow send-email to run outside a repo
  send-email: handle multiple Cc addresses when reading mbox message
  send-email: --suppress-cc improvements
  send-email: don't create temporary compose file until it is needed
  send-email: add --confirm option and configuration setting

Jeff King (4):
  valgrind: ignore ldso and more libz errors
  branch: clean up repeated strlen
  add basic branch display tests
  never fallback relative times to absolute

Jeremy White (2):
  Enable setting attach as the default in .gitconfig for git-format-pat=
ch.
  imap.preformattedHTML to tell Thunderbird to send non-flowed text

Johannes Schindelin (11):
  Add valgrind support in test scripts
  Valgrind support: check for more than just programming errors
  test-lib.sh: optionally output to test-results/$TEST.out, too
  t/Makefile: provide a 'valgrind' target
  Add a script to coalesce the valgrind outputs
  Tests: let --valgrind imply --verbose and --tee
  test-lib: avoid assuming that templates/ are in the GIT_EXEC_PATH
  valgrind: do not require valgrind 3.4.0 or newer
  Avoid segfault with 'git branch' when the HEAD is detached
  git config: trivial cleanup for editor action
  MinGW: 64-bit file offsets

John Tapsell (1):
  Documentation - More examples for git bisect

Junio C Hamano (4):
  git-blame: refactor code to emit "porcelain format" output
  blame: show "previous" information in --porcelain/--incremental forma=
t
  git-add -i/-p: learn to unwrap C-quoted paths
  Draft release notes: Carry forward the warning for behaviour changes

Marius Storm-Olsen (2):
  Add bare repository indicator for __git_ps1
  Fixup: Add bare repository indicator for __git_ps1

Nanako Shiraishi (3):
  Add --format that is a synonym to --pretty
  Give short-hands to --pretty=3Dtformat:%formatstring
  Add --oneline that is a synonym to "--pretty=3Doneline --abbrev-commi=
t"

SZEDER G=C3=A1bor (1):
  rerere: remove duplicated functions

Sverre Rabbelier (1):
  Teach rebase to rebase even if upstream is up to date

Ted Pavlic (4):
  completion: For consistency, change "git rev-parse" to __gitdir calls
  completion: Use consistent if [...] convention, not "test"
  completion: Better __git_ps1 support when not in working directory
  completion: More fixes to prevent unbound variable errors

Teemu Likonen (1):
  bash completion: add --format=3D and --oneline options for "git log"
