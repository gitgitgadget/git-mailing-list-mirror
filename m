Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 123DC1F4BD
	for <e@80x24.org>; Thu, 10 Oct 2019 12:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733206AbfJJMfj (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 08:35:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53341 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732228AbfJJMfg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 08:35:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id i16so6749910wmd.3
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 05:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x0wApsDLgaNQ4wNWf8YiA6PwIlW5+8KFmZgQ1b5OQOE=;
        b=Rm1kSJ+/h5uGaEKFMU3EpW0oBzPu7//LD7hsk/Ij198vpLgoRf37+LKMWaPa5Ligti
         dlkCbknnK6HF1nBtxTtFagoTPepqU0YUOyJpc0n0oTUNn4FV9Gc5CtsDiV0ZY6hM2d9Y
         WdDkcNbaMpeprJmYAx8/lnT5rGGVtk/V4AnP8CRlqYzLlBEW8xtzT6I2D6zSobbwb6jk
         SoLcawf6ApZujXJB8gRiynff8JusVkvioq4Mn7EbPywtdJIawIVHUwc4YUjAuPFBg0DF
         aVBAelvF2LWVVFwW9Cxp7j/6DXOwbgSJp/9I+oy/oWAjdknkk47IA0tPA53247JtTeTk
         NWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x0wApsDLgaNQ4wNWf8YiA6PwIlW5+8KFmZgQ1b5OQOE=;
        b=oPBlEuHbPTi7cR5VOMhmJe3Z+dPatfORV+h3zo0WgYSXP5BzXZRYfBUX4Tl9YBP2g2
         R+oF1dhMM9bMfN+I19gTOlbjMV83Z8V/USTtjjHM9MegH+KrZaHi1LKAk9FmJj1nmL6q
         MfvNryiPhj3+JiuBLmAVasBP1d7to3qupdVE86YwPksiI4yI6hepMc5wyAo1coi4uG8g
         4Czjx/EZ9LiTOEm8HUmGbjyY33O3IiPJN/ZWH90q0O72NFNCzRHRF/OWJk6qoUaS8rX1
         H16JEZ0YGNDA5gNCmnDaWb3XlYctx30+ATRyOhd/EeW7dX9plh7afj6IF1ds64ZiVD+L
         ly/w==
X-Gm-Message-State: APjAAAU/DEE8ryCFrbDpxfD9LQNV2s9iO1C4ebAeOKTODMpP4wPDlYcB
        uGf8C3RDX8RHBZRJlSxGNlCHXc+P
X-Google-Smtp-Source: APXvYqyLtpVQ/SboixkpU5FqX6AqzgAhlfMx1z8kezDh5cH1nQS+YiJ5gOYIFGDc+Jbg5supTtt4qQ==
X-Received: by 2002:a7b:c936:: with SMTP id h22mr7285282wml.1.1570710934493;
        Thu, 10 Oct 2019 05:35:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h7sm4467394wrt.17.2019.10.10.05.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 05:35:34 -0700 (PDT)
Date:   Thu, 10 Oct 2019 05:35:34 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Oct 2019 12:35:32 GMT
Message-Id: <7b88e36723e3e6d51118d62211f487b497c532cc.1570710932.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.387.git.gitgitgadget@gmail.com>
References: <pull.387.git.gitgitgadget@gmail.com>
From:   "Tanay Abhra via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] t1308-config-set: fix a test that has a typo
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Tanay Abhra <tanayabh@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tanay Abhra <tanayabh@gmail.com>

Change test 'find value_list for a key from a configset' to redirect the
result to 'expect' instead of 'except' which was a typo.

With this change, the test case actually fails because it uses
`configset_get_value`. Clearly, this was intended to be
`configset_get_value_multi` since the test expects a list of values
instead of a single value, so let's fix that, too.

Originally contributed as https://github.com/git/git/pull/451.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1308-config-set.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index d0a2727b85..7b4e1a63eb 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -166,14 +166,14 @@ test_expect_success 'find value with highest priority from a configset' '
 '
 
 test_expect_success 'find value_list for a key from a configset' '
-	cat >except <<-\EOF &&
+	cat >expect <<-\EOF &&
+	lama
+	ball
 	sam
 	bat
 	hask
-	lama
-	ball
 	EOF
-	test-tool config configset_get_value case.baz config2 .git/config >actual &&
+	test-tool config configset_get_value_multi case.baz config2 .git/config >actual &&
 	test_cmp expect actual
 '
 
-- 
gitgitgadget
