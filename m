From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Wed, 14 Nov 2007 16:20:55 -0800
Message-ID: <7vabpg9x5k.fsf@gitster.siamese.dyndns.org>
References: <20071022061115.GR14735@spearce.org>
	<7vodeecyni.fsf@gitster.siamese.dyndns.org>
	<7vpryqwtt7.fsf@gitster.siamese.dyndns.org>
	<7vk5ot40w9.fsf@gitster.siamese.dyndns.org>
	<7vy7d43ptc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 01:21:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsSU7-0006Z2-Rh
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 01:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388AbXKOAVQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2007 19:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753363AbXKOAVP
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 19:21:15 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:36193 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147AbXKOAVO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Nov 2007 19:21:14 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 1D58F2EF;
	Wed, 14 Nov 2007 19:21:36 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6ADEF95CEA;
	Wed, 14 Nov 2007 19:21:34 -0500 (EST)
X-maint-at: b57321f57b324320bdcf9f453ec4788da166f8f4
X-master-at: 039bc64e886716593d59910694a6c8ed5b72c515
In-Reply-To: <7vy7d43ptc.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 11 Nov 2007 23:06:55 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65029>

* The 'maint' branch has these fixes since the last announcement.

Benoit Sigoure (1):
  git-svn: prevent dcommitting if the index is dirty.

Christian Couder (1):
  for-each-ref: fix off by one read.

Jeff King (1):
  git-branch: remove mention of non-existent '-b' option

Jing Xue (1):
  replace reference to git-rm with git-reset in git-commit doc

Jonas Fonseca (1):
  Documentation: Fix man page breakage with DocBook XSL v1.72

Junio C Hamano (3):
  t/t3404: fix test for a bogus todo file.
  revert/cherry-pick: allow starting from dirty work tree.
  git-clean: honor core.excludesfile

Sergei Organov (2):
  core-tutorial.txt: Fix argument mistake in an example.
  git-remote.txt: fix typo

Shawn O. Pearce (2):
  Fix memory leak in traverse_commit_list
  Don't allow fast-import tree delta chains to exceed maximum depth

Wincent Colaiuta (1):
  Grammar fixes for gitattributes documentation


* The 'master' branch has these since the last announcement
  in addition to the above.

Alex Riesen (1):
  Fix dependencies of parse-options test program

Andreas Ericsson (1):
  Simplify strchrnul() compat code

Bj=C3=B6rn Steinbrink (3):
  git-commit.sh: Fix usage checks regarding paths given when they do
      not make sense
  t7005-editor.sh: Don't invoke real vi when it is in GIT_EXEC_PATH
  git-commit: Add tests for invalid usage of -a/--interactive with
      paths

Brian Gernhardt (2):
  format-patch: Add configuration and off switch for --numbered
  format-patch: Test --[no-]numbered and format.numbered

David Symonds (1):
  Rearrange git-format-patch synopsis to improve clarity.

Emil Medve (1):
  git-stash: Fix listing stashes

Eric Wong (1):
  git-svn: support for funky branch and project names over HTTP(S)

Gordon Hopper (1):
  git-cvsimport: fix handling of user name when it is not set in
      CVSROOT

Johannes Schindelin (2):
  rebase: operate on a detached HEAD
  rebase: fix "rebase --continue" breakage

Johannes Sixt (2):
  git-clean: Fix error message if clean.requireForce is not set.
  Fix preprocessor logic that determines the availablity of
      strchrnul().

Jonas Fonseca (1):
  Documentation: Fix references to deprecated commands

Junio C Hamano (9):
  stash: implement "stash create"
  rebase: allow starting from a dirty tree.
  Revert "rebase: allow starting from a dirty tree."
  git-merge: no reason to use cpio anymore
  ce_match_stat, run_diff_files: use symbolic constants for
      readability
  git-add: make the entry stat-clean after re-adding the same
      contents
  t2200: test more cases of "add -u"
  Resurrect git-revert.sh example and add comment to builtin-revert.c
  core.excludesfile clean-up

Mike Hommey (2):
  Reuse previous annotation when overwriting a tag
  Add tests for git tag

Nicolas Pitre (6):
  fix display overlap between remote and local progress
  sideband.c: ESC is spelled '\033' not '\e' for portability.
  make display of total transferred more accurate
  remove dead code from the csum-file interface
  make display of total transferred fully accurate
  nicer display of thin pack completion

Pierre Habouzit (1):
  git-fetch: be even quieter.

Ren=C3=A9 Scharfe (5):
  Add strchrnul()
  --pretty=3Dformat: on-demand format expansion
  --pretty=3Dformat: parse commit message only once
  add strbuf_adddup()
  --format=3Dpretty: avoid calculating expensive expansions twice

Robin Rosenberg (1):
  cvsexportcommit: Add switch to specify CVS workdir

R=C3=A9mi Vanicat (1):
  Make GIT_INDEX_FILE apply to git-commit

Sergei Organov (2):
  user-manual.txt: fix a few mistakes
  user-manual: minor rewording for clarity.

Shawn O. Pearce (5):
  git-fetch: Always fetch tags if the object they reference exists
  run-command: Support sending stderr to /dev/null
  rev-list: Introduce --quiet to avoid /dev/null redirects
  git-fetch: avoid local fetching from alternate (again)
  Handle broken vsnprintf implementations in strbuf
