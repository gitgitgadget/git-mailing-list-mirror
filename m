From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: [BUG] OSX ends with "install: git-init.1: No such file or directory"
Date: 10 Jan 2007 21:51:35 -0800
Message-ID: <8664bedsbc.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jan 11 06:52:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4sr8-00078F-T5
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 06:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965285AbXAKFvh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 00:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965289AbXAKFvh
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 00:51:37 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:8589 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965285AbXAKFvg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 00:51:36 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id D27278D5AE
	for <git@vger.kernel.org>; Wed, 10 Jan 2007 21:51:35 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 24199-01-17 for <git@vger.kernel.org>;
 Wed, 10 Jan 2007 21:51:35 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 43E098E447; Wed, 10 Jan 2007 21:51:35 -0800 (PST)
To: git@vger.kernel.org
x-mayan-date: Long count = 12.19.13.17.8; tzolkin = 3 Lamat; haab = 1 Muan
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36549>


    install -m644 git-add.1 git-am.1 git-annotate.1 git-apply.1 git-applymbox.1 git-applypatch.1 git-archimport.1 git-archive.1 git-bisect.1 git-blame.1 git-branch.1 git-cat-file.1 git-check-ref-format.1 git-checkout-index.1 git-checkout.1 git-cherry-pick.1 git-cherry.1 git-clean.1 git-clone.1 git-commit-tree.1 git-commit.1 git-convert-objects.1 git-count-objects.1 git-cvsexportcommit.1 git-cvsimport.1 git-cvsserver.1 git-daemon.1 git-describe.1 git-diff-files.1 git-diff-index.1 git-diff-stages.1 git-diff-tree.1 git-diff.1 git-fetch-pack.1 git-fetch.1 git-fmt-merge-msg.1 git-for-each-ref.1 git-format-patch.1 git-fsck-objects.1 git-gc.1 git-get-tar-commit-id.1 git-grep.1 git-hash-object.1 git-http-fetch.1 git-http-push.1 git-imap-send.1 git-index-pack.1 git-init-db.1 git-init.1 git-instaweb.1 git-local-fetch.1 git-log.1 git-lost-found.1 git-ls-files.1 git-ls-remote.1 git-ls-tree.1 git-mai
 linfo.1 git-mailsplit.1 git-merge-base.1 git-merge-file.1 git-merge-index.1 git-merge-one-
 file.1 git-merge-tree.1 git-merge.1 git-mktag.1 git-mktree.1 git-mv.1 git-name-rev.1 git-p4import.1 git-pack-objects.1 git-pack-redundant.1 git-pack-refs.1 git-parse-remote.1 git-patch-id.1 git-peek-remote.1 git-prune-packed.1 git-prune.1 git-pull.1 git-push.1 git-quiltimport.1 git-read-tree.1 git-rebase.1 git-receive-pack.1 git-reflog.1 git-relink.1 git-remote.1 git-repack.1 git-repo-config.1 git-request-pull.1 git-rerere.1 git-reset.1 git-resolve.1 git-rev-list.1 git-rev-parse.1 git-revert.1 git-rm.1 git-runstatus.1 git-send-email.1 git-send-pack.1 git-sh-setup.1 git-shell.1 git-shortlog.1 git-show-branch.1 git-show-index.1 git-show-ref.1 git-show.1 git-ssh-fetch.1 git-ssh-upload.1 git-status.1 git-stripspace.1 git-svn.1 git-svnimport.1 git-symbolic-ref.1 git-tag.1 git-tar-tree.1 git-unpack-file.1 git-unpack-objects.1 git-update-index.1 git-update-ref.1 git-update-server-info.1 git-up
 load-archive.1 git-upload-pack.1 git-var.1 git-verify-pack.1 git-verify-tag.1 git-whatchan
 ged.1 git-write-tree.1 gitk.1 /opt/git/man/man1
    install: git-init.1: No such file or directory
    make[1]: *** [install] Error 71
    rm git-init.xml
    make: *** [install-doc] Error 2

If I cd into Documentation, and try to make "git-init.1", I get this:

    % make git-init.1
    asciidoc -b docbook -d manpage -f asciidoc.conf git-init.txt
    xmlto -m callouts.xsl man git-init.xml
    Note: meta date   : No date. Using generated date       git-init-db
    Note: meta source : No productname or alternative       git-init-db
    Note: meta source : No refmiscinfo@class=source         git-init-db
    Note: meta version: No productnumber or alternative     git-init-db
    Note: meta version: No refmiscinfo@class=version        git-init-db
    Warn: meta source : No valid fallback. Leaving empty    git-init-db
    Note: meta manual : No ancestor with title              git-init-db
    Note: meta manual : No refmiscinfo@class=manual         git-init-db
    Warn: meta manual : No valid fallback. Leaving empty    git-init-db
    Note: Writing git-init-db.1
    rm git-init.xml

That's not good. Making git-init-db when it wants git-init.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
