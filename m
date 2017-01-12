Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CF351FEB3
	for <e@80x24.org>; Fri, 13 Jan 2017 00:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750908AbdAMAAf (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 19:00:35 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33570 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750889AbdAMAAe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 19:00:34 -0500
Received: by mail-pf0-f180.google.com with SMTP id y143so20773335pfb.0
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 16:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/xWmPM0uefqQo6lIpLsQaU4X4eoFlkXU+KzTjeVZueM=;
        b=jXLr3NZAnB5iyT/EiGDZrtiRXs3vhJG6i4HHPhmt+gJtTp7ZjOTexsFrY3pSiOoh5K
         jaNTsTO8ei+pFzmYUodmPqfxwk0xe7XKdl+Byh3Au04qlm7TtCpzsQpDSiCgk6C4cH76
         M5lbIGcSFFZbGlgjZ6mivytdYZP6BS6+byEyyxjVa3dkKRSNqbvA6FFk1mEnrZb0/E9P
         JIiU3OddyALjuwxwCy1VbIdfB9pGegx6gYsF2I9DxsR8zymgVM0e3W+g5RLGXTSJirW4
         QzJihTizgv0EVeRaw1PmgxZofKNjMb7pIEB2CzHQtobCJqvZe3Z56dgQuxe3hHJ7zECC
         vkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/xWmPM0uefqQo6lIpLsQaU4X4eoFlkXU+KzTjeVZueM=;
        b=NETN2X0YYy0I8q+qXPvgH/nIqUhkmTWYHPDPHiFt9QgQzqrQsv1vXOQLxcptVEdLzu
         T9NHKEKD2cql+zWAdm6l3wsIY1rR8BdURnqJS9+KQTlfwzfJOxK41MlIWEqFsBRIAgHd
         kquoBr1XMd3LPlzoe2KxOGkR/Sj9cyj+1AI5r+s+dZmi+p9Onx3Egg8sIFByA81OPUeM
         B0M/DLrw4aYm5qfnd9lMIUnUPYGhCN2EdlUv/0PxJObHZVeqoNjeGVEId/wZsluEOUy+
         5OC3mXm0trrE+rkaM5cX9prBPMFSd4ruFDi/zfxprtfeG4Utf8JiQFRV45SNrEV04s9F
         MgrA==
X-Gm-Message-State: AIkVDXKJqzRvHf+da/hQDtIAxgEzUIX63Vx7fuoL1NF1MDUKBkIWxsw58nUwbvadVYkhSlCK
X-Received: by 10.99.61.13 with SMTP id k13mr20623080pga.154.1484265260724;
        Thu, 12 Jan 2017 15:54:20 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id e6sm24312192pgf.4.2017.01.12.15.54.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jan 2017 15:54:19 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>, gitster@pobox.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH 12/27] Documentation: fix a typo
Date:   Thu, 12 Jan 2017 15:53:39 -0800
Message-Id: <20170112235354.153403-13-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.390.gc69c2f50cf-goog
In-Reply-To: <20170112235354.153403-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Documentation/gitattributes.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 3173dee7e..a53d093ca 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -88,7 +88,7 @@ is either not set or empty, $HOME/.config/git/attributes is used instead.
 Attributes for all users on a system should be placed in the
 `$(prefix)/etc/gitattributes` file.
 
-Sometimes you would need to override an setting of an attribute
+Sometimes you would need to override a setting of an attribute
 for a path to `Unspecified` state.  This can be done by listing
 the name of the attribute prefixed with an exclamation point `!`.
 
-- 
2.11.0.390.gc69c2f50cf-goog

