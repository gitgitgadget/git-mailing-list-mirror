From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (stable)
Date: Fri, 13 Jun 2008 03:10:35 -0700
Message-ID: <7vfxrhwspw.fsf@gitster.siamese.dyndns.org>
References: <7vtzibbjxn.fsf@gitster.siamese.dyndns.org>
 <7vwsn75pmv.fsf@gitster.siamese.dyndns.org>
 <7vy77gapkl.fsf@gitster.siamese.dyndns.org>
 <7vmynqfeab.fsf@gitster.siamese.dyndns.org>
 <7vwsmjj0js.fsf@gitster.siamese.dyndns.org>
 <7vhcdchr80.fsf@gitster.siamese.dyndns.org>
 <7vhcd0jyyp.fsf@gitster.siamese.dyndns.org>
 <7vod6wpjvr.fsf@gitster.siamese.dyndns.org>
 <7vod6nikuw.fsf@gitster.siamese.dyndns.org>
 <7viqws6zaz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 12:11:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K76G5-0002ry-GG
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 12:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757957AbYFMKKx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2008 06:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757648AbYFMKKx
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 06:10:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49756 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbYFMKKv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Jun 2008 06:10:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3F74726A8;
	Fri, 13 Jun 2008 06:10:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E771126A6; Fri, 13 Jun 2008 06:10:45 -0400 (EDT)
X-maint-at: 2feaf4e977c5e7392ef42689b34d60c4d2f40f4f
X-master-at: dc92cc20f8dcfefcd5d79e8550736bcc437ea2e4
In-Reply-To: <7viqws6zaz.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 02 Jun 2008 01:01:08 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FE87478A-3930-11DD-AAD8-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84862>

Since v1.5.6-rc2 there are handful more fixes.  More important ones amo=
ng
them are:

 - "git-remote prune -n" fix (Olivier Marin)

 - "git-log --graph --first-parent" fix (Adam Simpkins)

 - "git-fast-export" fix for multi-root repository (Shawn)

 - "gitk" works better with detached HEAD (Paul Mackerras)

Time for -rc3 this weekend and hopefully the final sometime next week.

---
* The 'maint' branch has these fixes since the last announcement.

Bj=C3=B6rn Steinbrink (1):
  name-rev: Fix segmentation fault when using --all

=46red Maranh=C3=A3o (1):
  fix typo in tutorial

Johannes Sixt (1):
  Remove exec bit from builtin-fast-export.c

Junio C Hamano (1):
  GIT 1.5.5.4

Lea Wiemann (1):
  git-for-each-ref.txt: minor improvements

Michael Dressel (1):
  describe: match pattern for lightweight tags too

Miklos Vajna (1):
  git-read-tree: document -v option.


* The 'master' branch has these since the last announcement
  in addition to the above.

Adam Simpkins (2):
  graph API: fix "git log --graph --first-parent"
  git log --graph: print '*' for all commits, including merges

Alex Riesen (1):
  Fix t5516 on cygwin: it does not like double slashes at the beginning=
 of
    a path

Ask Bj=C3=B8rn Hansen (2):
  gitweb setup instruction: rewrite HEAD and root as well
  send-email: Allow the envelope sender to be set via configuration

Boyd Lynn Gerber (2):
  progress.c: avoid use of dynamic-sized array
  Port to 12 other Platforms.

Chris Ridd (1):
  Improve sed portability

Christian Couder (2):
  documentation: convert "diffcore" and "repository-layout" to man page=
s
  documentation: move git(7) to git(1)

Daniel Barkalow (1):
  Use nonrelative paths instead of absolute paths for cloned repositori=
es

Dirk Suesserott (1):
  Documentation/git-mailsplit: Enhanced description of -o option

Geoffrey Irving (1):
  doc: adding gitman.info and *.texi to .gitignore

Jakub Narebski (2):
  gitweb: Fix "next" link on bottom of page
  gitweb: Add charset info to "raw" output of 'text/plain' blobs

Jeff King (2):
  Fix "git clone http://$URL" to check out the worktree when asked
  document --pretty=3Dtformat: option

Johannes Schindelin (1):
  merge-recursive: respect core.autocrlf when writing out the result

Johannes Sixt (2):
  rebase --interactive: Compute upstream SHA1 before switching branches
  make_nonrelative_path: Use is_absolute_path()

Junio C Hamano (12):
  commit: drop duplicated parents
  GIT v1.5.6-rc1
  t7502: do not globally unset GIT_COMMITTER_* environment variables
  t7502: tighten loosely written test sequence
  Documentation: git-log cannot use rev-list specific options
  t7502: honor SHELL_PATH
  GIT 1.5.6-rc2
  http-push.c: remove duplicated code
  "remote prune": be quiet when there is nothing to prune
  Documentation/git-pull.txt: Use more standard [NOTE] markup
  Documentation: exclude @pxref{[REMOTES]} from texinfo intermediate ou=
tput
  user-manual: describe how higher stages are set during a merge

Karl Hasselstr=C3=B6m (1):
  Revert "git.el: Set process-environment instead of invoking env"

Kevin Ballard (1):
  Documentation/git-filter-branch.txt: Fix description of --commit-filt=
er

Lea Wiemann (5):
  cat-file --batch: flush stdout also when objects are missing
  t1006-cat-file.sh: typo
  cat-file --batch / --batch-check: do not exit if hashes are missing
  Documentation/git-cat-file.txt: add missing line break
  t/.gitattributes: only ignore whitespace errors in test files

Linus Torvalds (1):
  Consolidate SHA1 object file close

Marius Storm-Olsen (1):
  Add testcase for merging in a CRLF repo

Mikael Magnusson (1):
  Typo in RelNotes.

Miklos Vajna (3):
  Strbuf documentation: document most functions
  Remove unused code in parse_commit_buffer()
  git-rebase -i: mention the short command aliases in the todo list

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

Shawn O. Pearce (1):
  fast-export: Correctly generate initial commits with no parents

Stephan Beyer (6):
  git-commit.txt: Correct option alternatives
  git-commit.txt: Add missing long/short options
  Docs: Use "-l::\n--long\n" format in OPTIONS sections
  Docs: add some long/short options
  git-describe.txt: document --always
  git-name-rev.txt: document --no-undefined and --always

Teemu Likonen (1):
  Print info about "git help COMMAND" on git's main usage pages
