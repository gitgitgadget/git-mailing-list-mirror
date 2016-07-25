Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4CAC203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 22:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756062AbcGYWAZ (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 18:00:25 -0400
Received: from mta01.prd.rdg.aluminati.org ([94.76.243.214]:55306 "EHLO
	mta01.prd.rdg.aluminati.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756053AbcGYWAW (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jul 2016 18:00:22 -0400
Received: from mta01.prd.rdg.aluminati.org (localhost [127.0.0.1])
	by mta.aluminati.local (Postfix) with ESMTP id 6EB31C4738;
	Mon, 25 Jul 2016 23:00:20 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTP id 6940820B69;
	Mon, 25 Jul 2016 23:00:20 +0100 (BST)
X-Quarantine-ID: <wXvfIHr__zE4>
X-Virus-Scanned: Debian amavisd-new at mta01.prd.rdg.aluminati.org
X-Amavis-Alert:	BAD HEADER SECTION, Duplicate header field: "References"
Received: from mta.aluminati.local ([127.0.0.1])
	by localhost (mta01.prd.rdg.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wXvfIHr__zE4; Mon, 25 Jul 2016 23:00:19 +0100 (BST)
Received: from river.lan (unknown [10.2.0.10])
	by mta01.prd.rdg.aluminati.org (Postfix) with ESMTPSA id 0808362141;
	Mon, 25 Jul 2016 23:00:14 +0100 (BST)
From:	John Keeping <john@keeping.me.uk>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org, John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 1/3] Documentation/git-push: fix placeholder formatting
Date:	Mon, 25 Jul 2016 22:59:55 +0100
Message-Id: <bb37a70b0a47a72d38e29d34b3dd66ef9f018655.1469483499.git.john@keeping.me.uk>
X-Mailer: git-send-email 2.9.2.639.g855ae9f
In-Reply-To: <cover.1469483499.git.john@keeping.me.uk>
References: <cover.1469483499.git.john@keeping.me.uk>
In-Reply-To: <cover.1469483499.git.john@keeping.me.uk>
References: <xmqq4m7d7hlq.fsf@gitster.mtv.corp.google.com> <cover.1469483499.git.john@keeping.me.uk>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Format the placeholder as monospace to match other occurrences in this
file and obey CodingGuidelines.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
New in v2.

 Documentation/git-push.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 93c3527..bf7c9a2 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -198,7 +198,7 @@ branch we have for it.
 +
 `--force-with-lease=<refname>:<expect>` will protect the named ref (alone),
 if it is going to be updated, by requiring its current value to be
-the same as the specified value <expect> (which is allowed to be
+the same as the specified value `<expect>` (which is allowed to be
 different from the remote-tracking branch we have for the refname,
 or we do not even have to have such a remote-tracking branch when
 this form is used).
-- 
2.9.2.639.g855ae9f

