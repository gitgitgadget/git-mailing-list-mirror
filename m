Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08C3F1F461
	for <e@80x24.org>; Thu, 22 Aug 2019 22:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404810AbfHVWBR (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 18:01:17 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:37891 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404737AbfHVWBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 18:01:16 -0400
Received: from localhost.localdomain (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 4385E240004;
        Thu, 22 Aug 2019 22:01:11 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH v2 0/4] git-gui: Add ability to revert selected hunks and lines
Date:   Fri, 23 Aug 2019 03:31:03 +0530
Message-Id: <20190822220107.4153-1-me@yadavpratyush.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819214110.26461-1-me@yadavpratyush.com>
References: <20190819214110.26461-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This series adds the ability to revert selected lines and hunks in
git-gui. Partially based on the patch by Bert Wesarg [0].

The commits can be found in the topic branch 'py/revert-hunks-lines'
at https://github.com/prati0100/git-gui/tree/py/revert-hunks-lines

Once reviewed, pull the commits from
415ce3f8582769d1d454b3796dc6c9c847cefa87 till
0a1f4ea92b97e673fda40918dae68deead43bb27, or just munge the patches and
apply them locally, whichever you prefer.

Changes in v2:
- Add an option to disable the revert confirmation prompt as suggested
  by Johannes Sixt.
- Base the patches on Pat's git-gui tree instead of git.git.

[0]
https://public-inbox.org/git/a9ba4550a29d7f3c653561e7029f0920bf8eb008.1326116492.git.bert.wesarg@googlemail.com/

Pratyush Yadav (4):
  git-gui: Move revert confirmation dialog creation to separate function
  git-gui: Add option to disable the revert confirmation prompt
  git-gui: Add the ability to revert selected lines
  git-gui: Add the ability to revert selected hunk

 git-gui.sh     | 40 +++++++++++++++++++++++++++++--
 lib/diff.tcl   | 65 ++++++++++++++++++++++++++++++++++++++++++--------
 lib/index.tcl  | 31 ++++++++++++++++--------
 lib/option.tcl |  1 +
 4 files changed, 115 insertions(+), 22 deletions(-)

--
2.21.0

