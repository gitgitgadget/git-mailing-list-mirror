From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Mar 2009, #01; Tue, 03)
Date: Tue, 03 Mar 2009 01:09:14 -0800
Message-ID: <7viqmrdlc5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 10:10:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeQeI-0002V6-Ey
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 10:10:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752725AbZCCJJY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 04:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbZCCJJW
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 04:09:22 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58619 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbZCCJJV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 04:09:21 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 32E089E7D3;
	Tue,  3 Mar 2009 04:09:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 15F349E7D1; Tue,
  3 Mar 2009 04:09:16 -0500 (EST)
X-maint-at: dcc901bc2926f92558a854430570123b4152451d
X-master-at: 1d035f85649cbb0a4fcc3e341f7e854acf9cf3c1
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FA51543C-07D2-11DE-8C3A-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112038>

Hopefully the last "What's in" before 1.6.2 final.  Small fixes here an=
d
there and nothing earth shattering.

* The 'maint' branch has these fixes since the last announcement.

Danijel Tasov (1):
  added missing backtick in git-apply.txt

David J. Mellor (1):
  Documentation: minor grammatical fixes.

Gerrit Pape (1):
  Documentation/git-push: --all, --mirror, --tags can not be combined

Junio C Hamano (1):
  tests: fix "export var=3Dval"

Matthieu Moy (2):
  Document git blame --reverse.
  More friendly message when locking the index fails.

Michael Spang (1):
  Skip timestamp differences for diff --no-index

Todd Zullinger (1):
  Documentation: Note file formats send-email accepts


* The 'master' branch has these since the last announcement
  in addition to the above.

Abhijit Menon-Sen (1):
  Convert git-* invocations to "git *" in the svnimport example.

Alexandre Julliard (3):
  git.el: Make sure that file lists are sorted as they are created.
  git.el: Improve the confirmation message on remove and revert.
  Add a README in the contrib/emacs directory.

Allan Caffee (1):
  trace: Fixed a minor typo in an error message.

Ben Walton (2):
  git-svn fix to avoid using strftime %z
  git-svn - return original format_svn_date semantics

Brian Gernhardt (1):
  git-svn: Create leading directories in create-ignore

Christian Couder (3):
  README: fix path to "gitcvs-migration.txt" and be more consistent
  bisect: fix quoting TRIED revs when "bad" commit is also "skip"ped
  bisect: fix another instance of eval'ed string

David J. Mellor (3):
  Documentation: minor grammatical fixes.
  Documentation: minor grammatical fixes.
  Documentation: minor grammatical fixes.

D=C3=A9vai Tam=C3=A1s (1):
  git-svn: Fix for rewriteRoot URL containing username.

Eric Wong (2):
  git-svn: fix delete+add branch tracking with empty files
  git-svn: disable broken symlink workaround by default

=46elipe Contreras (2):
  git add: trivial codestyle cleanup
  sha1_file.c: fix typo

Gerrit Pape (2):
  Install builtins with the user and group of the installing personalit=
y
  git-quiltimport: preserve standard input to be able to read user inpu=
t

Giuseppe Bilotta (1):
  gitweb: fix wrong base URL when non-root DirectoryIndex

Jay Soffian (3):
  disallow providing multiple upstream branches to rebase, pull --rebas=
e
  Allow HTTP tests to run on Darwin
  t5540-http-push.sh: avoid non-portable grep -P

Johannes Schindelin (2):
  Introduce the function strip_path_suffix()
  system_path(): simplify using strip_path_suffix(), and add suffix "gi=
t"

Johannes Sixt (2):
  gitattributes.txt: Path matching rules are explained in gitignore.txt
  t3400-rebase: Move detached HEAD check earlier

Junio C Hamano (4):
  git-svn: fix parsing of timestamp obtained from svn
  Make sure objects/pack exists before creating a new pack
  GIT 1.6.2-rc2
  git-am: make --abort less dangerous

Lars Noschinski (1):
  filter-branch -d: Export GIT_DIR earlier

Linus Torvalds (1):
  Support 'raw' date format

Marc Branchaud (1):
  Docs: Expand explanation of the use of + in git push refspecs.

Marcel M. Cary (2):
  gitweb: Fix warnings with override permitted but no repo override
  gitweb: Hyperlink multiple git hashes on the same commit message line

Michael J Gruber (2):
  Fix typo in contrib/examples/git-svnimport.txt
  git-am: Keep index in case of abort with dirty index

Mike Ralphson (1):
  Fix odb_mkstemp() on AIX

Paul Mackerras (1):
  gitk: Fix possible infinite loop and display corruption

Pete Wyckoff (1):
  git-p4: avoid syncing duplicate changes

Peter Oberndorfer (1):
  git-svn: read the dcommit url from the config file on a per remote ba=
sis

Ren=C3=A9 Scharfe (1):
  builtin-receive-pack.c: fix compiler warnings about format string

SZEDER G=C3=A1bor (2):
  bash: add missing 'git merge' options
  bash: update 'git svn' options

Thomas Rast (2):
  bash completion: refactor common log, shortlog and gitk options
  bash completion: only show 'log --merge' if merging

Todd Zullinger (1):
  git-rebase: Update --whitespace documentation
