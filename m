Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55D7820C16
	for <e@80x24.org>; Tue,  5 Dec 2017 17:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752681AbdLEQ74 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 11:59:56 -0500
Received: from siwi.pair.com ([209.68.5.199]:45240 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752668AbdLEQ7S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 11:59:18 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 18C02844E8;
        Tue,  5 Dec 2017 11:59:18 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8202F844DE;
        Tue,  5 Dec 2017 11:59:17 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        christian.couder@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6 10/12] fixup: sha1_file: add TODO
Date:   Tue,  5 Dec 2017 16:58:52 +0000
Message-Id: <20171205165854.64979-11-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171205165854.64979-1-git@jeffhostetler.com>
References: <20171205165854.64979-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 sha1_file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sha1_file.c b/sha1_file.c
index ce67f27..dd956e2 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1196,6 +1196,10 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 		/* Check if it is a missing object */
 		if (fetch_if_missing && repository_format_partial_clone &&
 		    !already_retried) {
+			/*
+			 * TODO Investigate haveing fetch_object() return
+			 * TODO error/success and stopping the music here.
+			 */
 			fetch_object(repository_format_partial_clone, real);
 			already_retried = 1;
 			continue;
-- 
2.9.3

