From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH 0/7] Some superficial documentation changes
Date: Mon, 30 Jun 2008 16:56:56 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jon Loeliger <jdl@jdl.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 30 23:58:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDROX-0001UG-CN
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 23:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763429AbYF3V5s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 17:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763066AbYF3V5s
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 17:57:48 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:48774 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761325AbYF3V5r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 17:57:47 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m5ULuxlX021059;
	Mon, 30 Jun 2008 16:57:02 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m5ULuus4007405;
	Mon, 30 Jun 2008 16:56:59 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86940>

This patch series is an updated version of a patch I sent this morning.
The purpose of the patches is to make the absence of git- commands not
so jarring while reading the manual.  It does this by holding fast to a
distinction between programs (like git-clone) and command lines (like
"git clone <repo>").

Issues:

 - It is a huge patch touching most of the manpages, not made by any
   automated process

 - Sometimes it is not clear whether a mention of git-diff, say, is
   referring to the `git-diff` program or the command line `git diff`
   (without any options). So we guess.

 - Most non-git man pages use 'italics' for the names of programs, but I
   stuck to `teletype text` because that is what seems to be most common
   in the Git docs. If people want to change this, I can send a separate
   patch to that end.

 - There are not enough cross-references (the "see also" sections are
   too often absent).

But at least I was able to check that patch 6/7 (which redistributes the
dashes in the world) doesn't touch anything but spaces and hyphens.
Hopefully that should make this easier to review.

