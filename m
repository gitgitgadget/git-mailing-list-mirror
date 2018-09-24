Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A06E1F453
	for <e@80x24.org>; Mon, 24 Sep 2018 21:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbeIYDTl (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 23:19:41 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35667 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeIYDTk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 23:19:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id p12-v6so9658457pfh.2
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 14:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=njVK7igx+h9jBQXLDChkUwcNuceJ7yanrcPOpwkbrWU=;
        b=S8W6D2qYj70ErGtKdY2pGGb3nSkqMENkQ2dvM8cJBDN2CZ9lnIBrxYyIjMqk7TEGj2
         6Ibo/lcJ2CFZD7tA17iThZpJOUOiZPIBdNsDgTVClsDZ4yxeQCzr5QhGEz4m8qw2f9O5
         6Eop70nbalW/Qu8X4VC5U+kpB+cBndEg8fCgpr8QGDZnHTKHt1yu/b5k/J5OScfg5uwZ
         /mBoSEe1JxscE21hf1sk7sCq9/nDIkrlRIBDR1G1MSMZ173jTjb9h7C+JwuJcd2vLY+v
         1jwmQaFeb8lc47vcBl2vHovU8ofLGEQ39iLGp0eCtemU4d8esTBx9Ul+B7h5oZNr/Qmz
         rOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=njVK7igx+h9jBQXLDChkUwcNuceJ7yanrcPOpwkbrWU=;
        b=JKcFG3EnzTWSF/AWmbw+/J5/Mn8Stz7lljeeMzCxRK6xGkCRWKGcEJqkrR/nfnEZsG
         W6ZiohjgzfvlaHeN4IVk+Yc1ronjc3Ux0nmCP78fuUWtRZ6XE7vXIn8G0lofTywG2eQy
         t4lYt0FBZ7HyQ4lN69oa325ER47rtgmGbeQDNhP9M1dXMPGj10ubLmBD/NcdbRQgOdcl
         Sno7CsdOYfozd2+bY7Km423F2rJ0hPSmTs/5G7y9c+3JUww2bBMvyYHaR10E91x4Ykyn
         6z2fWlzZ/0jKdHpBQgZXxnuScvj5n8ZbBnTEKSxAHqbA5yINIp+QjmMf8wi/XUij6qE3
         p9Fw==
X-Gm-Message-State: ABuFfogX2mQ8880luPWEBcJzuYjltMHxv/I7IA8F93b4zOS+Io7WSi5q
        xvf5lBRVlO4v86A92t1W+tUV1Nxg
X-Google-Smtp-Source: ACcGV63I5rxQ+zJIz5yZPAZHj0xLGWQWZlj3K2SfOS1/6HYkDlWWqIdDG1Iq2mE6afy6t/fEVXnefg==
X-Received: by 2002:a62:5c03:: with SMTP id q3-v6mr547767pfb.182.1537823731596;
        Mon, 24 Sep 2018 14:15:31 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id h82-v6sm273540pfa.173.2018.09.24.14.15.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 14:15:30 -0700 (PDT)
Date:   Mon, 24 Sep 2018 14:15:30 -0700 (PDT)
X-Google-Original-Date: Mon, 24 Sep 2018 21:15:27 GMT
Message-Id: <56374128136fe9377503d446daf98e67847194aa.1537823728.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.41.git.gitgitgadget@gmail.com>
References: <pull.41.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] read-cache: update index format default to v4
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, peartben@gmail.com, git@jeffhostetler.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The index v4 format has been available since 2012 with 9d22778
"reach-cache.c: write prefix-compressed names in the index". Since
the format has been stable for so long, almost all versions of Git
in use today understand version 4, removing one barrier to upgrade
-- that someone may want to downgrade and needs a working repo.

Despite being stable for a long time, this index version was never
adopted as the default. This prefix-compressed version of the format
can get significant space savings on repos with large working
directories (which naturally tend to have deep nesting). This version
is set as the default for some external tools, such as VFS for Git.
Because of this external use, the format has had a lot of "testing in
production" and also is subject to continuous integration in these
environments.

Previously, to test version 4 indexes, we needed to run the test
suite with GIT_TEST_INDEX_VERSION=4 (or TEST_GIT_INDEX_VERSION=4).

One potential, but short-term, downside is that we lose coverage of
the version 3 indexes. The trade-off is that we may want to cover
that version using GIT_TEST_INDEX_VERSION=3.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 372588260e..af6c8f2a67 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1484,7 +1484,7 @@ struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
  * Index File I/O
  *****************************************************************/
 
-#define INDEX_FORMAT_DEFAULT 3
+#define INDEX_FORMAT_DEFAULT 4
 
 static unsigned int get_index_format_default(void)
 {
-- 
gitgitgadget
