From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Jan 2009, #03; Sat, 24)
Date: Sat, 24 Jan 2009 21:01:04 -0800
Message-ID: <7v3af8kmi7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 25 06:02:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQx8p-0005AE-Bj
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 06:02:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbZAYFBP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jan 2009 00:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbZAYFBO
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 00:01:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40957 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbZAYFBN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jan 2009 00:01:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1F0B11D147;
	Sun, 25 Jan 2009 00:01:10 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 10B8F1D10C; Sun,
 25 Jan 2009 00:01:05 -0500 (EST)
X-maint-at: 692be9f365be09160f8baa1d6d521d0f65ec4cf9
X-master-at: 5dc1308562ab5991ecada68b06707709bea408c9
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2E741E6E-EA9D-11DD-B673-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107040>

* The 'maint' branch has these fixes since the last announcement.

Anders Melchiorsen (4):
  Documentation: git push repository can also be a remote
  Documentation: remove a redundant elaboration
  Documentation: mention branches rather than heads
  Documentation: avoid using undefined parameters

Boyd Stephen Smith Jr (1):
  Fix Documentation for git-describe

Clemens Buchacher (3):
  unpack-trees: handle failure in verify_absent
  unpack-trees: fix path search bug in verify_absent
  unpack-trees: remove redundant path search in verify_absent

Johannes Schindelin (3):
  bisect view: call gitk if Cygwin's SESSIONNAME variable is set
  git add: do not add files from a submodule
  Rename diff.suppress-blank-empty to diff.suppressBlankEmpty

Junio C Hamano (1):
  format-patch: show patch text for the root commit

Lars Noschinski (1):
  shell: Document that 'cvs server' is a valid command

Paul Jarc (1):
  configure clobbers LDFLAGS

Philippe Bruhat (1):
  Git.pm: correctly handle directory name that evaluates to "false"

Ren=C3=A9 Scharfe (1):
  shortlog: handle multi-line subjects like log --pretty=3Doneline et. =
al. do

Thomas Rast (3):
  diff: accept -- when using --no-index
  diff --no-index: test for pager after option parsing
  diff --no-index -q: fix endless loop


* The 'master' branch has these since the last announcement
  in addition to the above.

Arjen Laarhoven (1):
  t/t4202-log.sh: Add testcases

Bj=C3=B6rn Steinbrink (1):
  Rename detection: Avoid repeated filespec population

Brandon Casey (1):
  Makefile: use shell for-loop rather than Make's foreach loop during
    install

Jeff King (2):
  color: make it easier for non-config to parse color specs
  expand --pretty=3Dformat color options

Johannes Schindelin (3):
  Implement the patience diff algorithm
  Introduce the diff option '--patience'
  bash completions: Add the --patience option

Jonas Flod=C3=A9n (1):
  git-am: Make it easier to see which patch failed

Junio C Hamano (4):
  git-am: add --directory=3D<dir> option
  Teach format-patch to handle output directory relative to cwd
  git-am: fix shell quoting
  git-am: re-fix the diag message printing

Keith Cascio (2):
  test more combinations of ignore-whitespace options to diff
  Fix combined use of whitespace ignore options to diff

Linus Torvalds (1):
  Wrap inflate and other zlib routines for better error reporting

Markus Heidelberg (4):
  contrib/difftool: change trap condition from SIGINT to INT
  contrib/difftool: remove distracting 'echo' in the SIGINT handler
  use uppercase POSIX compliant signals for the 'trap' command
  bash completion: add 'rename' subcommand to git-remote

Ralf Wildenhues (1):
  Fix naming scheme for configure cache variables.

Ray Chuan (1):
  http-push: refactor lock-related headers creation for curl requests

Ren=C3=A9 Scharfe (5):
  Add ctype test
  Reformat ctype.c
  Change NUL char handling of isspecial()
  Add is_regex_special()
  Optimize color_parse_mem

SZEDER G=C3=A1bor (1):
  Fix gitdir detection when in subdir of gitdir

Santi B=C3=A9jar (2):
  commit: more compact summary and without extra quotes
  tutorial-2: Update with the new "git commit" ouput

Stephan Beyer (5):
  checkout: don't crash on file checkout before running post-checkout h=
ook
  Move run_hook() from builtin-commit.c into run-command.c (libgit)
  api-run-command.txt: talk about run_hook()
  run_hook(): check the executability of the hook before filling argv
  run_hook(): allow more than 9 hook arguments

Thomas Rast (2):
  bash completion: move pickaxe options to log
  bash completion: refactor diff options

martin f. krafft (1):
  git-am: implement --reject option passed to git-apply
