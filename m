From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH/RFC 0/6] Documentation: use dashless links
Date: Fri, 12 Sep 2008 12:55:19 +0200
Message-ID: <1221216926-20435-1-git-send-email-git@drmicha.warpmail.net>
Cc: Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 12 12:57:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ke6L0-0003pN-Qk
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 12:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbYILKzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 06:55:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752477AbYILKzh
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 06:55:37 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51893 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752451AbYILKzg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Sep 2008 06:55:36 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 15013160EAB
	for <git@vger.kernel.org>; Fri, 12 Sep 2008 06:55:35 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 12 Sep 2008 06:55:35 -0400
X-Sasl-enc: kTWmrwL3eTQTDi/QnPw8q6v20uZQHbbhY9N66JQkMNbB 1221216934
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1413D18250;
	Fri, 12 Sep 2008 06:55:33 -0400 (EDT)
X-Mailer: git-send-email 1.6.0.1.308.gede4c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95699>

This is yet another attempt at making Junio's eyes sore...
This series implements dashless links in html doc for all commands where
the dashless form is preferred. The idea is to use two different link
macros, such that man pages (from docbook) get the form some viewers
need, whereas html pages get dashless links.

The series is broken down into steps which basically correspond to one
"sed" each, and can thus be checked easily.

Specific R for C:
Do we have a final list of commands which should be advertised in dashed
form? Specifically: What about git-http-{fetch,push}?

To do, after the C in RFC:
Undashify command names in the body of the doc (non-link text).

P.S.: This series corresponds to
ede4caf6e3204f9d63758d6410d0f124b0caab32..29993d99b87b701158d21c8234a162123ee29e39
in the dashless-doc branch of http://repo.or.cz/w/git/mjg.git

P.P.S.: I switched my e-mail address. Sorry about that, I'll stick with
that one.

