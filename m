Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D09EB1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 20:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbeJKESq (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 00:18:46 -0400
Received: from mail.weplayciv.com ([162.221.200.53]:35188 "EHLO
        mail.weplayciv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbeJKESq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 00:18:46 -0400
Received: from localhost.localdomain (c-3985e555.02-149-6c6b7013.bbcust.telenor.se [85.229.133.57])
        by mail.weplayciv.com (Postfix) with ESMTPSA id 3EDB59444AE;
        Wed, 10 Oct 2018 13:54:51 -0700 (PDT)
From:   Daniels Umanovskis <daniels@umanovskis.se>
To:     git@vger.kernel.org
Cc:     Daniels Umanovskis <daniels@umanovskis.se>
Subject: [PATCH v2 0/1] branch: introduce --show-current display option
Date:   Wed, 10 Oct 2018 22:54:31 +0200
Message-Id: <20181010205432.11990-1-daniels@umanovskis.se>
X-Mailer: git-send-email 2.19.1.330.g93276587c.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2 reroll of a previously-discussed patch. Thanks to everyone for their
comments. Based on feedback:

1. Command is now a verb: git branch --show-current.

2. Changed to gitster's suggested implementation: nothing is printed
 if HEAD does not point to a symbolic ref. A fatal
 error if HEAD is a symbolic ref but does not start with refs/heads/.

3. Added a test to show this works with worktrees

A process question to the list. The patch adds a new localizable string
that gets output in case of repository corruption. I happen to speak a
couple of the languages that have po files. Is it accepted practice to
also include po edits in my patch in such a case, or should that be
left to the regular l10n workflow?

Daniels Umanovskis (1):
  branch: introduce --show-current display option

 Documentation/git-branch.txt |  6 +++++-
 builtin/branch.c             | 21 ++++++++++++++++--
 t/t3203-branch-output.sh     | 41 ++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 3 deletions(-)

-- 
2.19.1.330.g93276587c.dirty

