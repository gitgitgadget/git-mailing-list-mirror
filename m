Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A7481F453
	for <e@80x24.org>; Mon, 28 Jan 2019 21:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfA1VsE (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 16:48:04 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:37787 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfA1Vrs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 16:47:48 -0500
Received: by mail-ed1-f46.google.com with SMTP id h15so14345451edb.4
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 13:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lEO2zm4D+RRdgd0jZP3xHjEnfHFoC5J4c6eHcxbWOoE=;
        b=fl/JB+imr9tQ9nzxfBh4WWo3geb19wsYflxOeixg/7+TGVujgtsa6uLzHHdyB7JnFa
         epYQKhdx2qTIqoLYr+skQ7cddcfdybPFNwCYJEpc4sMoSq5ZupQUZ/DOJlL4XXCdwh45
         a7/KO7BZJKBJXLle00veXX0foCRk5WXaVrN8oJAydr6XF3yw0ICeU9tuyUczgvXsJ6RC
         yVCUKArntkXnqM5ohxW7zt3EScVqXOyVf4qB9kzHHFekiIsit8vDki8i1UgpYVJDzt3f
         1Klb6Q6PKoAXU3QNtGHiYOl+w4HscUJrAaWzZQqx3eIcwfEa1kGa08aEvfuv6Sgdalf9
         +IJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lEO2zm4D+RRdgd0jZP3xHjEnfHFoC5J4c6eHcxbWOoE=;
        b=M+xmJG8/BOvYfhUINMne8j53k2QZb9ZNCRZ2MTFApiMptD0roNl+HjpkskaGBb0Zai
         K6MRZ+vtCj8oyyRWpGmJHaDPGRKwdWNppZdBXcZbUhEPO0A7FazN18gtf/98ig1AxZ3g
         65EfcHSRZl/nveLwZcWSrs25/TyD7vIYtuKbAk2pvO7s+PJcGBgkB6WvtBcEibEKF1BB
         Wr4aVWsfOlJEO9A19phlMfAu36KDwf6hfsYK+FtlNz1WG+8yVY4/CjYwnY9jltRnu807
         NjCePb+LFX5ipXIJLvjJbbKc5G85Bz+0P8gmjcMwCcNVSABYn2LPPhoWv7Y2u23N9uAo
         Wi0w==
X-Gm-Message-State: AJcUukd664ljVPCAsa/lr7u8leq43uRN7zEW8hXqV7PPj1wns92cGUIr
        ImiAUkY4iIRbFBE25sU0jkaejTOw
X-Google-Smtp-Source: ALg8bN47Juy1+2Dh7kvU6oWBXNRdi6WD9kGjsrpHl90TkwccsLWhtMsYz+M2OoW1hPbHy4vDb41ysQ==
X-Received: by 2002:a50:f5b0:: with SMTP id u45mr23426272edm.45.1548712066528;
        Mon, 28 Jan 2019 13:47:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20sm14138206edm.29.2019.01.28.13.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 13:47:46 -0800 (PST)
Date:   Mon, 28 Jan 2019 13:47:46 -0800 (PST)
X-Google-Original-Date: Mon, 28 Jan 2019 21:47:31 GMT
Message-Id: <b590f1910007cc7a8cb0d7a5b026bb978ce16386.1548712060.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.v2.git.gitgitgadget@gmail.com>
References: <pull.108.git.gitgitgadget@gmail.com>
        <pull.108.v2.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 06/14] trace2:data: add trace2 sub-process classification
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

