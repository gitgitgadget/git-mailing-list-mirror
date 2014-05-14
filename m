From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Please pull the patch series "use the $( ... ) construct for command substitution"
Date: Wed, 14 May 2014 17:23:05 +0200
Message-ID: <CA+EOSBk4YvQHTG=gRd1TF9gX0OgjLpjRidh7NAa9wmjr6bSkBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 14 17:23:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkb1U-0007pd-T8
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 17:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755588AbaENPXI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 11:23:08 -0400
Received: from mail-ve0-f172.google.com ([209.85.128.172]:50240 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755462AbaENPXG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 11:23:06 -0400
Received: by mail-ve0-f172.google.com with SMTP id oz11so2613171veb.3
        for <git@vger.kernel.org>; Wed, 14 May 2014 08:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=mEKQ4QUdpD503uU3mGxDeERWzJBFJvWpL2EaOsd0G6k=;
        b=JkwTs2zxFMciEqleAe66fspgiv7lrgdhGijRfP3lEOu/4rs0rTEeAV988K3qVFOcY2
         vlKJMts3GaLC3XwxF1FG3CzT8FwABVr9YB3mxUPJhsYFXxSb/KZUT5PHg6WHN7gqCfx+
         JSJGbSeE0uXazsKaEEmV7sY6TKfgSQoAdYi1CLu28Pev8Uxq+WU5PLphkMPYmc6oV0lM
         khJQ2PLW74WYvrQo4M5/Dfgbm0PR5VS28tabtZ9r3/9u3O9AsueGEzeZ2fZfsw2iJc73
         1vAQYuV/GNdwM2XSnXyWISkk2WbEd7Kdcf5cAOyGb/hLmxeQFnuVKgCZPlkuqLZKDfQv
         3AcQ==
X-Received: by 10.220.190.197 with SMTP id dj5mr3549017vcb.19.1400080985247;
 Wed, 14 May 2014 08:23:05 -0700 (PDT)
Received: by 10.52.163.207 with HTTP; Wed, 14 May 2014 08:23:05 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248919>

The following changes since commit 6308767f0bb58116cb405e1f4f77f5dfc1589920:


  Merge branch 'fc/prompt-zsh-read-from-file' (2014-05-13 11:53:14 -0700)


are available in the git repository at:


  https://github.com/devzero2000/git-core.git  ep/shell-command-substitution-v4


for you to fetch changes up to 8c8883150c391fae33c122228af937594142600e:



  test-lib-functions.sh: use the $( ... ) construct for command
substitution (2014-05-14 05:34:52 -0700)

----------------------------------------------------------------

I have re-created a branch with these patches based on a previous
observation made here

http://www.spinics.net/lists/git/msg230236.html

Thanks very much to the people (Matthieu i think)
that will make the reviews, I understand it's boring

----------------------------------------------------------------

Elia Pinto (83):

      t5003-archive-zip.sh: use the $( ... ) construct for command substitution

      t5517-push-mirror.sh: use the $( ... ) construct for command substitution

      t6002-rev-list-bisect.sh: use the $( ... ) construct for command
substitution

      t7700-repack.sh: use the $( ... ) construct for command substitution

      t5100-mailinfo.sh: use the $( ... ) construct for command substitution

      t5520-pull.sh: use the $( ... ) construct for command substitution

      t6015-rev-list-show-all-parents.sh: use the $( ... ) construct
for command substitution

      t8003-blame-corner-cases.sh: use the $( ... ) construct for
command substitution

      t5300-pack-object.sh: use the $( ... ) construct for command substitution

      t5522-pull-symlink.sh: use the $( ... ) construct for command substitution

      t6032-merge-large-rename.sh: use the $( ... ) construct for
command substitution

      t5301-sliding-window.sh: use the $( ... ) construct for command
substitution

      t5530-upload-pack-error.sh: use the $( ... ) construct for
command substitution

      t6034-merge-rename-nocruft.sh: use the $( ... ) construct for
command substitution

      t9100-git-svn-basic.sh: use the $( ... ) construct for command
substitution

      t5302-pack-index.sh: use the $( ... ) construct for command substitution

      t5537-fetch-shallow.sh: use the $( ... ) construct for command
substitution

      t6132-pathspec-exclude.sh: use the $( ... ) construct for
command substitution

      t9101-git-svn-props.sh: use the $( ... ) construct for command
substitution

      t5303-pack-corruption-resilience.sh: use the $( ... ) construct
for command substitution

      t5538-push-shallow.sh: use the $( ... ) construct for command substitution

      t7001-mv.sh: use the $( ... ) construct for command substitution

      t9104-git-svn-follow-parent.sh: use the $( ... ) construct for
command substitution

      t5304-prune.sh: use the $( ... ) construct for command substitution

      t5550-http-fetch-dumb.sh: use the $( ... ) construct for command
substitution

      t7003-filter-branch.sh: use the $( ... ) construct for command
substitution

      t9105-git-svn-commit-diff.sh: use the $( ... ) construct for
command substitution

      t5305-include-tag.sh: use the $( ... ) construct for command substitution

      t5551-http-fetch-smart.sh: use the $( ... ) construct for
command substitution

      t7004-tag.sh: use the $( ... ) construct for command substitution

      t9107-git-svn-migrate.sh: use the $( ... ) construct for command
substitution

      t5500-fetch-pack.sh: use the $( ... ) construct for command substitution

      t5570-git-daemon.sh: use the $( ... ) construct for command substitution

      t7006-pager.sh: use the $( ... ) construct for command substitution

      t9108-git-svn-glob.sh: use the $( ... ) construct for command substitution

      t5505-remote.sh: use the $( ... ) construct for command substitution

      t5601-clone.sh: use the $( ... ) construct for command substitution

      t7103-reset-bare.sh: use the $( ... ) construct for command substitution

      t9109-git-svn-multi-glob.sh: use the $( ... ) construct for
command substitution

      t5506-remote-groups.sh: use the $( ... ) construct for command
substitution

      t5700-clone-reference.sh: use the $( ... ) construct for command
substitution

      t7406-submodule-update.sh: use the $( ... ) construct for
command substitution

      t9110-git-svn-use-svm-props.sh: use the $( ... ) construct for
command substitution

      t5510-fetch.sh: use the $( ... ) construct for command substitution

      t5710-info-alternate.sh: use the $( ... ) construct for command
substitution

      t7408-submodule-reference.sh: use the $( ... ) construct for
command substitution

      t9114-git-svn-dcommit-merge.sh: use the $( ... ) construct for
command substitution

      t5515-fetch-merge-logic.sh: use the $( ... ) construct for
command substitution

      t5900-repo-selection.sh: use the $( ... ) construct for command
substitution

      t7504-commit-msg-hook.sh: use the $( ... ) construct for command
substitution

      t5516-fetch-push.sh: use the $( ... ) construct for command substitution

      t6001-rev-list-graft.sh: use the $( ... ) construct for command
substitution

      t7602-merge-octopus-many.sh: use the $( ... ) construct for
command substitution

      unimplemented.sh: use the $( ... ) construct for command substitution

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

      t7505-prepare-commit-msg-hook.sh: use the $( ... ) construct for
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



 t/t1100-commit-tree-options.sh            |    4 ++--

 t/t1401-symbolic-ref.sh                   |    2 +-

 t/t1410-reflog.sh                         |   24 ++++++++++++------------

 t/t1511-rev-parse-caret.sh                |    4 ++--

 t/t1512-rev-parse-disambiguation.sh       |    8 ++++----

 t/t2102-update-index-symlinks.sh          |    2 +-

 t/t3030-merge-recursive.sh                |    2 +-

 t/t3100-ls-tree-restrict.sh               |    2 +-

 t/t3101-ls-tree-dirname.sh                |    2 +-

 t/t3210-pack-refs.sh                      |    2 +-

 t/t3403-rebase-skip.sh                    |    2 +-

 t/t3511-cherry-pick-x.sh                  |   14 +++++++-------

 t/t3600-rm.sh                             |    4 ++--

 t/t3700-add.sh                            |   16 ++++++++--------

 t/t5003-archive-zip.sh                    |    2 +-

 t/t5100-mailinfo.sh                       |   12 ++++++------

 t/t5300-pack-object.sh                    |   18 +++++++++---------

 t/t5301-sliding-window.sh                 |   14 +++++++-------

 t/t5302-pack-index.sh                     |   34
+++++++++++++++++-----------------

 t/t5303-pack-corruption-resilience.sh     |    8 ++++----

 t/t5304-prune.sh                          |    2 +-

 t/t5305-include-tag.sh                    |    8 ++++----

 t/t5500-fetch-pack.sh                     |   16 ++++++++--------

 t/t5505-remote.sh                         |    2 +-

 t/t5506-remote-groups.sh                  |    2 +-

 t/t5510-fetch.sh                          |   10 +++++-----

 t/t5515-fetch-merge-logic.sh              |    4 ++--

 t/t5516-fetch-push.sh                     |    4 ++--

 t/t5517-push-mirror.sh                    |    2 +-

 t/t5520-pull.sh                           |   10 +++++-----

 t/t5522-pull-symlink.sh                   |    2 +-

 t/t5530-upload-pack-error.sh              |    2 +-

 t/t5537-fetch-shallow.sh                  |    4 ++--

 t/t5538-push-shallow.sh                   |    4 ++--

 t/t5550-http-fetch-dumb.sh                |    8 ++++----

 t/t5551-http-fetch-smart.sh               |    2 +-

 t/t5570-git-daemon.sh                     |    8 ++++----

 t/t5601-clone.sh                          |    2 +-

 t/t5700-clone-reference.sh                |    2 +-

 t/t5710-info-alternate.sh                 |    2 +-

 t/t5900-repo-selection.sh                 |    2 +-

 t/t6001-rev-list-graft.sh                 |   12 ++++++------

 t/t6002-rev-list-bisect.sh                |    6 +++---

 t/t6015-rev-list-show-all-parents.sh      |    6 +++---

 t/t6032-merge-large-rename.sh             |    2 +-

 t/t6034-merge-rename-nocruft.sh           |    2 +-

 t/t6132-pathspec-exclude.sh               |    2 +-

 t/t7001-mv.sh                             |    4 ++--

 t/t7003-filter-branch.sh                  |    6 +++---

 t/t7004-tag.sh                            |   16 ++++++++--------

 t/t7006-pager.sh                          |    2 +-

 t/t7103-reset-bare.sh                     |    2 +-

 t/t7406-submodule-update.sh               |    4 ++--

 t/t7408-submodule-reference.sh            |    2 +-

 t/t7504-commit-msg-hook.sh                |    2 +-

 t/t7505-prepare-commit-msg-hook.sh        |   32
++++++++++++++++----------------

 t/t7602-merge-octopus-many.sh             |    8 ++++----

 t/t7700-repack.sh                         |    4 ++--

 t/t8003-blame-corner-cases.sh             |    4 ++--

 t/t9100-git-svn-basic.sh                  |   24 ++++++++++++------------

 t/t9101-git-svn-props.sh                  |   30 +++++++++++++++---------------

 t/t9104-git-svn-follow-parent.sh          |   48
++++++++++++++++++++++++------------------------

 t/t9105-git-svn-commit-diff.sh            |    4 ++--

 t/t9107-git-svn-migrate.sh                |   16 ++++++++--------

 t/t9108-git-svn-glob.sh                   |   20 ++++++++++----------

 t/t9109-git-svn-multi-glob.sh             |   32
++++++++++++++++----------------

 t/t9110-git-svn-use-svm-props.sh          |    2 +-

 t/t9114-git-svn-dcommit-merge.sh          |   12 ++++++------

 t/t9118-git-svn-funky-branch-names.sh     |    2 +-

 t/t9119-git-svn-info.sh                   |    2 +-

 t/t9129-git-svn-i18n-commitencoding.sh    |    4 ++--

 t/t9130-git-svn-authors-file.sh           |   12 ++++++------

 t/t9132-git-svn-broken-symlink.sh         |    4 ++--

 t/t9137-git-svn-dcommit-clobber-series.sh |   24 ++++++++++++------------

 t/t9138-git-svn-authors-prog.sh           |    2 +-

 t/t9145-git-svn-master-branch.sh          |    4 ++--

 t/t9150-svk-mergetickets.sh               |    2 +-

 t/t9300-fast-import.sh                    |   68
++++++++++++++++++++++++++++++++++----------------------------------

 t/t9350-fast-export.sh                    |    6 +++---

 t/t9501-gitweb-standalone-http-status.sh  |    6 +++---

 t/t9901-git-web--browse.sh                |    2 +-

 t/test-lib-functions.sh                   |    8 ++++----

 unimplemented.sh                          |    2 +-

 83 files changed, 363 insertions(+), 363 deletions(-)
