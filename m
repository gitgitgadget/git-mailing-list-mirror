Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F32C11F453
	for <e@80x24.org>; Tue, 30 Oct 2018 09:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeJ3SPJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 14:15:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43352 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeJ3SPJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 14:15:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id h4-v6so5498206pfi.10
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 02:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=e7YAnNppjldxX/NhyLZR2PT3RbSwcuUzcKC+FMvCmrA=;
        b=pJn8GIXdwqZy09uc6TbfrT9xJvnlcHrefWH163Jdnza+bGO/kGZc2AGHuw/8epPDrs
         PbqzEEgw5FN3rDKLF4BKqD0XIyHdO9T0kJFAAQ5CB8WDTWlHqCmK5djrc/tUD4FheElA
         UnPYvRGP4DI4n69Do37Kq8sS4t/5mNb3bhoxHQruJjz1eaFIcX10L8Rf/Qf0AMdg+F6i
         nU6FHUv+zTJtQYzTCTFAsC+nNCqL1Ny6as1jZ9uDZkhpYYZyzSXB7+8IvAsX1FBWrc1H
         Zyhx2bImLBqEHaP5JiDDGdWJHV3CHGX0KcNAGWJkmLB92WVTxq0w4GmKQkZceothZ0C3
         z55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=e7YAnNppjldxX/NhyLZR2PT3RbSwcuUzcKC+FMvCmrA=;
        b=ildpwCY4TFt8l6bZX3g4WYApRaY5t0zpAXdO/GCc1Ue+c5PnRE4n+rKNVQ2YBLq9pE
         s1/fA0bIGjBEJsKy3vgnK1NQeGxDiENfpDjjP4/0KtAy+ooEuDZXeucuq+CCo4HlWWM6
         s1N76PmysnKieHVDjgpKhsy+ty4j462uQ0hFvGuP2dXJRLbl9HoqzX+leDU9cflSevAt
         uzJ9vo80uWIGKs9s4Zspl6ork7XhLkyBxr+xiRYKbSz5a2RvTVohg8oY9aMw5h6P0Q0N
         UUooyW/raQwRaABk6OROVxHXOBcj62gdnRYIYUIhV/IntCGQiLUidPBOoH6FC0vElwT2
         4gbQ==
X-Gm-Message-State: AGRZ1gKjM6iqzvBkLoB7NZQPNAAZyznW1di6qL2lDK08ejoNJgTG+Ti3
        RK27u2N1V8C7V0DBthAcnogLZr/m
X-Google-Smtp-Source: AJdET5cTZJAFECeH80rAJBmYB9ZHCb+OL0VoyXSWOM0vxeX3TNXd8QH+zR9Ovwh8E1BaDnR1dVCzTQ==
X-Received: by 2002:a62:ac18:: with SMTP id v24-v6mr2156569pfe.126.1540891350033;
        Tue, 30 Oct 2018 02:22:30 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id i19-v6sm6599209pfi.87.2018.10.30.02.22.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 02:22:29 -0700 (PDT)
Date:   Tue, 30 Oct 2018 02:22:29 -0700 (PDT)
X-Google-Original-Date: Tue, 30 Oct 2018 09:22:24 GMT
Message-Id: <77b2cfb2188b9a5b65c4564faea2a292963371bf.1540891346.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.57.git.gitgitgadget@gmail.com>
References: <pull.57.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] t7800: fix quoting
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Karsten Blees <karsten.blees@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When passing a command-line to call an external diff command to the
difftool, we must be prepared for paths containing special characters,
e.g. backslashes in the temporary directory's path on Windows.

This patch is needed in preparation for the next commit, which will
make the MinGW version of Git *not* rewrite TMP to use forward slashes
instead of backslashes.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7800-difftool.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 562bd215a..22b9199d5 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -332,7 +332,7 @@ test_expect_success 'difftool --extcmd cat arg1' '
 test_expect_success 'difftool --extcmd cat arg2' '
 	echo branch >expect &&
 	git difftool --no-prompt \
-		--extcmd sh\ -c\ \"cat\ \$2\" branch >actual &&
+		--extcmd sh\ -c\ \"cat\ \\\"\$2\\\"\" branch >actual &&
 	test_cmp expect actual
 '
 
-- 
gitgitgadget

