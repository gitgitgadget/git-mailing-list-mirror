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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C7391F461
	for <e@80x24.org>; Thu, 27 Jun 2019 09:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfF0JhU (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 05:37:20 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38699 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfF0JhU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 05:37:20 -0400
Received: by mail-ed1-f68.google.com with SMTP id r12so6442019edo.5
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 02:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4+gp3uuNF3krmaCy5OasHmhrNPLO3UreB+T9T9nltgk=;
        b=sifNOtKsB7dYMYZbj5Gpvxh48VnWR9UtsyWXUbm29GQIUvw7logQ4UmDIRhmS+gF35
         PNubWd40sWksJ4lrIYiYb7E5+/6ZNTxopidf+IH73MDABc/gK0nxSFgrit0zmChjvJg+
         kA5BgslVPbMw+GOkP9JkuvGHcbmQjivTbLP3Vyfn5k/1SzaOPcotxWmB3TxDxUkTe939
         jXe5I6fcXj3oO21ZdNZ6JoPhE+2kXPqe9by9wXkMFpueNRHzXI1s0vaPTdDzBY+6wZW3
         iHfTj+aMzL2YlnQQv2MBUd0kmrQI89loQ/TA/K+GYQF3xVQlp/gNDQ2hUGvcj9EaQT3a
         j9wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4+gp3uuNF3krmaCy5OasHmhrNPLO3UreB+T9T9nltgk=;
        b=Px2N/HbphBsYeE0MYwaHeaPAKVyUed64YqUxmIQC4yGyn0pxqfeqh6f58o2n05qLkJ
         mq8l4DnIPe23lmxbY9aLeez2eP3pHIIh8ODrFCzPm4Epf9Yfjae52etTktABRp7hxVaV
         b7ASyPkv7Q+RZFLUtCQUEYfIfpGQQh+Gq85yb46mFvxyu2aZ7Ojawjkt2NgEGMkdFykO
         3zW+ebqJpelTwjLP6o9QmfcJWayChKL5NMEz2sZ9UwY9MXuxkK7IK8+tvB5Z5PZrKgRH
         Bp/892czqs1k28Wfv59a6HdQBhg+GkOvLuSCOR/E16zaFec1Je7/2HcUYez9WEUqSIJU
         CgSg==
X-Gm-Message-State: APjAAAWpuuEOcCNuSmXzWfOvUuNBUK6AxqRhBMnvA9c3gShylrvayVPC
        vNsyU2Ngc5RWnWjbuZgsT1AMeuGK
X-Google-Smtp-Source: APXvYqxfrnAqsSc7cTbYqAmP4N5LQXCLpW7T/zYqsJpXgyHs3dUMd1HiY0AHjn6VEDi2+42NxufNew==
X-Received: by 2002:a17:906:318e:: with SMTP id 14mr2156013ejy.85.1561628239051;
        Thu, 27 Jun 2019 02:37:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p22sm322514ejm.38.2019.06.27.02.37.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 02:37:18 -0700 (PDT)
Date:   Thu, 27 Jun 2019 02:37:18 -0700 (PDT)
X-Google-Original-Date: Thu, 27 Jun 2019 09:37:15 GMT
Message-Id: <54fff4ef40d1dba2153de27413fb53e992228b5b.1561628237.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.147.git.gitgitgadget@gmail.com>
References: <pull.147.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/2] mingw: get pw_name in UTF-8 format
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

Previously, we would have obtained the user name encoded in whatever the
current code page is.

Note: the "user name" here does not denote the full name but instead the
short logon name.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 9b6d2400e1..8526876262 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1946,13 +1946,19 @@ struct passwd *getpwuid(int uid)
 	static unsigned initialized;
 	static char user_name[100];
 	static struct passwd *p;
+	wchar_t buf[100];
 	DWORD len;
 
 	if (initialized)
 		return p;
 
-	len = sizeof(user_name);
-	if (!GetUserName(user_name, &len)) {
+	len = sizeof(buf);
+	if (!GetUserNameW(buf, &len)) {
+		initialized = 1;
+		return NULL;
+	}
+
+	if (xwcstoutf(user_name, buf, sizeof(user_name)) < 0) {
 		initialized = 1;
 		return NULL;
 	}
-- 
gitgitgadget

