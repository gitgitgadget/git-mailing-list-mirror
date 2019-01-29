Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60F7D1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfA2OTj (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:19:39 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39815 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbfA2OTi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:19:38 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so16098721edt.6
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 06:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6wZF5XyFnvK4tOVLEGObR7qCxdrcyoiAaAwrz8JEDdo=;
        b=rqvX/BlX6+g60Lzw6Or1CJnJEwtFXckQ5mU5A66b7uv3Ogaja6ZVojPjexfIMMNqN2
         PrvyYTsNPk7+VX6k93RIg97mXbTk93GkNXig4Somv3B/vbQLtdwKJd+6NlwHKk/vdCV1
         yiKrKZUzpyVBqPjcEgVOBh7FvlWdvZFjILiWtZ5P2wObofVJdKmSEuJtDZqyYwKwdafU
         T91DSzhYtst0c5irKwWcQYT2b17iRWflwVUAXqWAWwk5g8cyfmasm6h/Njw9IlDXx5kc
         Rqrekcq/E6cjPmjYbaY8gAf/0tCp4A/y8QqghkjzEDrMA0PlSBPUGnGxg9CxRxGUlsGw
         iyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6wZF5XyFnvK4tOVLEGObR7qCxdrcyoiAaAwrz8JEDdo=;
        b=FPTddrS+UU08KiPldcb3Hff99uQFrpMAljfY40i8Ig+MtMwD/jDGlsLHOA7AxCCKoB
         1sKZVLxo7Q+5ea4IVWT48+M3BX4KkB+VPNvqtTCkmI/3E5xRq7nybPS/TCzvPede5Zvl
         nxVFDtxmuf/jTbHUnRyasezFeZz5sMKPMu1BlSJSfIMcA+dm/xD9tySE7foHfQ90S/Oy
         GmvrJbvglSiIrXvI+t0dyD/TH1wiFvB7XxZGOjoauPMry2Yi4YOoGVgTldffNuLKkyiX
         1r6hoD14mmZxk6uKzPQ9vByvCEMWnmlHwHXjG1cOwJLerHpKuqAGBNxsSVFEHU2OhbU9
         FyWQ==
X-Gm-Message-State: AJcUukcV4o/kslJnYecq0ZXAyhkJQybQt9vQ6YK8sHayUiBO0/iFNs2w
        /bGiDyGkY2DjOQaRbYq3fz8JT4Q7
X-Google-Smtp-Source: ALg8bN6inoN6Dy3pwitUpf80Jg0JINMwp9o/1mnYKVwZ5afahXaNqxdG99a+sXMi78+fR+o6MjtT7w==
X-Received: by 2002:a50:de88:: with SMTP id c8mr25628938edl.129.1548771576136;
        Tue, 29 Jan 2019 06:19:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m14sm15825593edc.27.2019.01.29.06.19.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 06:19:35 -0800 (PST)
Date:   Tue, 29 Jan 2019 06:19:35 -0800 (PST)
X-Google-Original-Date: Tue, 29 Jan 2019 14:19:16 GMT
Message-Id: <77896b2f8e6fcef5fbcd9805b724f3f074c2d769.1548771561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v6.git.gitgitgadget@gmail.com>
References: <pull.31.v5.git.gitgitgadget@gmail.com>
        <pull.31.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 17/21] tests: add t/helper/ to the PATH with --with-dashes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We really need to be able to find the test helpers... Really. This
change was forgotten when we moved the test helpers into t/helper/

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9c0ca5effb..c790e98fd2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1227,7 +1227,7 @@ else # normal case, use ../bin-wrappers only unless $with_dashes:
 	GIT_EXEC_PATH=$GIT_BUILD_DIR
 	if test -n "$with_dashes"
 	then
-		PATH="$GIT_BUILD_DIR:$PATH"
+		PATH="$GIT_BUILD_DIR:$GIT_BUILD_DIR/t/helper:$PATH"
 	fi
 fi
 GIT_TEMPLATE_DIR="$GIT_BUILD_DIR"/templates/blt
-- 
gitgitgadget

