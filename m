Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1847E1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 22:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752192AbeCPWdw (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 18:33:52 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:36977 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751951AbeCPWdv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 18:33:51 -0400
Received: by mail-qk0-f193.google.com with SMTP id y137so12713822qka.4
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 15:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eyFV/3f9jOMzFEwB5EyXzSvgmem/cLsCfmnkNtPJ/V4=;
        b=Z5nRDsMiODtIR9V4bvZlrwen3wAdrPDWD+MK3Q0RoMrr5SfW3nL4CHN+OVD4YdyC+j
         FvwVjfGk32NmuNbXtLZttXYHWyXOJSJCVL8Cfkvd2ekZ1SiqD19NxWBVM8KnM2QHh0u6
         2ZbYrtroxc28zSj6zcZYzktu02/3hRNeYEjS1jvhaWSpj82+U77IBVkU3T6htuLGE3RJ
         4ffsI/NEnj1DjuOhmXqAIC7piApHYIpg7JdTUlFv+3UBqbMwtL6KlaUWKmCJVLKBzPp7
         i94J2gJif9n6X+4uBo8CJpF5ddN6txoZMs14/TixOAGaTtdXPdSNT/Tg53lLMLrsPPek
         bK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eyFV/3f9jOMzFEwB5EyXzSvgmem/cLsCfmnkNtPJ/V4=;
        b=ag1mv1KVCIFSW0TrAc8mpxufYanooYBAyQwhb4yExyzn6LRBPMYN0hpKl5cVkeo0Ts
         AcKvCTYgz/hullli+Z06kFx8CwYI/0Vvr6jz/RZnZp2aHzqflGxvm6hBfPCOfEL6/CH2
         gZyVQPkypI7CYfoijoTnWK02TPQV27f7lwcifUWovvEkfcxWrvz24JnapUL7cBsKF8PW
         UMSVpv+64DrYhVcccl1eiBZAcdQXVYy5Ba4s/SFSUZmKXirnPo8r9q1roovRK6FA3LIt
         WITJ+iYhD6tz/8SQDQ6IDD//R8w7N+h3KYg1myksj2hZazTpUEpfS3P1dwomq0KUKyw4
         3u/Q==
X-Gm-Message-State: AElRT7E0wQEvLT4tSpKF+Glxq4n0aAug4tgk+gU5dDBp2nv9vuqADArH
        AYYycYpHfElQeTPtcdoSRbdkFRSqlIE=
X-Google-Smtp-Source: AG47ELu9sbjW2efoUXuvgdOOjZ0DKQJW48W3qF7jpI4HdcDVNtakK8tX8iBgUZ/PV8AFFFnBGDnkqw==
X-Received: by 10.55.217.77 with SMTP id u74mr5293756qki.148.1521239630726;
        Fri, 16 Mar 2018 15:33:50 -0700 (PDT)
Received: from Matrix.hsd1.pa.comcast.net (c-67-186-35-242.hsd1.pa.comcast.net. [67.186.35.242])
        by smtp.gmail.com with ESMTPSA id z67sm5814990qke.19.2018.03.16.15.33.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Mar 2018 15:33:50 -0700 (PDT)
From:   Roger Solano <sroger.git@gmail.com>
X-Google-Original-From: Roger Solano <sc_rogeralberto@hotmail.com>
To:     git@vger.kernel.org
Cc:     Roger Solano <sc_rogeralberto@hotmail.com>
Subject: [GSoC] parse: not show usage help when invalid id
Date:   Fri, 16 Mar 2018 18:33:45 -0400
Message-Id: <20180316223345.7799-1-sc_rogeralberto@hotmail.com>
X-Mailer: git-send-email 2.13.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

patch for too chatty command when <id> is invalid
ex. git tag --contains <id>

It is possible to skip 'goto show_usage_error' when
parse_long_opt fails? and return directly from there.

Signed-off-by: Roger Solano <sc_rogeralberto@hotmail.com>
---
 parse-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index 125e84f98..074915eb3 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -550,7 +550,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			goto show_usage;
 		switch (parse_long_opt(ctx, arg + 2, options)) {
 		case -1:
-			goto show_usage_error;
+			return -1; 
 		case -2:
 			goto unknown;
 		}
-- 
2.13.6

