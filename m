Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A9CE20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 20:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbdAWUf5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 15:35:57 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35960 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751602AbdAWUfz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 15:35:55 -0500
Received: by mail-pf0-f178.google.com with SMTP id 189so43793331pfu.3
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 12:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EJaybqyFs34m5cZ7YPejZb4V/WZx1/DrPEs06yrxNqs=;
        b=Hy6nLBhhGEqOTyFWcwTFY+Y9Nb6lWKaLFTntStB7UwRtOr0tU6TUNM/JCXgLTCdPPd
         fQhreaOEktxgeCCK4EFfQYBdXZMbXssphU2D/QRpqWndgYqW5hq5Wt0rM+O22UBY017d
         SwfmUUwnpQWhJPCIs8C4J2NDKwxb7SjhGrjpv4He5u0A4Ac9W3k1gaUdi+l8jBrdPVER
         bQiKMRGeLEMKE+1Fgs7R5WWeR4gKjib0Uy98qd22Kkql/UrCXbSc1KvAfy9UL71A7YQF
         ZOKpezzdH6X7Jb0cVEIa95ivuwgIPtGX2umsbmH5rEr0swKbIUsqxlKprJI+Eb/+aW3K
         hACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EJaybqyFs34m5cZ7YPejZb4V/WZx1/DrPEs06yrxNqs=;
        b=H6qOQnNDnPdYxsRQFCSeFzbk7HheNi0Z/Exjouou1JaVRwbkm4F28209Zcnp8I9Dgi
         JWJhet5nTBOK+9cT0LbMiivkUl7xm6C4oy4WobalrMBaYaEvcEfg93qlLo8K0XFPxjjk
         fCs5WGV6Oi+Qwj+LSHAPlwK6HTF3Pg/oo8x3hPGnyhnR/QSrH7lEm7l7fZFxvtOq9x07
         wtSCnK0UlwDBPU3oYeONe9Aj/X+nASMuohFU9g5s5ABvmjiE7gxqJKNzdL3le6DzXDLM
         FssWeJ37qWVmtnF5it1qTLsqjaEjz1+N5CaYT2JTW0IO5k7XxsF3CqY/9sA55SqKNf2T
         d/Rw==
X-Gm-Message-State: AIkVDXK5ypTwwH1JMiGLP+I5B0s/NA0M2YXoWkYluWBuAQBc1mIqSnZ8dk3pvtieyrceSVGr
X-Received: by 10.98.76.132 with SMTP id e4mr34677406pfj.24.1485203755101;
        Mon, 23 Jan 2017 12:35:55 -0800 (PST)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id z29sm39280832pgc.7.2017.01.23.12.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jan 2017 12:35:53 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>, gitster@pobox.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 12/27] Documentation: fix a typo
Date:   Mon, 23 Jan 2017 12:35:10 -0800
Message-Id: <20170123203525.185058-13-bmwill@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <20170123203525.185058-1-bmwill@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
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
2.11.0.483.g087da7b7c-goog

