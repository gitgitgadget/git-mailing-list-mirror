Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69ADE1F732
	for <e@80x24.org>; Sat,  3 Aug 2019 23:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbfHCXwP (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 19:52:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35587 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729303AbfHCXwP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 19:52:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so69725858wmg.0
        for <git@vger.kernel.org>; Sat, 03 Aug 2019 16:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Qgyora3fN7K3/Lih3XGWnPzhHGMPxHorqSm9m/t2/ek=;
        b=U6sACJVZ6ALj9ShIMXNkxpM4WIyKBWoy0DRYognixxdc0v+N/yw3MBpMkPQiaP5kco
         NU8Pp+43EpdDUPqcQqWMT3+x/D2EKw3dMqel9N5mHzviV6S5IB+XiCD2Nsu9ALlf7mgQ
         RX/0EcPxCSKb3oveGhzmtpKld9g4TzELgPr3PM9B8+fouYGQvW+P2mk7wBC6dzDySwnD
         6SN8o1zW8gkEfAHS7ieHeJUjSQ0HDXJ/QlQ7rzFMxwANN9Js25n6ohvDRTJmNLgygFOS
         AMy85ftjax4KqRKy3ZssB46KYnvcyuO+fZxTxXjk8eBYB/Saub6n+nJLLOAdUcgt6rh4
         wg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Qgyora3fN7K3/Lih3XGWnPzhHGMPxHorqSm9m/t2/ek=;
        b=feXu/XTVF0Rn5pZV3og0eJguvWIVYIayEXDQa9u5X5kR1t+9ojmTC1KIi1DIj5pN/x
         Cbdo/L7XonFF0rGn/JE/Bwk0zL8E04/F9ZZZX6r6o/HhgyGRrE4F1SGmxnqRinuNsD2a
         Bgk8Ld4brWAQUoLeBBzcA3NnGjwUg5UBE/WSveN1iSEirk50PgiUdNa2dztNzI1KKrqq
         Sx9uXyV3YkF3r5duTYbtfVCh36qGJlrCKCQVOrB0ufaG4gTIafiCzx4b8Yi/QExF38XW
         sW5L7PaJKp+fFeLLWO02F25sOy405ogiwqrZmkY00l5W59s2Z5P0jb+vZYH4Mpzv25wc
         HFTw==
X-Gm-Message-State: APjAAAUCPf5iysX2t3St2Ic81kqJZ5hIcRCNXB6gRTOyiwM82CqhQACY
        6hcdJokutElQxy2R/KbwSNsaQC1B
X-Google-Smtp-Source: APXvYqxNo3CeF0LsYQ5z2fgz9IBZTF2MKu+Nv8icZlUlFc1Ce9mKC+hQf2PMmVo8SCQZAQZoFstBIg==
X-Received: by 2002:a1c:a997:: with SMTP id s145mr10252686wme.106.1564876333138;
        Sat, 03 Aug 2019 16:52:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm64546148wmc.36.2019.08.03.16.52.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 16:52:12 -0700 (PDT)
Date:   Sat, 03 Aug 2019 16:52:12 -0700 (PDT)
X-Google-Original-Date: Sat, 03 Aug 2019 23:52:06 GMT
Message-Id: <d00bbdce0d5104f1793b7fa0dce14f678e9fb331.1564876327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.305.git.gitgitgadget@gmail.com>
References: <pull.305.git.gitgitgadget@gmail.com>
From:   "lufia via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 5/6] Add plan9/wrap.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, lufia <lufia@lufia.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: lufia <lufia@lufia.org>

Plan 9 has bind(1) instead of ln(1), but bind isn't persisted to the disk.
However it isn't efficient to copy git to git- subcommands such as git-add.
Therefore Plan 9 needs wrap.c to switch behavior by executable name.

Signed-off-by: lufia <lufia@lufia.org>
---
 plan9/wrap.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 plan9/wrap.c

diff --git a/plan9/wrap.c b/plan9/wrap.c
new file mode 100644
index 0000000000..589d13bf5d
--- /dev/null
+++ b/plan9/wrap.c
@@ -0,0 +1,16 @@
+#include <stdio.h>
+#include <errno.h>
+#include <string.h>
+#define _POSIX_SOURCE
+#include <unistd.h>
+
+int
+main(int argc, char *argv[])
+{
+	USED(argc);
+	if(execv("/bin/git", argv) < 0){
+		fprintf(stderr, "%s: %s\n", argv[0], strerror(errno));
+		return 1;
+	}
+	return 0; /* can't happen */
+}
-- 
gitgitgadget

