Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BE5020248
	for <e@80x24.org>; Thu, 11 Apr 2019 15:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfDKPS7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Apr 2019 11:18:59 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43696 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfDKPSn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Apr 2019 11:18:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id w3so5539575edu.10
        for <git@vger.kernel.org>; Thu, 11 Apr 2019 08:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vs307d+a1gx3jEA8oGCR7mKO5fqlVqvJOB3q3lxhDhc=;
        b=bSghPtQXsOixCtFyVgwpacyarkQq25mIxzbRQpTvgJ1OuXLxz1xOA6XgJ5jJJG/sEw
         z7BkYffq9wyTDtvVG+NCmVnOJNlChIf1QOiwrN0NfD8ral0id0tTNCpO/3ewAwF83KEw
         8EMlImvDrBLJJuGE1oMfp4eBcKwSXbhh8xVLQAB1x7d+MPR6yGft82OO9sPwyzyvnhI8
         WTpgkiz/LlYwSGRWlsPkNTrzAIdEUR4/juFvRxGGOjs3U36Ymh2tHTPjL9cuVlrXZ3mk
         0fh3OvWVs1rxU+IRyyaHiqVT6B0VTLSnRZ6Jk6pqvjWgogC40eDkwuT92b971WLQ5Eu9
         BSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vs307d+a1gx3jEA8oGCR7mKO5fqlVqvJOB3q3lxhDhc=;
        b=XXtSdbWwM4w89H5RHPVmpX6njtrfz5WgAswpLZwxnJALmf3DmfDGbbB4WLDCMSly03
         L2ZlQ7sc9hUt4Orddttfh+t+eXM/W2vWmtyMydARcN4jsaaicla7fONQn5ZN86yZxuGY
         pmZx4U2Pkgluu+fx1q1QFybbMmaqc9Yjfvmxw7QFeyionwtZF6z2lEnCTceVOpuUIsFe
         fVOBKWp87QOyCV4Pd5p1hjKiPRlwAIGXejWdEOXuotm5ArCc3LBlyHs5OyfIRFN4wL1b
         7G2GpS3aDe+U0HkvNL+vp6HF0cqk6Bvog++AlA4tYYyCs8PFJUjlu2WeMil4GGIa/wIP
         sDVw==
X-Gm-Message-State: APjAAAX4amatKOkTxr3yulKBx3Lzf/3PEbUZ7SqaRGWLDnXbyUIN/opJ
        nAGpwmsihEs6qZybfIuNOaTyR1MZ
X-Google-Smtp-Source: APXvYqzwH7+UEJOMaJ4K7qGzCFqzbITmoYPZn++EgF4ZA5a3HYFBYWyWnYUaBvUidRYeGdB6ESw8fw==
X-Received: by 2002:a17:906:938d:: with SMTP id l13mr27518343ejx.250.1554995921439;
        Thu, 11 Apr 2019 08:18:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bz3sm7087201ejb.52.2019.04.11.08.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 08:18:40 -0700 (PDT)
Date:   Thu, 11 Apr 2019 08:18:40 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Apr 2019 15:18:30 GMT
Message-Id: <c3c5f6a96b280fc934b179de671e28ade8381f69.1554995916.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.169.v3.git.gitgitgadget@gmail.com>
References: <pull.169.v2.git.gitgitgadget@gmail.com>
        <pull.169.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 04/10] trace2: find exec-dir before trace2 initialization
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jrnieder@gmail.com,
        steadmon@google.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach Git to resolve the executable directory before initializing
Trace2.  This allows the system configuration directory to be
discovered earlier (because it is sometimes relative to the prefix
or runtime-prefix).

This will be used by the next commit to allow trace2 settings to
be loaded from the system config.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 common-main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common-main.c b/common-main.c
index 6137af0e63..299ca62a72 100644
--- a/common-main.c
+++ b/common-main.c
@@ -37,12 +37,12 @@ int main(int argc, const char **argv)
 	sanitize_stdfds();
 	restore_sigpipe_to_default();
 
+	git_resolve_executable_dir(argv[0]);
+
 	trace2_initialize();
 	trace2_cmd_start(argv);
 	trace2_collect_process_info();
 
-	git_resolve_executable_dir(argv[0]);
-
 	git_setup_gettext();
 
 	initialize_the_repository();
-- 
gitgitgadget

