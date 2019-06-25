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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DAC31F461
	for <e@80x24.org>; Tue, 25 Jun 2019 14:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731513AbfFYOtf (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 10:49:35 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39020 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731198AbfFYOte (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 10:49:34 -0400
Received: by mail-ed1-f65.google.com with SMTP id m10so27562063edv.6
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 07:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LoCuUzbLrTlxvzT3SSXNCTd+NcF5pCsvxAgW+KCAJpY=;
        b=l1GCFALLsygH6W65cUuJNs9+pMr0yJkiIL6qA9xrL/mIBs3Qd0xLiUebu/0qwxRxUN
         EpBJwLTgl7iTQgcudSG1HsoLc3QbQi1XuqwJw3x6sZiWMLj5bncXFMc8hxbTS/3mDaff
         e+J6DV3ZhxraHzFRlEVX1ecswD//8fj0GCVLal1NM4REF8KR8xRySgZuE3XQE3P+5U2c
         Ef3SzjQVlUgFFrlp6TP5bAfWkavZ7fBcwAqCwEUJYltOIfeRF8uq2fB8kr98D1Rj0o+l
         i3goMIExSZkOR9UkmPz8wIUYLbgbnlI10hgL8YtpMwPDROaWuq8sed25ydTz7Z12AcHt
         bgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LoCuUzbLrTlxvzT3SSXNCTd+NcF5pCsvxAgW+KCAJpY=;
        b=hTy2iOgF/6iNiuCRdr0h3Q06Kwi9bSysAy14KQC2ZaLXkcETeIsHVOMxbBmdJPN9vU
         E3N9A7a864MpS+YgsUisSeWpU4npQmT2ewkng0ecrHUkVt6asw94xuiX8clcnzLytKNJ
         pWqg6AA9U29ibEED3rwWnObSL66AAxjUG5l290QSzkgWWvp+PcdqjcPICpanaviiWgDQ
         3wncLPmtdAquBis+ZoIzu82HbGA1+PVXHdXinhMeq4NfjxLubdGRRhFZQ89N5cYkri/4
         CEK8Z1m4bSJDCSeuigGb8iWiuLMEgdwMlLWNQ7rHn5KZGOgBoLmmrgqvhu5vyaQZMPwT
         s1lg==
X-Gm-Message-State: APjAAAWTrvpursgP4+lTmPH4A2tyyIkGv4NQXIqrVKbYcJ/GfgRHCeaH
        MK0cxh8xXeSGJ+FsPZ/Rd/0EKO1o
X-Google-Smtp-Source: APXvYqwqoj960Q3XOQ+CkJXBPGbU/LJ+Afa98J+OQBIQbTOxAZig6xKshJkRgLlLaa/A0SOZEXoSgw==
X-Received: by 2002:a50:aed6:: with SMTP id f22mr60890521edd.59.1561474172645;
        Tue, 25 Jun 2019 07:49:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m32sm4918284edc.89.2019.06.25.07.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 07:49:32 -0700 (PDT)
Date:   Tue, 25 Jun 2019 07:49:32 -0700 (PDT)
X-Google-Original-Date: Tue, 25 Jun 2019 14:49:11 GMT
Message-Id: <71d85b58b66af94b6e85776f74a63774bfb91845.1561474167.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.149.v3.git.gitgitgadget@gmail.com>
References: <pull.149.v2.git.gitgitgadget@gmail.com>
        <pull.149.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 05/20] obstack: fix compiler warning
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

