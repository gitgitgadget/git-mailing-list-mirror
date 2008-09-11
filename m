From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Sep 2008, #02; Wed, 10)
Date: Wed, 10 Sep 2008 20:49:40 -0700
Message-ID: <7viqt3tk8b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 11 05:51:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KddCq-00028Q-Cw
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 05:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962AbYIKDtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 23:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753026AbYIKDtq
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 23:49:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36900 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbYIKDtp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 23:49:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 42B415F803;
	Wed, 10 Sep 2008 23:49:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7695A5F802; Wed, 10 Sep 2008 23:49:42 -0400 (EDT)
X-maint-at: 873358dd2ac3bf2cea9a370d8586378a27a092f2
X-master-at: ede4caf6e3204f9d63758d6410d0f124b0caab32
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: ABB54CC6-7FB4-11DD-B7E4-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95577>

There are still a few topics that are meant for 'maint' cooking in higher
stages; we will have 1.6.0.2 after they are merged down.

On the 'master' front, it looks like 1.6.1 will not have anything
particularly big like 1.6.0 did.  Other than many s/git-foo/git foo/
updates in tests (finished -- the documentation needs to go through the
same process), there are many small bells and whistles enhancements, but
nothing earth shattering.  I am expecting that we will go into 1.6.1-rc0
freeze in two weeks.

* The 'maint' branch has these fixes since the last announcement.

Arjen Laarhoven (1):
  Use compatibility regex library for OSX/Darwin

Junio C Hamano (4):
  checkout: do not check out unmerged higher stages randomly
  diff: Help "less" hide ^M from the output
  log --author/--committer: really match only with name part
  Update draft release notes for 1.6.0.2

Marcus Griep (2):
  Git.pm: Use File::Temp->tempfile instead of ->new
  git-svn: Fixes my() parameter list syntax error in pre-5.8 Perl

Miklos Vajna (1):
  t7501: always use test_cmp instead of diff

Nicolas Pitre (5):
  pack-objects: improve returned information from write_one()
  improve reliability of fixup_pack_header_footer()
  pack-objects: use fixup_pack_header_footer()'s validation mode
  index-pack: use fixup_pack_header_footer()'s validation mode
  fixup_pack_header_footer(): use nicely aligned buffer sizes


* The 'master' branch has these since the last announcement
  in addition to the above.

Alex Riesen (1):
  Add help.autocorrect to enable/disable autocorrecting

Andreas Ericsson (1):
  Teach "git diff -p" to locate PHP class methods

Arjen Laarhoven (1):
  t6023-merge-file: Work around non-portable sed usage

Christian Couder (1):
  refs: improve comments about "reading" argument of "resolve_ref"

Dotan Barak (1):
  Use xmalloc() and friends to catch allocation failures

Eric Wong (1):
  git-svn: fix handling of even funkier branch names

Giovanni Funchal (1):
  configure: auto detect dynamic library path switches

Heikki Orsila (1):
  Start conforming code to "git subcmd" style part 2

Johannes Schindelin (1):
  git wrapper: DWIM mistyped commands

Johannes Sixt (1):
  Windows: git-shell can be compiled again

Junio C Hamano (2):
  Makefile: Allow CC_LD_DYNPATH to be overriden
  Fix git-diff-tree --stdin

Michael J Gruber (2):
  allow installation of man and html doc from the man and html branches
  separate build targets for man and html documentation

Mikael Magnusson (1):
  Correct output of git-count-objects.

Nanako Shiraishi (8):
  t/t91XX-svn: start removing use of "git-" from these tests
  t/t91XX git-svn tests: run "git svn" not "git-svn"
  t9200: use "git cvsexportcommit" without dash
  t9300, t9301: use "git fast-import/fast-export" without dash
  t9700: use "git config" without dash
  tests: use "git foo" without dash in strings
  t9101: use "git hash-object" without dash
  Install git-cvsserver in $(bindir)
