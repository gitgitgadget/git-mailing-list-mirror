From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH 0/2] GIT, Git, git
Date: Sat, 19 Jan 2013 10:57:45 +0100 (CET)
Message-ID: <732444561.1327663.1358589465467.JavaMail.ngmail@webmail24.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: th.acker@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 10:58:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwVBj-00041O-53
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 10:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915Ab3ASJ5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2013 04:57:49 -0500
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:44502 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751707Ab3ASJ5r (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2013 04:57:47 -0500
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mx.arcor.de (Postfix) with ESMTP id 7D18DE4288
	for <git@vger.kernel.org>; Sat, 19 Jan 2013 10:57:45 +0100 (CET)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net [151.189.21.48])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id 7C04E7FE494;
	Sat, 19 Jan 2013 10:57:45 +0100 (CET)
Received: from webmail24.arcor-online.net (webmail24.arcor-online.net [151.189.8.174])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 7331E3AEB10;
	Sat, 19 Jan 2013 10:57:45 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-08.arcor-online.net 7331E3AEB10
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1358589465; bh=A6jP7EBX1ZwcINVhf8xkIR05r3D8EWs+rIayTjNsV3Y=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=MzZv8B8NwKgry0H1rUUBhxgmq3QRu/ZLZOVLseul5Wk9dbuN0/e/+95Hf+0ygbEIE
	 kqSNxYXlTyz0b89InX2p95DP5BMObbC9T1uYeDnOyd+krJqg7kp0t6X5BzSIZR4u7I
	 3bI7S3lKtJZcdMa/+KhiOfqW7lzi1WozEaGWO8DQ=
Received: from [188.105.103.171] by webmail24.arcor-online.net (151.189.8.174) with HTTP (Arcor Webmail); Sat, 19 Jan 2013 10:57:45 +0100 (CET)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.103.171
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213965>


Git changed its 'official' system name from 'GIT' to 'Git' in v1.6.5.3
(as can be seen in the corresponding release note where 'GIT' was 
changed to 'Git' in the header line).

Alas the documention uses 'GIT', 'Git' or even 'git' to refer to the
Git system. So change every occurrence of 'GIT" and 'git' to 'Git'
whenever Git as a system is referred to (but don't do this change
in the release notes because they constitute a history orthogonal
to the history versioned by Git).

