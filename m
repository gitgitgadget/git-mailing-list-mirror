From: Junio C Hamano <gitster@pobox.com>
Subject: GIT 1.5.6-rc3
Date: Sat, 14 Jun 2008 22:16:58 -0700
Message-ID: <7v63sbe0qd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 15 07:18:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7kdQ-0006aV-Ta
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 07:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbYFOFRK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Jun 2008 01:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbYFOFRJ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 01:17:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45530 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbYFOFRF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Jun 2008 01:17:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ED9AE37D9;
	Sun, 15 Jun 2008 01:17:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 089E837D8; Sun, 15 Jun 2008 01:17:00 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 49DD92CE-3A9A-11DD-B8A7-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85064>

I've pushed out 1.5.6-rc3 to kernel.org.  Nothing majorly disrupting no=
r
scary here.

--

Ask Bj=C3=B8rn Hansen (2):
      gitweb setup instruction: rewrite HEAD and root as well
      send-email: Allow the envelope sender to be set via configuration

Avery Pennarun (2):
      git-svn: don't append extra newlines at the end of commit message=
s.
      git-svn: test that extra blank lines aren't inserted in commit me=
ssages.

Boyd Lynn Gerber (2):
      progress.c: avoid use of dynamic-sized array
      Port to 12 other Platforms.

Chris Ridd (1):
      Improve sed portability

Christian Couder (1):
      documentation: bisect: remove bits talking about a bisection bran=
ch

=46lavio Poletti (1):
      git-instaweb: improve auto-discovery of httpd and call convention=
s.

=46red Maranh=C3=A3o (1):
      fix typo in tutorial

Geoffrey Irving (1):
      doc: adding gitman.info and *.texi to .gitignore

Jakub Narebski (2):
      gitweb: Make it work with $GIT containing spaces
      Use 'trash directory' thoroughly in t/test-lib.sh

Jeff King (1):
      document --pretty=3Dtformat: option

Johannes Schindelin (1):
      merge-recursive: respect core.autocrlf when writing out the resul=
t

Johannes Sixt (2):
      make_nonrelative_path: Use is_absolute_path()
      Remove exec bit from builtin-fast-export.c

Junio C Hamano (8):
      http-push.c: remove duplicated code
      "remote prune": be quiet when there is nothing to prune
      Documentation/git-pull.txt: Use more standard [NOTE] markup
      Documentation: exclude @pxref{[REMOTES]} from texinfo intermediat=
e output
      user-manual: describe how higher stages are set during a merge
      t4126: fix test that happened to work due to timing
      sha1_file.c: dead code removal
      GIT 1.5.6-rc3

Lea Wiemann (4):
      t1006-cat-file.sh: typo
      cat-file --batch / --batch-check: do not exit if hashes are missi=
ng
      Documentation/git-cat-file.txt: add missing line break
      t/.gitattributes: only ignore whitespace errors in test files

Linus Torvalds (4):
      Consolidate SHA1 object file close
      Avoid cross-directory renames and linking on object creation
      Make loose object file reading more careful
      Simplify and rename find_sha1_file()

Marius Storm-Olsen (1):
      Add testcase for merging in a CRLF repo

Mark Levedahl (1):
      git-submodule - Fix errors regarding resolve_relative_url

Mikael Magnusson (1):
      Typo in RelNotes.

Mike Hommey (1):
      Don't allocate too much memory in quote_ref_url

Miklos Vajna (3):
      Remove unused code in parse_commit_buffer()
      git-rebase -i: mention the short command aliases in the todo list
      git-read-tree: document -v option.

Olivier Marin (4):
      remote show: fix the -n option
      builtin-remote: split show_or_prune() in two separate functions
      remote prune: print the list of pruned branches
      remote show: list tracked remote branches with -n

Paul Mackerras (1):
      gitk: Handle detached heads better

Philippe Bruhat (BooK) (1):
      git-cvsimport: do not fail when CVSROOT is /

Pieter de Bie (1):
      git-send-email: allow whitespace in addressee list

Ren=C3=A9 Scharfe (1):
      Ignore .gitattributes in bare repositories

SZEDER G=C3=A1bor (2):
      git add: add long equivalents of '-u' and '-f' options
      completion: add more 'git add' options

Shawn O. Pearce (1):
      fast-export: Correctly generate initial commits with no parents

Stephan Beyer (6):
      git-commit.txt: Correct option alternatives
      git-commit.txt: Add missing long/short options
      Docs: Use "-l::\n--long\n" format in OPTIONS sections
      Docs: add some long/short options
      git-describe.txt: document --always
      git-name-rev.txt: document --no-undefined and --always
