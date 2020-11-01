Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1309C4742C
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 17:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0BAC2222F
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 17:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgKARFY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 12:05:24 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:57926 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbgKARFW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 12:05:22 -0500
Received: from client3368.fritz.box (i5C74609C.versanet.de [92.116.96.156])
        by dd36226.kasserver.com (Postfix) with ESMTPA id 42B733C459F;
        Sun,  1 Nov 2020 18:05:18 +0100 (CET)
From:   Stefan Haller <stefan@haller-berlin.de>
To:     git@vger.kernel.org
Cc:     me@yadavpratyush.com
Subject: [PATCH 0/2] git-gui: Auto-rescan on activate
Date:   Sun,  1 Nov 2020 18:05:03 +0100
Message-Id: <20201101170505.71246-1-stefan@haller-berlin.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do an automatic rescan whenever the git-gui window receives focus. Most other
GUI tools do this, and it's very convenient; no more pressing F5 manually.

People who don't like this behavior can turn it off using
"git config gui.autorescan false".

Stefan Haller (2):
  git-gui: Delay rescan until idle time
  git-gui: Auto-rescan on activate

 git-gui.sh | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

--
2.29.2

