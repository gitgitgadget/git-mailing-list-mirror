From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: [RFC/PATCH 7/7] Documentation formatting and cleanup
Date: Mon, 30 Jun 2008 17:36:41 -0500 (CDT)
Message-ID: <Pine.GSO.4.62.0806301730230.7190@harper.uchicago.edu>
References: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jon Loeliger <jdl@jdl.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 00:38:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDS0X-0003pR-Hq
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 00:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763557AbYF3WhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 18:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763752AbYF3WhD
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 18:37:03 -0400
Received: from smtp01.uchicago.edu ([128.135.12.77]:50349 "EHLO
	smtp01.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763191AbYF3WhB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 18:37:01 -0400
Received: from harper.uchicago.edu (harper.uchicago.edu [128.135.12.7])
	by smtp01.uchicago.edu (8.13.8/8.13.8) with ESMTP id m5UMafat003410;
	Mon, 30 Jun 2008 17:36:42 -0500
Received: from localhost (jrnieder@localhost)
	by harper.uchicago.edu (8.12.10/8.12.10) with ESMTP id m5UMafPI008916;
	Mon, 30 Jun 2008 17:36:41 -0500 (CDT)
X-Authentication-Warning: harper.uchicago.edu: jrnieder owned process doing -bs
In-Reply-To: <Pine.GSO.4.62.0806301650530.7190@harper.uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86950>

[184 KB patch online at
<http://home.uchicago.edu/~jrnieder/20080701-git-doc-style.txt>]

Following what appears to be the predominant style, format
names of commands and commandlines both as `teletype text`.

While we're at it, add articles ("a" and "the") in some
places, italicize the name of the command in the manual page
synopsis line, and add a comma or two where it seems appropriate.

Signed-off-by: Jonathan Nieder <jrnieder@uchicago.edu>

	1) I am using `teletype text` both for command names and
	   for command lines. Probably I should be using italics
	   for the command names.

	2) Should these changes be split up more?

 Documentation/git-annotate.txt          |    2 +-
 Documentation/git-apply.txt             |   12 ++--
 Documentation/git-archimport.txt        |    6 +-
 Documentation/git-archive.txt           |    6 +-
 Documentation/git-bisect.txt            |    8 +-
 Documentation/git-blame.txt             |    4 +-
 Documentation/git-branch.txt            |    8 +-
 Documentation/git-bundle.txt            |   27 +++---
 Documentation/git-check-ref-format.txt  |    2 +-
 Documentation/git-checkout-index.txt    |    2 +-
 Documentation/git-checkout.txt          |    4 +-
 Documentation/git-cherry-pick.txt       |    2 +-
 Documentation/git-cherry.txt            |    8 +-
 Documentation/git-citool.txt            |    4 +-
 Documentation/git-clean.txt             |    4 +-
 Documentation/git-clone.txt             |   12 ++--
 Documentation/git-commit-tree.txt       |    2 +-
 Documentation/git-commit.txt            |   20 +++---
 Documentation/git-config.txt            |   12 ++--
 Documentation/git-cvsexportcommit.txt   |    7 +-
 Documentation/git-cvsimport.txt         |   18 ++--
 Documentation/git-cvsserver.txt         |   43 +++++-----
 Documentation/git-daemon.txt            |   22 +++---
 Documentation/git-describe.txt          |    8 +-
 Documentation/git-diff-files.txt        |    2 +-
 Documentation/git-diff-index.txt        |   26 +++---
 Documentation/git-diff-tree.txt         |   10 +-
 Documentation/git-fast-export.txt       |    8 +-
 Documentation/git-fast-import.txt       |   16 ++--
 Documentation/git-fetch-pack.txt        |   16 ++--
 Documentation/git-fetch.txt             |    2 +-
 Documentation/git-filter-branch.txt     |   12 ++--
 Documentation/git-fmt-merge-msg.txt     |    4 +-
 Documentation/git-format-patch.txt      |    4 +-
 Documentation/git-fsck.txt              |    6 +-
 Documentation/git-gc.txt                |   10 +-
 Documentation/git-get-tar-commit-id.txt |    6 +-
 Documentation/git-grep.txt              |    2 +-
 Documentation/git-gui.txt               |   24 +++---
 Documentation/git-hash-object.txt       |    2 +-
 Documentation/git-help.txt              |    6 +-
 Documentation/git-http-fetch.txt        |    2 +-
 Documentation/git-imap-send.txt         |    2 +-
 Documentation/git-index-pack.txt        |    8 +-
 Documentation/git-instaweb.txt          |    4 +-
 Documentation/git-log.txt               |    4 +-
 Documentation/git-ls-files.txt          |    8 +-
 Documentation/git-ls-remote.txt         |    2 +-
 Documentation/git-mailinfo.txt          |    4 +-
 Documentation/git-merge-base.txt        |    8 +-
 Documentation/git-merge-file.txt        |   10 +-
 Documentation/git-merge-index.txt       |   14 ++--
 Documentation/git-merge-one-file.txt    |    4 +-
 Documentation/git-merge.txt             |   14 ++--
 Documentation/git-mergetool.txt         |    2 +-
 Documentation/git-name-rev.txt          |    6 +-
 Documentation/git-pack-objects.txt      |    8 +-
 Documentation/git-pack-redundant.txt    |    4 +-
 Documentation/git-patch-id.txt          |    2 +-
 Documentation/git-peek-remote.txt       |    4 +-
 Documentation/git-prune.txt             |   10 +-
 Documentation/git-pull.txt              |    3 +-
 Documentation/git-push.txt              |    2 +-
 Documentation/git-read-tree.txt         |   14 ++--
 Documentation/git-rebase.txt            |   22 +++---
 Documentation/git-receive-pack.txt      |   16 ++--
 Documentation/git-repack.txt            |   11 ++-
 Documentation/git-rerere.txt            |   10 +-
 Documentation/git-reset.txt             |    2 +-
 Documentation/git-rev-list.txt          |    6 +-
 Documentation/git-rev-parse.txt         |   12 ++--
 Documentation/git-rm.txt                |    2 +-
 Documentation/git-send-pack.txt         |   14 ++--
 Documentation/git-shell.txt             |    2 +-
 Documentation/git-shortlog.txt          |    2 +-
 Documentation/git-show-branch.txt       |    4 +-
 Documentation/git-show-index.txt        |    4 +-
 Documentation/git-show-ref.txt          |    4 +-
 Documentation/git-show.txt              |    6 +-
 Documentation/git-stash.txt             |   12 ++--
 Documentation/git-submodule.txt         |    4 +-
 Documentation/git-svn.txt               |  133 +++++++++++++++----------------
 Documentation/git-symbolic-ref.txt      |    2 +-
 Documentation/git-tag.txt               |    8 +-
 Documentation/git-tar-tree.txt          |    4 +-
 Documentation/git-unpack-objects.txt    |    2 +-
 Documentation/git-update-index.txt      |   14 ++--
 Documentation/git-upload-archive.txt    |    2 +-
 Documentation/git-upload-pack.txt       |    6 +-
 Documentation/git-verify-pack.txt       |    4 +-
 Documentation/git-verify-tag.txt        |    2 +-
 Documentation/git-web--browse.txt       |    6 +-
 Documentation/git-whatchanged.txt       |    4 +-
 Documentation/git.txt                   |   10 +-
 Documentation/gitattributes.txt         |   12 ++--
 Documentation/gitcore-tutorial.txt      |   18 ++--
 Documentation/gitcvs-migration.txt      |    4 +-
 Documentation/gitdiffcore.txt           |   34 ++++----
 Documentation/gitignore.txt             |    4 +-
 Documentation/gitk.txt                  |    3 +-
 Documentation/gitrepository-layout.txt  |    2 +-
 Documentation/gittutorial-2.txt         |   28 +++---
 Documentation/gittutorial.txt           |   46 ++++++------
 103 files changed, 510 insertions(+), 509 deletions(-)

See <http://home.uchicago.edu/~jrnieder/20080701-git-doc-style.txt>.
