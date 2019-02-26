Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6C7920248
	for <e@80x24.org>; Tue, 26 Feb 2019 11:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfBZLFx (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 06:05:53 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42234 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfBZLFx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 06:05:53 -0500
Received: from localhost (2a02-ab04-03b9-5e00-0000-0000-0000-0003.dynamic.v6.chello.sk [IPv6:2a02:ab04:3b9:5e00::3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: andrewsh)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C7AE227FBC0;
        Tue, 26 Feb 2019 11:05:51 +0000 (GMT)
From:   Andrej Shadura <andrew.shadura@collabora.co.uk>
To:     git@vger.kernel.org
Cc:     Paul Mackerras <paulus@ozlabs.org>
Subject: [PATCH 2/2] gitk: disable autoselect by default
Date:   Tue, 26 Feb 2019 12:05:35 +0100
Message-Id: <20190226110535.29172-2-andrew.shadura@collabora.co.uk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190226110535.29172-1-andrew.shadura@collabora.co.uk>
References: <20190226110535.29172-1-andrew.shadura@collabora.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Auto-selection of the commit hash overwrites whatever content was in the
selection clipboard, and also pollutes the clipboard history if the user
is using a clipboard manager. Most users probably want this off by
default.

Signed-off-by: Andrej Shadura <andrew.shadura@collabora.co.uk>
---
 gitk-git/gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 5766754ab6..583e505709 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -12291,7 +12291,7 @@ set maxlinelen 200
 set showlocalchanges 1
 set limitdiffs 1
 set datetimeformat "%Y-%m-%d %H:%M:%S"
-set autoselect 1
+set autoselect 0
 set autosellen 40
 set perfile_attrs 0
 set want_ttk 1
-- 
2.19.1

