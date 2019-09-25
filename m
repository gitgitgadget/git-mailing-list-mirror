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
	by dcvr.yhbt.net (Postfix) with ESMTP id 011001F463
	for <e@80x24.org>; Wed, 25 Sep 2019 08:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406889AbfIYIVA (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 04:21:00 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43647 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405820AbfIYIVA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 04:21:00 -0400
Received: by mail-pf1-f194.google.com with SMTP id a2so2920301pfo.10
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 01:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lFcV47DB4Mjsk7x9zpQCBh38AxGXQgtojKWMVnYNzUs=;
        b=mTKo40GTFYAtlGk9Yb99nnhh9FNb8F9uB5I258SZciKS/2fdZAjZLBji+rYgsbTQCg
         qPKiGT49erRFEQxxxpSDOqgGeK0BuS0fnQg/7ZG81EmXbRzKCQg00R9NOxO1OYMfU0nc
         Ese9KqrZ2SAS1FJENO5fas0KJwBNKR9zU7xF8eRkSxz1wkmnOOLU3QsLsQKL3LZuHaAo
         WPF8HaHeJs2IND7CsoH/DUUIOZdRMJga5sOi1v5frj+JPSeZ6fI90KA/q3tPNpJ6ru6Q
         1eII2NEfd1sGLN6y+TM8IrOjz2HC6TYhsa15bpdPC+/0r6FLyCJIDK/tD+l8pDP+9QKK
         No0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lFcV47DB4Mjsk7x9zpQCBh38AxGXQgtojKWMVnYNzUs=;
        b=YYfjSErdx0qLGH3iIkOVIKZR4lxnI9oYOgIk3c9NUJ48LH/KlUAxIbatb68RGVt01r
         BG3io21bFyhbAnstblnV7qS12CoLxaENF1kmSO+AJ1pc7FtT0RiDeNNBjYk3VTTtTZoc
         Bp3jCn8sII/ZIkNsMzms/f1AMV2lrRnvR6Ez8glKQROvnJYlHxcqCJTMsmenCKOUeHZo
         rDtf316efC9blKJnzZPyUU0rhOJvyw790oUnBX3xrvsMUStWRo+uGM9E4xMdXpHkU8mT
         MFOaFpdu4RsGrTHAXKpSQ5nugqv5IdUdAHmXRj70pkCV8ZuV7WEtmAs2hAMNXhhU7Vp7
         2tBQ==
X-Gm-Message-State: APjAAAVOVotS4Mp2cMHZRLY2MZi/KGOz8JIySR3IcVI7RlkmYnCv3Y3/
        PVJCpOuQ0yf7ZY12AFAWHXwP1eRe
X-Google-Smtp-Source: APXvYqwWPb5N4B0LfK6+CdliO0figB2p/4EerY4ZMVaOPmWaSJmMpjtmL1ClFNhL8c7mETnHL7LIbQ==
X-Received: by 2002:a17:90a:630b:: with SMTP id e11mr5209829pjj.132.1569399658857;
        Wed, 25 Sep 2019 01:20:58 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id cx22sm1911596pjb.19.2019.09.25.01.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 01:20:58 -0700 (PDT)
Date:   Wed, 25 Sep 2019 01:20:56 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 2/4] promisor-remote.h: include missing header
Message-ID: <2befc450fb04dde1f676ec9d0cf04da9b1a1ca70.1569398897.git.liu.denton@gmail.com>
References: <cover.1569263631.git.liu.denton@gmail.com>
 <cover.1569398897.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1569398897.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we ran `make hdr-check`, we got the following warning message:

	promisor-remote.h:21:46: warning: declaration of 'struct repository' will not be visible outside of this function [-Wvisibility]
	extern int promisor_remote_get_direct(struct repository *repo,
						     ^
	1 warning generated.

This was caused by a missing reference to `struct repository`, which is
defined in "repository.h".

Include this missing header to fix this warning.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 promisor-remote.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/promisor-remote.h b/promisor-remote.h
index 8200dfc940..76e8d86c7c 100644
--- a/promisor-remote.h
+++ b/promisor-remote.h
@@ -1,6 +1,8 @@
 #ifndef PROMISOR_REMOTE_H
 #define PROMISOR_REMOTE_H
 
+#include "repository.h"
+
 struct object_id;
 
 /*
-- 
2.23.0.248.g3a9dd8fb08

