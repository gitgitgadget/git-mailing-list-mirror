From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Jan 2009, #01; Wed, 14)
Date: Wed, 14 Jan 2009 03:32:37 -0800
Message-ID: <7vhc423yy2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 12:34:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN40n-00084q-BW
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 12:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755670AbZANLcr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Jan 2009 06:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754264AbZANLcp
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 06:32:45 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37631 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755559AbZANLcm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2009 06:32:42 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 17BD790477;
	Wed, 14 Jan 2009 06:32:41 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EF01390476; Wed,
 14 Jan 2009 06:32:38 -0500 (EST)
X-maint-at: 4f8b8992ef0c009822cdca18d32ddf3a124ee284
X-master-at: 3cf3b838c7b379824c68ee87799aaaa9028b36cd
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0D9ECCE6-E22F-11DD-9A6D-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105618>

Many topics graduated to 'master' and I updated the draft release notes
for 1.6.2.

* The 'maint' branch has these fixes since the last announcement.

Clemens Buchacher (1):
  modify/delete conflict resolution overwrites untracked file

=46elipe Contreras (1):
  fast-import: Cleanup mode setting.

Henrik Austad (2):
  Use capitalized names where appropriate
  Be consistent in switch usage for tar

Jay Soffian (1):
  Git.pm: call Error::Simple() properly

Joey Hess (1):
  README: tutorial.txt is now called gittutorial.txt

Johannes Schindelin (1):
  merge-recursive: mark rename/delete conflict as unmerged

Junio C Hamano (3):
  merge-recursive: do not clobber untracked working tree garbage
  builtin-apply: prevent non-explicit permission changes
  git checkout: do not allow switching to a tree-ish that is not a comm=
it

Kirill A. Korinskiy (1):
  http-push: support full URI in handle_remote_ls_ctx()

Markus Heidelberg (1):
  doc/git-send-email: mention sendemail.cc config variable

Miklos Vajna (1):
  fast-export: print usage when no options specified

Pierre Habouzit (1):
  Avoid spurious error messages on error mistakes.

jidanni@jidanni.org (3):
  Documentation/git-tag.txt: minor typo and grammar fix
  Documentation/git-push.txt: minor: compress one option
  contrib/examples/README: give an explanation of the status of these f=
iles


* The 'master' branch has these since the last announcement
  in addition to the above.

Adeodato Sim=C3=B3 (2):
  builtin-shortlog.c: use string_list_append(), and don't strdup
    unnecessarily
  t7501-commit.sh: explicitly check that -F prevents invoking the edito=
r

Alexander Potashev (1):
  remove trailing LF in die() messages

Charles Bailey (4):
  Fix some tab/space inconsistencies in git-mergetool.sh
  Add -y/--no-prompt option to mergetool
  mergetool: Add prompt to continue after failing to merge a file
  mergetool: Don't keep temporary merge files unless told to

Christian Couder (1):
  sha1_file: make "read_object" static

Clemens Buchacher (3):
  unpack-trees: handle failure in verify_absent
  unpack-trees: fix path search bug in verify_absent
  unpack-trees: remove redundant path search in verify_absent

Eric Wong (1):
  git-svn: add --authors-file test

=46abian Emmes (2):
  cvsserver: add option to configure commit message
  cvsserver: change generation of CVS author names

Giuseppe Bilotta (1):
  gitweb: use href() when generating URLs in OPML

Jakub Narebski (3):
  gitweb: Move 'lineno' id from link to row element in git_blame
  gitweb: A bit of code cleanup in git_blame()
  gitweb: cache $parent_commit info in git_blame()

Jeff King (1):
  Makefile: clean up TEST_PROGRAMS definition

Johannes Schindelin (5):
  git wrapper: Make while loop more reader-friendly
  bisect view: call gitk if Cygwin's SESSIONNAME variable is set
  bundle: allow rev-list options to exclude annotated tags
  git add: do not add files from a submodule
  show <tag>: reuse pp_user_info() instead of duplicating code

Jon Loeliger (1):
  Fix Documentation typos surrounding the word 'handful'.

Junio C Hamano (2):
  ls-tree: add --full-tree option
  Update 1.6.2 draft release notes

Kjetil Barvik (1):
  Cleanup of unused symcache variable inside diff-lib.c

Lee Marlow (2):
  bash completion: Add '--intent-to-add' long option for 'git add'
  bash completion: Use 'git add' completions for 'git stage'

Marcel M. Cary (1):
  git-sh-setup: Fix scripts whose PWD is a symlink to a work-dir on OS =
X

Markus Heidelberg (3):
  git-cherry: make <upstream> parameter optional
  Documentation: clarify which parameters are optional to git-cherry
  contrib/vim: change URL to point to the latest syntax files

Matt Kraai (1):
  gitweb: unify boolean feature subroutines

Miklos Vajna (1):
  Add support for a pdf version of the user manual

Nanako Shiraishi (1):
  Document git-ls-tree --full-tree

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
  grep: support --no-ext-grep to test builtin grep
  grep: grep cache entries if they are "assume unchanged"

Nicolas Pitre (1):
  objects to be pruned immediately don't have to be loosened

Paul Jarc (1):
  configure clobbers LDFLAGS

Philippe Bruhat (1):
  Git.pm: correctly handle directory name that evaluates to "false"

Pierre Habouzit (1):
  filter-branch: add git_commit_non_empty_tree and --prune-empty.

Ren=C3=A9 Scharfe (2):
  diff: add option to show context between close hunks
  strbuf: instate cleanup rule in case of non-memory errors

SZEDER G=C3=A1bor (1):
  bash: add '--merge' to 'git reset'

William Pursell (2):
  Add subroutine to display one-line summary of hunks
  Add 'g' command to go to a hunk