Enjoy...

  Documentation: fix links to tutorials and other new manual pages
  whitespace fix in Documentation/git-repack.txt
  Documentation: complicate example of "man git-blah"
  git-daemon(1): don't assume git-daemon in /usr/bin
  Documentation: prepare to be consistent about "git-" versus "git "
  Documentation: be consistent about "git-" versus "git "
  Documentation formatting and cleanup

 Documentation/diff-options.txt           |    2 +-
 Documentation/git-add.txt                |    4 +-
 Documentation/git-am.txt                 |    4 +-
 Documentation/git-annotate.txt           |    2 +-
 Documentation/git-apply.txt              |   14 ++--
 Documentation/git-archimport.txt         |    8 +-
 Documentation/git-archive.txt            |    8 +-
 Documentation/git-bisect.txt             |    8 +-
 Documentation/git-blame.txt              |    6 +-
 Documentation/git-branch.txt             |   16 ++--
 Documentation/git-bundle.txt             |   41 ++++----
 Documentation/git-cat-file.txt           |    4 +-
 Documentation/git-check-attr.txt         |    2 +-
 Documentation/git-check-ref-format.txt   |    4 +-
 Documentation/git-checkout-index.txt     |   22 ++--
 Documentation/git-checkout.txt           |   12 +-
 Documentation/git-cherry-pick.txt        |    4 +-
 Documentation/git-cherry.txt             |   10 +-
 Documentation/git-citool.txt             |    4 +-
 Documentation/git-clean.txt              |    6 +-
 Documentation/git-clone.txt              |   14 ++--
 Documentation/git-commit-tree.txt        |    4 +-
 Documentation/git-commit.txt             |   28 +++---
 Documentation/git-config.txt             |   38 ++++----
 Documentation/git-count-objects.txt      |    4 +-
 Documentation/git-cvsexportcommit.txt    |   13 ++-
 Documentation/git-cvsimport.txt          |   20 ++--
 Documentation/git-cvsserver.txt          |   45 +++++-----
 Documentation/git-daemon.txt             |   34 ++++----
 Documentation/git-describe.txt           |   14 ++--
 Documentation/git-diff-files.txt         |    4 +-
 Documentation/git-diff-index.txt         |   34 ++++----
 Documentation/git-diff-tree.txt          |   18 ++--
 Documentation/git-diff.txt               |   18 ++--
 Documentation/git-fast-export.txt        |   10 +-
 Documentation/git-fast-import.txt        |   24 +++---
 Documentation/git-fetch-pack.txt         |   18 ++--
 Documentation/git-fetch.txt              |    4 +-
 Documentation/git-filter-branch.txt      |   14 ++--
 Documentation/git-fmt-merge-msg.txt      |    4 +-
 Documentation/git-for-each-ref.txt       |    8 +-
 Documentation/git-format-patch.txt       |    6 +-
 Documentation/git-fsck-objects.txt       |    2 +-
 Documentation/git-fsck.txt               |   10 +-
 Documentation/git-gc.txt                 |   16 ++--
 Documentation/git-get-tar-commit-id.txt  |    8 +-
 Documentation/git-grep.txt               |    4 +-
 Documentation/git-gui.txt                |   24 +++---
 Documentation/git-hash-object.txt        |    4 +-
 Documentation/git-help.txt               |    6 +-
 Documentation/git-http-fetch.txt         |    4 +-
 Documentation/git-http-push.txt          |    2 +-
 Documentation/git-imap-send.txt          |    6 +-
 Documentation/git-index-pack.txt         |   12 +-
 Documentation/git-init-db.txt            |    2 +-
 Documentation/git-init.txt               |    6 +-
 Documentation/git-instaweb.txt           |    8 +-
 Documentation/git-log.txt                |    6 +-
 Documentation/git-lost-found.txt         |    2 +-
 Documentation/git-ls-files.txt           |   10 +-
 Documentation/git-ls-remote.txt          |    4 +-
 Documentation/git-ls-tree.txt            |    2 +-
 Documentation/git-mailinfo.txt           |    8 +-
 Documentation/git-mailsplit.txt          |    2 +-
 Documentation/git-merge-base.txt         |   10 +-
 Documentation/git-merge-file.txt         |   14 ++--
 Documentation/git-merge-index.txt        |   20 ++--
 Documentation/git-merge-one-file.txt     |    4 +-
 Documentation/git-merge-tree.txt         |    2 +-
 Documentation/git-merge.txt              |   24 +++--
 Documentation/git-mergetool.txt          |   18 ++--
 Documentation/git-mktag.txt              |    2 +-
 Documentation/git-mktree.txt             |    2 +-
 Documentation/git-mv.txt                 |    6 +-
 Documentation/git-name-rev.txt           |    8 +-
 Documentation/git-pack-objects.txt       |   10 +-
 Documentation/git-pack-redundant.txt     |   10 +-
 Documentation/git-pack-refs.txt          |    4 +-
 Documentation/git-patch-id.txt           |    4 +-
 Documentation/git-peek-remote.txt        |    6 +-
 Documentation/git-prune-packed.txt       |    2 +-
 Documentation/git-prune.txt              |   14 ++--
 Documentation/git-pull.txt               |    5 +-
 Documentation/git-push.txt               |    4 +-
 Documentation/git-quiltimport.txt        |    2 +-
 Documentation/git-read-tree.txt          |   46 +++++-----
 Documentation/git-rebase.txt             |   38 ++++----
 Documentation/git-receive-pack.txt       |   24 +++---
 Documentation/git-relink.txt             |    2 +-
 Documentation/git-remote.txt             |   12 +-
 Documentation/git-repack.txt             |   15 ++--
 Documentation/git-repo-config.txt        |    2 +-
 Documentation/git-request-pull.txt       |    2 +-
 Documentation/git-rerere.txt             |   14 ++--
 Documentation/git-reset.txt              |    2 +-
 Documentation/git-rev-list.txt           |   16 ++--
 Documentation/git-rev-parse.txt          |   18 ++--
 Documentation/git-revert.txt             |    2 +-
 Documentation/git-rm.txt                 |   10 +-
 Documentation/git-send-email.txt         |    2 +-
 Documentation/git-send-pack.txt          |   16 ++--
 Documentation/git-shell.txt              |    2 +-
 Documentation/git-shortlog.txt           |    6 +-
 Documentation/git-show-branch.txt        |    8 +-
 Documentation/git-show-index.txt         |    6 +-
 Documentation/git-show-ref.txt           |   10 +-
 Documentation/git-show.txt               |    8 +-
 Documentation/git-stash.txt              |   22 ++--
 Documentation/git-status.txt             |    6 +-
 Documentation/git-stripspace.txt         |    2 +-
 Documentation/git-submodule.txt          |   14 ++--
 Documentation/git-svn.txt                |  153 +++++++++++++++---------------
 Documentation/git-symbolic-ref.txt       |    4 +-
 Documentation/git-tag.txt                |   18 ++--
 Documentation/git-tar-tree.txt           |    6 +-
 Documentation/git-unpack-file.txt        |    2 +-
 Documentation/git-unpack-objects.txt     |    4 +-
 Documentation/git-update-index.txt       |   26 +++---
 Documentation/git-update-ref.txt         |   10 +-
 Documentation/git-update-server-info.txt |    4 +-
 Documentation/git-upload-archive.txt     |    4 +-
 Documentation/git-upload-pack.txt        |    8 +-
 Documentation/git-var.txt                |    4 +-
 Documentation/git-verify-pack.txt        |    6 +-
 Documentation/git-verify-tag.txt         |    4 +-
 Documentation/git-web--browse.txt        |   10 +-
 Documentation/git-whatchanged.txt        |   10 +-
 Documentation/git-write-tree.txt         |    2 +-
 Documentation/git.txt                    |   30 +++---
 Documentation/gitattributes.txt          |   18 ++--
 Documentation/gitcore-tutorial.txt       |  127 ++++++++++++-------------
 Documentation/gitcvs-migration.txt       |   24 +++---
 Documentation/gitdiffcore.txt            |   34 ++++----
 Documentation/githooks.txt               |   10 +-
 Documentation/gitignore.txt              |    8 +-
 Documentation/gitk.txt                   |    3 +-
 Documentation/gitrepository-layout.txt   |   24 +++---
 Documentation/gittutorial-2.txt          |   40 ++++----
 Documentation/gittutorial.txt            |   66 +++++++-------
 Documentation/user-manual.txt            |   85 ++++++++---------
 140 files changed, 961 insertions(+), 964 deletions(-)
