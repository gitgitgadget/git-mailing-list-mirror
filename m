Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F326EC433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 18:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCC63611EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 18:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbhKFSwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 14:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhKFSwF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 14:52:05 -0400
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [IPv6:2a01:e0c:1:1599::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D0CC061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 11:49:24 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:9225:6fd8:b89b:1501])
        by smtp4-g21.free.fr (Postfix) with ESMTP id 2ACF319F59F;
        Sat,  6 Nov 2021 19:49:20 +0100 (CET)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH v3 00/10] doc: fix grammar rules in commands' syntax
Date:   Sat,  6 Nov 2021 19:48:48 +0100
Message-Id: <20211106184858.11500-1-jn.avila@free.fr>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
References: <pull.1066.git.1635261072531.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are command expressions which do not follow the grammar syntax rules.

According to the coding guidelines, the placeholders must:

 * be in small letters
 * enclosed in angle brackets
 * use hyphens as spaces

They also must represent tokens' meaning as atomic entities.

Some fixups for git-credential, git-ls-files, git-init and git-http-push.

changes since v1:

 * split changes across simpler commits

changes since v2:

 * remove back-quote formatting of placeholders from patches
 * revert renaming <bool> placeholder

Jean-Noël Avila (9):
  doc: fix git credential synopsis
  doc: split placeholders as individual tokens
  doc: express grammar placeholders between angle brackets
  doc: use only hyphens as word separators in placeholders
  doc: git-ls-files: express options as optional alternatives
  doc: use three dots for indicating repetition instead of star
  doc: uniformize <URL> placeholders' case
  doc: git-http-push: describe the refs as pattern pairs
  doc: git-init: clarify file modes in octal.

Junio C Hamano (1):
  init doc: --shared=0xxx does not give umask but perm bits

 Documentation/date-formats.txt        |  6 +--
 Documentation/git-archimport.txt      | 14 +++----
 Documentation/git-checkout.txt        | 36 +++++++++---------
 Documentation/git-cherry-pick.txt     |  6 +--
 Documentation/git-clone.txt           |  8 ++--
 Documentation/git-config.txt          | 46 +++++++++++------------
 Documentation/git-credential.txt      |  2 +-
 Documentation/git-cvsexportcommit.txt |  4 +-
 Documentation/git-cvsimport.txt       |  8 ++--
 Documentation/git-diff-files.txt      |  2 +-
 Documentation/git-diff-index.txt      |  2 +-
 Documentation/git-diff-tree.txt       |  2 +-
 Documentation/git-fsck.txt            |  2 +-
 Documentation/git-gui.txt             |  2 +-
 Documentation/git-help.txt            |  6 +--
 Documentation/git-http-fetch.txt      |  2 +-
 Documentation/git-http-push.txt       | 15 ++++----
 Documentation/git-init-db.txt         |  2 +-
 Documentation/git-init.txt            | 27 ++++++++------
 Documentation/git-log.txt             |  8 ++--
 Documentation/git-ls-files.txt        |  6 +--
 Documentation/git-merge-index.txt     |  2 +-
 Documentation/git-p4.txt              |  8 ++--
 Documentation/git-pack-objects.txt    |  4 +-
 Documentation/git-pack-redundant.txt  |  2 +-
 Documentation/git-reflog.txt          |  4 +-
 Documentation/git-remote.txt          |  8 ++--
 Documentation/git-request-pull.txt    |  8 ++--
 Documentation/git-shortlog.txt        |  8 ++--
 Documentation/git-sparse-checkout.txt |  2 +-
 Documentation/git-stage.txt           |  2 +-
 Documentation/git-svn.txt             |  2 +-
 Documentation/git-web--browse.txt     |  2 +-
 Documentation/gitcredentials.txt      |  4 +-
 Documentation/gitsubmodules.txt       |  2 +-
 Documentation/gitworkflows.txt        |  6 +--
 Documentation/pretty-formats.txt      | 54 +++++++++++++--------------
 Documentation/urls-remotes.txt        |  8 ++--
 builtin/credential.c                  |  2 +-
 39 files changed, 168 insertions(+), 166 deletions(-)

-- 
2.33.1

