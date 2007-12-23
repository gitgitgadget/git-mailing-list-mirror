From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable frozen)
Date: Sun, 23 Dec 2007 01:21:52 -0800
Message-ID: <7vfxxtu5ov.fsf@gitster.siamese.dyndns.org>
References: <20071022061115.GR14735@spearce.org>
	<7vodeecyni.fsf@gitster.siamese.dyndns.org>
	<7vpryqwtt7.fsf@gitster.siamese.dyndns.org>
	<7vk5ot40w9.fsf@gitster.siamese.dyndns.org>
	<7vy7d43ptc.fsf@gitster.siamese.dyndns.org>
	<7vabpg9x5k.fsf@gitster.siamese.dyndns.org>
	<7vy7cwsi3p.fsf@gitster.siamese.dyndns.org>
	<7vk5o6jbq9.fsf@gitster.siamese.dyndns.org>
	<7v63zjgoel.fsf@gitster.siamese.dyndns.org>
	<7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>
	<7vhcixtnm4.fsf@gitster.siamese.dyndns.org>
	<7vfxye4yv7.fsf@gitster.siamese.dyndns.org>
	<7vve78qhtf.fsf@gitster.siamese.dyndns.org>
	<7vbq8v5n0u.fsf_-_@gitster.siamese.dyndns.org>
	<7vy7btaf4p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 23 10:22:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6N2S-0003AV-1R
	for gcvg-git-2@gmane.org; Sun, 23 Dec 2007 10:22:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbXLWJWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2007 04:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbXLWJV7
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Dec 2007 04:21:59 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62614 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbXLWJV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2007 04:21:57 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 985A610BA;
	Sun, 23 Dec 2007 04:21:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C705B10B9;
	Sun, 23 Dec 2007 04:21:54 -0500 (EST)
X-maint-at: 4f3d37035a7c735a3b69f962656819f4ff7e4927
X-master-at: 0e545f75169e2c260dfb4445203c23cafdfc76ef
In-Reply-To: <7vy7btaf4p.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 17 Dec 2007 00:40:06 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69173>

Stabilization cycle towards -rc2 continues.

The main point of -rc cycle is regression fixes and general
bugfixes, although a few new features managed to slip in.

 - diff.external configuration variable serves the same purpose
   as GIT_EXTERNAL_DIFF environment;

 - "git diff --src-prefix=l/ --dst-prefix=k/" can be used to
   change the usual prefix (i.e. a/foo vs. b/foo).

----------------------------------------------------------------

* The 'maint' branch has these fixes since the last announcement.

Jeff King (2):
  clone: correctly report http_fetch errors
  git-send-email: avoid duplicate message-ids


* The 'master' branch has these since the last announcement
  in addition to the above.

Charles Bailey (2):
  Fix git-instaweb breakage on MacOS X due to the limited sed functionality
  Remove old generated files from .gitignore.

Eric Wong (3):
  git-svn: avoid leaving leftover committer/author info in rebase
  git-svn: workaround a for broken symlinks in SVN
  git-svn: avoid warning when run without arguments

Finn Arne Gangstad (1):
  Improved submodule merge support

Gustaf Hendeby (1):
  Make git send-email accept $EDITOR with arguments

H.Merijn Brand (1):
  the use of 'tr' in the test suite isn't really portable

Jakub Narebski (1):
  gitweb: fix whitespace in config_to_multi (indent with tab)

Jeff King (2):
  test "git clone -o"
  clean up 1.5.4 release notes

Jim Meyering (2):
  git-filter-branch.sh: more portable tr usage: use \012, not \n.
  Don't dereference NULL upon lookup failure.

Johannes Schindelin (6):
  Support config variable diff.external
  Document diff.external and mergetool.<tool>.path
  rebase -p -i: handle "no changes" gracefully
  git show <tag>: show the tagger
  Teach diff machinery to display other prefixes than "a/" and "b/"
  Mention git-shell's "cvs" substitution in the RelNotes

Johannes Sixt (3):
  Plug a resource leak in threaded pack-objects code.
  Clean up documentation that references deprecated 'git peek-remote'.
  filter-branch: Remove broken and unnecessary summary of rewritten refs.

Junio C Hamano (8):
  builtin-blame.c: remove unneeded memclr()
  GIT 1.5.4-rc1
  t4024: fix test script to use simpler sed pattern
  fix git commit --amend -m "new message"
  shell-scripts usage(): consistently exit with non-zero
  Documentation: ls-files -v is about "assume unchanged".
  Fix $EDITOR regression introduced by rewrite in C.
  Documentation: describe 'union' low-level merge driver

Linus Torvalds (2):
  unpack-trees: FLEX_ARRAY fix
  Re(-re)*fix trim_common_tail()

Marco Roeland (1):
  clone: fix options '-o' and '--origin' to be recognised again

Miklos Vajna (1):
  everyday: replace 'prune' and 'repack' with 'gc'

Nicolas Pitre (2):
  fix style of a few comments in diff-delta.c
  make 'git describe --all --contains' work

Pierre Habouzit (4):
  Fix segfault in diff-delta.c when FLEX_ARRAY is 1
  git-tag: fix -l switch handling regression.
  Force the sticked form for options with optional arguments.
  parse-options: Add a gitcli(5) man page.

Ralf Wildenhues (1):
  Fix some documentation typos.

Sam Vilain (1):
  Clarify error response from 'git fetch' for bad responses

Sean Estabrooks (1):
  Fix interactive rebase to preserve author email address

Shawn O. Pearce (3):
  Avoid update hook during git-rebase --interactive
  Catch and handle git-commit failures in git-rebase --interactive
  Reallow git-rebase --interactive --continue if commit is unnecessary

Stefan Sperling (1):
  Small comment fix for git-cvsimport.

Wincent Colaiuta (1):
  Emit helpful status for accidental "git stash" save
