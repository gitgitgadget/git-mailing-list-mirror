Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBBCC4320A
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC3461103
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 17:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhHBRKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 13:10:07 -0400
Received: from bee.birch.relay.mailchannels.net ([23.83.209.14]:63141 "EHLO
        bee.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229737AbhHBRKH (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 2 Aug 2021 13:10:07 -0400
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5451E362B4E;
        Mon,  2 Aug 2021 17:00:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a13.g.dreamhost.com (100-96-17-210.trex-nlb.outbound.svc.cluster.local [100.96.17.210])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 07797362816;
        Mon,  2 Aug 2021 17:00:18 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from pdx1-sub0-mail-a13.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.17.210 (trex/6.3.3);
        Mon, 02 Aug 2021 17:00:19 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|novalis@novalis.org
X-MailChannels-Auth-Id: dreamhost
X-Decisive-Soft: 6f454b6348c0a8eb_1627923618951_1737720736
X-MC-Loop-Signature: 1627923618951:2018524319
X-MC-Ingress-Time: 1627923618951
Received: from pdx1-sub0-mail-a13.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a13.g.dreamhost.com (Postfix) with ESMTP id 1DC71806B5;
        Mon,  2 Aug 2021 10:00:14 -0700 (PDT)
Received: from corey.lan (unknown [98.113.183.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by pdx1-sub0-mail-a13.g.dreamhost.com (Postfix) with ESMTPSA id 8347F806AA;
        Mon,  2 Aug 2021 10:00:12 -0700 (PDT)
X-DH-BACKEND: pdx1-sub0-mail-a13
From:   David Turner <dturner@twosigma.com>
To:     git@vger.kernel.org, novalis@novalis.org
Cc:     David Turner <dturner@twosigma.com>
Subject: [PATCH v2 1/3] Remove unused var
Date:   Mon,  2 Aug 2021 13:00:02 -0400
Message-Id: <20210802170004.4103535-1-dturner@twosigma.com>
X-Mailer: git-send-email 2.11.GIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: David Turner <dturner@twosigma.com>
---
 t/t4060-diff-submodule-option-diff-format.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
index dc7b242697..69b9946931 100755
--- a/t/t4060-diff-submodule-option-diff-format.sh
+++ b/t/t4060-diff-submodule-option-diff-format.sh
@@ -361,7 +361,6 @@ test_expect_success 'typechanged submodule(submodule->blob)' '
 rm -f sm1 &&
 test_create_repo sm1 &&
 head6=$(add_file sm1 foo6 foo7)
-fullhead6=$(cd sm1; git rev-parse --verify HEAD)
 test_expect_success 'nonexistent commit' '
 	git diff-index -p --submodule=diff HEAD >actual &&
 	cat >expected <<-EOF &&
-- 
2.11.GIT

