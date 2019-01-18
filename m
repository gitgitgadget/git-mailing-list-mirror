Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A482E1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 07:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfARHrI (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 02:47:08 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45293 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727396AbfARHrH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 02:47:07 -0500
Received: by mail-ed1-f66.google.com with SMTP id d39so10349663edb.12
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 23:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a60PDB/sFGZbiveurPxw6uMN1zI85wNCHnWFU/k8O74=;
        b=X65fUxC9IIXWT8Zp+IPZRlYs3ioJhyEtd6AVMhAqQDuiFBPbmusrylAI94/7CohV3m
         NK9qDXNMyD8nVuU2lcAWAoU8JNaUzM1eVMjG2wGmHZA0g94NBYj69kt55a5TCwWYIICm
         NKYXkAVBUEXty8is73x9ErgkfAa8jJ55bOPc+JjY2nHR2k7QsVMDcuyS+hYTEw95tyIr
         WLRrI9NV4joyFPQvCPeK4LPYaeV8gn9SDC/W0dLMu/DVdVvOOdoaZ6fSKdSGhqOzSwSm
         A3S4YDLBwwBNIjMQ9KVdLJE920gByNjJHynN+xPU23quOWGpWD/w5suMgaZamTMakrf0
         V6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a60PDB/sFGZbiveurPxw6uMN1zI85wNCHnWFU/k8O74=;
        b=uGA/RG6Dpto0bmmliIwFICLiTZ8MOQoeSzhdqqHGn7K4wGCOE/MygoZObrh4AW3mIB
         9um9Y4i0npCKIUzXLG8/+u1XtJgruZ9s/LYZT9HlPZVgV2nhKoQbpt/+g/N1mSIXxM+9
         XN5RQDo54yVXUhd7kDynQYdxr+NLbnLNAfwObkdWGBqGmoE6X7shmKaE0Ej6TR3uWseK
         EAJLmE5K6k8aT/m9XCI2TF0vw7Zlf39RvkfPcqOetRo8Nwg/GhA4SkzksVE1FkhKcX45
         rnNTvR0DOpM3UkRwcTH6TUuZIS4fWz7ltR48htddENVHg2I9a4dAhB09OFEmG/xqpGzO
         AHUg==
X-Gm-Message-State: AJcUukfv025PfZCrm7xajbw3QktghaEwDfOLfwN0qWi60aYtxtLaB+zT
        autZbDc/OXMACdf6PHJweTl5GJOX
X-Google-Smtp-Source: ALg8bN5ohLhU1540D56escgA6zv8A7bKsLzqY66EsK7hgLGIKsZoc/pExeIgRjaNtie1IyvTP+83nw==
X-Received: by 2002:a17:906:14d8:: with SMTP id y24-v6mr13530231ejc.216.1547797625853;
        Thu, 17 Jan 2019 23:47:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 24sm7094733eds.97.2019.01.17.23.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 23:47:05 -0800 (PST)
Date:   Thu, 17 Jan 2019 23:47:05 -0800 (PST)
X-Google-Original-Date: Fri, 18 Jan 2019 07:46:57 GMT
Message-Id: <4950c889aacd869a8f4fd30b8d5cde4b43957347.1547797620.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.103.v2.git.gitgitgadget@gmail.com>
References: <pull.103.git.gitgitgadget@gmail.com>
        <pull.103.v2.git.gitgitgadget@gmail.com>
From:   "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 4/7] add--interactive.perl: use add--helper --status for
 status_cmd
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Daniel Ferreira <bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Daniel Ferreira <bnmvco@gmail.com>

Call the newly introduced add--helper builtin on
status_cmd() instead of relying on add--interactive's Perl
functions to build print the numstat.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
---
 git-add--interactive.perl | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 20eb81cc92..a6536f9cf3 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -597,9 +597,7 @@ sub prompt_help_cmd {
 }
 
 sub status_cmd {
-	list_and_choose({ LIST_ONLY => 1, HEADER => $status_head },
-			list_modified());
-	print "\n";
+	system(qw(git add--helper --status));
 }
 
 sub say_n_paths {
-- 
gitgitgadget

