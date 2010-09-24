From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 00/95] Add missing &&'s in the testsuite
Date: Fri, 24 Sep 2010 15:06:53 -0600
Message-ID: <1285362413-18265-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 23:05:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzFSo-0006gL-QD
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 23:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757294Ab0IXVFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 17:05:16 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37929 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591Ab0IXVFP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 17:05:15 -0400
Received: by wyb28 with SMTP id 28so2313234wyb.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 14:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=xI32k+cDJXZPduxDvGnGH/Fhyeoeq0rzRRLwm6dfzmc=;
        b=Bvjc4OmWIWwzioM1FNCbTTSnk+ODjdFGqCCfHffV29LmIzSqO+BvsVOw2ZxISDefel
         47g0LFvqsrTSyAfTj6hrg5aVDqZvXmM1FTG1/nq9XGpD/55EvW4KUnkpy/y0aas35rGn
         qCnODx0RPcUDpzmcms/KrTD4r1CS4u6T7CzVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=oH06xCCg9OhzxAJ7+dPO/xpfj7i9eB4pK/5ZC1yvTApHbXzaAOrH6YJDElnRAuoII7
         yxY5lqNWrlBjBywpUMoifwy9Klcbw9GZAcZvcI08o4v74RPwtsSIvpikKok2HI1HAWgL
         Ahn3OZH7yrGaoizH7XUmMFCDibH2gwzYvabbw=
Received: by 10.216.35.77 with SMTP id t55mr9961714wea.0.1285362313772;
        Fri, 24 Sep 2010 14:05:13 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id u32sm1669673weq.35.2010.09.24.14.05.11
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 14:05:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157060>

I ran across three testfiles which were missing &&s; one was missing
several, while another would no longer pass after adding one and had
no comment to that effect.  So I decided it was time to look through
the testsuite.  Now I have a 95 patch series, which I'm worried might
be a bit too much spam for the mailing list.  So the patches are
available from
   git://gitorious.org/~newren/git/en.git   add-missing-ands
Let me know if you're fine with mailing list spam, and I'd be happy
to flood all your inboxes.

