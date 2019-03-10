Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AB6820248
	for <e@80x24.org>; Sun, 10 Mar 2019 14:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfCJObf (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Mar 2019 10:31:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37433 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfCJObf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Mar 2019 10:31:35 -0400
Received: by mail-pf1-f196.google.com with SMTP id s22so1758889pfh.4
        for <git@vger.kernel.org>; Sun, 10 Mar 2019 07:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :signed-off-by:user-agent;
        bh=JcZCeepqrLYUgV4dYFjkrB58Eldnlr+j+4lOfBqoZ3Q=;
        b=cHWmy4Di22GjXgQuhqO/JnISFcwFEsTdj8IyTJa/ABAykOIf9zXaquwR8l7aEI/sJ9
         cmnkOJ3AUGBcDBfSsxtbBkMuNKXuZ1o8xHZHFRLhJVD3ChQhYsWrAzxoepX2nfZWyFv7
         om5mS1rm+JYdaNMrry1pcHJh59iw1+5MnBRKBQi92buOlTYRZwTb07Oy6ZQJTSPHJ1lh
         na2jIfly4q6UqU+ctndtHYFQLxh+BDrXy4bR0Zm65RZMh1Pje5/NnhVi6ZhpOU8/IMm3
         fRAqMpafCsmB5d3k7XtniC10RidI6LmlLTKdG9wFnGGVu3VRy6TgQNZ45uA653PeYUYs
         1wuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:signed-off-by:user-agent;
        bh=JcZCeepqrLYUgV4dYFjkrB58Eldnlr+j+4lOfBqoZ3Q=;
        b=nN44aGEZCyq1Sk2PD0bJRcpRvn1rd0R9xmn8V8pgFCpQ1OCbyHcYnRxdfv9j+vNXk1
         NNek+uutQTOKkRSVXQe4bqXfxPylf2tTmLRegQitVrSG7xpZXsnAYXc7KOjQV9JgCEm0
         W4QOaxjugImslSze9EnxNgjq641l3nAkK1UOMvMYXhV3vTBAPHR/m6oms4sMfXfk4xIo
         LqlZ6sudhPmQRgo95/G0Pfd8SXZp3uEARjIX8pO1v7eM5t9PmUnk2DjOobiq0xPe1Dfj
         WkW0jiPKdF7hUI7S50t6tZjZXKVw+mWY3tfU5jNY/a5JWUJS+73et+Tx52+KVI//5ThI
         9AvQ==
X-Gm-Message-State: APjAAAUVYXCZuGVbpbdkmhvlcsD94dFjUE7049k/4FhMUpzMeVx8hZYB
        yrRbEfOh18Z68+vcVz28vF0Q8LoeSfc=
X-Google-Smtp-Source: APXvYqzHyI5jsCuOeBaZAaN3mR7cK2OZLaFLFl3iwrv6Ktp/TRjdmIP1358b2UdM8rCZfu6HZ17Pow==
X-Received: by 2002:a62:1706:: with SMTP id 6mr28001630pfx.28.1552228293938;
        Sun, 10 Mar 2019 07:31:33 -0700 (PDT)
Received: from hacker-queen ([157.49.180.183])
        by smtp.gmail.com with ESMTPSA id i7sm4884316pgp.62.2019.03.10.07.31.31
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 07:31:33 -0700 (PDT)
From:   sushmaunnibhavi <sushmaunnibhavi425@gmail.com>
X-Google-Original-From: sushmaunnibhavi <sushmaunnibhavi@gmail.com>
Date:   Sun, 10 Mar 2019 20:01:26 +0530
To:     git@vger.kernel.org
Subject: [GSOC][PATCH] Fixed an issue which contained extra unnecessary code
Message-ID: <20190310143126.GA13588@hacker-queen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Signed-off-by: Sushma Unnibhavi <sushmaunnibhavi425@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From 5a6c233c6bf0a35aca000b32b9e936a34532900a Mon Sep 17 00:00:00 2001
From: sushmaunnibhavi <sushmaunnibhavi@gmail.com>
Date: Sun, 10 Mar 2019 19:37:33 +0530
Subject: [GSOC][PATCH] Fixed an issue which contained extra unnecessary code
Signed-off-by: Sushma Unnibhavi <sushmaunnibhavi425@gmail.com>
---
Since '\n' and '\0' are char_len==1,it is not necessary to check if the char_len<=1.
 compat/regex/regexec.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
index 1b5d89fd5e..df62597531 100644
--- a/compat/regex/regexec.c
+++ b/compat/regex/regexec.c
@@ -3799,11 +3799,6 @@ check_node_accept_bytes (const re_dfa_t *dfa, int node_idx,
   char_len = re_string_char_size_at (input, str_idx);
   if (node->type == OP_PERIOD)
     {
-      if (char_len <= 1)
-	return 0;
-      /* FIXME: I don't think this if is needed, as both '\n'
-	 and '\0' are char_len == 1.  */
-      /* '.' accepts any one character except the following two cases.  */
       if ((!(dfa->syntax & RE_DOT_NEWLINE) &&
 	   re_string_byte_at (input, str_idx) == '\n') ||
 	  ((dfa->syntax & RE_DOT_NOT_NULL) &&
-- 
2.17.1

