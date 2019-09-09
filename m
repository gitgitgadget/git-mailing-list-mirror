Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A41991F463
	for <e@80x24.org>; Mon,  9 Sep 2019 23:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389605AbfIIXVG (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 19:21:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42141 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729890AbfIIXVF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 19:21:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id q14so16355321wrm.9
        for <git@vger.kernel.org>; Mon, 09 Sep 2019 16:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XlHMLn6UEFGZU1p0hvcM1rwClK76NlMTN+T/jzQstug=;
        b=d6WCdqoFwDDn3aPGzLJgrwxtgHHuHAfTtmOiJtVIRTq0qAxWIosR5ZGxvUH6wqeb6T
         k3yuilMOlcmxFigKJKtWg0DRHmvfDl0jNGLW0vW7fXuRncAwKvQS2t2iDUIVGq+Ido0/
         h/kvy/V5ohG/j+SStwfrp4Xlq+KrGnKM76LVXBURzFhBoilmAy9pjJF49S1cJfqdwqJ1
         rXtuEAotJ4Gat5kucqV58sAToCV9NqZlyoyEXrmbivExUWg+f3/xOKRzIBr9yPB3vG1N
         ehCFFm26HEva34JKpI+LPsgvh1YYeG1CZzPjxBvASpYvoRjRQLQI/2e4fTXRAf4bCVry
         fD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XlHMLn6UEFGZU1p0hvcM1rwClK76NlMTN+T/jzQstug=;
        b=gZ00xBTDz/z+AdQGJ5NxGnthk4LBU4Gqn5Waes0h4lJ3EvAaI4oUnQjl8qk8JQJKiI
         zvJKGhH8KEWVFdK21YJTz34useuiYEAzj1DLhkfmJiThzvTCwjSV5ugJPABa8451whew
         163OhPRNp+t6+EYaYa4s0/AYbZzyA/EkwRUJhRo2Se6WtU+fTeMvzd8yKOllJt2Ce5Jj
         a0g8lVKnT3DKYUVjrjABFCyoMK42uawN6SoNiSimayC4jQ+wn1O+uysLFSnfs6d8hi9M
         1/Lv/0z1wug8Fuz1dUl8lDgUd+/M/BTv1/f+at9xU+1E3xm/zMeNTI1t5qipe83bqtsP
         oSaA==
X-Gm-Message-State: APjAAAXsfR077lE/3mCxpebiuzIV5oblMNykYTx1yMqP1tkwjXX3nxCc
        tV6apvCKsgI497Ug0bQ7YBpEP3lu
X-Google-Smtp-Source: APXvYqwJEb7/oPkbNrTwNu1kbfwEz7QTmZKzyqqYEGuUsVlxYQFgjgnOlAVAk2WUjieSmrqH3WCf/Q==
X-Received: by 2002:a5d:62c7:: with SMTP id o7mr21486813wrv.197.1568071263890;
        Mon, 09 Sep 2019 16:21:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 189sm1685824wma.6.2019.09.09.16.21.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 16:21:03 -0700 (PDT)
Date:   Mon, 09 Sep 2019 16:21:03 -0700 (PDT)
X-Google-Original-Date: Mon, 09 Sep 2019 23:21:01 GMT
Message-Id: <5248e3332c90e91c1c6a911090d331f005789014.1568071262.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.330.git.gitgitgadget@gmail.com>
References: <pull.330.git.gitgitgadget@gmail.com>
From:   "Cameron Steffen via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/1] doc: small formatting fix
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Cameron Steffen <cam.steffen94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cameron Steffen <cam.steffen94@gmail.com>

move an incorrectly placed backtick

Signed-off-by: Cameron Steffen <cam.steffen94@gmail.com>
---
 Documentation/pretty-formats.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 079598307a..b87e2e83e6 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -208,7 +208,7 @@ endif::git-rev-list[]
 '%GP':: show the fingerprint of the primary key whose subkey was used
 	to sign a signed commit
 '%gD':: reflog selector, e.g., `refs/stash@{1}` or `refs/stash@{2
-	minutes ago`}; the format follows the rules described for the
+	minutes ago}`; the format follows the rules described for the
 	`-g` option. The portion before the `@` is the refname as
 	given on the command line (so `git log -g refs/heads/master`
 	would yield `refs/heads/master@{0}`).
-- 
gitgitgadget
