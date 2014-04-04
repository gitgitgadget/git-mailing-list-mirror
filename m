From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Patch Series v3 for "use the $( ... ) construct for command substitution"
Date: Fri, 4 Apr 2014 18:52:03 +0200
Message-ID: <CA+EOSBkF+hLOab0oJH7HuUb_KKn+1sgV_Lshwupgj-_yAAfmFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 04 18:52:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WW7Ln-00015f-OU
	for gcvg-git-2@plane.gmane.org; Fri, 04 Apr 2014 18:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbaDDQwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2014 12:52:06 -0400
Received: from mail-ve0-f176.google.com ([209.85.128.176]:44697 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783AbaDDQwE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2014 12:52:04 -0400
Received: by mail-ve0-f176.google.com with SMTP id db11so1611062veb.7
        for <git@vger.kernel.org>; Fri, 04 Apr 2014 09:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=Pu2YeZ7xATrPw5Of6DIHP8TdPv6zXZlPHAotyYTi4zE=;
        b=gQjPz6JY3LcgNb5BHjrxak0+QHRok8HoUYuqgtfe9O3h6CT01Tkw9hgqkB7dHO6+og
         umRugDC1mabYOoZaNfT6xLnOomNk8QI9qp8OSrM1CkiQIEmw3JwweFxXZZwxZFOSUIfe
         CQg7YSzkt+w9/ZHZqhJoKpZ29iVo8faF5rLJ36sQIgCLnJHPY0/i6uGeLchUunPtm10P
         EyEnYPWBZJ6WC/2fKXeSgT0dbSXeWAaNg8af6NCZUjwzEfvz3j5yQm3m8CUTd3xux+7M
         b9DsrczKmAzrO5CF/6U3STFchChl7rVHaQ67QUTUgByg4fqmK2QT/Rwmyg5Twv73hVI3
         NP2Q==
X-Received: by 10.58.230.103 with SMTP id sx7mr1094290vec.28.1396630323727;
 Fri, 04 Apr 2014 09:52:03 -0700 (PDT)
Received: by 10.52.163.137 with HTTP; Fri, 4 Apr 2014 09:52:03 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245764>

This patch series contain the

 use the $( ... ) construct for command substitution

patches not already merged in ep/shell-command-substitution
in the mantainer repository. It is the version 3 of the
patch series.

I changed the commit message in accordance with those approved,
and I have rebased the patches to the master branch, adjusting where
necessary any conflicts. The patches can be applied also to pu and next.

I hope this is a better way to send the (a long) patch series to git.

Best Regards

------

The following changes since commit 82edd396632501b3dd1901d0f3ae5aa72759b5fb:

  Update draft release notes to 2.0 (2014-04-03 13:40:59 -0700)

are available in the git repository at:

  git@github.com:devzero2000/git-core.git ep/shell-command-substitution-v3

for you to fetch changes up to a4f27b5de27b9848c0720ac2c74a3b82c2531122:

  t7505-prepare-commit-msg-hook.sh: use the $( ... ) construct for
command substitution (2014-04-04 08:03:33 -0700)

----------------------------------------------------------------
Elia Pinto (140):
      howto-index.sh: use the $( ... ) construct for command substitution
      install-webdoc.sh: use the $( ... ) construct for command substitution
      git-checkout.sh: use the $( ... ) construct for command substitution
      git-clone.sh: use the $( ... ) construct for command substitution
      git-commit.sh: use the $( ... ) construct for command substitution
      git-fetch.sh: use the $( ... ) construct for command substitution
      git-ls-remote.sh: use the $( ... ) construct for command substitution
      git-merge.sh: use the $( ... ) construct for command substitution
      git-repack.sh: use the $( ... ) construct for command substitution
      git-resolve.sh: use the $( ... ) construct for command substitution
      git-revert.sh: use the $( ... ) construct for command substitution
      git-tag.sh: use the $( ... ) construct for command substitution
      t9360-mw-to-git-clone.sh: use the $( ... ) construct for command
substitution
      t9362-mw-to-git-utf8.sh: use the $( ... ) construct for command
substitution
      t9365-continuing-queries.sh: use the $( ... ) construct for
command substitution
      test-gitmw-lib.sh: use the $( ... ) construct for command substitution
      t7900-subtree.sh: use the $( ... ) construct for command substitution
      appp.sh: use the $( ... ) construct for command substitution
      txt-to-pot.sh: use the $( ... ) construct for command substitution
      git-pull.sh: use the $( ... ) construct for command substitution
      git-rebase--merge.sh: use the $( ... ) construct for command substitution
      git-rebase.sh: use the $( ... ) construct for command substitution
      git-stash.sh: use the $( ... ) construct for command substitution
      git-web--browse.sh: use the $( ... ) construct for command substitution
      lib-credential.sh: use the $( ... ) construct for command substitution
      lib-cvs.sh: use the $( ... ) construct for command substitution
      lib-gpg.sh: use the $( ... ) construct for command substitution
      p5302-pack-index.sh: use the $( ... ) construct for command substitution
      t0001-init.sh: use the $( ... ) construct for command substitution
      t0010-racy-git.sh: use the $( ... ) construct for command substitution
      t0020-crlf.sh: use the $( ... ) construct for command substitution
      t0025-crlf-auto.sh: use the $( ... ) construct for command substitution
      t0026-eol-config.sh: use the $( ... ) construct for command substitution
      t0030-stripspace.sh: use the $( ... ) construct for command substitution
      t0300-credentials.sh: use the $( ... ) construct for command substitution
      t1000-read-tree-m-3way.sh: use the $( ... ) construct for
command substitution
      t1001-read-tree-m-2way.sh: use the $( ... ) construct for
command substitution
      t1002-read-tree-m-u-2way.sh: use the $( ... ) construct for
command substitution
      t1003-read-tree-prefix.sh: use the $( ... ) construct for
command substitution
      t1004-read-tree-m-u-wf.sh: use the $( ... ) construct for
command substitution
      t1020-subdirectory.sh: use the $( ... ) construct for command substitution
      t1050-large.sh: use the $( ... ) construct for command substitution
      t1100-commit-tree-options.sh: use the $( ... ) construct for
command substitution
      t1401-symbolic-ref.sh: use the $( ... ) construct for command substitution
      t1410-reflog.sh: use the $( ... ) construct for command substitution
      t1511-rev-parse-caret.sh: use the $( ... ) construct for command
substitution
      t1512-rev-parse-disambiguation.sh: use the $( ... ) construct
for command substitution
      t2102-update-index-symlinks.sh: use the $( ... ) construct for
command substitution
      t3030-merge-recursive.sh: use the $( ... ) construct for command
substitution
      t3100-ls-tree-restrict.sh: use the $( ... ) construct for
command substitution
      t3101-ls-tree-dirname.sh: use the $( ... ) construct for command
substitution
      t3210-pack-refs.sh: use the $( ... ) construct for command substitution
      t3403-rebase-skip.sh: use the $( ... ) construct for command substitution
      t3511-cherry-pick-x.sh: use the $( ... ) construct for command
substitution
      t3600-rm.sh: use the $( ... ) construct for command substitution
      t3700-add.sh: use the $( ... ) construct for command substitution
      t3905-stash-include-untracked.sh: use the $( ... ) construct for
command substitution
      t3910-mac-os-precompose.sh: use the $( ... ) construct for
command substitution
      t4006-diff-mode.sh: use the $( ... ) construct for command substitution
      t4010-diff-pathspec.sh: use the $( ... ) construct for command
substitution
      t4012-diff-binary.sh: use the $( ... ) construct for command substitution
      t4013-diff-various.sh: use the $( ... ) construct for command substitution
      t4014-format-patch.sh: use the $( ... ) construct for command substitution
      t4036-format-patch-signer-mime.sh: use the $( ... ) construct
for command substitution
      t4038-diff-combined.sh: use the $( ... ) construct for command
substitution
      t4057-diff-combined-paths.sh: use the $( ... ) construct for
command substitution
      t4116-apply-reverse.sh: use the $( ... ) construct for command
substitution
      t4119-apply-config.sh: use the $( ... ) construct for command substitution
      t4204-patch-id.sh: use the $( ... ) construct for command substitution
      t5000-tar-tree.sh: use the $( ... ) construct for command substitution
      t5003-archive-zip.sh: use the $( ... ) construct for command substitution
      t5100-mailinfo.sh: use the $( ... ) construct for command substitution
      t5300-pack-object.sh: use the $( ... ) construct for command substitution
      t5301-sliding-window.sh: use the $( ... ) construct for command
substitution
      t5302-pack-index.sh: use the $( ... ) construct for command substitution
      t5303-pack-corruption-resilience.sh: use the $( ... ) construct
for command substitution
      t5304-prune.sh: use the $( ... ) construct for command substitution
      t5305-include-tag.sh: use the $( ... ) construct for command substitution
      t5500-fetch-pack.sh: use the $( ... ) construct for command substitution
      t5505-remote.sh: use the $( ... ) construct for command substitution
      t5506-remote-groups.sh: use the $( ... ) construct for command
substitution
      t5510-fetch.sh: use the $( ... ) construct for command substitution
      t5515-fetch-merge-logic.sh: use the $( ... ) construct for
command substitution
      t5516-fetch-push.sh: use the $( ... ) construct for command substitution
      t5517-push-mirror.sh: use the $( ... ) construct for command substitution
      t5520-pull.sh: use the $( ... ) construct for command substitution
      t5522-pull-symlink.sh: use the $( ... ) construct for command substitution
      t5530-upload-pack-error.sh: use the $( ... ) construct for
command substitution
      t5537-fetch-shallow.sh: use the $( ... ) construct for command
substitution
      t5538-push-shallow.sh: use the $( ... ) construct for command substitution
      t5550-http-fetch-dumb.sh: use the $( ... ) construct for command
substitution
      t5551-http-fetch-smart.sh: use the $( ... ) construct for
command substitution
      t5570-git-daemon.sh: use the $( ... ) construct for command substitution
      t5601-clone.sh: use the $( ... ) construct for command substitution
      t5700-clone-reference.sh: use the $( ... ) construct for command
substitution
      t5710-info-alternate.sh: use the $( ... ) construct for command
substitution
      t5900-repo-selection.sh: use the $( ... ) construct for command
substitution
      t6001-rev-list-graft.sh: use the $( ... ) construct for command
substitution
      t6002-rev-list-bisect.sh: use the $( ... ) construct for command
substitution
      t6015-rev-list-show-all-parents.sh: use the $( ... ) construct
for command substitution
      t6032-merge-large-rename.sh: use the $( ... ) construct for
command substitution
      t6034-merge-rename-nocruft.sh: use the $( ... ) construct for
command substitution
      t6132-pathspec-exclude.sh: use the $( ... ) construct for
command substitution
      t7001-mv.sh: use the $( ... ) construct for command substitution
      t7003-filter-branch.sh: use the $( ... ) construct for command
substitution
      t7004-tag.sh: use the $( ... ) construct for command substitution
      t7006-pager.sh: use the $( ... ) construct for command substitution
      t7103-reset-bare.sh: use the $( ... ) construct for command substitution
      t7406-submodule-update.sh: use the $( ... ) construct for
command substitution
      t7408-submodule-reference.sh: use the $( ... ) construct for
command substitution
      t7504-commit-msg-hook.sh: use the $( ... ) construct for command
substitution
      t7602-merge-octopus-many.sh: use the $( ... ) construct for
command substitution
      t7700-repack.sh: use the $( ... ) construct for command substitution
      t8003-blame-corner-cases.sh: use the $( ... ) construct for
command substitution
      t9001-send-email.sh: use the $( ... ) construct for command substitution
      t9100-git-svn-basic.sh: use the $( ... ) construct for command
substitution
      t9101-git-svn-props.sh: use the $( ... ) construct for command
substitution
      t9104-git-svn-follow-parent.sh: use the $( ... ) construct for
command substitution
      t9105-git-svn-commit-diff.sh: use the $( ... ) construct for
command substitution
      t9107-git-svn-migrate.sh: use the $( ... ) construct for command
substitution
      t9108-git-svn-glob.sh: use the $( ... ) construct for command substitution
      t9109-git-svn-multi-glob.sh: use the $( ... ) construct for
command substitution
      t9110-git-svn-use-svm-props.sh: use the $( ... ) construct for
command substitution
      t9114-git-svn-dcommit-merge.sh: use the $( ... ) construct for
command substitution
      t9118-git-svn-funky-branch-names.sh: use the $( ... ) construct
for command substitution
      t9119-git-svn-info.sh: use the $( ... ) construct for command substitution
      t9129-git-svn-i18n-commitencoding.sh: use the $( ... ) construct
for command substitution
      t9130-git-svn-authors-file.sh: use the $( ... ) construct for
command substitution
      t9132-git-svn-broken-symlink.sh: use the $( ... ) construct for
command substitution
      t9137-git-svn-dcommit-clobber-series.sh: use the $( ... )
construct for command substitution
      t9138-git-svn-authors-prog.sh: use the $( ... ) construct for
command substitution
      t9145-git-svn-master-branch.sh: use the $( ... ) construct for
command substitution
      t9150-svk-mergetickets.sh: use the $( ... ) construct for
command substitution
      t9300-fast-import.sh: use the $( ... ) construct for command substitution
      t9350-fast-export.sh: use the $( ... ) construct for command substitution
      t9501-gitweb-standalone-http-status.sh: use the $( ... )
construct for command substitution
      t9901-git-web--browse.sh: use the $( ... ) construct for command
substitution
      test-lib-functions.sh: use the $( ... ) construct for command substitution
      unimplemented.sh: use the $( ... ) construct for command substitution
      t7505-prepare-commit-msg-hook.sh: use the $( ... ) construct for
command substitution

 Documentation/howto-index.sh                    |   12 ++--
 Documentation/install-webdoc.sh                 |    6 +-
 contrib/examples/git-checkout.sh                |    8 +--
 contrib/examples/git-clone.sh                   |   20 +++----
 contrib/examples/git-commit.sh                  |   10 ++--
 contrib/examples/git-fetch.sh                   |    6 +-
 contrib/examples/git-ls-remote.sh               |    4 +-
 contrib/examples/git-merge.sh                   |    4 +-
contrib/examples/git-repack.sh                  |    2 +-
 contrib/examples/git-resolve.sh                 |    2 +-
 contrib/examples/git-revert.sh                  |    2 +-
 contrib/examples/git-tag.sh                     |    2 +-
 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh    |   14 ++---
 contrib/mw-to-git/t/t9362-mw-to-git-utf8.sh     |    4 +-
 contrib/mw-to-git/t/t9365-continuing-queries.sh |    2 +-
 contrib/mw-to-git/t/test-gitmw-lib.sh           |    6 +-
 contrib/subtree/t/t7900-subtree.sh              |    2 +-
 contrib/thunderbird-patch-inline/appp.sh        |   14 ++---
 git-gui/po/glossary/txt-to-pot.sh               |    4 +-
 git-pull.sh                                     |    2 +-
 git-rebase--merge.sh                            |    4 +-
 git-rebase.sh                                   |    8 +--
 git-stash.sh                                    |    2 +-
 git-web--browse.sh                              |    6 +-
 t/lib-credential.sh                             |    2 +-
 t/lib-cvs.sh                                    |    2 +-
 t/lib-gpg.sh                                    |    2 +-
 t/perf/p5302-pack-index.sh                      |    2 +-
 t/t0001-init.sh                                 |   12 ++--
 t/t0010-racy-git.sh                             |    4 +-
 t/t0020-crlf.sh                                 |   42 +++++++-------
 t/t0025-crlf-auto.sh                            |   38 ++++++-------
 t/t0026-eol-config.sh                           |   20 +++----
 t/t0030-stripspace.sh                           |   20 +++----
 t/t0300-credentials.sh                          |    2 +-
 t/t1000-read-tree-m-3way.sh                     |    4 +-
 t/t1001-read-tree-m-2way.sh                     |   18 +++---
 t/t1002-read-tree-m-u-2way.sh                   |   10 ++--
 t/t1003-read-tree-prefix.sh                     |    2 +-
 t/t1004-read-tree-m-u-wf.sh                     |    8 +--
 t/t1020-subdirectory.sh                         |   22 ++++----
 t/t1050-large.sh                                |    4 +-
 t/t1100-commit-tree-options.sh                  |    4 +-
 t/t1401-symbolic-ref.sh                         |    2 +-
 t/t1410-reflog.sh                               |   24 ++++----
 t/t1511-rev-parse-caret.sh                      |    4 +-
 t/t1512-rev-parse-disambiguation.sh             |    8 +--
 t/t2102-update-index-symlinks.sh                |    2 +-
 t/t3030-merge-recursive.sh                      |    2 +-
 t/t3100-ls-tree-restrict.sh                     |    2 +-
 t/t3101-ls-tree-dirname.sh                      |    2 +-
 t/t3210-pack-refs.sh                            |    2 +-
 t/t3403-rebase-skip.sh                          |    2 +-
 t/t3511-cherry-pick-x.sh                        |   14 ++---
 t/t3600-rm.sh                                   |    4 +-
 t/t3700-add.sh                                  |   16 +++---
 t/t3905-stash-include-untracked.sh              |    4 +-
 t/t3910-mac-os-precompose.sh                    |   16 +++---
 t/t4006-diff-mode.sh                            |    2 +-
 t/t4010-diff-pathspec.sh                        |    4 +-
 t/t4012-diff-binary.sh                          |   16 +++---
 t/t4013-diff-various.sh                         |    6 +-
 t/t4014-format-patch.sh                         |   10 ++--
 t/t4036-format-patch-signer-mime.sh             |    2 +-
 t/t4038-diff-combined.sh                        |    2 +-
 t/t4057-diff-combined-paths.sh                  |    2 +-
 t/t4116-apply-reverse.sh                        |   12 ++--
 t/t4119-apply-config.sh                         |    2 +-
t/t4204-patch-id.sh                             |    4 +-
 t/t5000-tar-tree.sh                             |    6 +-
 t/t5003-archive-zip.sh                          |    2 +-
 t/t5100-mailinfo.sh                             |   12 ++--
 t/t5300-pack-object.sh                          |   18 +++---
 t/t5301-sliding-window.sh                       |   14 ++---
 t/t5302-pack-index.sh                           |   34 ++++++------
 t/t5303-pack-corruption-resilience.sh           |    8 +--
 t/t5304-prune.sh                                |    2 +-
 t/t5305-include-tag.sh                          |    8 +--
 t/t5500-fetch-pack.sh                           |   16 +++---
 t/t5505-remote.sh                               |    2 +-
 t/t5506-remote-groups.sh                        |    2 +-
 t/t5510-fetch.sh                                |   10 ++--
 t/t5515-fetch-merge-logic.sh                    |    4 +-
 t/t5516-fetch-push.sh                           |    4 +-
 t/t5517-push-mirror.sh                          |    2 +-
 t/t5520-pull.sh                                 |   10 ++--
 t/t5522-pull-symlink.sh                         |    2 +-
 t/t5530-upload-pack-error.sh                    |    2 +-
 t/t5537-fetch-shallow.sh                        |    4 +-
 t/t5538-push-shallow.sh                         |    4 +-
 t/t5550-http-fetch-dumb.sh                      |    8 +--
 t/t5551-http-fetch-smart.sh                     |    2 +-
 t/t5570-git-daemon.sh                           |    8 +--
 t/t5601-clone.sh                                |    2 +-
 t/t5700-clone-reference.sh                      |    2 +-
 t/t5710-info-alternate.sh                       |    2 +-
 t/t5900-repo-selection.sh                       |    2 +-
 t/t6001-rev-list-graft.sh                       |   12 ++--
 t/t6002-rev-list-bisect.sh                      |    6 +-
 t/t6015-rev-list-show-all-parents.sh            |    6 +-
 t/t6032-merge-large-rename.sh                   |    2 +-
 t/t6034-merge-rename-nocruft.sh                 |    2 +-
 t/t6132-pathspec-exclude.sh                     |    2 +-
 t/t7001-mv.sh                                   |    4 +-
 t/t7003-filter-branch.sh                        |    6 +-
 t/t7004-tag.sh                                  |   16 +++---
 t/t7006-pager.sh                                |    2 +-
 t/t7103-reset-bare.sh                           |    2 +-
 t/t7406-submodule-update.sh                     |    4 +-
 t/t7408-submodule-reference.sh                  |    2 +-
 t/t7504-commit-msg-hook.sh                      |    2 +-
 t/t7505-prepare-commit-msg-hook.sh              |   32 +++++------
 t/t7602-merge-octopus-many.sh                   |    8 +--
 t/t7700-repack.sh                               |    4 +-
 t/t8003-blame-corner-cases.sh                   |    4 +-
 t/t9001-send-email.sh                           |   10 ++--
 t/t9100-git-svn-basic.sh                        |   24 ++++----
 t/t9101-git-svn-props.sh                        |   30 +++++-----
 t/t9104-git-svn-follow-parent.sh                |   48 ++++++++--------
 t/t9105-git-svn-commit-diff.sh                  |    4 +-
 t/t9107-git-svn-migrate.sh                      |   16 +++---
 t/t9108-git-svn-glob.sh                         |   20 +++----
 t/t9109-git-svn-multi-glob.sh                   |   32 +++++------
 t/t9110-git-svn-use-svm-props.sh                |    2 +-
 t/t9114-git-svn-dcommit-merge.sh                |   12 ++--
 t/t9118-git-svn-funky-branch-names.sh           |    2 +-
 t/t9119-git-svn-info.sh                         |    2 +-
 t/t9129-git-svn-i18n-commitencoding.sh          |    4 +-
 t/t9130-git-svn-authors-file.sh                 |   12 ++--
 t/t9132-git-svn-broken-symlink.sh               |    4 +-
 t/t9137-git-svn-dcommit-clobber-series.sh       |   24 ++++----
 t/t9138-git-svn-authors-prog.sh                 |    2 +-
 t/t9145-git-svn-master-branch.sh                |    4 +-
 t/t9150-svk-mergetickets.sh                     |    2 +-
 t/t9300-fast-import.sh                          |   68 +++++++++++------------
 t/t9350-fast-export.sh                          |    6 +-
 t/t9501-gitweb-standalone-http-status.sh        |    6 +-
 t/t9901-git-web--browse.sh                      |    2 +-
 t/test-lib-functions.sh                         |    8 +--
 unimplemented.sh                                |    2 +-
 140 files changed, 592 insertions(+), 592 deletions(-)
