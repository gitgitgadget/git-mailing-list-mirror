Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDF551F453
	for <e@80x24.org>; Tue, 29 Jan 2019 10:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfA2K4E (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 05:56:04 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43130 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfA2K4E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 05:56:04 -0500
Received: by mail-ed1-f68.google.com with SMTP id f9so15570021eds.10
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 02:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uepX89WpmySZVZiQidp5n8vafOSu8WKYPUyxf0bWqHY=;
        b=TIl8vcQyJ0RzXY5Oo/OqPTQvq2RKKhnrVdFYn+4ETj7nYvGaTxJvIv8YnUAn74e4OP
         a4Pr9vub6HxehdAeA+qDEOgQkz6O3ymxSccCJWkjwOuE31+g/4jxN7n3CigsJfLVsGq2
         WGlmN2/Py+SbR3kbhRK96lx7N1GpzZbcQLCtuibTn1i2zgDpksdom6va2+7Fqj6JCWER
         yGo63TSP8mu74/DdilaGpoOtWNAmhLiCRtdFcpD+l3bmRyONUNt0bpgAvsJtmLfAdgNq
         QpcP/DHaikU9WmWtRIyXZQlBqOBRKHBIJQVLdlgFUmQd2R7HHAXDOUAfgU7V1O36Et34
         jjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uepX89WpmySZVZiQidp5n8vafOSu8WKYPUyxf0bWqHY=;
        b=SysPZggA60CBCwCdEt/Ozquy+D1SZ8BJem0AwSzQWcpArLnZYkvfUjUibvfbE7+lH2
         QBLzkx3RuNF25R0rytBt7SsCcmbtZwcJWas4SJ9nHh8T1Rd5l9WEw+bs7y3o1CQLoUxy
         z8/cE7Gg4kdo+L+5LA/m7DMpzQ3X0NXW5HFXjorDTJFm/5S4yP+mr8mRQhtKrSZC8Zp5
         XYedD3l8432gYru7Ai27OttfefZDRuAMCKYlqg9oWZGk6ggXG6IzcIdtgc9/nScrDzx9
         1BUI48eAdtg3DWt2CM1Clo6CND/NTVNQ83aQ6IVVZ5sQAFZUy2bJQMnRP3xEuIbmE8rh
         hlVA==
X-Gm-Message-State: AJcUukd9l9zlMprrEI0p4wXrUXdEkzl/8t/eFekciUOyIGMeLp47ohj/
        GDao7Chg5gKxSSUIcZLefBOU0Ojs
X-Google-Smtp-Source: ALg8bN5E4J6hIWYjwPaC/9R/3m8Loy3HdX03006pdp+gDMgVIipCh/5TMPc1Jn+X9U+G8XxERDo2Lw==
X-Received: by 2002:a17:906:4b41:: with SMTP id j1mr13398921ejv.69.1548759362575;
        Tue, 29 Jan 2019 02:56:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x58sm13928098edm.10.2019.01.29.02.56.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 02:56:02 -0800 (PST)
Date:   Tue, 29 Jan 2019 02:56:02 -0800 (PST)
X-Google-Original-Date: Tue, 29 Jan 2019 10:56:00 GMT
Message-Id: <946d5637f10d25ca7addbe376ead053be569c5e8.1548759361.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.113.git.gitgitgadget@gmail.com>
References: <pull.113.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] fixup! Merge branch 'js/vsts-ci' into pu
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

The js/vsts-ci and sg/travis-specific-cc branches do not interact so
well... While Travis has the Homebrew package gcc@8 installed in their
Xcode 10.1 images, Azure Pipelines' agents do not.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 276b99693d..16f4ecbc67 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -123,7 +123,7 @@ then
 		echo "$SYSTEM_TASKDEFINITIONSURI$SYSTEM_TEAMPROJECT/_build/results?buildId=$1"
 	}
 
-	BREW_INSTALL_PACKAGES=
+	BREW_INSTALL_PACKAGES=gcc@8
 	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
 	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
 	export MAKEFLAGS="--jobs=10"
-- 
gitgitgadget
