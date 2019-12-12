Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A25C43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 20:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41615214AF
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 20:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbfLLUr3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 15:47:29 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:58716 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730784AbfLLUr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 15:47:29 -0500
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:d1:f360:33e:2802:50eb:d77d])
        by smtp2-g21.free.fr (Postfix) with ESMTP id DD79F2003D6;
        Thu, 12 Dec 2019 21:47:25 +0100 (CET)
From:   =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Subject: [PATCH 2/3] doc: remove non pure ASCII characters
Date:   Thu, 12 Dec 2019 21:46:54 +0100
Message-Id: <20191212204655.10425-2-jn.avila@free.fr>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191212204655.10425-1-jn.avila@free.fr>
References: <20191212204655.10425-1-jn.avila@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Non ASCII characters may be handled by publishing chains, but right
now, nothing indicates the encoding of files. Moreover, non ASCII
source strings upset the localization toolchain.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-clone.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 34011c2940..2e8babe671 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -262,9 +262,9 @@ or `--mirror` is given)
 	All submodules which are cloned will be shallow with a depth of 1.
 
 --[no-]remote-submodules::
-	All submodules which are cloned will use the status of the submodule’s
+	All submodules which are cloned will use the status of the submodule's
 	remote-tracking branch to update the submodule, rather than the
-	superproject’s recorded SHA-1. Equivalent to passing `--remote` to
+	superproject's recorded SHA-1. Equivalent to passing `--remote` to
 	`git submodule update`.
 
 --separate-git-dir=<git dir>::
-- 
2.24.0

