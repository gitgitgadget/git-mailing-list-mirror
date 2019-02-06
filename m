Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0654D1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 17:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbfBFRQG (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 12:16:06 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:35711 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731551AbfBFRQA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 12:16:00 -0500
Received: by mail-ed1-f54.google.com with SMTP id b17so2389953eds.2
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 09:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lEO2zm4D+RRdgd0jZP3xHjEnfHFoC5J4c6eHcxbWOoE=;
        b=QZ2Jiz+zB+gsxifd0kp0xE1oyU3MX1+Oe9NXCMJ4jirTnQiJozNT3ZO/0Gxbm+RHNv
         veqETuvR3O0BFj9vI3OfLBTBskbMWZZBPr+ZoBkz6p+PHNb0d2q/5gn6Y+/lkNkNgDk3
         yLSbBqPSm08PbSd3PIlyISxcx7txgwbVuvrJH6kWwXRmIrmWbs8UEaWFIDGZMaXsFL7Y
         Zyi7h4PKuGjP7h0roas9lHAJjoBi+AbyCKI6faMXYNA07XaEgecsBfMZQrBZmOC80TJ4
         DAe5vMV7tK7IpZm64sGcLXOsD6Mss8sibKhgekAs61tDXZj9Ihq+sx/zt6PKr6F7TLxk
         OSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lEO2zm4D+RRdgd0jZP3xHjEnfHFoC5J4c6eHcxbWOoE=;
        b=jw7VsAacoKeGQfJrxwaX55eS4qnsc1IDhBVBVRSv4JAxd21kIntJ+DQyTIxZRjNaQL
         3oWJs98vQXv+tHglKvWZ6gfk1KX88KrhRttTKdmXrPLahVoYB+GQGloEelEHRo7c+YmK
         6yxuVDkCK+YpQf10llHo52In+aCHoKepLGoTqbbcK2dsnn9SrK1YuNnVX+nM73xb7Nzo
         Lu/wOGzjsSJN1xQWZWVslAHFBqxfTXJ3l00G6B5V/XDM7jBegQViG2RjfWKZ9Bmw9f2D
         zczhR1NUcjxul4JSMiJddKEEDbNQMOB313Zj6j+JSVToDWRP9WpkLsVyTAIJfGkNWwtu
         A3kg==
X-Gm-Message-State: AHQUAuaDoY/Xg7ft2bF++dnTEfq4qqQY/4fbnbLGNS8VMd01rUgqmhoF
        BgvZE8zVCZxe8zop1QZw6Bm3lDLr
X-Google-Smtp-Source: AHgI3Ib9qGEciCA2O7uPD4pToAI3+KOahZNaL0ab/W2wDnykEhxddIN6FKELcTfjUy4Ia9zf1PITZQ==
X-Received: by 2002:aa7:d88c:: with SMTP id u12mr8611192edq.237.1549473358734;
        Wed, 06 Feb 2019 09:15:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b46sm6114099edc.57.2019.02.06.09.15.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:15:58 -0800 (PST)
Date:   Wed, 06 Feb 2019 09:15:58 -0800 (PST)
X-Google-Original-Date: Wed, 06 Feb 2019 17:15:41 GMT
Message-Id: <d7ce85b702599666ee4ea66b1ac3947ad60c3a82.1549473350.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v6.git.gitgitgadget@gmail.com>
References: <pull.108.v5.git.gitgitgadget@gmail.com>
        <pull.108.v6.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 06/15] trace2:data: add trace2 sub-process classification
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

