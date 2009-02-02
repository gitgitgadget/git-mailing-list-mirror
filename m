From: Junio C Hamano <junio@pobox.com>
Subject: What's in git.git (Feb 2009, #01; Sun, 01)
Date: Mon, 02 Feb 2009 00:05:10 -0800
Message-ID: <7veiyhl0w9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 09:06:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTtpL-0001RC-Py
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 09:06:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbZBBIFT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Feb 2009 03:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbZBBIFS
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 03:05:18 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39110 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbZBBIFQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Feb 2009 03:05:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 96EF395426;
	Mon,  2 Feb 2009 03:05:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7944995424; Mon,
  2 Feb 2009 03:05:13 -0500 (EST)
X-maint-at: 6ac92294b30d7c8619cf15b531448f011dbdcdcc
X-master-at: 2ea3c17189bf9ca459879129ca190792b5451f05
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3962EF9E-F100-11DD-A337-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108066>

There are yet more fixes that have been cooking in next and then master
that have been merged to 'maint' in preparation for the next 1.6.1.X
maintenance release.

On the 'master' front, I think we are ready to plan for 1.6.2 release.
Tonight's "What's cooking" should be a pretty good guide for estimating
what will be in -rc0, in addition to what we already have in 'master'.


* The 'maint' branch has these fixes since the last announcement.

Bj=C3=B6rn Steinbrink (1):
  Rename detection: Avoid repeated filespec population

Jeff King (1):
  avoid 31-bit truncation in write_loose_object

Junio C Hamano (3):
  ls-tree: add --full-tree option
  Teach format-patch to handle output directory relative to cwd
  GIT 1.6.1.2

Marcel M. Cary (1):
  git-sh-setup: Fix scripts whose PWD is a symlink to a work-dir on OS =
X

Markus Heidelberg (2):
  git-commit: color status output when color.ui is set
  git-status -v: color diff output when color.ui is set

Nanako Shiraishi (1):
  Document git-ls-tree --full-tree

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  grep: support --no-ext-grep to test builtin grep
  grep: grep cache entries if they are "assume unchanged"

Nicolas Pitre (1):
  objects to be pruned immediately don't have to be loosened

Ren=C3=A9 Scharfe (1):
  merge: fix out-of-bounds memory access


* The 'master' branch has these since the last announcement
  in addition to the above.

Anders Melchiorsen (2):
  Documentation: more git push examples
  Documentation: rework src/dst description in git push

David Aguilar (1):
  contrib/difftool: Don't repeat merge tool candidates

Giuseppe Bilotta (3):
  gitweb: make static files accessible with PATH_INFO
  gitweb: webserver config for PATH_INFO
  gitweb: align comments to code

Jake Goulding (3):
  Make opt_parse_with_commit() non-static
  Make has_commit() non-static
  git-tag: Add --contains option

Jakub Narebski (1):
  gitweb: Update README that gitweb works better with PATH_INFO

Jeff King (5):
  diff: refactor tempfile cleanup handling
  chain kill signals for cleanup functions
  refactor signal handling for cleanup functions
  pager: do wait_for_pager on signal death
  t0005: use SIGTERM for sigchain test

Johannes Gilger (1):
  mergetool: Don't repeat merge tool candidates

Johannes Schindelin (8):
  Fix submodule squashing into unrelated commit
  t3404 & t3411: undo copy&paste
  lib-rebase.sh: Document what set_fake_editor() does
  test-lib.sh: introduce test_commit() and test_merge() helpers
  Simplify t3410
  Simplify t3411
  Simplify t3412
  Fix 'git diff --no-index' with a non-existing symlink target

Johannes Sixt (1):
  Windows: Fix signal numbers

Junio C Hamano (6):
  Documentation: simplify refspec format description
  diff.c: output correct index lines for a split diff
  revision traversal: allow UNINTERESTING objects to be missing
  rebase -i squashes submodule changes into unrelated commit
  builtin-apply.c: do not set bogus mode in check_preimage() for delete=
d
    path
  Update draft release notes to 1.6.2

Kirill Smelkov (5):
  mailinfo: correctly handle multiline 'Subject:' header
  mailinfo: 'From:' header should be unfold as well
  mailinfo: add explicit test for mails like '<a.u.thor@example.com> (A=
 U
    Thor)'
  mailinfo: tests for RFC2047 examples
  mailinfo: cleanup extra spaces for complex 'From:'

Markus Heidelberg (1):
  contrib/difftool: add support for Kompare

Michele Ballabio (1):
  git-shortlog.txt: fix example about .mailmap

Stefan Karpinski (2):
  git-cvsserver: handle CVS 'noop' command.
  git-cvsserver: run post-update hook *after* update.

Steffen Prohaska (6):
  Move computation of absolute paths from Makefile to runtime (in
    preparation for RUNTIME_PREFIX)
  git_extract_argv0_path(): Move check for valid argv0 from caller to
    callee
  Add calls to git_extract_argv0_path() in programs that call git_confi=
g_*
  Modify setup_path() to only add git_exec_path() to PATH
  Compute prefix at runtime if RUNTIME_PREFIX is set
  Windows: Revert to default paths and convert them by RUNTIME_PREFIX

Steve Haslam (1):
  Refactor git_set_argv0_path() to git_extract_argv0_path()

Thomas Rast (2):
  t3412: clean up GIT_EDITOR usage
  t3412: use log|name-rev instead of log --graph
