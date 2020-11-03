Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73404C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41EC8206F8
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgKCQQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 11:16:37 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:58198 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbgKCQQh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 11:16:37 -0500
Received: from client3368.fritz.box (i5C745802.versanet.de [92.116.88.2])
        by dd36226.kasserver.com (Postfix) with ESMTPA id 8C8B73C36D9;
        Tue,  3 Nov 2020 17:16:35 +0100 (CET)
From:   Stefan Haller <stefan@haller-berlin.de>
To:     me@yadavpratyush.com
Cc:     git@vger.kernel.org
Subject: [PATCH v2 0/1] git-gui: Auto-rescan on activate
Date:   Tue,  3 Nov 2020 17:16:30 +0100
Message-Id: <20201103161631.89971-1-stefan@haller-berlin.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <fe2f24e8-52f2-81fe-0ebd-ecd90b1acfb4@haller-berlin.de>
References: <fe2f24e8-52f2-81fe-0ebd-ecd90b1acfb4@haller-berlin.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v2:
- dropped the unnecessary "after idle" logic
- do the rescan only for the top-level widget; this avoids unnecessary rescans
  when switching focus between sub-panes
- add a checkbox to the options dialog

As explained earlier, I still very much believe that "on" is a good default for
the option, so I kept it that way.

Stefan Haller (1):
  git-gui: Auto-rescan on activate

 git-gui.sh     | 5 +++++
 lib/option.tcl | 1 +
 2 files changed, 6 insertions(+)

--
2.29.2

