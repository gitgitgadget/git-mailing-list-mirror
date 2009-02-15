From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Feb 2009, #03; Sun, 15)
Date: Sun, 15 Feb 2009 02:45:10 -0800
Message-ID: <7vvdrcm11l.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 15 11:46:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYeWK-0007Vd-Il
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 11:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbZBOKpR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Feb 2009 05:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbZBOKpQ
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 05:45:16 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64294 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbZBOKpP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Feb 2009 05:45:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9B81699D56;
	Sun, 15 Feb 2009 05:45:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BA7D099D55; Sun,
 15 Feb 2009 05:45:12 -0500 (EST)
X-maint-at: e5887c1bda12b31ea7af0ce798bfdee308e1b176
X-master-at: 075394e26cd7fb38e08d5f637a5fc825ab0b3fb3
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BA3606EA-FB4D-11DD-8E45-0433C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109990>

This is hopefully the last announcement before 1.6.2-rc1 is tagged.
Nothing unexpectedly complex nor controversial, just bunch of follow-up
fixes to what have already been scheduled for the upcoming release.

I am going to bed now; it is way past my bedtime.

* The 'master' branch has these since the last announcement.

=46abian Franz (1):
  submodule: add --no-fetch parameter to update command

Jacob Helwig (1):
  Add 'rm -f' equivalent to 'git rm' example of filter-branch
    --index-filter

Jakub Narebski (1):
  gitweb: Better regexp for SHA-1 committag match

Jeff King (1):
  symbolic-ref: allow refs/<whatever> in HEAD

Jeremy White (1):
  Update documentation to add further information about using Thunderbi=
rd
    with git-imap-send.

Johannes Schindelin (1):
  gc: make --prune useful again by accepting an optional parameter

Junio C Hamano (5):
  Revert "validate_headref: tighten ref-matching to just branches"
  Install the default "master" branch configuration after cloning a voi=
d
  Teach the "@{-1} syntax to "git branch"
  Teach @{-1} to git merge
  RelNotes Update

Keith Cascio (1):
  Remove redundant bit clears from diff_setup()

Marcel M. Cary (1):
  git-sh-setup: Use "cd" option, not /bin/pwd, for symlinked work tree

Marius Storm-Olsen (5):
  Add mailmap.file as configurational option for mailmap location
  Add find_insert_index, insert_at_index and clear_func functions to
    string_list
  Add map_user() and clear_mailmap() to mailmap
  Change current mailmap usage to do matching on both name and email of
    author/committer.
  Move mailmap documentation into separate file

Mark Burton (1):
  git-rebase.txt: --interactive does not work with --whitespace

Matt Kraai (1):
  bash-completion: Complete the values of color.interactive, color.ui,
    color.pager

Nazri Ramliy (1):
  Bugfix: GIT_EXTERNAL_DIFF with more than one changed files

SZEDER G=C3=A1bor (3):
  Move 'rev-parse --git-dir' test to t1500
  t1500: more 'git rev-parse --git-dir' tests
  bash: fix misspelled 'git svn' option

Tay Ray Chuan (1):
  use a hash of the lock token as the suffix for PUT/MOVE

Thomas Rast (2):
  log: do not print ellipses with --abbrev-commit
  Documentation: pruning recipe for destructive filter-branch