Michael J Gruber (6):
  modified asciidoc macros for dashless git doc
  convert doc links for server type programmes
  convert doc links for non-dashed git commands
  convert doc links for other pages
  convert doc links for git subcommands
  adjust the command lists (by category) to the new doc link macros

 Documentation/asciidoc.conf              |   19 ++-
 Documentation/blame-options.txt          |    2 +-
 Documentation/cmd-list.perl              |    7 +-
 Documentation/config.txt                 |  174 +++++++++++-----------
 Documentation/diff-options.txt           |    6 +-
 Documentation/everyday.txt               |   48 +++---
 Documentation/fetch-options.txt          |    2 +-
 Documentation/git-add.txt                |   18 +-
 Documentation/git-am.txt                 |   14 +-
 Documentation/git-annotate.txt           |    6 +-
 Documentation/git-apply.txt              |    2 +-
 Documentation/git-archimport.txt         |    2 +-
 Documentation/git-archive.txt            |    2 +-
 Documentation/git-bisect.txt             |    2 +-
 Documentation/git-blame.txt              |    6 +-
 Documentation/git-branch.txt             |    8 +-
 Documentation/git-bundle.txt             |    2 +-
 Documentation/git-cat-file.txt           |    4 +-
 Documentation/git-check-attr.txt         |    4 +-
 Documentation/git-check-ref-format.txt   |    4 +-
 Documentation/git-checkout-index.txt     |    2 +-
 Documentation/git-checkout.txt           |    4 +-
 Documentation/git-cherry-pick.txt        |    4 +-
 Documentation/git-cherry.txt             |    4 +-
 Documentation/git-citool.txt             |    4 +-
 Documentation/git-clean.txt              |    2 +-
 Documentation/git-clone.txt              |    4 +-
 Documentation/git-commit-tree.txt        |    6 +-
 Documentation/git-commit.txt             |   18 +-
 Documentation/git-config.txt             |    2 +-
 Documentation/git-count-objects.txt      |    2 +-
 Documentation/git-cvsexportcommit.txt    |    2 +-
 Documentation/git-cvsimport.txt          |    6 +-
 Documentation/git-cvsserver.txt          |    8 +-
 Documentation/git-daemon.txt             |    2 +-
 Documentation/git-describe.txt           |    2 +-
 Documentation/git-diff-files.txt         |    2 +-
 Documentation/git-diff-index.txt         |    2 +-
 Documentation/git-diff-tree.txt          |    2 +-
 Documentation/git-diff.txt               |    8 +-
 Documentation/git-fast-export.txt        |    6 +-
 Documentation/git-fast-import.txt        |    4 +-
 Documentation/git-fetch-pack.txt         |    2 +-
 Documentation/git-fetch.txt              |    4 +-
 Documentation/git-filter-branch.txt      |    8 +-
 Documentation/git-fmt-merge-msg.txt      |    4 +-
 Documentation/git-format-patch.txt       |    6 +-
 Documentation/git-fsck-objects.txt       |    2 +-
 Documentation/git-fsck.txt               |    2 +-
 Documentation/git-gc.txt                 |   12 +-
 Documentation/git-get-tar-commit-id.txt  |    2 +-
 Documentation/git-grep.txt               |    2 +-
 Documentation/git-gui.txt                |    4 +-
 Documentation/git-hash-object.txt        |    2 +-
 Documentation/git-help.txt               |   10 +-
 Documentation/git-http-fetch.txt         |    2 +-
 Documentation/git-http-push.txt          |    2 +-
 Documentation/git-imap-send.txt          |    2 +-
 Documentation/git-index-pack.txt         |    2 +-
 Documentation/git-init-db.txt            |    2 +-
 Documentation/git-init.txt               |    2 +-
 Documentation/git-instaweb.txt           |    6 +-
 Documentation/git-log.txt                |    4 +-
 Documentation/git-lost-found.txt         |    4 +-
 Documentation/git-ls-files.txt           |   10 +-
 Documentation/git-ls-remote.txt          |    2 +-
 Documentation/git-ls-tree.txt            |    2 +-
 Documentation/git-mailinfo.txt           |    4 +-
 Documentation/git-mailsplit.txt          |    2 +-
 Documentation/git-merge-base.txt         |    2 +-
 Documentation/git-merge-file.txt         |    4 +-
 Documentation/git-merge-index.txt        |    2 +-
 Documentation/git-merge-one-file.txt     |    2 +-
 Documentation/git-merge-tree.txt         |    2 +-
 Documentation/git-merge.txt              |   14 +-
 Documentation/git-mergetool.txt          |    2 +-
 Documentation/git-mktag.txt              |    2 +-
 Documentation/git-mktree.txt             |    2 +-
 Documentation/git-mv.txt                 |    2 +-
 Documentation/git-name-rev.txt           |    2 +-
 Documentation/git-pack-objects.txt       |    8 +-
 Documentation/git-pack-redundant.txt     |    8 +-
 Documentation/git-pack-refs.txt          |    2 +-
 Documentation/git-parse-remote.txt       |    2 +-
 Documentation/git-patch-id.txt           |    2 +-
 Documentation/git-peek-remote.txt        |    2 +-
 Documentation/git-prune-packed.txt       |    6 +-
 Documentation/git-prune.txt              |   10 +-
 Documentation/git-pull.txt               |    8 +-
 Documentation/git-push.txt               |    6 +-
 Documentation/git-quiltimport.txt        |    2 +-
 Documentation/git-read-tree.txt          |    8 +-
 Documentation/git-rebase.txt             |    4 +-
 Documentation/git-receive-pack.txt       |    6 +-
 Documentation/git-reflog.txt             |    8 +-
 Documentation/git-relink.txt             |    2 +-
 Documentation/git-remote.txt             |   12 +-
 Documentation/git-repack.txt             |   16 +-
 Documentation/git-repo-config.txt        |    2 +-
 Documentation/git-request-pull.txt       |    2 +-
 Documentation/git-rerere.txt             |    2 +-
 Documentation/git-reset.txt              |    6 +-
 Documentation/git-rev-list.txt           |    2 +-
 Documentation/git-rev-parse.txt          |    4 +-
 Documentation/git-revert.txt             |    8 +-
 Documentation/git-rm.txt                 |    4 +-
 Documentation/git-send-email.txt         |    2 +-
 Documentation/git-send-pack.txt          |    6 +-
 Documentation/git-sh-setup.txt           |    2 +-
 Documentation/git-shell.txt              |    2 +-
 Documentation/git-shortlog.txt           |    2 +-
 Documentation/git-show-branch.txt        |    4 +-
 Documentation/git-show-index.txt         |    2 +-
 Documentation/git-show-ref.txt           |    4 +-
 Documentation/git-show.txt               |    4 +-
 Documentation/git-stash.txt              |   12 +-
 Documentation/git-status.txt             |    8 +-
 Documentation/git-stripspace.txt         |    2 +-
 Documentation/git-submodule.txt          |    4 +-
 Documentation/git-svn.txt                |    8 +-
 Documentation/git-symbolic-ref.txt       |    2 +-
 Documentation/git-tag.txt                |    2 +-
 Documentation/git-tar-tree.txt           |    2 +-
 Documentation/git-unpack-file.txt        |    2 +-
 Documentation/git-unpack-objects.txt     |    4 +-
 Documentation/git-update-index.txt       |   14 +-
 Documentation/git-update-ref.txt         |    2 +-
 Documentation/git-update-server-info.txt |    4 +-
 Documentation/git-upload-archive.txt     |    2 +-
 Documentation/git-upload-pack.txt        |    2 +-
 Documentation/git-var.txt                |    8 +-
 Documentation/git-verify-pack.txt        |    2 +-
 Documentation/git-verify-tag.txt         |    2 +-
 Documentation/git-web--browse.txt        |    4 +-
 Documentation/git-whatchanged.txt        |    2 +-
 Documentation/git-write-tree.txt         |    2 +-
 Documentation/git.txt                    |   40 +++---
 Documentation/gitattributes.txt          |   10 +-
 Documentation/gitcli.txt                 |    2 +-
 Documentation/gitcore-tutorial.txt       |   16 +-
 Documentation/gitcvs-migration.txt       |   24 ++--
 Documentation/gitdiffcore.txt            |   16 +-
 Documentation/gitglossary.txt            |    6 +-
 Documentation/githooks.txt               |    2 +-
 Documentation/gitignore.txt              |    2 +-
 Documentation/gitk.txt                   |    6 +-
 Documentation/gitmodules.txt             |    6 +-
 Documentation/gitrepository-layout.txt   |   30 ++--
 Documentation/gittutorial-2.txt          |   22 ++--
 Documentation/gittutorial.txt            |   28 ++--
 Documentation/glossary-content.txt       |   18 +-
 Documentation/merge-config.txt           |    8 +-
 Documentation/pretty-options.txt         |    2 +-
 Documentation/rev-list-options.txt       |   14 +-
 Documentation/urls-remotes.txt           |    2 +-
 Documentation/urls.txt                   |    2 +-
 Documentation/user-manual.txt            |  246 +++++++++++++++---------------
 command-list.txt                         |   12 +-
 158 files changed, 680 insertions(+), 664 deletions(-)
