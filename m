Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C73B1FE4E
	for <e@80x24.org>; Mon, 21 Nov 2016 20:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754156AbcKUUrc (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Nov 2016 15:47:32 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36149 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753566AbcKUUrb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2016 15:47:31 -0500
Received: by mail-pg0-f49.google.com with SMTP id f188so133582260pgc.3
        for <git@vger.kernel.org>; Mon, 21 Nov 2016 12:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kdw6mPWcKu0c8zAYAA8w1T+DtP0S0204qMeOnnXQOmI=;
        b=FJ8mfg42K+HKzG25NyCkgtNqZKPj6OoyAssx3OIYotvqcUam/leJZFMs1tdRNLNiv2
         bRoX0uC5AkjQhMCdHu4opMN0rLzedcL1fNz0EH2AH1KD/nGGHu1UtYvHomg1pQfI8dm4
         7GlZXTuJEJEhN7Bja+tNzvCiQTgvBuT675opH01mgwynfh/zWDKImPgVbWRNlhUh5UKw
         tVHjgF2fcwMZuTbHB9tiLDCqpMYoyY7VP8qiOobafqqFPby0vkZifuF4aMdlviKQw3WP
         9UaasSt5EChUd+kDTqk8OQePn3Nu4d4oqjFkMO3p8dpDbzznFO9BvU54Gt2MsWzu86B8
         Z31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kdw6mPWcKu0c8zAYAA8w1T+DtP0S0204qMeOnnXQOmI=;
        b=P4x0vfSakDCAEMWzHy1cno6x9olPvv+VVLfCuem4QL0ObIrsDos9+wsKgrEIfBgnk7
         XwDX/UCpHLjYC6dEgeoMzjzsFvoEjoC2OcAIwP4m6MqVuqA4G5pCxiLpUiYQ28CDlmkv
         QCUWcw18p8qCWXKSDbZyIgAGi4N2WVY9KxjVopPegvV1zsmphJjg637jo/Q6mFioPskG
         Bg1WIycXxNhzz4MObXZGc0O5L+xaLqfmg6EvMKSLwaYpetgFZUBqsAJnYjGjG2oC60OA
         qRw+jxEMjUg6FoZ+ZdWScSC0QJUvyuxVnLrLpIARjDIP/ytw967pvKRhVOXDk+4/NsnO
         /IeA==
X-Gm-Message-State: AKaTC01XqZg/9ojRcAETauWHeK6kTT8VJDl3jUYzc3qXMfhDlITIsHIbKtjjwlvP8AXwK465
X-Received: by 10.98.85.198 with SMTP id j189mr5340581pfb.182.1479761250216;
        Mon, 21 Nov 2016 12:47:30 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.12])
        by smtp.gmail.com with ESMTPSA id v77sm39500750pfa.85.2016.11.21.12.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Nov 2016 12:47:29 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        jacob.e.keller@intel.com
Subject: [PATCH] doc: mention user-configured trailers
Date:   Mon, 21 Nov 2016 12:47:21 -0800
Message-Id: <1479761241-26284-1-git-send-email-jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <CA+P7+xrQEBYQQhqJQQCpLrs+4WOJOvH1X27w5Ou=2VPT=FegGQ@mail.gmail.com>
References: <CA+P7+xrQEBYQQhqJQQCpLrs+4WOJOvH1X27w5Ou=2VPT=FegGQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 1462450 ("trailer: allow non-trailers in trailer block",
2016-10-21), functionality was added (and tested [1]) to allow
non-trailer lines in trailer blocks, as long as those blocks contain at
least one Git-generated or user-configured trailer, and consists of at
least 25% trailers. The documentation was updated to mention this new
functionality, but did not mention "user-configured trailer".

Further update the documentation to also mention "user-configured
trailer".

[1] "with non-trailer lines mixed with a configured trailer" in
t/t7513-interpret-trailers.sh

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---

Yes, mentioning a trailer in a Git config will cause interpret-trailers
to treat it similarly to a Git-generated trailer (in that its presence
causes a block partially consisting of trailers to be considered a
trailer block). See the commit message above for a test case that
verifies that.

I took a look at the documentation, and it wasn't completely documented,
so here is a patch to correct that.

 Documentation/git-interpret-trailers.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index e99bda6..09074c7 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -49,7 +49,8 @@ will be added before the new trailer.
 
 Existing trailers are extracted from the input message by looking for
 a group of one or more lines that (i) are all trailers, or (ii) contains at
-least one Git-generated trailer and consists of at least 25% trailers.
+least one Git-generated or user-configured trailer and consists of at
+least 25% trailers.
 The group must be preceded by one or more empty (or whitespace-only) lines.
 The group must either be at the end of the message or be the last
 non-whitespace lines before a line that starts with '---'. Such three
-- 
2.8.0.rc3.226.g39d4020

