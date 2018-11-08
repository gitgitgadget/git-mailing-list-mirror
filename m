Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F6531F453
	for <e@80x24.org>; Thu,  8 Nov 2018 04:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbeKHO2g (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 09:28:36 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:38849 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbeKHO2g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 09:28:36 -0500
Received: by mail-pf1-f179.google.com with SMTP id b11-v6so8755963pfi.5
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 20:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PpyWUWyYCwRPIJRv0hsR8EFW6rgo8fGBdtd2ufw8cTQ=;
        b=aA7/6ZmPG9qyOuAtHa3G/hV7pvR12hnfqK92/8UWUlXx62kwG3bnyk0cFfBtUfH7t4
         9eYk+msHZyYVh2Jq+qGXobvk1A8iCFmB3H4IB8Fz63oQaOTZmq8OINIbenuea+Iv5yPl
         wWQUIVN9G/NhFlp7yyectPCtTchn/PAq6XMj21CuNioKkDSaIOrRVpQxkgwhe8ioaDvF
         pYxcqg8MAge8C+FvJ2dneoH4ddOQmKIGJbCA7AZGGvYPN+o3X6HG0YOIg/W2iKxzZvBm
         a8F7mVdYDKtgg1r3B/Ee+73SGFXDCJrzDKdTBQ/GiQtoDD+4ehxCQ+aBye2NeGr23bRc
         GLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PpyWUWyYCwRPIJRv0hsR8EFW6rgo8fGBdtd2ufw8cTQ=;
        b=B/Xuqe7Wh8OxkHDR3LLWioJOrwbBTqtAbSCebfSypS4OA/2sJ8WPvkvt70VIBno9/o
         tsE+F9q2mCdCJXX34GXdbCdsQgLt5DNGQvudiu4P/ELKaB1xou2ROsy2PC3iButd2H8/
         Z/wdbwElNbBEvLzq999xfURpxg57JeTddY+F/blD0cqZ0y71gPr+hvJzkAuoCPJKbkEW
         jghm3nKiFO4CTYKCoGYd1sYUm3hsPSdu0YI92zg9SJTJzhAjm/3HWce44C3dH2fvTDPZ
         CLvc8FbqkCICBm4kywFtaN48XAd6IYFIhZH/95DBr8nJGr4jxTx/Olv13PTGL/fn0akx
         5v2w==
X-Gm-Message-State: AGRZ1gLJap1WaJ5FuUKi5me+WxmA1zKH3r5sB0WTqtmA9hc4wri/gnNO
        9ITu/UvLrb8PmMD17IkncD6wQTsh
X-Google-Smtp-Source: AJdET5duTI85PyXMGpQ5YhZG0qLkudcwcxrIJRNrtTtPyd+vs4ir0PorcMnv/Qy4QUKAQ/JaYmAGwg==
X-Received: by 2002:aa7:8719:: with SMTP id b25-v6mr3114928pfo.250.1541652898483;
        Wed, 07 Nov 2018 20:54:58 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id f6-v6sm2908811pfg.128.2018.11.07.20.54.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 20:54:57 -0800 (PST)
Date:   Wed, 07 Nov 2018 20:54:57 -0800 (PST)
X-Google-Original-Date: Thu, 08 Nov 2018 04:54:51 GMT
Message-Id: <pull.69.v3.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.69.v2.git.gitgitgadget@gmail.com>
References: <pull.69.v2.git.gitgitgadget@gmail.com>
From:   "Force.Charlie-I via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 0/4] http: add support selecting http version
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Normally, git doesn't need to set curl to select the HTTP version, it works
fine without HTTP/2. Adding HTTP/2 support is a icing on the cake.

This patch support force enable HTTP/2 or HTTP/1.1. 

example: 

GIT_CURL_VERBOSE=1 git2 -c http.version=HTTP/2 ls-remote https://bitbucket.org/aquariusjay/deeplab-public-ver2.git

Force Charlie (4):
  http: add support selecting http version
  support force use http 1.1
  fix curl version to support CURL_HTTP_VERSION_2TLS
  http: change http.version value type

 http.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)


base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-69%2Ffcharlie%2Fmaster-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-69/fcharlie/master-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/69

Range-diff vs v2:

 1:  4f5a935c43 = 1:  4f5a935c43 http: add support selecting http version
 2:  06e9685d2b = 2:  06e9685d2b support force use http 1.1
 3:  eee67d8356 = 3:  eee67d8356 fix curl version to support CURL_HTTP_VERSION_2TLS
 -:  ---------- > 4:  ef975b6093 http: change http.version value type

-- 
gitgitgadget
