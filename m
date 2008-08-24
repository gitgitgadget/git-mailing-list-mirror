From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Aug 2008, #06; Sat, 23)
Date: Sat, 23 Aug 2008 20:37:59 -0700
Message-ID: <7v7ia7t754.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 24 05:39:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KX6Rd-0006dQ-B6
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 05:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbYHXDiI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Aug 2008 23:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbYHXDiH
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 23:38:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbYHXDiF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Aug 2008 23:38:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F29E86C5F0;
	Sat, 23 Aug 2008 23:38:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1F4F86C5EF; Sat, 23 Aug 2008 23:38:01 -0400 (EDT)
X-maint-at: 913e0e99b6a6e63af6a062622a1f94bd78fd8052
X-master-at: d6096f17d2d5d9ccb453aabf8edc6ee238b166fc
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0E46FB6C-718E-11DD-BD93-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93512>

There are a few fix-up that just have started cooking in 'next/pu'; the=
y
eventually should be merged to 'maint', but not yet.

There are quite a few topics graduated to 'master'.

* The 'maint' branch has these fixes since the last announcement.

Brandon Casey (2):
  revision.h: make show_early_output an extern which is defined in
    revision.c
  compat/snprintf.c: handle snprintf's that always return the # chars
    transmitted

Eric Raible (1):
  Completion: add missing '=3D' for 'diff --diff-filter'

Eric Wong (1):
  git-svn: fix dcommit to urls with embedded usernames

Junio C Hamano (1):
  unpack_trees(): protect the handcrafted in-core index from read_cache=
()

Miklos Vajna (1):
  Fix 'git help help'

Tor Arvid Lund (1):
  git-p4: Fix one-liner in p4_write_pipe function.


* The 'master' branch has these since the last announcement
  in addition to the above.

Alex Riesen (1):
  Extend "checkout --track" DWIM to support more cases

Brandon Casey (1):
  remote.c: add a function for deleting a refspec array and use it (twi=
ce)

Christian Couder (1):
  merge-base: teach "git merge-base" to drive underlying merge_bases_ma=
ny()

Dan Hensgen (1):
  git-merge documentation: more details about resolving conflicts

David Aguilar (1):
  git-submodule: replace duplicated code with a module_list function

Johan Herland (1):
  Teach "git diff -p" HTML funcname patterns

Johannes Schindelin (4):
  t9700: remove useless check
  tests: Clarify dependencies between tests, 'aggregate-results' and
    'clean'
  Enable parallel tests
  test-lib: do not remove trash_directory if called with --debug

Johannes Sixt (1):
  filter-branch: Grok special characters in tag names

Jonathan del Strother (1):
  Revert "Convert output messages in merge-recursive to past tense."

Junio C Hamano (8):
  documentation: merge-base: explain "git merge-base" with more than 2 =
args
  merge-base-many: add trivial tests based on the documentation
  git-merge-octopus: use (merge-base A (merge B C D E...)) for stepwise
    merge
  update-index: refuse to add working tree items beyond symlinks
  add: refuse to add working tree items beyond symlinks
  index: future proof for "extended" index entries
  tests: use $TEST_DIRECTORY to refer to the t/ directory
  templates/Makefile: install is unnecessary, just use mkdir -p

Karl Hasselstr=C3=B6m (4):
  Refactoring: Split up diff_tree_stdin
  diff-tree: Note that the commit ID is printed with --stdin
  Teach git diff-tree --stdin to diff trees
  Add test for diff-tree --stdin with two trees

Kirill Smelkov (1):
  Teach "git diff -p" Python funcname patterns

Marcus Griep (2):
  count-objects: Add total pack size to verbose output
  Update t/.gitignore to ignore all trash directories

Marek Zawirski (1):
  Make push more verbose about illegal combination of options

Mark Levedahl (1):
  git-submodule - Add 'foreach' subcommand

Neil Roberts (1):
  config.mak.in: Pass on LDFLAGS from configure

Paolo Bonzini (1):
  provide more errors for the "merge into empty head" case

Peter Valdemar M=C3=B8rch (2):
  Teach git log --check to return an appropriate exit code
  Teach git log --exit-code to return an appropriate exit code

Pieter de Bie (1):
  builtin-reflog: Allow reflog expire to name partial ref

Shawn O. Pearce (1):
  Make reflog query '@{1219188291}' act as '@{2008.8.19.16:24:51.-0700}=
'

Stephan Beyer (1):
  Fix commit_tree() buffer leak