[PATCH 1/2] Change old system name 'GIT' to 'Git'
[PATCH 2/2] Change 'git' to 'Git' whenever the whole system is referred to

 Documentation/CodingGuidelines                     |  14 +-
 Documentation/SubmittingPatches                    |  12 +-
 Documentation/asciidoc.conf                        |   2 +-
 Documentation/blame-options.txt                    |   4 +-
 Documentation/config.txt                           | 106 +++++------
 Documentation/diff-config.txt                      |   2 +-
 Documentation/diff-options.txt                     |   4 +-
 Documentation/everyday.txt                         |  10 +-
 Documentation/git-apply.txt                        |   2 +-
 Documentation/git-archimport.txt                   |  14 +-
 Documentation/git-archive.txt                      |   2 +-
 Documentation/git-bisect-lk2009.txt                |  22 +--
 Documentation/git-bisect.txt                       |   4 +-
 Documentation/git-blame.txt                        |   2 +-
 Documentation/git-branch.txt                       |   2 +-
 Documentation/git-bundle.txt                       |   2 +-
 Documentation/git-check-ref-format.txt             |   4 +-
 Documentation/git-checkout.txt                     |   4 +-
 Documentation/git-clean.txt                        |   6 +-
 Documentation/git-clone.txt                        |  12 +-
 Documentation/git-commit-tree.txt                  |   2 +-
 Documentation/git-commit.txt                       |   6 +-
 Documentation/git-credential-cache.txt             |   4 +-
 Documentation/git-credential-store.txt             |   6 +-
 Documentation/git-credential.txt                   |   6 +-
 Documentation/git-cvsexportcommit.txt              |   6 +-
 Documentation/git-cvsimport.txt                    |  10 +-
 Documentation/git-cvsserver.txt                    |  20 +-
 Documentation/git-daemon.txt                       |  10 +-
 Documentation/git-describe.txt                     |   2 +-
 Documentation/git-diff.txt                         |   2 +-
 Documentation/git-difftool.txt                     |   2 +-
 Documentation/git-fetch.txt                        |   2 +-
 Documentation/git-filter-branch.txt                |   4 +-
 Documentation/git-format-patch.txt                 |  10 +-
 Documentation/git-fsck.txt                         |   6 +-
 Documentation/git-grep.txt                         |   2 +-
 Documentation/git-hash-object.txt                  |   2 +-
 Documentation/git-help.txt                         |   2 +-
 Documentation/git-http-backend.txt                 |   2 +-
 Documentation/git-index-pack.txt                   |   6 +-
 Documentation/git-init.txt                         |  16 +-
 Documentation/git-log.txt                          |   2 +-
 Documentation/git-ls-files.txt                     |   2 +-
 Documentation/git-merge-index.txt                  |   4 +-
 Documentation/git-merge.txt                        |   4 +-
 Documentation/git-mergetool--lib.txt               |   2 +-
 Documentation/git-mktag.txt                        |   4 +-
 Documentation/git-mv.txt                           |   2 +-
 Documentation/git-p4.txt                           |  66 +++----
 Documentation/git-pack-objects.txt                 |  12 +-
 Documentation/git-pull.txt                         |   8 +-
 Documentation/git-push.txt                         |   8 +-
 Documentation/git-quiltimport.txt                  |   4 +-
 Documentation/git-rebase.txt                       |   2 +-
 Documentation/git-reflog.txt                       |   2 +-
 Documentation/git-remote-ext.txt                   |  14 +-
 Documentation/git-remote-fd.txt                    |  10 +-
 Documentation/git-remote-helpers.txt               |  46 ++---
 Documentation/git-replace.txt                      |   2 +-
 Documentation/git-rev-list.txt                     |   2 +-
 Documentation/git-rev-parse.txt                    |   4 +-
 Documentation/git-rm.txt                           |   8 +-
 Documentation/git-send-email.txt                   |   2 +-
 Documentation/git-send-pack.txt                    |   2 +-
 Documentation/git-sh-setup.txt                     |   4 +-
 Documentation/git-show-index.txt                   |   2 +-
 Documentation/git-status.txt                       |   8 +-
 Documentation/git-stripspace.txt                   |   2 +-
 Documentation/git-submodule.txt                    |   2 +-
 Documentation/git-svn.txt                          |  88 ++++-----
 Documentation/git-tag.txt                          |   2 +-
 Documentation/git-tools.txt                        |  40 ++--
 Documentation/git-update-index.txt                 |  16 +-
 Documentation/git-update-ref.txt                   |   2 +-
 Documentation/git-upload-archive.txt               |   2 +-
 Documentation/git-upload-pack.txt                  |   2 +-
 Documentation/git-var.txt                          |  12 +-
 Documentation/git-verify-pack.txt                  |   2 +-
 Documentation/git-verify-tag.txt                   |   2 +-
 Documentation/git-web--browse.txt                  |   4 +-
 Documentation/git-whatchanged.txt                  |   4 +-
 Documentation/git.txt                              |  90 ++++-----
 Documentation/gitattributes.txt                    |  68 +++----
 Documentation/gitcli.txt                           |  14 +-
 Documentation/gitcore-tutorial.txt                 | 150 +++++++--------
 Documentation/gitcredentials.txt                   |  24 +--
 Documentation/gitcvs-migration.txt                 |  20 +-
 Documentation/gitdiffcore.txt                      |   2 +-
 Documentation/gitglossary.txt                      |   4 +-
 Documentation/githooks.txt                         |   8 +-
 Documentation/gitignore.txt                        |  22 +--
 Documentation/gitk.txt                             |   8 +-
 Documentation/gitmodules.txt                       |   4 +-
 Documentation/gitnamespaces.txt                    |   2 +-
 Documentation/gitrepository-layout.txt             |  10 +-
 Documentation/gitrevisions.txt                     |   2 +-
 Documentation/gittutorial-2.txt                    |  38 ++--
 Documentation/gittutorial.txt                      |  48 ++---
 Documentation/gitweb.conf.txt                      |  32 ++--
 Documentation/gitweb.txt                           |  22 +--
 Documentation/gitworkflows.txt                     |   6 +-
 Documentation/glossary-content.txt                 |  58 +++---
 Documentation/howto-index.sh                       |   4 +-
 Documentation/howto/maintain-git.txt               |   6 +-
 Documentation/howto/new-command.txt                |  20 +-
 .../howto/rebase-from-internal-branch.txt          |   6 +-
 Documentation/howto/rebuild-from-update-hook.txt   |   8 +-
 .../howto/recover-corrupted-blob-object.txt        |   4 +-
 Documentation/howto/revert-a-faulty-merge.txt      |   2 +-
 Documentation/howto/revert-branch-rebase.txt       |   4 +-
 Documentation/howto/setup-git-server-over-http.txt |  18 +-
 Documentation/howto/use-git-daemon.txt             |   2 +-
 .../howto/using-signed-tag-in-pull-request.txt     |   4 +-
 Documentation/i18n.txt                             |   8 +-
 Documentation/merge-config.txt                     |   8 +-
 Documentation/rev-list-options.txt                 |   4 +-
 Documentation/revisions.txt                        |   2 +-
 Documentation/technical/api-builtin.txt            |   2 +-
 Documentation/technical/api-config.txt             |  10 +-
 Documentation/technical/api-credentials.txt        |  16 +-
 Documentation/technical/api-directory-listing.txt  |   2 +-
 Documentation/technical/api-index-skel.txt         |   4 +-
 Documentation/technical/api-parse-options.txt      |   2 +-
 Documentation/technical/api-remote.txt             |   2 +-
 Documentation/technical/index-format.txt           |   8 +-
 Documentation/technical/pack-format.txt            |   4 +-
 Documentation/technical/pack-heuristics.txt        |  20 +-
 Documentation/technical/racy-git.txt               |  26 +--
 Documentation/urls-remotes.txt                     |   2 +-
 Documentation/urls.txt                             |   2 +-
 Documentation/user-manual.txt                      | 212 ++++++++++-----------
 132 files changed, 904 insertions(+), 904 deletions(-)



---
Thomas
