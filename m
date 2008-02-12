From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git
Date: Mon, 11 Feb 2008 23:25:09 -0800
Message-ID: <7vd4r24ox6.fsf@gitster.siamese.dyndns.org>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 12 08:26:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOpX2-00070L-D1
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 08:26:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759402AbYBLHZp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2008 02:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759510AbYBLHZp
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 02:25:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:52754 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759017AbYBLHZo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2008 02:25:44 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 02BE833CD;
	Tue, 12 Feb 2008 02:25:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 11DDD33C7;
	Tue, 12 Feb 2008 02:25:40 -0500 (EST)
X-maint-at: 6c47d0e8f3983cff5bf633cb8e6f7ecfecf48db7
X-master-at: ecb879f8772d5970bf1eb3677f9c9ebdd6e116a1
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73632>

Config parser fixes are in 'maint', along with many other
minor fixes.

As promised, a handful topics that have been cooking in 'next'
have graduated to 'master'.

----------------------------------------------------------------

* The 'maint' branch has these fixes since v1.5.4.1

David Steven Tweed (1):
  Make git prune remove temporary packs that look like write failures

=46rank Lichtenheld (1):
  config: Fix --unset for continuation lines

Gerrit Pape (1):
  builtin-commit: remove .git/SQUASH_MSG upon successful commit

James Bowes (1):
  Add a BuildRequires for gettext in the spec file.

Johannes Schindelin (2):
  bisect: allow starting with a detached HEAD
  Document that the default of branch.autosetupmerge is true

Jonas Fonseca (1):
  man pages are littered with .ft C and others

Junio C Hamano (24):
  git-pull documentation: fix markup
  archive-tar.c: guard config parser from value=3DNULL
  Add config_error_nonbool() helper function
  builtin-apply.c: guard config parser from value=3DNULL
  builtin-branch.c: guard config parser from value=3DNULL
  builtin-commit.c: guard config parser from value=3DNULL
  builtin-config.c: guard config parser from value=3DNULL
  builtin-log.c: guard config parser from value=3DNULL
  builtin-reflog.c: guard config parser from value=3DNULL
  builtin-show-branch.c: guard config parser from value=3DNULL
  builtin-tag.c: guard config parser from value=3DNULL
  connect.c: guard config parser from value=3DNULL
  convert.c: guard config parser from value=3DNULL
  diff.c: guard config parser from value=3DNULL
  git.c: guard config parser from value=3DNULL
  help.c: guard config parser from value=3DNULL
  http.c: guard config parser from value=3DNULL
  merge-recursive.c: guard config parser from value=3DNULL
  remote.c: guard config parser from value=3DNULL
  setup.c: guard config parser from value=3DNULL
  wt-status.c: guard config parser from value=3DNULL
  imap-send.c: guard config parser from value=3DNULL
  builtin-log.c: guard config parser from value=3DNULL
  config.c: guard config parser from value=3DNULL

Martin Koegler (1):
  pack-objects: only throw away data during memory pressure

Mike Hommey (1):
  Work around curl-gnutls not liking to be reinitialized

Miklos Vajna (1):
  builtin-gc.c: guard config parser from value=3DNULL

Uwe Kleine-K=C3=B6nig (1):
  rebase -i: accept -m as advertised in the man page


* The 'master' branch has these since v1.5.4 in addition to the
  above.

Alexandre Julliard (4):
  git.el: Support for showing unknown/ignored directories.
  git.el: Added a command to amend a commit.
  git.el: Check for existing buffers on revert.
  git.el: Better handling of subprocess errors.

Bruno Ribas (1):
  gitweb: Make use of the $git_dir variable at sub git_get_project_url_=
list

Christian Couder (1):
  config: add test cases for empty value and no value config variables.

Daniel Barkalow (2):
  Test :/string form for checkout
  Reduce the number of connects when fetching

David Brown (1):
  git-send-email: Generalize auto-cc recipient mechanism.

Eric Wong (1):
  git-svn: improve repository URL matching when following parents

=46lorian La Roche (1):
  gitweb: Make feed entries point to commitdiff view

James Bowes (1):
  Add a BuildRequires for gettext in the spec file.

Jason McMullan (1):
  Remove $Id: ..$ $Header: ..$ etc from +ko and +k files during import

Johannes Schindelin (3):
  Also use unpack_trees() in do_diff_cache()
  Fix "git clone" for git:// protocol
  Introduce the config variable pack.packSizeLimit

Johannes Sixt (1):
  Fix misuse of prefix_path()

Jonas Fonseca (1):
  man pages are littered with .ft C and others

Junichi Uekawa (1):
  git-blame.el: show the when, who and what in the minibuffer.

Junio C Hamano (12):
  index: be careful when handling long names
  Avoid running lstat(2) on the same cache entry.
  read-cache.c: fix a couple more CE_REMOVE conversion
  read-cache.c: introduce is_racy_timestamp() helper
  lazy index hashing
  Sane use of test_expect_failure
  test: reword the final message of tests with known breakages
  known breakage: revision range computation with clock skew
  fix misuse of prefix_path()
  Make error messages from cherry-pick/revert more sensible
  Define the project whitespace policy
  Update the main documentation (stale notes section)

Karl Hasselstr=C3=B6m (2):
  git-svn: Don't call git-repack anymore
  Let "git svn" run "git gc --auto" occasionally

Linus Torvalds (3):
  Make on-disk index representation separate from in-core one
  Make run_diff_index() use unpack_trees(), not read_tree()
  Create pathname-based hash-table lookup into index

Martin Koegler (2):
  git-fsck: report missing author/commit line in a commit as an error
  parse_object_buffer: don't ignore errors from the object specific par=
sing
    functions

Michael Witten (3):
  git-send-email: ssh/login style password requests
  git-send-email: SIG{TERM,INT} handlers
  git-send-email: Better handling of EOF

Mike Hommey (1):
  Work around curl-gnutls not liking to be reinitialized

Pierre Habouzit (2):
  git-describe: Add a --match option to limit considered tags.
  git-name-rev: add a --(no-)undefined option.

Rafael Garcia-Suarez (1):
  Make git-remote.perl "use strict" compliant

Robin Rosenberg (1):
  Improve bash prompt to detect various states like an unfinished merge

Simon Hausmann (2):
  git-p4: Fix submit user-interface.
  git-p4: Ensure the working directory and the index are clean before
    "git-p4 rebase"

Tim Stoakes (1):
  Add `git svn blame' command

Toby Allsopp (1):
  git-p4: Fix indentation from tab to spaces

Tommy Thorn (1):
  git-p4: Fix an obvious typo
