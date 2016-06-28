Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56E412018B
	for <e@80x24.org>; Tue, 28 Jun 2016 11:41:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbcF1Llq (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 07:41:46 -0400
Received: from mx2.imag.fr ([129.88.30.17]:42719 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023AbcF1Ll1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 07:41:27 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u5SBeGRI028849
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 28 Jun 2016 13:40:16 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.42.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u5SBeHF2019214;
	Tue, 28 Jun 2016 13:40:17 +0200
From:	Matthieu Moy <Matthieu.Moy@imag.fr>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>,
	Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr>,
	Erwan MATHONIERE <erwan.mathoniere@ensimag.grenoble-inp.fr>,
	Tom RUSSELLO <tom.russello@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH v2 0/7] literal formatting in documentation
Date:	Tue, 28 Jun 2016 13:40:08 +0200
Message-Id: <20160628114015.25828-1-Matthieu.Moy@imag.fr>
X-Mailer: git-send-email 2.8.2.397.gbe91ebf.dirty
In-Reply-To: <20160627174623.11084-1-Matthieu.Moy@imag.fr>
References: <20160627174623.11084-1-Matthieu.Moy@imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Tue, 28 Jun 2016 13:40:16 +0200 (CEST)
X-IMAG-MailScanner-Information:	Please contact MI2S MIM  for more information
X-MailScanner-ID: u5SBeGRI028849
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check:	1467718817.89698@V0wYB0wMGgnqLw9C+rHnJQ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This should address all comments from Peff.

The series is now based on master (which now contains tr/doc-tt).

Content changes since v1:

* First patch (fix indentation prior to actual change to avoid 'git
  am' warning) is new.

* One buggy replacement (`grep.patternType` -> 'grep.patternType')
  removed.

Other fixes are typos and details in commit messages.

Matthieu Moy (7):
  Documentation/git-mv.txt: fix whitespace indentation
  doc: typeset short command-line options as literal
  doc: typeset long command-line options as literal
  doc: typeset '--' as literal
  doc: typeset long options with argument as literal
  CodingGuidelines: formatting HEAD in documentation
  doc: typeset HEAD and variants as literal

 Documentation/CodingGuidelines           |  5 ++--
 Documentation/config.txt                 | 40 ++++++++++++++++----------------
 Documentation/diff-config.txt            |  2 +-
 Documentation/diff-format.txt            |  8 +++----
 Documentation/diff-generate-patch.txt    |  6 ++---
 Documentation/fetch-options.txt          |  6 ++---
 Documentation/git-am.txt                 |  4 ++--
 Documentation/git-bisect.txt             |  2 +-
 Documentation/git-branch.txt             |  6 ++---
 Documentation/git-cat-file.txt           | 12 +++++-----
 Documentation/git-checkout.txt           |  4 ++--
 Documentation/git-cherry-pick.txt        |  2 +-
 Documentation/git-clean.txt              |  2 +-
 Documentation/git-commit-tree.txt        |  2 +-
 Documentation/git-commit.txt             |  4 ++--
 Documentation/git-config.txt             | 28 +++++++++++-----------
 Documentation/git-credential-store.txt   |  2 +-
 Documentation/git-cvsimport.txt          | 12 +++++-----
 Documentation/git-cvsserver.txt          | 12 +++++-----
 Documentation/git-daemon.txt             |  8 +++----
 Documentation/git-describe.txt           |  2 +-
 Documentation/git-diff-index.txt         |  4 ++--
 Documentation/git-diff-tree.txt          | 20 ++++++++--------
 Documentation/git-difftool.txt           |  2 +-
 Documentation/git-fast-import.txt        |  4 ++--
 Documentation/git-fetch-pack.txt         |  4 ++--
 Documentation/git-filter-branch.txt      |  6 ++---
 Documentation/git-for-each-ref.txt       |  2 +-
 Documentation/git-fsck.txt               |  2 +-
 Documentation/git-grep.txt               | 10 ++++----
 Documentation/git-gui.txt                |  2 +-
 Documentation/git-help.txt               |  6 ++---
 Documentation/git-http-push.txt          |  4 ++--
 Documentation/git-interpret-trailers.txt |  2 +-
 Documentation/git-ls-files.txt           |  2 +-
 Documentation/git-ls-tree.txt            |  8 +++----
 Documentation/git-mktree.txt             |  2 +-
 Documentation/git-mv.txt                 |  4 ++--
 Documentation/git-notes.txt              |  2 +-
 Documentation/git-p4.txt                 | 22 +++++++++---------
 Documentation/git-push.txt               |  2 +-
 Documentation/git-rebase.txt             | 10 ++++----
 Documentation/git-remote.txt             | 10 ++++----
 Documentation/git-repack.txt             |  4 ++--
 Documentation/git-revert.txt             |  4 ++--
 Documentation/git-send-email.txt         | 24 +++++++++----------
 Documentation/git-send-pack.txt          | 10 ++++----
 Documentation/git-shell.txt              |  4 ++--
 Documentation/git-show-branch.txt        |  2 +-
 Documentation/git-show-ref.txt           |  6 ++---
 Documentation/git-svn.txt                | 26 ++++++++++-----------
 Documentation/git-tag.txt                |  2 +-
 Documentation/git-update-index.txt       | 14 +++++------
 Documentation/git-web--browse.txt        |  2 +-
 Documentation/git.txt                    | 10 ++++----
 Documentation/gitcore-tutorial.txt       |  2 +-
 Documentation/gitdiffcore.txt            |  4 ++--
 Documentation/gitk.txt                   |  2 +-
 Documentation/gitmodules.txt             |  2 +-
 Documentation/gitremote-helpers.txt      | 10 ++++----
 Documentation/rev-list-options.txt       |  2 +-
 Documentation/revisions.txt              | 26 ++++++++++-----------
 62 files changed, 228 insertions(+), 227 deletions(-)

-- 
2.8.2.397.gbe91ebf.dirty

