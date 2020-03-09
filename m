Return-Path: <SRS0=lsTH=42=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5ECC10F29
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 12:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0219208C3
	for <git@archiver.kernel.org>; Mon,  9 Mar 2020 12:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgCIMKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Mar 2020 08:10:15 -0400
Received: from mta-07-4.privateemail.com ([68.65.122.27]:21822 "EHLO
        MTA-07-4.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgCIMKP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Mar 2020 08:10:15 -0400
Received: from MTA-07.privateemail.com (localhost [127.0.0.1])
        by MTA-07.privateemail.com (Postfix) with ESMTP id 0F0EE60050;
        Mon,  9 Mar 2020 08:10:13 -0400 (EDT)
Received: from localhost.localdomain (unknown [10.20.151.246])
        by MTA-07.privateemail.com (Postfix) with ESMTPA id E99E360054;
        Mon,  9 Mar 2020 12:10:10 +0000 (UTC)
From:   "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "i.Dark_Templar" <darktemplar@dark-templar-archives.net>
Subject: [RFC PATCH v2 2/2] Enable multiline merge commit message by default
Date:   Mon,  9 Mar 2020 15:07:22 +0300
Message-Id: <20200309120722.4987-3-darktemplar@dark-templar-archives.net>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309120722.4987-1-darktemplar@dark-templar-archives.net>
References: <2f0417b3-9e9e-f0db-ab11-92dd7cd2b29a@dark-templar-archives.net>
 <20200309120722.4987-1-darktemplar@dark-templar-archives.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: i.Dark_Templar <darktemplar@dark-templar-archives.net>
---
 builtin/fmt-merge-msg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 191824c962..ab445110b0 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -20,7 +20,7 @@ static const char * const fmt_merge_msg_usage[] = {
 };
 
 static int use_branch_desc;
-static int use_multiline = -1;
+static int use_multiline = 2;
 
 int fmt_merge_msg_config(const char *key, const char *value, void *cb)
 {
-- 
2.24.1

