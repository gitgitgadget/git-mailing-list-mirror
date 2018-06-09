Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CB3B1F403
	for <e@80x24.org>; Sat,  9 Jun 2018 15:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753231AbeFIPTw (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 11:19:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62051 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753062AbeFIPTv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 11:19:51 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC7C9DD1D5;
        Sat,  9 Jun 2018 11:19:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=GNu+4B5lB9kAKuVy8dI+L4CO90M
        =; b=hDq48ipAQ3Q1uj2WsxSkxP5q6ftHEUZUchUWyX4ZTfN/24NcN2W6lrCZq30
        aD560fpbQJTlE/XWJgROGqIMOu35HkKZ2UOXT8l97wdPoqDZSu/zNGYxjJkoxOCB
        NwPl5IIn2qL87GmnyMeEuqfhRTmW/vZVi78/zlVnxnlucgXk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C25DCDD1D4;
        Sat,  9 Jun 2018 11:19:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:date:message-id; s=mesmtp;
 bh=IOvJ3GUbXRGrA+8S9ugHb05vMs0vwXgHeFxM98afuT8=;
 b=x7qSTqnC5mW/QWIzC+I00TIGE9Au7xaOeGScosb0OpCk4Aofaiv6r90UtriqfckLQ1d0Gj2HR+FiE6Lk2AlDDKsO2IhZt2SsQvkVPJYFyMIMRmOp/69icbDVTH2h0e3lNEAV3EZXYYGpz8NHWkfBP1131Zis1zonWo/tSciTyZg=
Received: from kmlap.local (unknown [76.118.43.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 25265DD1D3;
        Sat,  9 Jun 2018 11:19:48 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     git@vger.kernel.org
Cc:     Kyle Meyer <kyle@kyleam.com>
Subject: [PATCH] gitworkflows: fix grammar in 'Merge upwards' rule
Date:   Sat,  9 Jun 2018 11:19:43 -0400
Message-Id: <20180609151943.7387-1-kyle@kyleam.com>
X-Mailer: git-send-email 2.17.1
X-Pobox-Relay-ID: 8C264906-6BF8-11E8-A57B-67830C78B957-24757444!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kyle Meyer <kyle@kyleam.com>
---
 Documentation/gitworkflows.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 926e044d0..ca11c7bda 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -107,7 +107,7 @@ the unstable branch into the stable one.  Hence the following:
 .Merge upwards
 [caption="Rule: "]
 =====================================
-Always commit your fixes to the oldest supported branch that require
+Always commit your fixes to the oldest supported branch that requires
 them.  Then (periodically) merge the integration branches upwards into each
 other.
 =====================================
-- 
2.11.0

