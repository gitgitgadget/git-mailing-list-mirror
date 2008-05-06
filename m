From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Mon, 05 May 2008 23:38:39 -0700
Message-ID: <7vhcdchr80.fsf@gitster.siamese.dyndns.org>
References: <7vtzibbjxn.fsf@gitster.siamese.dyndns.org>
 <7vwsn75pmv.fsf@gitster.siamese.dyndns.org>
 <7vy77gapkl.fsf@gitster.siamese.dyndns.org>
 <7vmynqfeab.fsf@gitster.siamese.dyndns.org>
 <7vwsmjj0js.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 08:40:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtGqO-0003QS-03
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 08:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752666AbYEFGjS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 May 2008 02:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752412AbYEFGjS
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 02:39:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63949 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbYEFGjO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2008 02:39:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B30E0355D;
	Tue,  6 May 2008 02:38:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id C6254355B; Tue,  6 May 2008 02:38:46 -0400 (EDT)
X-maint-at: 6233a5210ef64ba31bbf0e867e03e9176e0aace9
X-master-at: 867fa20fe929942fba2345adc591e6f5c74f8c11
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 15671A1A-1B37-11DD-BFDB-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81335>

* The 'maint' branch has these fixes since the last announcement.

Alex Riesen (2):
  Use "=3D" instead of "=3D=3D" in condition as it is more portable
  Fix use after free() in builtin-fetch

Dan McGee (1):
  Remove 'header' from --signoff option description

=46lorian Ragwitz (1):
  filter-branch: Documentation fix.

Jeff King (3):
  fix reflog approxidate parsing bug
  cvsimport: always pass user data to "system" as a list
  checkout: don't rfc2047-encode oneline on detached HEAD

Junio C Hamano (2):
  clone: detect and fail on excess parameters
  fetch-pack: brown paper bag fix

Linus Torvalds (1):
  fetch-pack: do not stop traversing an already parsed commit


* The 'master' branch has these since the last announcement
  in addition to the above.

Adam Simpkins (2):
  Remove dead code: show_log() sep argument and diff_options.msg_sep
  log: print log entry terminator even if the message is empty

Alex Riesen (1):
  Use the modern syntax of git-diff-files in t2002-checkout-cache-u.sh

Bart Trojanowski (1):
  make git-status use a pager

Brandon Casey (1):
  filter-branch.sh: support nearly proper tag name filtering

Christian Couder (3):
  rev-parse: teach "--verify" to be quiet when using "-q" or "--quiet"
  rev-parse: fix --verify to error out when passed junk after a good re=
v
  Documentation: hooks: fix missing verb in pre-applypatch description

Gustaf Hendeby (2):
  git-svn: Make create-ignore use git add -f
  Documentation: Add create-ignore to git svn manual

Heikki Orsila (4):
  Document functions xmemdupz(), xread() and xwrite()
  Die for an early EOF in a file reading loop
  Make read_in_full() and write_in_full() consistent with xread() and
    xwrite()
  Cleanup xread() loops to use read_in_full()

Jeff King (2):
  git-fetch: always show status of non-tracking-ref fetches
  Documentation: point git-prune users to git-gc

Jon Loeliger (1):
  Add otherwise missing --strict option to unpack-objects summary.

Junio C Hamano (2):
  write_index(): optimize ce_smudge_racily_clean_entry() calls with
    CE_UPTODATE
  diff-files: mark an index entry we know is up-to-date as such

J=C3=B6rg Sommer (1):
  post-merge: Add it's not executed if merge failed.

Lars Hjemli (7):
  Add platform-independent .git "symlink"
  Teach resolve_gitlink_ref() about the .git file
  Teach git-submodule.sh about the .git file
  Teach GIT-VERSION-GEN about the .git file
  git-branch: add support for --merged and --no-merged
  git-branch.txt: compare --contains, --merged and --no-merged
  Add tests for `branch --[no-]merged`

Liu Yubao (1):
  Documentation on --git-dir and --work-tree

Matthieu Moy (1):
  git-svn: detect and fail gracefully when dcommitting to a void

Miklos Vajna (2):
  git checkout: add -t alias for --track
  INSTALL: add a note about GNU interactive tools has been renamed

Paolo Bonzini (1):
  Add a remote.*.mirror configuration option

Richard Quirk (2):
  bash: Add completion for gitk --merge
  Documentation gitk: Describe what --merge does

Stephen R. van den Berg (1):
  git-svn: Same default as cvsimport when using --use-log-author
