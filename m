Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F082C5519F
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 19:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FC3B20758
	for <git@archiver.kernel.org>; Sun, 22 Nov 2020 19:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgKVTpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Nov 2020 14:45:50 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:41580 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbgKVTpt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Nov 2020 14:45:49 -0500
Received: from client3368.fritz.box (i5C744221.versanet.de [92.116.66.33])
        by dd36226.kasserver.com (Postfix) with ESMTPA id 5F51D3C052C;
        Sun, 22 Nov 2020 20:45:48 +0100 (CET)
From:   Stefan Haller <stefan@haller-berlin.de>
To:     me@yadavpratyush.com
Cc:     git@vger.kernel.org
Subject: [PATCH 0/1] git-gui: fix colored label backgrounds on Mac
Date:   Sun, 22 Nov 2020 20:45:36 +0100
Message-Id: <20201122194537.41870-1-stefan@haller-berlin.de>
X-Mailer: git-send-email 2.29.0.18.gf8c967e53c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's another attempt at fixing the colored label backgrounds when using themed
widgets on Mac. I sent a different approach a few weeks ago, which was to make
the gui.usettk option default to off on Mac. This was clearly not a good
solution. This time I'm presenting an approach that is a little less drastic;
it's still not ideal, but I feel it's an acceptable compromise.

Another problem that is improved by this is dark mode on Mac: in that mode the
label text was almost invisible, because it was black on a very dark grey
background.

Stefan Haller (1):
  git-gui: fix colored label backgrounds when using themed widgets

 lib/themed.tcl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--
2.29.0.18.gf8c967e53c

