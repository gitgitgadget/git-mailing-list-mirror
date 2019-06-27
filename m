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
	by dcvr.yhbt.net (Postfix) with ESMTP id 99E351F461
	for <e@80x24.org>; Thu, 27 Jun 2019 09:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfF0J3E (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 05:29:04 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43306 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfF0J3E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 05:29:04 -0400
Received: by mail-ed1-f65.google.com with SMTP id e3so6376517edr.10
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 02:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CxxlAv2dgTieJd3LmATo8ilLkDD/L+YPvDuH4xCzhn8=;
        b=HOdPCn3G6Snhw/A9IRWraeRoZsDTCa43S8aUNkJlYtQUmo1/8RBBFQ/ZAx8YTtFYT/
         68AaTOk3gKcnqWsOdsZZv8QCaSM11Z1gSKUFHeVyPzz6Bk4sbCAA0WE4y8CjX70BzLZ7
         In2Runzhu3LXfMwI9aYT9F1flNBJ/0n9GLbQ8u91zDJmWumRGwjCe+tASqy1ixOH4Ay4
         Uj1q2EiGUe5F5CTNCG4fwQELqCpEhQ85p0VAz9znP15L7YJes2fc55eqwxm4+uKr9WBl
         oETlFOVBK+xNTtyRzZVhx35vI/ATZlrZks5BYEkHq40R/9d3Ye5lZavMhpbzWSYSgtOt
         K54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CxxlAv2dgTieJd3LmATo8ilLkDD/L+YPvDuH4xCzhn8=;
        b=untegeNLPEj/x6M5Z+iAPAdw/3sK9SM+FxE+pziQ8cvD+KkbW8dDYmWLPr3d8f0OaM
         U2RxR5r9sQngkZQ0O0JuzHeNIZb9PEvLswRWss1+7gtVFJsbTHr8f8huGnSZqBGOPFB9
         sewdP6NkwZliqHfNp1aagog5wMwv2IfGoSmHoVs79aLGP28qld7/2QrLfoxSelj2Qxj6
         w3E7g2DvK6R93N1ebtxC+HIWcoLnhxfjEnJFuRNcJe0zP+RMD1SmlnMW5kkEwAKQBpuU
         JymvX2++wqc13y/ZE5tOyg+DGFbmLwl9dQrZP3NabhgeYAe6mZCm3ANbnGcpbYnjSUo/
         9jKg==
X-Gm-Message-State: APjAAAVmdpyPFRyn6k/ncFlnaQBWnw3dv5HfIjeceKe+JdM/E6Bh9xGX
        /tWzbTEaw1bxIC3J0OOyH1jaB4qb
X-Google-Smtp-Source: APXvYqyizCfRqKiumgN/KQPS505cI5KiGgKKgaBMcxXAqZDH7sQn61LAgdGdCisBP0PHP63xrumFHQ==
X-Received: by 2002:a50:b104:: with SMTP id k4mr2762039edd.75.1561627742366;
        Thu, 27 Jun 2019 02:29:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r44sm548561edd.20.2019.06.27.02.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 02:29:02 -0700 (PDT)
Date:   Thu, 27 Jun 2019 02:29:02 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Jun 2019 09:29:00 GMT
Message-Id: <af1ac3bde430a6e7c2963e77dfb24b0eff6c587f.1561627740.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.215.git.gitgitgadget@gmail.com>
References: <pull.215.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] mingw: enable stack smashing protector
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

To reduce Git for Windows' attack surface, we started using the Address
Space Layout Randomization and Data Execution Prevention features in
ce6a158561f9 (mingw: enable DEP and ASLR, 2019-05-08).

To remove yet another attack vector, let's make use of gcc's stack
smashing protector that helps detect stack buffer overruns early.

Rather than using -fstack-protector, we use -fstack-protector-strong
because on Windows: The latter appears to strike a better balance
between the performance impact and the provided safety.

In a non-scientific test (time git log --grep=is -p), best of 5 timings
went from 23.009s to 22.997s, i.e. the performance impact was *well*
lost in the noise.

This fixes https://github.com/git-for-windows/git/issues/501

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/config.mak.uname b/config.mak.uname
index b71688eeb7..2400e7879c 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -596,7 +596,8 @@ else
 			BASIC_LDFLAGS += -Wl,--large-address-aware
 		endif
 		CC = gcc
-		COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY
+		COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
+			-fstack-protector-strong
 		EXTLIBS += -lntdll
 		INSTALL = /bin/install
 		NO_R_TO_GCC_LINKER = YesPlease
-- 
gitgitgadget
