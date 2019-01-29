Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA7181F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfA2OTj (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:19:39 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:42748 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfA2OTh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:19:37 -0500
Received: by mail-ed1-f52.google.com with SMTP id y20so16080597edw.9
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 06:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tz7VD9jZtEnv8yooHJRr2Q/rjZIeYRglb+VYrbixkYA=;
        b=CrKavrZ0fJiqlOspLqP5g36VU1rzhAYxMgjzvUfjJnEHhdfkmyvGRROkrRiu199tKP
         yqr0p2HWcvlSM0pA+kBZEYEIr3nZSWL5YshfTfnrqN1nT8MTGNoFshJHciTDQjd/1pPx
         Tcds1fMwQj3qp1id1o7iMN5Ao8Rmsw9e0jQ1SKUYxWCh+fxgFO+QGqhUCo3hHxVYN4Ol
         3XGeCZLZ1u6TeQsg9EyeXKI3zF6Zngt5fffm5szMz29/zXkkyJxfj8coA8ZiEZyqMnoQ
         jhBHqtnNIzqT9ofG6dj8TB6OP+rIycALOOnxa84/7oU2Yo5q6xO+4OxOHY+lOE1MFb3s
         fZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tz7VD9jZtEnv8yooHJRr2Q/rjZIeYRglb+VYrbixkYA=;
        b=N5v+I6oRSRwG+1PRX7vzaxpY3MsedTK6/zkZALmSJtfrBV1QZpEGUPaWPl4JnUPGWK
         6eK3SWlE7pcBPCuzzc+t5IF6SMvmQu2HMoTRSlWwcyl/FHTIQyKk1g0CczqonkGKi6hc
         mzkYoHPCvAm/Eu1+GuycpUXroq11QtUfQ4X4BFxTvdnQXaYYTwcZ1FABCn4zJ0oByZma
         Eyo8qKMS91UDXjcb/8010Y+KaCS+At5MJzpxTQRTQJirL+TksCcqVBUO69B/qrF/WmU6
         qgxF7XlQsttulDhadXWnyxwNe4yfmwhDAwZi2mlISx6KMahio/a+KwsWV5LCVQZnpNaD
         Xj+g==
X-Gm-Message-State: AJcUukfg8hG8MdBld3C+yhRuCVQFDYnZPzyexw8JrPbPK/hiU0/3dj7P
        aUsnd5dit/bhRuLzmKpv3mJCkRJZ
X-Google-Smtp-Source: ALg8bN6IlBcK2u551GmZBZsKHCaE46/zi92ymQBjMUjWtg0TbGmGD+h3Ewhv5SHIRE7zBZsgnPCTuQ==
X-Received: by 2002:a50:cf41:: with SMTP id d1mr25949425edk.242.1548771575433;
        Tue, 29 Jan 2019 06:19:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v14sm13785315edq.74.2019.01.29.06.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 06:19:35 -0800 (PST)
Date:   Tue, 29 Jan 2019 06:19:35 -0800 (PST)
X-Google-Original-Date: Tue, 29 Jan 2019 14:19:15 GMT
Message-Id: <991b41afa4a83a73f59a72504d269d64d12ecf8f.1548771561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v6.git.gitgitgadget@gmail.com>
References: <pull.31.v5.git.gitgitgadget@gmail.com>
        <pull.31.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 16/21] mingw: try to work around issues with the test
 cleanup
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

It seems that every once in a while in the Git for Windows SDK, there
are some transient file locking issues preventing the test clean up to
delete the trash directory. Let's be gentle and try again five seconds
later, and only error out if it still fails the second time.

This change helps Windows, and does not hurt any other platform
(normally, it is highly unlikely that said deletion fails, and if it
does, normally it will fail again even 5 seconds later).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index f31a1c8f79..9c0ca5effb 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1104,7 +1104,11 @@ test_done () {
 			error "Tests passed but trash directory already removed before test cleanup; aborting"
 
 			cd "$TRASH_DIRECTORY/.." &&
-			rm -fr "$TRASH_DIRECTORY" ||
+			rm -fr "$TRASH_DIRECTORY" || {
+				# try again in a bit
+				sleep 5;
+				rm -fr "$TRASH_DIRECTORY"
+			} ||
 			error "Tests passed but test cleanup failed; aborting"
 		fi
 		test_at_end_hook_
-- 
gitgitgadget

