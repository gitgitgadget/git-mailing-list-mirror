Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69F701F404
	for <e@80x24.org>; Tue, 18 Sep 2018 05:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbeIRLS4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 07:18:56 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52248 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeIRLS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 07:18:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id y139-v6so972913wmc.2
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 22:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yYrNL2V91b8hi6xcX9KWpjL6jRVwusyqKgFPsi0VrrE=;
        b=b+1Se1MCIMZcxBEgRVu7BvaYjwkLb74qBkPfnYw0SLXh0v+G5bXae1Bh8QiSDHoJsC
         qhIsFhWussxcTwJ2c+9u6U7a0lHfxX/kEsFGc2h/UNSJ83EWF8/TPKsVpVXccEIr2aAz
         HfjiUe6YuRNFrSusA1pgSqavwaPcInwDFnaXb+jf/CozibpgJ4tGYUVosX1znjlA/p3v
         m2oq2NkctlZKFIDsYFGO6Gi1jj+fOC+uCuFyPkc8dU5VH7x5pOfHKkiTI8uejhDm8IHf
         K9mLEIZbNTPnjfsWq3vC1l5Zvf97t9KjC8AbQytmAcxStxyxGmQy/C1IT3wRtiGsX/KH
         AdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yYrNL2V91b8hi6xcX9KWpjL6jRVwusyqKgFPsi0VrrE=;
        b=akEgkoDtrvC/cpKFUxkKubVrtXtiYg2h809DGHFOrP4Qd9OGbQ1Q6RO5lO0+yFnV29
         s4JcuxkCDL+MltGaID6j5TERmCjv6JDyM4Fp90rkYm3CdAPkJ1CutUDSifPlX3y9FSDu
         FuEYSu4/Whh6saZxPkNHXgoaI9bdtnjkPEvE/OvpS8O1EazbPSpKm7pqAnWgusccQ0/r
         OjYLzxHz1SVda2xqzsuwRYQyPPldyHChT4YCo5BR7vyG1co7erQ9ZwkTy8oONvteBtAy
         N1XZuRsCS+M56bcOMWQH+9hyvIrm0m2LiQrlEQJyFWXXwdafTx1mEJB7wG8cFKCtHOhz
         kScA==
X-Gm-Message-State: APzg51BwiyTdJXEls5bsClk754KTHFhStxUMFYFofkQrnYqu0xhfUVc2
        WlqtQPUqmVxbIPywCpILTVSIgGpgEfA=
X-Google-Smtp-Source: ANB0VdauA00cdaY7aceNlM7mOOmZOVME8fZ+Gg48yGUC2q+88uu62eprFJrg0NBLXJjYCpBNIMftwQ==
X-Received: by 2002:a1c:cbc1:: with SMTP id b184-v6mr14391367wmg.149.1537249676512;
        Mon, 17 Sep 2018 22:47:56 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 132-v6sm881398wmd.13.2018.09.17.22.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 22:47:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 3/3] fetch doc: correct grammar in --force docs
Date:   Tue, 18 Sep 2018 05:47:40 +0000
Message-Id: <20180918054740.24180-4-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc2.392.g5ba43deb5a
In-Reply-To: <20180918054740.24180-1-avarab@gmail.com>
References: <20180918054740.24180-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Work the same" is incorrect and needs to be "Works the same
way". Fixes grammar in document anion I added in the recently landed
0bc8d71b99 ("fetch: stop clobbering existing tags without --force",
2018-08-31).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/pull-fetch-param.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index 2b1fbe03aa..7d3a60f5b9 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -47,7 +47,7 @@ Until Git version 2.20, and unlike when pushing with
 linkgit:git-push[1], any updates to `refs/tags/*` would be accepted
 without `+` in the refspec (or `--force`). When fetching, we promiscuously
 considered all tag updates from a remote to be forced fetches.  Since
-Git version 2.20, fetching to update `refs/tags/*` work the same way
+Git version 2.20, fetching to update `refs/tags/*` works the same way
 as when pushing. I.e. any updates will be rejected without `+` in the
 refspec (or `--force`).
 +
-- 
2.19.0.rc2.392.g5ba43deb5a

