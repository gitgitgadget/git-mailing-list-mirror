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
	by dcvr.yhbt.net (Postfix) with ESMTP id F24841F462
	for <e@80x24.org>; Wed, 19 Jun 2019 21:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbfFSVGG (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 17:06:06 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40006 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfFSVGB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 17:06:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so1275497eds.7
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 14:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LoCuUzbLrTlxvzT3SSXNCTd+NcF5pCsvxAgW+KCAJpY=;
        b=Amx8ArF9jaOMfSQIh8vjjfPfdr3AcNPvR3q3CQz+F3o9j0+NXIX6luJpsbUpvyi9yI
         Ko8xU9QESeqWeYKS76zqc+9lIrkM7y7MyOmnoDTG4H75QMn4JRLyPfNEx1gaSythowdS
         KR1HR0x8dL9pWy32uNf+cwHaE6aoI7ZM4dF4Yyw41DAKTk5V24vL5In+VbdQ4tjqiiyu
         hkKR6YV1rwzmYhL1N8l7dcR5ww91KdN8ciLYH/+VkuqX7FK4MOqRGM1oUfPD5IMs/4IR
         TzuVm82lk4mnP5yO5vDWMM4eKQafOQDyr7ix3aZdpa/I9vU+TIFcETmA9lbr0+1TqnpH
         4sxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LoCuUzbLrTlxvzT3SSXNCTd+NcF5pCsvxAgW+KCAJpY=;
        b=jISRLnE1SdH7ELH9oB+PZg7aX//tmFuOCruKelZ0hyXqD9yhItCn9KQU4IeMRZ9Crx
         aHxP0JJfPKRPcl0JnX2C/pqtNI4Qos414hBaZE5wmIFRXujibiV4hIGev74Tuq1rqZAk
         E1KfVm5T9jZqDYqSaYDrYFJQ1R+umvS22J5lnQSfh5vyu2BgBrH7k3pHZ5xVPateyhPa
         deG3vszrHeApu5QbZJTEv13zPa+O4GZJueke8ZclbAhMuxULmzK9CZUIUaGh3+RH0C90
         dwqbX/39bWY3dAwcy1A5sToaYaerNVo+F4o13tpUwBBnFD7ojDEYKv7eTgsulk6fkcKo
         OmGw==
X-Gm-Message-State: APjAAAWWhwmz0mUNdIvVk2+eTW61jskO2F1lb/MkCX873Gjp0KgQ1bhc
        JtAMXJ9T0pGf2gjkmwBDoOKTKENJ
X-Google-Smtp-Source: APXvYqx85QoDiVsJVJEQMy16Jg1xJPmArTdb4qsihWUmAoINigVEUua4pdkNJR1APuGXrWWoOErxfA==
X-Received: by 2002:a50:9590:: with SMTP id w16mr114351820eda.0.1560978359659;
        Wed, 19 Jun 2019 14:05:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b25sm5884661ede.34.2019.06.19.14.05.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 14:05:59 -0700 (PDT)
Date:   Wed, 19 Jun 2019 14:05:59 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 21:05:39 GMT
Message-Id: <71d85b58b66af94b6e85776f74a63774bfb91845.1560978354.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v2.git.gitgitgadget@gmail.com>
References: <pull.149.git.gitgitgadget@gmail.com>
        <pull.149.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 05/20] obstack: fix compiler warning
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

MS Visual C suggests that the construct

	condition ? (int) i : (ptrdiff_t) d

is incorrect. Let's fix this by casting to ptrdiff_t also for the
positive arm of the conditional.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/obstack.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/obstack.h b/compat/obstack.h
index ced94d0118..ae36ed6a66 100644
--- a/compat/obstack.h
+++ b/compat/obstack.h
@@ -496,7 +496,7 @@ __extension__								\
 ( (h)->temp.tempint = (char *) (obj) - (char *) (h)->chunk,		\
   ((((h)->temp.tempint > 0						\
     && (h)->temp.tempint < (h)->chunk_limit - (char *) (h)->chunk))	\
-   ? (int) ((h)->next_free = (h)->object_base				\
+   ? (ptrdiff_t) ((h)->next_free = (h)->object_base				\
 	    = (h)->temp.tempint + (char *) (h)->chunk)			\
    : (((obstack_free) ((h), (h)->temp.tempint + (char *) (h)->chunk), 0), 0)))
 
-- 
gitgitgadget

