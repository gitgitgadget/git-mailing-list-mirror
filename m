Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54AA51F404
	for <e@80x24.org>; Mon,  1 Jan 2018 22:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752315AbeAAWyz (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jan 2018 17:54:55 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38497 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752306AbeAAWyy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jan 2018 17:54:54 -0500
Received: by mail-wm0-f68.google.com with SMTP id 64so58301857wme.3
        for <git@vger.kernel.org>; Mon, 01 Jan 2018 14:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gxhP/PmO3jNUvsrrNnrqiz1OK/d5sxhm8FKc/EFpfZk=;
        b=D91iRYLSQxd03ov+VmH34Pvug8BsqOmshPK6tJw2QYEaJSdqTAAFQVnssaWHDqkImp
         ABl/bHAOssHiHD5lNx9ZMoCsbvlLEGsAZb08ESCaKNbJLbQ7JNJftBUGJ1P4LVAJ5OLX
         Q/NodbusztVDeY2rPhFw42KMEh8595a7u48sOuEUr+YUVju6WKGfolv6XNliwk1eLROI
         tFayhJBeCvoxU0SJlrhsuBkc4Kjg8Ghos0FQy77FeqBskqw++DYgsl3Wj7hPL1H5JzYr
         KfsauHhxgHn1yfPMCPytZT7vkTw7DeAC2kmwYxtME8WZpDIbM1YK4Wicdv0GW9ULmp7m
         Yo3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gxhP/PmO3jNUvsrrNnrqiz1OK/d5sxhm8FKc/EFpfZk=;
        b=H93CmNuFjlyyVuZK49ykI5BwuInm/oJne9BZbTmZW7IU/eF1v3aV3Z/L/+AlhcVL4o
         lYLWf81paAhREl1xC+1/2ZnTTYcJqNRdqdaYVzzvFO5uOp2kggxJplPHjQec3pz86nq/
         xfpa3CSa32SsOm8aoGr824MkVtQ4BwJSadZdS3eIhJ5qBMQ3vVHebFtltBFWMFGiI8mE
         N7X9YztSgz0PCi3E8qUB1jMvXObhV0eBRL4j74LR/eCLPtiryVwswWKqcGJWwEGXTBqh
         xgt+o6al0MKsv9X2cgJTGyBV4pg5sfgMtezg3h75NO0TBYMnmzHc6GxStJmU5QMavRAM
         L2XA==
X-Gm-Message-State: AKGB3mKjuttQWJKivxKm9HpfRdSYt3q0XM8GPn1lSREPNcWIpr88cBOI
        ATS/jZWSiX8j3MIcMxcfUBM=
X-Google-Smtp-Source: ACJfBotAYd3tK2k+bSNOvofPbd33zgepq2EnhfR/rg+fIs2V0MpDrZl+vxbhq5kVn6VRdET4Tn8b1w==
X-Received: by 10.28.52.81 with SMTP id b78mr10052560wma.70.1514847293378;
        Mon, 01 Jan 2018 14:54:53 -0800 (PST)
Received: from localhost.localdomain (94-21-23-100.pool.digikabel.hu. [94.21.23.100])
        by smtp.gmail.com with ESMTPSA id d7sm54186061wrd.54.2018.01.01.14.54.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Jan 2018 14:54:52 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/4] t3200: fix a misindented line
Date:   Mon,  1 Jan 2018 23:54:46 +0100
Message-Id: <20180101225448.2561-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.67.g3a46dbca7
In-Reply-To: <20180101225448.2561-1-szeder.dev@gmail.com>
References: <20180101225448.2561-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t3200-branch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 503a88d02..e9f55ac04 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -1215,7 +1215,7 @@ test_expect_success 'use --edit-description' '
 		echo "New contents" >"$1"
 	EOF
 	EDITOR=./editor git branch --edit-description &&
-		write_script editor <<-\EOF &&
+	write_script editor <<-\EOF &&
 		git stripspace -s <"$1" >"EDITOR_OUTPUT"
 	EOF
 	EDITOR=./editor git branch --edit-description &&
-- 
2.16.0.rc0.67.g3a46dbca7

