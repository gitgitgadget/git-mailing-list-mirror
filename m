From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [PATCH 6/7] Documentation: be consistent about "git-" versus "git
 "
Date: Mon, 30 Jun 2008 17:29:51 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0806301717320.7190@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
 <Pine.GSO.4.62.0806301716150.7190@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 00:31:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDRuV-0002Ik-QT
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 00:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762839AbYF3WaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 18:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752563AbYF3WaQ
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 18:30:16 -0400
Received: from smtp02.uchicago.edu ([128.135.12.75]:48483 "EHLO
	smtp02.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbYF3WaP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 18:30:15 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp02.uchicago.edu (8.13.8/8.13.8) with ESMTP id m5UMTpwx025953;
	Mon, 30 Jun 2008 17:29:51 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m5UMTpC0008527;
	Mon, 30 Jun 2008 17:29:51 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0806301716150.7190@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86949>

[Patch at <http://home.uchicago.edu/~jrnieder/20080701-git-doc-hyphens.txt>]

Since the git-* commands are not installed in $(bindir), using
"git-command <parameters>" in examples in the documentation is
not a good idea. On the other hand, it is nice to be able to
refer to each command using one hyphenated word. (There is no
escaping it, anyway: man page names cannot have spaces in them.)

This patch retains the dash in naming an operation, command,
program, process, or action. Complete command lines that can
be entered at a shell (i.e., without options omitted) are
made to use the dashless form.

The changes consist only of replacing some spaces with hyphens
and vice versa. After a "s/ /-/g", the unpatched and patched
versions are identical.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>

 Documentation/git-add.txt                |    2 +-
 Documentation/git-am.txt                 |    4 +-
 Documentation/git-annotate.txt           |    2 +-
 Documentation/git-apply.txt              |    2 +-
 Documentation/git-archimport.txt         |    2 +-
 Documentation/git-archive.txt            |    2 +-
 Documentation/git-bisect.txt             |    2 +-
 Documentation/git-blame.txt              |    2 +-
 Documentation/git-branch.txt             |    8 +-
 Documentation/git-bundle.txt             |   14 ++--
 Documentation/git-cat-file.txt           |    4 +-
 Documentation/git-check-attr.txt         |    2 +-
 Documentation/git-check-ref-format.txt   |    4 +-
 Documentation/git-checkout-index.txt     |   20 +++---
 Documentation/git-checkout.txt           |    8 +-
 Documentation/git-cherry-pick.txt        |    2 +-
 Documentation/git-cherry.txt             |    2 +-
 Documentation/git-clean.txt              |    2 +-
 Documentation/git-clone.txt              |    2 +-
 Documentation/git-commit-tree.txt        |    2 +-
 Documentation/git-commit.txt             |    4 +-
 Documentation/git-config.txt             |   26 ++++----
 Documentation/git-count-objects.txt      |    4 +-
 Documentation/git-cvsexportcommit.txt    |    8 +-
 Documentation/git-cvsimport.txt          |    4 +-
 Documentation/git-cvsserver.txt          |    2 +-
 Documentation/git-daemon.txt             |    2 +-
 Documentation/git-describe.txt           |   10 ++--
 Documentation/git-diff-files.txt         |    2 +-
 Documentation/git-diff-index.txt         |   12 ++--
 Documentation/git-diff-tree.txt          |    8 +-
 Documentation/git-diff.txt               |   18 +++---
 Documentation/git-fast-export.txt        |    2 +-
 Documentation/git-fast-import.txt        |    8 +-
 Documentation/git-fetch-pack.txt         |    2 +-
 Documentation/git-fetch.txt              |    4 +-
 Documentation/git-filter-branch.txt      |    4 +-
 Documentation/git-fmt-merge-msg.txt      |    4 +-
 Documentation/git-for-each-ref.txt       |    8 +-
 Documentation/git-format-patch.txt       |    2 +-
 Documentation/git-fsck-objects.txt       |    2 +-
 Documentation/git-fsck.txt               |    4 +-
 Documentation/git-gc.txt                 |    6 +-
 Documentation/git-get-tar-commit-id.txt  |    2 +-
 Documentation/git-grep.txt               |    2 +-
 Documentation/git-hash-object.txt        |    2 +-
 Documentation/git-http-fetch.txt         |    2 +-
 Documentation/git-http-push.txt          |    2 +-
 Documentation/git-imap-send.txt          |    4 +-
 Documentation/git-index-pack.txt         |    4 +-
 Documentation/git-init-db.txt            |    2 +-
 Documentation/git-init.txt               |    6 +-
 Documentation/git-instaweb.txt           |    4 +-
 Documentation/git-log.txt                |    2 +-
 Documentation/git-lost-found.txt         |    2 +-
 Documentation/git-ls-files.txt           |    2 +-
 Documentation/git-ls-remote.txt          |    2 +-
 Documentation/git-ls-tree.txt            |    2 +-
 Documentation/git-mailinfo.txt           |    4 +-
 Documentation/git-mailsplit.txt          |    2 +-
 Documentation/git-merge-base.txt         |    4 +-
 Documentation/git-merge-file.txt         |    4 +-
 Documentation/git-merge-index.txt        |    6 +-
 Documentation/git-merge-tree.txt         |    2 +-
 Documentation/git-merge.txt              |   10 ++--
 Documentation/git-mergetool.txt          |   16 +++---
 Documentation/git-mktag.txt              |    2 +-
 Documentation/git-mktree.txt             |    2 +-
 Documentation/git-mv.txt                 |    6 +-
 Documentation/git-name-rev.txt           |    2 +-
 Documentation/git-pack-objects.txt       |    2 +-
 Documentation/git-pack-redundant.txt     |    6 +-
 Documentation/git-pack-refs.txt          |    4 +-
 Documentation/git-patch-id.txt           |    2 +-
 Documentation/git-peek-remote.txt        |    2 +-
 Documentation/git-prune-packed.txt       |    2 +-
 Documentation/git-prune.txt              |    4 +-
 Documentation/git-pull.txt               |    2 +-
 Documentation/git-push.txt               |    2 +-
 Documentation/git-quiltimport.txt        |    2 +-
 Documentation/git-read-tree.txt          |   32 +++++-----
 Documentation/git-rebase.txt             |   20 +++---
 Documentation/git-receive-pack.txt       |   10 ++--
 Documentation/git-relink.txt             |    2 +-
 Documentation/git-remote.txt             |   12 ++--
 Documentation/git-repack.txt             |   10 ++--
 Documentation/git-repo-config.txt        |    2 +-
 Documentation/git-request-pull.txt       |    2 +-
 Documentation/git-rerere.txt             |    4 +-
 Documentation/git-rev-list.txt           |   10 ++--
 Documentation/git-rev-parse.txt          |    6 +-
 Documentation/git-revert.txt             |    2 +-
 Documentation/git-rm.txt                 |    8 +-
 Documentation/git-send-email.txt         |    2 +-
 Documentation/git-send-pack.txt          |    2 +-
 Documentation/git-shortlog.txt           |    6 +-
 Documentation/git-show-branch.txt        |    4 +-
 Documentation/git-show-index.txt         |    2 +-
 Documentation/git-show-ref.txt           |    6 +-
 Documentation/git-show.txt               |    2 +-
 Documentation/git-stash.txt              |   12 ++--
 Documentation/git-status.txt             |    6 +-
 Documentation/git-stripspace.txt         |    2 +-
 Documentation/git-submodule.txt          |   10 ++--
 Documentation/git-svn.txt                |   34 +++++-----
 Documentation/git-symbolic-ref.txt       |    2 +-
 Documentation/git-tag.txt                |   14 ++--
 Documentation/git-tar-tree.txt           |    2 +-
 Documentation/git-unpack-file.txt        |    2 +-
 Documentation/git-unpack-objects.txt     |    2 +-
 Documentation/git-update-index.txt       |   12 ++--
 Documentation/git-update-ref.txt         |   10 ++--
 Documentation/git-update-server-info.txt |    2 +-
 Documentation/git-upload-archive.txt     |    2 +-
 Documentation/git-upload-pack.txt        |    2 +-
 Documentation/git-var.txt                |    4 +-
 Documentation/git-verify-pack.txt        |    2 +-
 Documentation/git-verify-tag.txt         |    2 +-
 Documentation/git-web--browse.txt        |    6 +-
 Documentation/git-whatchanged.txt        |    6 +-
 Documentation/git-write-tree.txt         |    2 +-
 Documentation/gitattributes.txt          |   14 ++--
 Documentation/gitcore-tutorial.txt       |  102 +++++++++++++++---------------
 Documentation/gitcvs-migration.txt       |    8 +-
 Documentation/gitdiffcore.txt            |    2 +-
 Documentation/githooks.txt               |   10 ++--
 Documentation/gitignore.txt              |    4 +-
 Documentation/gitrepository-layout.txt   |   18 +++---
 Documentation/gittutorial-2.txt          |   18 +++---
 Documentation/gittutorial.txt            |   30 +++++-----
 Documentation/user-manual.txt            |   76 +++++++++++-----------
 131 files changed, 462 insertions(+), 462 deletions(-)

Because it is long, I haven't sent the patch. You can find it at
<http://home.uchicago.edu/~jrnieder/20080701-git-doc-hyphens.txt>.
