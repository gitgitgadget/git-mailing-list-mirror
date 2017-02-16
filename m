Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D0772013C
	for <e@80x24.org>; Thu, 16 Feb 2017 05:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750794AbdBPFFu (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 00:05:50 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33002 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750728AbdBPFFt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 00:05:49 -0500
Received: by mail-pg0-f68.google.com with SMTP id 5so882334pgj.0
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 21:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=d+Rh1sKAnEzH+cAK7S7fUso0kwpwSW2u/ticMgx+4E0=;
        b=Tdy6eMXm5bdF0tvnSXyqXMby0Jo35quFF4nVf6MjfqqnWsZkbS44u93NqgV1TllhBf
         kFffa4zjLoUSKSBGR+KpuFm4q0d2kGM6zFbQ+ubgA0cBPgUJI+3weSWw9ssb+DzrN1zQ
         PeH1tOPHmmMByE7B5zyOGtGs2rn+kBPKW3eL4qb3G5bdYQkxGf7R0Egi62tRZOm3Yvh6
         WloCULZX4mfuSLY68wUAkNSYfpm0Iih06dfvUlHzMpuj1Z1EolCfDL/2dc9FQ15T4X4g
         DffwXKRbxOXE2m0KTLd816Q/Lw54y+1fq6dJXf0oJL6whrgtby2kbG0UE6gd91l3lJ7k
         miew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d+Rh1sKAnEzH+cAK7S7fUso0kwpwSW2u/ticMgx+4E0=;
        b=ZVQZuqjeazVCqXvfHJgZGeMD84GBIL7mRWs6jThVJMZmlpmsC8VN+aqyMB/k72htuI
         tz5ZsNArRX3BV4PhjQn1PIvz4QDWUeiUuQptwPScguFcXTz/ZniaA0N5autTsh8Vpwyw
         uCCxeSzXE7Qrkb5Cbof+VP/62xabzfLoFJem4Wy3SKsMgxZ18y3uykqQNARJyNd6kJUu
         6DXluSg3Suabu4Blo40czDUHmJFHsL73e98vGCEpqYumOD4uNaaLG3HJYf70uFHRGpKb
         oIi7j8OPHeIrPoelzwlSQsPa3qwoRwcVxHjHPic0gEblx5D3orWNYhHJD6dZeWKdmekm
         NfTQ==
X-Gm-Message-State: AMke39nuJPYcdxO+nllUYAIwjzrtMIAtralun6u4Kw7xLFLUOq5n9z7WbpeHf34CZmoQEQ==
X-Received: by 10.98.134.2 with SMTP id x2mr477334pfd.158.1487221548140;
        Wed, 15 Feb 2017 21:05:48 -0800 (PST)
Received: from localhost.localdomain (x084097.dynamic.ppp.asahi-net.or.jp. [122.249.84.97])
        by smtp.gmail.com with ESMTPSA id k76sm10398835pfg.42.2017.02.15.21.05.46
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 21:05:47 -0800 (PST)
From:   David Pursehouse <david.pursehouse@gmail.com>
To:     git@vger.kernel.org
Cc:     David Pursehouse <dpursehouse@collab.net>
Subject: [PATCH 1/1] config.txt: Fix formatting of submodule.alternateErrorStrategy section
Date:   Thu, 16 Feb 2017 14:05:35 +0900
Message-Id: <20170216050535.64593-2-david.pursehouse@gmail.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170216050535.64593-1-david.pursehouse@gmail.com>
References: <20170216050535.64593-1-david.pursehouse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: David Pursehouse <dpursehouse@collab.net>

Add missing `::` after the title.

Signed-off-by: David Pursehouse <dpursehouse@collab.net>
---
 Documentation/config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1fee83ca4..6c378c6fc 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2894,7 +2894,7 @@ submodule.alternateLocation::
 	value is set to `superproject` the submodule to be cloned computes
 	its alternates location relative to the superprojects alternate.
 
-submodule.alternateErrorStrategy
+submodule.alternateErrorStrategy::
 	Specifies how to treat errors with the alternates for a submodule
 	as computed via `submodule.alternateLocation`. Possible values are
 	`ignore`, `info`, `die`. Default is `die`.
-- 
2.11.1

