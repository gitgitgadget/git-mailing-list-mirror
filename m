Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D889B1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 21:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbeIDBcm (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 21:32:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36898 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeIDBcm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 21:32:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id 2-v6so611359pgo.4
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 14:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Jz5/j2D8ZQx6cnVsey4wPwf9ZQuPOJxVq8aS8QV5hlY=;
        b=aVhGinDLgFmiCGfh0GTCBwc0oxihlcrrEQMBicdsL+ycZ31T4EDSYSnSVx4OUquWw8
         PT8W+Dw2a5R/iEDoN/QziLvhXBUGCawb8yJV6slzJAE+lNXyVHDDEaWCs1Vt5h31sK6C
         shnOrYS86mQ6DFnE5jZ5T6gqG90v2vFJ/ICfuLiYaPrxmKha59I/lBXV00Znpl46Tut+
         RLucFqMObruMaCSVbMlYW+4nj3gJBZsSc7+ZVui4HgjGxODJtiQaSuk41PHCb59GnyTy
         aAWZcYwXQJA19nWYInZ8yiGqZz0Tsm+GSEo/F/RPgi5Tw7Y+njmxztn6yKb08dCQe/O3
         Z9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Jz5/j2D8ZQx6cnVsey4wPwf9ZQuPOJxVq8aS8QV5hlY=;
        b=BJzXGmFMQsJiVvT/g6EDF2uQLWusa7YiI22ikcbhi4lHbtayVgMjAZv1Us2k2g7znc
         NHoCB8b7IP5ZPTiTRRoQgFDdqTjd3SRMpVXTzysscDphZrDXzl6Or4PmaySBCLyFo1yu
         FlM1BLzHFJ5ExrobdHoQ450YWI830uA5iajIMpFkEeAO5eFbAG/J2/O781XWa0lSubSZ
         FSEO9lsJyarBcm6C9Q/cKi+i1XdSpb2tZjWZxZvjHUVdbyjT+h8z6z0xBwewf/wCz0KT
         AEs1KfP2zSIfABuje7sXQ+kH1diNW0lZb9iLtgvtRs8M2OjrD1Mh8xrjhdYB0cKbvUkH
         vbNg==
X-Gm-Message-State: APzg51DWgkE3aWvZZWRw75SlVUA4S+ZalfrljIxrEJEQ851sFMRPuMUb
        UxWx2daenpTmiaUK1LcjGn9scwLx
X-Google-Smtp-Source: ANB0VdZnmw9VT10F+qM0ZMteZSzZ4B6VFNcxTr8zNUCpW5+DBF5KnLS/AGoBtludBGVwxBTdxPYoCQ==
X-Received: by 2002:a63:f414:: with SMTP id g20-v6mr13563398pgi.407.1536009042209;
        Mon, 03 Sep 2018 14:10:42 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id e8-v6sm28734703pgi.24.2018.09.03.14.10.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 14:10:41 -0700 (PDT)
Date:   Mon, 03 Sep 2018 14:10:41 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Sep 2018 21:10:26 GMT
Message-Id: <dc1d890d718bd629dea03e6f4706e94282891313.1536009027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.git.gitgitgadget@gmail.com>
References: <pull.31.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 9/9] README: add a build badge (status of the VSTS build)
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

Just like so many other OSS projects, we now also have a build badge.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 README.md | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/README.md b/README.md
index f920a42fad..f260e78042 100644
--- a/README.md
+++ b/README.md
@@ -1,3 +1,5 @@
+[![Build Status](https://git.visualstudio.com/git/_apis/build/status/test-git.git)](https://git.visualstudio.com/git/_build/latest?definitionId=2)
+
 Git - fast, scalable, distributed revision control system
 =========================================================
 
-- 
gitgitgadget
