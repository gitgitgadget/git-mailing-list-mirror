Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 831D020705
	for <e@80x24.org>; Wed,  7 Sep 2016 11:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757375AbcIGLVJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 07:21:09 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36647 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757363AbcIGLVE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 07:21:04 -0400
Received: by mail-pf0-f193.google.com with SMTP id x24so827235pfa.3
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 04:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Zqzy+8oYBJOJiLi7tUmCNEiWa3XVY41P7oWLrTd2jw=;
        b=jV07IJyUCGBMSRdRJD4U+24XAZZMfWvySu8LAWyHwTg2cUvsNZUT8woReJp7TlH7vg
         Df7/RXtUDTOQh3/Gf4pUaeXNpHHyKsTT0kFBxhykfbq+ffENCI6LSvy3eYB1RKR1f8/+
         JjpeFykSaW8yvuTWAKJgMVIzzpcAhixgg+tQpjCDktfPXdIzPy2kCdmagdD93eLlYG1L
         VAQGDSc+83Rgj/ATuRl5GuZ0dQ2QmXMNFxbGWKgOivrFAqPsg+2hyosUnFjNQh6PKSd6
         3plbg428oOB6/pBnvGf1URKzOOIioo4Othxt5LyvrAmzQxvmD1TjqsiuN9bShD7XQmZk
         JWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Zqzy+8oYBJOJiLi7tUmCNEiWa3XVY41P7oWLrTd2jw=;
        b=D583tMZFiA8lMWyE5dFJHz6y135vjY6XFFPjOWYrQ91VhWlkXFNCwOunodltvbqENU
         //ZONs+0OkU88UlykmP/VHEK2UDBcKBGd7+pdS26UbIE+brwKO5SeIiH36uzbG3Dy1VA
         qaNSyL4H7aVf0w2q7j5y3JK4kPNjC9INunhABcn0NqDfvz6uM5hvy5Tgw/6ctVNDyov3
         Inv5q7jP0rQNCYl8Z3jsp8OScsy1TnJolAIF+3lmAgzLb86czunm+2zH1QYKOIxFt/mf
         R5p8C+K4apTp5pe4HFZ5LHaManXQKbZX7SFU/kBdvD+IDevjjpAwb5Ny4py4++ZPWMtO
         /zAA==
X-Gm-Message-State: AE9vXwNR3xrnxFUrpFyH6+S4qBGbfOEsmpP7RI1wukO/lJ0pPNKoYMpLkkc2s+bEX+RmgQ==
X-Received: by 10.98.141.219 with SMTP id p88mr48538394pfk.153.1473247248955;
        Wed, 07 Sep 2016 04:20:48 -0700 (PDT)
Received: from ash ([115.76.139.213])
        by smtp.gmail.com with ESMTPSA id n3sm48272118paf.13.2016.09.07.04.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Sep 2016 04:20:48 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 07 Sep 2016 18:20:44 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/3] checkout: add some spaces between code and comment
Date:   Wed,  7 Sep 2016 18:19:39 +0700
Message-Id: <20160907111941.2342-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160907111941.2342-1-pclouds@gmail.com>
References: <20160822123502.3521-1-pclouds@gmail.com>
 <20160907111941.2342-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8672d07..1f71d06 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1038,7 +1038,7 @@ static int parse_branchname_arg(int argc, const char **argv,
 
 	if (!*source_tree)                   /* case (1): want a tree */
 		die(_("reference is not a tree: %s"), arg);
-	if (!has_dash_dash) {/* case (3).(d) -> (1) */
+	if (!has_dash_dash) {	/* case (3).(d) -> (1) */
 		/*
 		 * Do not complain the most common case
 		 *	git checkout branch
-- 
2.8.2.524.g6ff3d78

