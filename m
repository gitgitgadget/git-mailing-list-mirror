From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH 0/4] tests: use "git xyzzy" form
Date: Wed, 03 Sep 2008 17:59:25 +0900
Message-ID: <20080903175925.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 11:01:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaoEY-0000uI-7i
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 11:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbYICI7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 04:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbYICI7z
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 04:59:55 -0400
Received: from karen.lavabit.com ([72.249.41.33]:36029 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751350AbYICI7z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 04:59:55 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id AF402C88FB;
	Wed,  3 Sep 2008 03:59:44 -0500 (CDT)
Received: from 8115.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id ROT8VGE8W7UC; Wed, 03 Sep 2008 03:59:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=brwphW4LgHrADJ6YHfJ3AFtpAfAuJEa/hT/YVyHWAuWu7utxQBK/3ImIxMbhfrpwYqHOH/LazxOobkThAquRPyCUoNxwyneLiKeqQA0bRolq64griLIOiss/HDKdy9x606J6yqb/GAS6pL5F/nSb7y79CwvHIyLTdWHIHxqeHLc=;
  h=From:To:Cc:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94766>

These four patches update test scripts to use "git xyzzy" format so that
they can serve as sample usage for git commands better.

 [PATCH 1/4] tests: use "git xyzzy" form (t0000 - t3599)
 [PATCH 2/4] tests: use "git xyzzy" form (t3600 - t6999)
 [PATCH 3/4] tests: use "git xyzzy" form (t7000 - t7199)
 [PATCH 4/4] tests: use "git xyzzy" form (t7200 - t9001)

 t/t0050-filesystem.sh                |    2 +-
 t/t1007-hash-object.sh               |    2 +-
 t/t1200-tutorial.sh                  |    2 +-
 t/t1303-wacky-config.sh              |    2 +-
 t/t1400-update-ref.sh                |   10 +-
 t/t1503-rev-parse-verify.sh          |    2 +-
 t/t2005-checkout-index-symlinks.sh   |    4 +-
 t/t2050-git-dir-relative.sh          |    4 +-
 t/t2101-update-index-reupdate.sh     |    2 +-
 t/t2102-update-index-symlinks.sh     |    2 +-
 t/t2200-add-update.sh                |   12 +-
 t/t3001-ls-files-others-exclude.sh   |    2 +-
 t/t3020-ls-files-error-unmatch.sh    |    2 +-
 t/t3030-merge-recursive.sh           |   14 +-
 t/t3200-branch.sh                    |   58 +++---
 t/t3210-pack-refs.sh                 |    4 +-
 t/t3400-rebase.sh                    |    6 +-
 t/t3401-rebase-partial.sh            |   22 ++--
 t/t3403-rebase-skip.sh               |    2 +-
 t/t3404-rebase-interactive.sh        |    2 +-
 t/t3407-rebase-abort.sh              |    2 +-
 t/t3500-cherry.sh                    |   12 +-
 t/t3600-rm.sh                        |    4 +-
 t/t3800-mktag.sh                     |   12 +-
 t/t3900-i18n-commit.sh               |    6 +-
 t/t3901-i18n-patch.sh                |   16 +-
 t/t3903-stash.sh                     |    2 +-
 t/t4012-diff-binary.sh               |    4 +-
 t/t4103-apply-binary.sh              |   26 ++--
 t/t4124-apply-ws-rule.sh             |    2 +-
 t/t4127-apply-same-fn.sh             |    4 +-
 t/t4150-am.sh                        |    2 +-
 t/t4151-am-abort.sh                  |    4 +-
 t/t5300-pack-object.sh               |   14 +-
 t/t5301-sliding-window.sh            |    4 +-
 t/t5302-pack-index.sh                |   12 +-
 t/t5400-send-pack.sh                 |   30 ++--
 t/t5401-update-hooks.sh              |    4 +-
 t/t5402-post-merge-hook.sh           |    4 +-
 t/t5403-post-checkout-hook.sh        |    4 +-
 t/t5500-fetch-pack.sh                |    4 +-
 t/t5510-fetch.sh                     |    2 +-
 t/t5530-upload-pack-error.sh         |    4 +-
 t/t5600-clone-fail-cleanup.sh        |   12 +-
 t/t5602-clone-remote-exec.sh         |    4 +-
 t/t6006-rev-list-format.sh           |    6 +-
 t/t6025-merge-symlinks.sh            |   32 ++--
 t/t6026-merge-attr.sh                |   12 +-
 t/t6030-bisect-porcelain.sh          |    4 +-
 t/t6120-describe.sh                  |   30 ++--
 t/t6300-for-each-ref.sh              |   28 ++--
 t/t7001-mv.sh                        |   12 +-
 t/t7003-filter-branch.sh             |   22 ++--
 t/t7004-tag.sh                       |  318 +++++++++++++++++-----------------
 t/t7101-reset.sh                     |    8 +-
 t/t7102-reset.sh                     |    4 +-
 t/t7103-reset-bare.sh                |    2 +-
 t/t7201-co.sh                        |    2 +-
 t/t7300-clean.sh                     |   72 ++++----
 t/t7400-submodule-basic.sh           |   48 +++---
 t/t7401-submodule-summary.sh         |    2 +-
 t/t7500-commit.sh                    |    2 +-
 t/t7501-commit.sh                    |   48 +++---
 t/t7502-status.sh                    |    2 +-
 t/t7505-prepare-commit-msg-hook.sh   |    2 +-
 t/t7506-status-submodule.sh          |    2 +-
 t/t7600-merge.sh                     |    2 +-
 t/t7601-merge-pull-config.sh         |    2 +-
 t/t7602-merge-octopus-many.sh        |    2 +-
 t/t7603-merge-reduce-heads.sh        |    2 +-
 t/t7604-merge-custom-message.sh      |    2 +-
 t/t7605-merge-resolve.sh             |    2 +-
 t/t7610-mergetool.sh                 |    2 +-
 t/t7701-repack-unpack-unreachable.sh |    2 +-
 t/t9001-send-email.sh                |    2 +-
 75 files changed, 513 insertions(+), 513 deletions(-)

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
