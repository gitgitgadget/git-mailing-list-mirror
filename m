Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 117341F405
	for <e@80x24.org>; Thu,  9 Aug 2018 09:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbeHIMFN (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 08:05:13 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34684 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbeHIMFN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 08:05:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id y5-v6so2506573pgv.1
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 02:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jTTvzwVdH9r+sX8kHvpDgV9GDztZ2ZvJi/0rPxOjMKY=;
        b=gJw/7fEIhF/cEpBUGTNjukAQDhpVe/GOon65ekjwFnPzEQx5wqTTPgBFpjjwAxQ/EQ
         Vb111ipNFFWQP3xvOqDvthd/pNQfcYXkOBWee2Bb+vAoRl8zUONCGZOBKtzHhyMfNBBD
         IbzISshkiORuD7tEaJ62SFW+500LAQF6wYXqsEsPUVyQl7qYkk2G3ugfBFAjC5sxvnr5
         goDm8YMbIXggQeYEQoG/K+8otykDH7txMsQL7PiVduHX7Kd0mK+CCSYkKuaGLZmj2oY8
         773kqlmJ5io478YV5oLRWZeONDhMe7GNm52TaDd/w7/mLMtyKj1WyOG6626nGyJVOoaq
         DqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jTTvzwVdH9r+sX8kHvpDgV9GDztZ2ZvJi/0rPxOjMKY=;
        b=Wu5WTuL/GXMHDo7OfIWOKIk6r8DSHbo0z2v2oRZis6OqP0sVzta/HQBmB0g69M84Zi
         Xct2O4Z+Xb8WuRM11z4r8xBY0o5UydxnvMoj6TDKvHSkdiWJRJHdITjfWz6DvHJcFpd3
         ryhWQoyoEM1TMMG6N0ae1Z0ddizUrCofPNDO0CeF5IFCRWnb3sDp86fi/DQjATr9t4fs
         c/LIEufEMJ8P3p2v6NpbAi5RasKPJYpT+ZdxYxtTr1/OBc8U4SLdCk2uHrJjE6yxsthy
         achq0f5+PidccHFdzfH5N0iZI7CEPEHF6myIy8dz6xpEMNydMBmI0BHAKozn3xMsR21X
         MFtA==
X-Gm-Message-State: AOUpUlG9evx0awgXX/OHbV7+aTt67NA3W6Si2L68BBiJYrkWX4aXDRnQ
        azHqSW1T/umUK9qHkWlikDFNpq4U
X-Google-Smtp-Source: AA+uWPxUQSf6KZ6p1Q9qYX3Gvk41k3apWMaMQkulr6QnD3YdEg4UvsBum6+u2TlFc3v1yDM6xVS60Q==
X-Received: by 2002:a63:fd06:: with SMTP id d6-v6mr1463944pgh.348.1533807670898;
        Thu, 09 Aug 2018 02:41:10 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id q5-v6sm6216609pgv.61.2018.08.09.02.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 02:41:10 -0700 (PDT)
Date:   Thu, 09 Aug 2018 02:41:10 -0700 (PDT)
X-Google-Original-Date: Thu, 09 Aug 2018 09:41:05 GMT
Message-Id: <1d82eb450378c5d9ebdadb2f785df1782cf3a1d4.1533807667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.13.v3.git.gitgitgadget@gmail.com>
References: <pull.13.v2.git.gitgitgadget@gmail.com>
        <pull.13.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 1/2] t3430: demonstrate what -r, --autosquash & --exec
 should do
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

The --exec option's implementation is not really well-prepared for
--rebase-merges. Demonstrate this.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3430-rebase-merges.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 9e6229727..0bf5eaa37 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -363,4 +363,21 @@ test_expect_success 'octopus merges' '
 	EOF
 '
 
+test_expect_failure 'with --autosquash and --exec' '
+	git checkout -b with-exec H &&
+	echo Booh >B.t &&
+	test_tick &&
+	git commit --fixup B B.t &&
+	write_script show.sh <<-\EOF &&
+	subject="$(git show -s --format=%s HEAD)"
+	content="$(git diff HEAD^! | tail -n 1)"
+	echo "$subject: $content"
+	EOF
+	test_tick &&
+	git rebase -ir --autosquash --exec ./show.sh A >actual &&
+	grep "B: +Booh" actual &&
+	grep "E: +Booh" actual &&
+	grep "G: +G" actual
+'
+
 test_done
-- 
gitgitgadget

