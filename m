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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E2601F463
	for <e@80x24.org>; Wed, 25 Sep 2019 08:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406867AbfIYIU6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 04:20:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39679 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405820AbfIYIU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 04:20:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id v4so2932075pff.6
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 01:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y4y/D8zv33L9ePnaNbr7hbkgJuk1SAD4LmlOAkXliKo=;
        b=K4nDs+GMrBFyObRImny42Wztj1UBKjWOV9kLs/zFQMbe29HEBR5q/7zZ4f7bRl2bFo
         dlcrjxMNePD+UT3x8nG19MzjC/vCR364DqRgulhum/t271Cm3q5qYwCXxLeE8d1JVmPI
         hKf8jXNXBUfmMLVyjO3RVXJeeC0IdfJRk5bPb6Iup7rbiIEGVWpdimhrQOc39xXzpgmB
         mwv+QvwFag7kjJlUWeS0ZIIEwU+TOo9StlSakeMEHvClaY1Iorqww9jvw+ifE8veLjAa
         LrqAhjc7e9d9QkFBkv2JJdPLaWBd3ZVnCRxfjctdqZLczrKlJwyRAKD4zhvm4h2wUMdU
         NvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y4y/D8zv33L9ePnaNbr7hbkgJuk1SAD4LmlOAkXliKo=;
        b=Tf5iE9xSKnxxuQhXuyq5ab+ugbcHmBu/YQzBkSOgiCYJSo+BefVLrvyRREIe1mdNHF
         QEu/bqIAAzAFom+bHK+jIfNydmVU2SG+AhhHcdfA7B6KzXvR6lafZdFU9uZFHXkbLqdk
         FlmM8Lfn1WojJyUIJpQoQ9uWUhfLzYTqENYUOycGnJYppvVs/uqm+4pEiXlt1bceuS7x
         u5u2rA3rhfyOLYHwqlymUqKDM3xVSkhUsZxmJUexPPmeaAw6qn2k5LIdpns8m/dJV3VT
         Av8riF+OkO/Od+1mD8BtO9C26yHy9LTmG8eJBJFwEhefr9VRCHkzg7ELb2eTENBJ8C/5
         nj1g==
X-Gm-Message-State: APjAAAW9eqcB9Akh65Np86iGfcMVuHCxQV7GD3nKjg1F9IIh/XH9XtM7
        h7A0EJTvbV652mItIh2eJtLtgIKx
X-Google-Smtp-Source: APXvYqyhtwmPBrcYETgMpscpONx1P8cJJiM3ljGNMhQLcgiU1opozzdZHtRvr77l0GI+Lmwgk5/B5w==
X-Received: by 2002:a63:120a:: with SMTP id h10mr7266187pgl.29.1569399656047;
        Wed, 25 Sep 2019 01:20:56 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id i6sm6076326pfq.20.2019.09.25.01.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 01:20:55 -0700 (PDT)
Date:   Wed, 25 Sep 2019 01:20:53 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 1/4] apply.h: include missing header
Message-ID: <74efb6c04c1081d73be4c2666fa45ff2807464c3.1569398897.git.liu.denton@gmail.com>
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

When running `make hdr-check`, we got the following error messages:

	apply.h:146:22: error: use of undeclared identifier 'GIT_MAX_HEXSZ'
		char old_oid_prefix[GIT_MAX_HEXSZ + 1];
				    ^
	apply.h:147:22: error: use of undeclared identifier 'GIT_MAX_HEXSZ'
		char new_oid_prefix[GIT_MAX_HEXSZ + 1];
				    ^
	apply.h:151:33: error: array has incomplete element type 'struct object_id'
		struct object_id threeway_stage[3];
					       ^
	./strbuf.h:79:8: note: forward declaration of 'struct object_id'
	struct object_id;
	       ^
	3 errors generated.
	make: *** [apply.hco] Error 1

Include the missing "hash.h" header to fix these errors.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 apply.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/apply.h b/apply.h
index a795193435..da3d95fa50 100644
--- a/apply.h
+++ b/apply.h
@@ -1,6 +1,7 @@
 #ifndef APPLY_H
 #define APPLY_H
 
+#include "hash.h"
 #include "lockfile.h"
 #include "string-list.h"
 
-- 
2.23.0.248.g3a9dd8fb08

