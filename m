Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 524321F424
	for <e@80x24.org>; Tue, 19 Dec 2017 00:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966057AbdLSA3n (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 19:29:43 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44488 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936815AbdLSA3j (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 19:29:39 -0500
Received: by mail-pg0-f68.google.com with SMTP id j9so9847011pgc.11
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 16:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=AFFDHLBWm6Y4AhYJf+4lKUWraKBwVi8KX+4ppugKAMI=;
        b=usuX/aRfOTQcBNKrzShoLd9S4HyoEbWpuLmhDVKTH1WvgxC+UBOAI9yzpmlhuvbI82
         YQ7UGJGL3dCKQh5wgXiL0y8jqVOkiXq88qasFINK6Lgt7iOEt1F5JRhFXEcr13UhiRee
         FxDzQmw+gB02hoGNYOXIaGnqAW2Qrj2kl2j74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=AFFDHLBWm6Y4AhYJf+4lKUWraKBwVi8KX+4ppugKAMI=;
        b=Bpo8bKY/rNy8Mj7mrOQ5JN8xNEydsI9ylCD9WqUdhMm0Y4qpBSpUbByIpl/O42wMcD
         2T7hy/W3s6Uqeg5CJAnu1KUqr3ZiXutj232MFQeNa8P7kmHSmwXfeq/2BCyGgX31Bgfn
         DtE0EEb1Z7ix6m26ZcuS1RXDwQQPckXmxU8HPSTqyTuevIwcyRiWe3+qn/zRcCmgoJ/9
         Tg9D+802I2b0jWLddjgQ165SPdv3tEcPU8l0oZIpAIr3hguarc+vIoQf6EPXTQHVawwa
         yaelkKvBFUvVmEXySRvzSYIADxfFG2iRo3Rxyy35Fkd8BtESYFbSdwlCWuMBGpl41bDi
         5T9g==
X-Gm-Message-State: AKGB3mK6VaasjdFwquoCTTGeooFcj3qwU0Ie0OrLGFosxsFc0v6EInWd
        62SqWG8USPGIwAihVyN7o26kbwJa47k=
X-Google-Smtp-Source: ACJfBotW3AvY2V9KSB75tzllVidyhRbxusKt+mjXd73AuEm4ix5MRRiCocInJcL2irFXLt9dz934Ew==
X-Received: by 10.101.101.154 with SMTP id u26mr1298430pgv.416.1513643378324;
        Mon, 18 Dec 2017 16:29:38 -0800 (PST)
Received: from alexmv-linux.corp.dropbox.com (v160-sfo11-br01.corp.dropbox.com. [205.189.0.163])
        by smtp.gmail.com with ESMTPSA id b10sm26056581pfj.20.2017.12.18.16.29.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Dec 2017 16:29:37 -0800 (PST)
From:   Alex Vandiver <alexmv@dropbox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ben Peart <peartben@gmail.com>
Subject: [PATCH 4/6] fsmonitor: Add a trailing newline to test-dump-fsmonitor
Date:   Mon, 18 Dec 2017 16:28:56 -0800
Message-Id: <dab89f071d22a21b85dff5d31e9e9a8ceb6458e3.1513642743.git.alexmv@dropbox.com>
X-Mailer: git-send-email 2.15.1.626.gc4617b774
In-Reply-To: <20171219002858.22214-1-alexmv@dropbox.com>
References: <20171219002858.22214-1-alexmv@dropbox.com>
In-Reply-To: <95804e03dec9bd9d1a28ab92ed4356c37950468f.1513642743.git.alexmv@dropbox.com>
References: <95804e03dec9bd9d1a28ab92ed4356c37950468f.1513642743.git.alexmv@dropbox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it more readable when used for debugging from the
commandline.

Signed-off-by: Alex Vandiver <alexmv@dropbox.com>
---
 t/helper/test-dump-fsmonitor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
index 53b19b39b..4e56929f7 100644
--- a/t/helper/test-dump-fsmonitor.c
+++ b/t/helper/test-dump-fsmonitor.c
@@ -19,5 +19,6 @@ int cmd_main(int ac, const char **av)
 	for (i = 0; i < istate->cache_nr; i++)
 		printf((istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) ? "+" : "-");
 
+	printf("\n");
 	return 0;
 }
-- 
2.15.1.626.gc4617b774

