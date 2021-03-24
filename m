Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34352C433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 05:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03FD9619E3
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 05:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbhCXFhi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 01:37:38 -0400
Received: from smtp512.hk.chengmail.me ([113.10.190.174]:52825 "EHLO
        smtp512.hk.chengmail.me" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbhCXFhG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 01:37:06 -0400
X-CHENGMAILHOST: 113.10.190.174
X-CHENGMAIL-INSTANCEID: 4d90.605acffc.4ab62.0
From:   lilinchao@oschina.cn
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, lilinchao <lilinchao@oschina.cn>
Subject: [PATCH 1/2] transport.c: modify comment in transport_get().
Date:   Wed, 24 Mar 2021 13:36:47 +0800
X-source-message-id: <20210324053648.25584-1-lilinchao@oschina.cn>
X-Mailer: git-send-email 2.30.0.1006.g4a81e96670
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <f64df5f88c6211eb9c9a0024e87935e7@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: lilinchao <lilinchao@oschina.cn>

Signed-off-by: lilinchao <lilinchao@oschina.cn>
---
 transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/transport.c b/transport.c
index 1c4ab676d1..71b3d44cf3 100644
--- a/transport.c
+++ b/transport.c
@@ -1078,7 +1078,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		data->conn = NULL;
 		data->got_remote_heads = 0;
 	} else {
-		/* Unknown protocol in URL. Pass to external handler. */
+		/* Http/https and other unknown protocol in URL. Pass to external handler. */
 		int len = external_specification_len(url);
 		char *handler = xmemdupz(url, len);
 		transport_helper_init(ret, handler);
-- 
2.30.0.1006.g4a81e96670