80 of the 95 testfiles that needed changes were pretty mechanical --
just simple additions of '&&' in the appropriate place.  15 needed
other changes and I'm not entirely sure whether I made the right ones.
I've moved those 15 to the beginning of the series, so that you won't
have to hunt for them.  (If it makes sense to send just the first 15
to the list, let me know, and I'll do that.)


Elijah Newren (95):
  t6050 (replace): add missing &&
  t1001 (read-tree-m-2way): add missing &&
  t1002 (read-tree-m-u-2way): add missing &&
  t3020 (ls-files-error-unmatch): remove stray '1' from end of file
  t3600 (rm): add lots of missing &&
  t4002 (diff-basic): use test_might_fail for commands that might fail
  t4017 (diff-retval): replace manual exit code check with test_expect_code
  t4019 (diff-wserror): add lots of missing &&
  t4026 (color): add missing &&
  t4202 (log): Replace '<git-command> || :' with test_might_fail
  t5602 (clone-remote-exec): add missing &&
  t6016 (rev-list-graph-simplify-history): add missing &&
  t7001 (mv): add missing &&
  t7601 (merge-pull-config): add missing &&
  t7800 (difftool): add missing &&
  t0001 (init): add missing &&
  t0003 (attributes): add missing &&
  t0020 (crlf): add missing &&
  t0024 (crlf-archive): add missing &&
  t0026 (eol-config): add missing &&
  t0050 (filesystem): add missing &&
  t1000 (read-tree-m-3way): add missing &&
  t1302 (repo-version): add missing &&
  t1401 (symbolic-ref): add missing &&
  t1402 (check-ref-format): add missing &&
  t1410 (reflog): add missing &&
  t1501 (worktree): add missing &&
  t1509 (root-worktree): add missing &&
  t2007 (checkout-symlink): add missing &&
  t2016 (checkout-patch): add missing &&
  t2050 (git-dir-relative): add missing &&
  t2103 (update-index-ignore-missing): add missing &&
  t2200 (add-update): add missing &&
  t3001 (ls-files-others-exclude): add missing &&
  t3050 (subprojects-fetch): add missing &&
  t3203 (branch-output): add missing &&
  t3307 (notes-man): add missing &&
  t3406 (rebase-message): add missing &&
  t3408 (rebase-multi-line): add missing &&
  t3504 (cherry-pick-rerere): add missing &&
  t3903 (stash): add missing &&
  t3904 (stash-patch): add missing &&
  t4021 (format-patch-numbered): add missing &&
  t4027 (diff-submodule): add missing &&
  t4103 (apply-binary): add missing &&
  t4104 (apply-boundary): add missing &&
  t4111 (apply-subdir): add missing &&
  t4119 (apply-config): add missing &&
  t4124 (apply-ws-rule): add missing &&
  t4127 (apply-same-fn): add missing &&
  t4130 (apply-criss-cross-rename): add missing &&
  t4133 (apply-filenames): add missing &&
  t4150 (am): add missing &&
  t5300 (pack-object): add missing &&
  t5301 (sliding-window): add missing &&
  t5302 (pack-index): add missing &&
  t5500 (fetch-pack): add missing &&
  t5502 (quickfetch): add missing &&
  t5503 (tagfollow): add missing &&
  t5510 (fetch): add missing &&
  t5516 (fetch-push): add missing &&
  t5517 (push-mirror): add missing &&
  t5519 (push-alternates): add missing &&
  t5531 (deep-submodule-push): add missing &&
  t5541 (http-push): add missing &&
  t5550 (http-fetch): add missing &&
  t5601 (clone): add missing &&
  t5701 (clone-local): add missing &&
  t5705 (clone-2gb): add missing &&
  t6009 (rev-list-parent): add missing &&
  t6010 (merge-base): add missing &&
  t6022 (merge-rename): add a missing &&
  t6024 (recursive-merge): add missing &&
  t6030 (bisect-porcelain): add missing &&
  t6040 (tracking-info): add missing &&
  t7004 (tag): add missing &&
  t7105 (reset-patch): add missing &&
  t7300 (clean): add missing &&
  t7501 (commit): add missing &&
  t7502 (commit): add missing &&
  t7506 (status-submodule): add missing &&
  t7600 (merge): add missing &&
  t7610 (mergetool): add missing &&
  t7700 (repack): add missing &&
  t8003 (blame): add missing &&
  t9122 (git-svn-author): add missing &&
  t9123 (git-svn-rebuild-with-rewriteroot): add missing &&
  t9134 (git-svn-ignore-paths): add missing &&
  t9137 (git-svn-dcommit-clobber-series): add missing &&
  t9138 (git-svn-authors-prog): add missing &&
  t9146 (git-svn-empty-dirs): add missing &&
  t9151 (svn-mergeinfo): add missing &&
  t9200 (git-cvsexportcommit): add missing &&
  t9401 (git-cvsserver-crlf): add missing &&
  t9600 (cvsimport): add missing &&

 t/t0001-init.sh                             |   20 +++++-----
 t/t0003-attributes.sh                       |   16 ++++----
 t/t0020-crlf.sh                             |    2 +-
 t/t0024-crlf-archive.sh                     |    4 +-
 t/t0026-eol-config.sh                       |    2 +-
 t/t0050-filesystem.sh                       |    6 ++--
 t/t1000-read-tree-m-3way.sh                 |    2 +-
 t/t1001-read-tree-m-2way.sh                 |   18 +++++-----
 t/t1002-read-tree-m-u-2way.sh               |   10 +++---
 t/t1302-repo-version.sh                     |    2 +-
 t/t1401-symbolic-ref.sh                     |    2 +-
 t/t1402-check-ref-format.sh                 |    4 +-
 t/t1410-reflog.sh                           |    8 ++--
 t/t1501-worktree.sh                         |    2 +-
 t/t1509-root-worktree.sh                    |    6 ++--
 t/t2007-checkout-symlink.sh                 |    2 +-
 t/t2016-checkout-patch.sh                   |    2 +-
 t/t2050-git-dir-relative.sh                 |    4 +-
 t/t2103-update-index-ignore-missing.sh      |    2 +-
 t/t2200-add-update.sh                       |    2 +-
 t/t3001-ls-files-others-exclude.sh          |    2 +-
 t/t3020-ls-files-error-unmatch.sh           |    1 -
 t/t3050-subprojects-fetch.sh                |    4 +-
 t/t3203-branch-output.sh                    |    6 ++--
 t/t3307-notes-man.sh                        |    2 +-
 t/t3406-rebase-message.sh                   |    6 ++--
 t/t3408-rebase-multi-line.sh                |    2 +-
 t/t3504-cherry-pick-rerere.sh               |    4 +-
 t/t3600-rm.sh                               |   38 +++++++++-----------
 t/t3903-stash.sh                            |    4 +-
 t/t3904-stash-patch.sh                      |    2 +-
 t/t4002-diff-basic.sh                       |   12 +++---
 t/t4017-diff-retval.sh                      |   30 +++++----------
 t/t4019-diff-wserror.sh                     |   52 +++++++++++++-------------
 t/t4021-format-patch-numbered.sh            |    2 +-
 t/t4026-color.sh                            |    2 +-
 t/t4027-diff-submodule.sh                   |    2 +-
 t/t4103-apply-binary.sh                     |    8 ++--
 t/t4104-apply-boundary.sh                   |    4 +-
 t/t4111-apply-subdir.sh                     |    4 +-
 t/t4119-apply-config.sh                     |    2 +-
 t/t4124-apply-ws-rule.sh                    |    4 +-
 t/t4127-apply-same-fn.sh                    |   18 +++++-----
 t/t4130-apply-criss-cross-rename.sh         |    2 +-
 t/t4133-apply-filenames.sh                  |    6 ++--
 t/t4150-am.sh                               |    2 +-
 t/t4202-log.sh                              |    2 +-
 t/t5300-pack-object.sh                      |    4 +-
 t/t5301-sliding-window.sh                   |    2 +-
 t/t5302-pack-index.sh                       |    2 +-
 t/t5500-fetch-pack.sh                       |    2 +-
 t/t5502-quickfetch.sh                       |    2 +-
 t/t5503-tagfollow.sh                        |    4 +-
 t/t5510-fetch.sh                            |    2 +-
 t/t5516-fetch-push.sh                       |   20 +++++-----
 t/t5517-push-mirror.sh                      |   10 +++---
 t/t5519-push-alternates.sh                  |    2 +-
 t/t5531-deep-submodule-push.sh              |    2 +-
 t/t5541-http-push.sh                        |    2 +-
 t/t5550-http-fetch.sh                       |    6 ++--
 t/t5601-clone.sh                            |    6 ++--
 t/t5602-clone-remote-exec.sh                |   14 ++++----
 t/t5701-clone-local.sh                      |    8 ++--
 t/t5705-clone-2gb.sh                        |    2 +-
 t/t6009-rev-list-parent.sh                  |    2 +-
 t/t6010-merge-base.sh                       |    2 +-
 t/t6016-rev-list-graph-simplify-history.sh  |   24 +++---------
 t/t6022-merge-rename.sh                     |    2 +-
 t/t6024-recursive-merge.sh                  |    2 +-
 t/t6030-bisect-porcelain.sh                 |    8 ++--
 t/t6040-tracking-info.sh                    |    2 +-
 t/t6050-replace.sh                          |    4 +-
 t/t7001-mv.sh                               |    2 +-
 t/t7004-tag.sh                              |   14 ++++----
 t/t7105-reset-patch.sh                      |    6 ++--
 t/t7300-clean.sh                            |    6 ++--
 t/t7501-commit.sh                           |    2 +-
 t/t7502-commit.sh                           |    2 +-
 t/t7506-status-submodule.sh                 |    2 +-
 t/t7600-merge.sh                            |    2 +-
 t/t7601-merge-pull-config.sh                |   12 +++---
 t/t7610-mergetool.sh                        |    2 +-
 t/t7700-repack.sh                           |    2 +-
 t/t7800-difftool.sh                         |   12 +++---
 t/t8003-blame.sh                            |    6 ++--
 t/t9122-git-svn-author.sh                   |    4 +-
 t/t9123-git-svn-rebuild-with-rewriteroot.sh |    2 +-
 t/t9134-git-svn-ignore-paths.sh             |    6 ++--
 t/t9137-git-svn-dcommit-clobber-series.sh   |    2 +-
 t/t9138-git-svn-authors-prog.sh             |    6 ++--
 t/t9146-git-svn-empty-dirs.sh               |    6 ++--
 t/t9151-svn-mergeinfo.sh                    |   22 ++++++------
 t/t9200-git-cvsexportcommit.sh              |    4 +-
 t/t9401-git-cvsserver-crlf.sh               |    2 +-
 t/t9600-cvsimport.sh                        |    2 +-
 95 files changed, 287 insertions(+), 314 deletions(-)

-- 
1.7.3.95.g14291
