Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BCCC1F461
	for <e@80x24.org>; Mon, 19 Aug 2019 21:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfHSVl3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 17:41:29 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:33015 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbfHSVl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 17:41:29 -0400
Received: from localhost.localdomain (unknown [1.186.12.8])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 335E1100003;
        Mon, 19 Aug 2019 21:41:25 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] git-gui: Add ability to revert selected hunks and lines
Date:   Tue, 20 Aug 2019 03:11:07 +0530
Message-Id: <20190819214110.26461-1-me@yadavpratyush.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

This series adds the ability to revert selected lines and hunks in
git-gui. Partially based on the patch by Bert Wesarg [0].

The commits can be found in the topic branch 'py/git-gui-revert-lines'
at https://github.com/prati0100/git/tree/py/git-gui-revert-lines

Once reviewed, pull the commits from
832064f93d3ad432616e96ca70f682a7cfdcc3e0 till
72eed27a29f1e71cbefefa6b19f96c89793ac74d.

Let me know if there is some other way I'm supposed to ask for a pull.

[0]
https://public-inbox.org/git/a9ba4550a29d7f3c653561e7029f0920bf8eb008.1326116492.git.bert.wesarg@googlemail.com/

Pratyush Yadav (3):
  git-gui: Move revert confirmation dialog creation to separate function
  git-gui: Add the ability to revert selected lines
  git-gui: Add the ability to revert selected hunk

 git-gui/git-gui.sh    | 39 ++++++++++++++++++++++++--
 git-gui/lib/diff.tcl  | 65 ++++++++++++++++++++++++++++++++++++-------
 git-gui/lib/index.tcl | 27 +++++++++++-------
 3 files changed, 109 insertions(+), 22 deletions(-)

--
2.21.0

