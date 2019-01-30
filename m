Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F00D1F453
	for <e@80x24.org>; Wed, 30 Jan 2019 19:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733197AbfA3TvO (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 14:51:14 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41461 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbfA3TvM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 14:51:12 -0500
Received: by mail-ed1-f68.google.com with SMTP id a20so622717edc.8
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 11:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lEO2zm4D+RRdgd0jZP3xHjEnfHFoC5J4c6eHcxbWOoE=;
        b=b3OXrYqCZEVyF8T2rKfxjP+oWm/bCMywvRlbTgm2uavfqZjGyYnegY5p+9SvoQ+eUL
         I70xjpvKCk9BpvjgVwGCJ8lyhsL+Cm5lyh9JehymL2MZhOyeHBPPQvbXvPpImcWWrhmd
         IP2pLrQqyFsw4p5XICz3s7McAIjO+ld7/vokLp4PhKuiHK75LVY1cnyTI4aRJWYvg1qN
         9tRIi55fWiRmzYxOhmDci1KVmWduggQTgf8i8Tx6Jqlw/m/0iyGN8ek+GCXxw0e7LTNa
         Go4BIvF9UuLu5d+ZGbimkT6f9z50IMQJcfTT+h28rddUWtsawTn6YUc4rxbRXY83LZF7
         luZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lEO2zm4D+RRdgd0jZP3xHjEnfHFoC5J4c6eHcxbWOoE=;
        b=BPOyo+2g6nf7c9ZyV5XA6XrpRHlfKRfOIMTuUgyY0PVzcKX04eLdxLEITl7Ac/H3Ws
         snRMQx5tmgeVxtLSpNGkDtAuRh60UrxlpASXEw5di3Ti7hug3I3lSLz5tH+Jg/0dBTij
         967I4nEEV1gRBwlr6qG0nwlrOKYVY18mSAYuj5QTi9+UjZtFeWn5LdLTuiwu9otr0OBn
         KLk0XBJNu9EODWD5oSEK39V79N9bh8vTMpzfz5PLu5opPSl+UXf0Osovg1zJysV6Akg0
         PYd74sqj96mAm/fbmdMMpweEDmONH8uBCcAikMWFdFNRNDnAIGcoEUhzK1W3yS7g6Hl+
         7E6A==
X-Gm-Message-State: AJcUukeuGIwkr6y/72T0RhvL94kQN/chVmblMHbGjUMa9PhG/OGf57B4
        OlSy/JflGpx1NeRnH8k/IYtRfEZL
X-Google-Smtp-Source: ALg8bN5w8HJ/1tVLRu41+5tOxOs5Co9eKhzok26KbTo9TGvWwkBhPH8vWT1Sm+svwddBkHTbywl/Vw==
X-Received: by 2002:a50:a4ce:: with SMTP id x14mr30734246edb.229.1548877870349;
        Wed, 30 Jan 2019 11:51:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t24sm731537edb.7.2019.01.30.11.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 11:51:09 -0800 (PST)
Date:   Wed, 30 Jan 2019 11:51:09 -0800 (PST)
X-Google-Original-Date: Wed, 30 Jan 2019 19:50:55 GMT
Message-Id: <785f6f866e1c4b5848abfeb0b74ea641cea2cce7.1548877863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v3.git.gitgitgadget@gmail.com>
References: <pull.108.v2.git.gitgitgadget@gmail.com>
        <pull.108.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 06/14] trace2:data: add trace2 sub-process classification
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add trace2 classification for long-running processes
started in sub-process.c

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 sub-process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sub-process.c b/sub-process.c
index 8d2a1707cf..3f4af93555 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -88,6 +88,7 @@ int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, co
 	process->out = -1;
 	process->clean_on_exit = 1;
 	process->clean_on_exit_handler = subprocess_exit_handler;
+	process->trace2_child_class = "subprocess";
 
 	err = start_command(process);
 	if (err) {
-- 
gitgitgadget

