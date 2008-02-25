From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Mon, 25 Feb 2008 00:42:26 -0800
Message-ID: <7vfxvhjukt.fsf@gitster.siamese.dyndns.org>
References: <7v8x27iui1.fsf@gitster.siamese.dyndns.org>
 <7vd4r24ox6.fsf@gitster.siamese.dyndns.org>
 <7vir0o44mt.fsf_-_@gitster.siamese.dyndns.org>
 <7vejb7ymep.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 09:43:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTYvq-0002q4-2x
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 09:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222AbYBYImj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Feb 2008 03:42:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754096AbYBYImi
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 03:42:38 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59208 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186AbYBYImh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Feb 2008 03:42:37 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E3B5C22CB;
	Mon, 25 Feb 2008 03:42:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E21B922C8; Mon, 25 Feb 2008 03:42:33 -0500 (EST)
X-maint-at: ce4a7bff41c6bb4dc2d578264a429b5e13e89bdc
X-master-at: 99d8ea2c5ce6fc0b06fe8a43e7c0c108ddad853b
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75015>

By the end of this week, we will hopefully pretty much know what
will be (and what won't be) in 1.5.5.  Tonight's 'master'
contains Linus's "diff --dirstat" and my "apply ---whitespace"
enhancements, among other things.  The next 'master' update is
expected to be fairly big (see "What's cooking").

----------------------------------------------------------------

* The 'maint' branch has these fixes since v1.5.4.3

Shawn O. Pearce (3):
  Ensure 'make dist' compiles git-archive.exe on Cygwin
  Protect peel_ref fallback case from NULL parse_object result
  Correct fast-export file mode strings to match fast-import standard

----------------------------------------------------------------

* The 'master' branch has these since the last announcement
  in addition to the above.

Gerrit Pape (2):
  git-merge-index documentation: clarify synopsis
  builtin-tag.c: remove cruft

Jakub Narebski (1):
  gitweb: Fix bugs in git_search_grep_body: it's length(), not len()

Jay Soffian (2):
  send-email: fix In-Reply-To regression
  pull: pass --strategy along to to rebase

Jeff King (5):
  git_config_*: don't assume we are parsing a config file
  t3404: use configured shell instead of /bin/sh
  diff: fix java funcname pattern for solaris
  t9001: enhance fake sendmail test harness
  send-email: test compose functionality

Johannes Sixt (1):
  prefix_path: use is_absolute_path() instead of *orig =3D=3D '/'

Junio C Hamano (18):
  builtin-apply.c: refactor small part that matches context
  builtin-apply.c: restructure "offset" matching
  builtin-apply.c: push match-beginning/end logic down
  builtin-apply.c: make it more line oriented
  builtin-apply.c: optimize match_beginning/end processing a bit.
  builtin-apply.c: mark common context lines in lineinfo structure.
  builtin-apply.c: clean-up apply_one_fragment()
  builtin-apply.c: simplify calling site to apply_line()
  builtin-apply.c: do not feed copy_wsfix() leading '+'
  builtin-apply.c: move copy_wsfix() function a bit higher.
  builtin-apply.c: pass ws_rule down to match_fragment()
  git-apply --whitespace=3Dfix: fix whitespace fuzz introduced by previ=
ous
    run
  core.whitespace: cr-at-eol
  apply: do not barf on patch with too large an offset
  git-reset --hard and git-read-tree --reset: fix read_cache_unmerged()
  gitweb: Better chopping in commit search results
  ws_fix_copy(): move the whitespace fixing function to ws.c
  diff --dirstat: saner handling of binary and unmerged files

Linus Torvalds (5):
  Add "--dirstat" for some directory statistics
  Fix name re-hashing semantics
  Name hash fixups: export (and rename) remove_hash_entry
  Use helper function for copying index entry information
  Be more verbose when checkout takes a long time

Michele Ballabio (1):
  builtin-for-each-ref.c: fix typo in error message

Miklos Vajna (1):
  git-clean: handle errors if removing files fails

Santi B=C3=A9jar (1):
  git-bundle.txt: Add different strategies to create the bundle

Shawn O. Pearce (1):
  Teach git-grep --name-only as synonym for -l
