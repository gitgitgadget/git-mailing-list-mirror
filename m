Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BD8A1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 14:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfAWOki (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 09:40:38 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35986 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfAWOka (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 09:40:30 -0500
Received: by mail-ed1-f67.google.com with SMTP id f23so1889432edb.3
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 06:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6wZF5XyFnvK4tOVLEGObR7qCxdrcyoiAaAwrz8JEDdo=;
        b=pDdaIsYqmzvZ1SroOUM3GHgpkhHQ7OUscNEETIJveNoV09827tPOmEC4+BY+u3nbCu
         U60UjW9Zl/SnkMi9Q+hgWwJCv9uD8TClAE40XQIPRtyJtN76i+y9nVG846GgqmhdBCHq
         8ZOTTliAA9S7344mTn+eb8zzEZDrZy8UhZP1YfAwD62OFD59miro9FBlVB9CKWNk1Kyy
         QbNn/SGqmp7D2DumFg7WCRp/J1Cdi7sDFNwNS8h5JnxlvKJwqlf3X5tSAaHGEOY5QCZH
         6fehXErBhq5EBc0hlN5A+pWjkHDLFqCVAfDUlQChuj1V94pbP8A//ZffGOChstAsUDRC
         xXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6wZF5XyFnvK4tOVLEGObR7qCxdrcyoiAaAwrz8JEDdo=;
        b=QpPa9iysB4aJMZMu14vWq+3wZDDDMM8LPdm6PJcjCCg4cFybfQmSrRG/7AV/7xa9CM
         expPqHXNc0oJL1fIwFtL3iDiIrMvVrHmKBaa3pMSidKQka4WaKYrZ/BpzCpkZG8wh6Gg
         Wu5d6c/C7AOBPNiW9t18PCwdIIxwpd2n2wGCINlkcvPfbncDjazBrMEYDpLEXl4Y4Nrw
         cFZkwr/2eBJP9CHmm/yO81ND5SyoUNJpg89XNyb9OWfDXPW14m+JRMGU+PJVAAzuIrRr
         eciiIaISpjGr1KdZef0aB3JQLYohsrZu4Ve0VvE+GwN+YTE0mXlrRbo7I7AJXseNeLy3
         RKaw==
X-Gm-Message-State: AJcUukemN6zMFwfi0HZ+BedA2Su9h6ZbP9R9mslEub/nA51d3neQrfj4
        /AOY5Vn702VPAa5Ua2O3AzoRnz/H
X-Google-Smtp-Source: ALg8bN7km3sqLZ3PkhqLFo6G5kVBzOAh8YGFbRmvnNI/b3WbqH3S6ZYNAPOIs2bLnFesiIQe8tYYMA==
X-Received: by 2002:a17:906:828b:: with SMTP id h11-v6mr2718876ejx.115.1548254428752;
        Wed, 23 Jan 2019 06:40:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20sm10446591edm.29.2019.01.23.06.40.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:40:28 -0800 (PST)
Date:   Wed, 23 Jan 2019 06:40:28 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 14:40:08 GMT
Message-Id: <966c412f03013902826ffd188ee9af973be60833.1548254412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v4.git.gitgitgadget@gmail.com>
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 17/21] tests: add t/helper/ to the PATH with --with-dashes
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

We really need to be able to find the test helpers... Really. This
change was forgotten when we moved the test helpers into t/helper/

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 9c0ca5effb..c790e98fd2 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1227,7 +1227,7 @@ else # normal case, use ../bin-wrappers only unless $with_dashes:
 	GIT_EXEC_PATH=$GIT_BUILD_DIR
 	if test -n "$with_dashes"
 	then
-		PATH="$GIT_BUILD_DIR:$PATH"
+		PATH="$GIT_BUILD_DIR:$GIT_BUILD_DIR/t/helper:$PATH"
 	fi
 fi
 GIT_TEMPLATE_DIR="$GIT_BUILD_DIR"/templates/blt
-- 
gitgitgadget

