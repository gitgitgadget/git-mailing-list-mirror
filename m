Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 179EB20248
	for <e@80x24.org>; Fri, 12 Apr 2019 12:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfDLMAj (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 08:00:39 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:44216 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfDLMAg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 08:00:36 -0400
Received: by mail-ed1-f45.google.com with SMTP id d11so8074094edp.11
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 05:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=a6HInrpazxG+ZyyT+ukU+pYjlFBdRKEAQDUrtHtpFz0=;
        b=A3rlgVCHmGboLA7T42G3h43zv9dUYYHxmZLo32/TXZ9auK8lY6oejO4W0NcZ2EAZYU
         YqbKfpkmJVZwqiEIkJa8xKv/uyi4rq4w9p3yUkd+dxdbmo/g7xBs6/RG9ROHBHIx50se
         ZXtCxBC7NXHecC+Mq6y1p6UKeNhBIkDRjFwfi0d5rzQte8sWRzLiJH9eyMNTFvca+XlL
         C2VW12A34BjvknsnIg1WxpLGkOgOupcqyG9EVxo/gg5e4R2MiOC5BuxacJCFrLSJYzvp
         yLiulU5aepIXFdNwMYv7HlvKbbbaRa2lyj/mgzHez5KnlvJ0WepCDPfcCK6O6fcuaHrF
         t59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=a6HInrpazxG+ZyyT+ukU+pYjlFBdRKEAQDUrtHtpFz0=;
        b=ssbILj8yxTtXLiRZ5L+mxN8K07mUWYnwZ5zrBfyCcYVbK1UzdwkNNNlgn4QoXTGjR5
         MeJb8ZcxFR/85H56ShNECHo658WwTdbUwnQdsAqJDGa9IJBB5bisuc0uXrISPyjf2GOb
         +I8Cbb3Ar16jo81uU7wpwqsGGAgRqYIi4M2bL0yVtyD0MBOBYKpgzddH6fRjZGnkRIxL
         sxSef1NaMxJ6Mtcm6wACnCpuRMvv3nyF2TM7E8sED1unsmkf0jFbzCl32vTx+L9+jHsI
         NlGv09t06oVgK5sMTDiXJy2rFH1sqg0AWRdz+KnmbZKjuP1nf9Xlq9jgm65qjhlRr9Tx
         +OHQ==
X-Gm-Message-State: APjAAAUIpnaLxPGy5czN4bWgc6MeShSwUC/bpGzJ6XyXALZSDxRM5jlM
        YS9zqP4j96AE1OS8lfuOa7rG/5CH
X-Google-Smtp-Source: APXvYqxIuPsoVwljJWP+ognKkYj19Nb3G1aOJJby1HzcGjLBmzQXZJ8wFAtVxRJ0AnhEB5FWf1lgEw==
X-Received: by 2002:a17:906:1545:: with SMTP id c5mr31431442ejd.135.1555070434259;
        Fri, 12 Apr 2019 05:00:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m10sm397644edl.62.2019.04.12.05.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 05:00:33 -0700 (PDT)
Date:   Fri, 12 Apr 2019 05:00:33 -0700 (PDT)
X-Google-Original-Date: Fri, 12 Apr 2019 12:00:26 GMT
Message-Id: <96ced7e17cb40c4d0f15955c482857196862ab80.1555070430.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.168.git.gitgitgadget@gmail.com>
References: <pull.168.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/7] check-docs: do not pretend that commands are listed which
 are excluded
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

In the previous commit, we taught `git help -a` to stop listing commands
that are excluded from the build.

In this commit, we stop `check-docs` from claiming that those commands
are listed.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 8f3c477ab3..5880d4d3a9 100644
--- a/Makefile
+++ b/Makefile
@@ -3085,6 +3085,7 @@ check-docs::
 	( \
 		sed -e '1,/^### command list/d' \
 		    -e '/^#/d' \
+		    $(patsubst %,-e '/^% /d',$(EXCLUDED_PROGRAMS)) \
 		    -e '/guide$$/d' \
 		    -e 's/[ 	].*//' \
 		    -e 's/^/listed /' command-list.txt; \
-- 
gitgitgadget

