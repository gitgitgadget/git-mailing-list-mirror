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
	by dcvr.yhbt.net (Postfix) with ESMTP id 839C81F461
	for <e@80x24.org>; Tue, 25 Jun 2019 14:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbfFYOuB (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 10:50:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42288 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731509AbfFYOtg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 10:49:36 -0400
Received: by mail-ed1-f66.google.com with SMTP id z25so27539234edq.9
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 07:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r/O7mGiYSOfebeKLkybd1sbh6jRCwfbI+Q4YuChRtPw=;
        b=vViLoL8pxrtGDwtl9+IEjP6+3UUHaRurZxMjM14ThLEgNwMls/3WoRYC2R1R+RmNIK
         /pnxV6U9zBas4lyI//cCZKVh4LylqAThwv9uviJedsoreVrcj73+Ub2C8OqKH0X2r5zN
         sevhoZ7pXJ23LaAUxwlOnEcMiSFn1SefpB4HGFI/E328kh5TiJ+eGgdEzrvyzxCWK0B1
         iqS9h7zscOxn6FzaovTldiJhi/UacMTZmGo8p8x+u2lBYBU5VxB0zZfc/BFWuZ8nCNoQ
         fJu3dM9HxCkP3segNPf08Rkm9nu+h9ITp5TOaEAVS53qzvkKH1mvHzYML+qL3n18ZgrC
         vb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r/O7mGiYSOfebeKLkybd1sbh6jRCwfbI+Q4YuChRtPw=;
        b=KRGxadUI8miUmSYVRtarnU6IJEaZxICTpur22Kbxcrr7McgJt0mAtu8uxjG3ULR8x9
         k9Td0SIJk07kOUm2YoCjL/F9Tgnx1MTVDNN8j3xGOaCPINAz0q3jtxLQMUkC+ndvyce+
         +IWDMuiksg3/qwI34A3PZWNoeWrqTew9iITbDRmRAisxrnWSoAydoJ7vLiBaV25t2uc1
         hrquZxNMue7qCb10xkVsWfla2B9PQ2c/Ulgbc14upfUfSLb90z3yvKdyhajChu6CfgmL
         38VbfAkI/Wr+te8zQNexyRz6gMwFoVYapgP+3hL2CPpJX6ybUTiEzChzepqiOKQh7CQJ
         1pLA==
X-Gm-Message-State: APjAAAW2o2CAkGljRJ9rM93QzIXX/Bm/su32WjH6mkWr/RckxepOSC0O
        h58AFAu2T7IqWAnm0SaETUnzk18G
X-Google-Smtp-Source: APXvYqyIwKL+ckAKcoNa0QMEJHQxe3fJx+WW07q5yYerSQ5TAqOG7voGR7iqnmURzS0efDZQmEKKCQ==
X-Received: by 2002:a17:907:20a6:: with SMTP id pw6mr33239422ejb.111.1561474174977;
        Tue, 25 Jun 2019 07:49:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d28sm5009882edn.31.2019.06.25.07.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:49:34 -0700 (PDT)
Date:   Tue, 25 Jun 2019 07:49:34 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 14:49:14 GMT
Message-Id: <0a2985dc3c096023928ef81eea6da05ed1cd73f7.1561474167.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v3.git.gitgitgadget@gmail.com>
References: <pull.149.v2.git.gitgitgadget@gmail.com>
        <pull.149.v3.git.gitgitgadget@gmail.com>
From:   "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 08/20] msvc: include sigset_t definition
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philip Oakley <philipoakley@iee.org>

On MSVC (VS2008) sigset_t is not defined.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/msvc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/compat/msvc.h b/compat/msvc.h
index 29a8ce8204..04b4750b87 100644
--- a/compat/msvc.h
+++ b/compat/msvc.h
@@ -18,6 +18,8 @@
 
 #undef ERROR
 
+typedef int sigset_t;
+
 #include "compat/mingw.h"
 
 #endif
-- 
gitgitgadget

