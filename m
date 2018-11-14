Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95D8E1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 13:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733107AbeKOACY (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 19:02:24 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:34903 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbeKOACX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 19:02:23 -0500
Received: by mail-pg1-f169.google.com with SMTP id 32-v6so7416124pgu.2
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 05:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uWfeXiQPgcGzYWM8+idpgn+Uv+Q5RrNQhW7GFYDOGdw=;
        b=HNVPOsduF/BbQ41KZZVxSyi8N7WEiO4jEEBWOWmei8crn3Wt+Q5jb27MbqtSQN2XGN
         us00wEQLu/fPIKxH3xPYXJxAwibOMxWtAXrao2QJQmztmsSuS9KeHPaifOGBcVZsKWrL
         X4xD/aiiVzOkk67cYTHTOuRhAJDJ/xuRZHJJdma0vc6XqYvdUxhnx/Be78ZGz6nCQ9f8
         52UJu49pMZc33C69ET/Z4AP550o15HL6dDLU6ZjU3e2jwuBHqwxJ2wqj4PYkBU2Bc8Zy
         yvFN368yXbShRj1jUEjwgWSHkzDH5SQyehq8dQNwVlGH2UtY3Gm0WcXxQFwWmT4JzOK1
         LDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uWfeXiQPgcGzYWM8+idpgn+Uv+Q5RrNQhW7GFYDOGdw=;
        b=ozPbw5SrtxadZYs4jUtT9FqF3nQSh3MMlnMAWRSikA1vV9YtYLQq7QDKUO43kHy6/p
         Kst1ru/4Sr9trg9qp8lll5th0/buOqo4eyZMFIFLxlNBYGZie3oeOgUZTkkY1xjuMupK
         9bLBlr9tX5B+I26nEnLl/DVZotauQdOtgV5/fdofZMWslqhAtGGOZjdZMasznctX9hEn
         BJaD7Y0GbydRJLBUnRNVESTQUKJUn8mAgcgTsJ2vsYenMv0V87T/zfGSrzRYDS643QqO
         +488fXKfGMgldENhkjqELrR9jx6oE4/P7iZYAUb4xw7V4JdyAVUAz3sO4ZN7XMS5Eruf
         XFKg==
X-Gm-Message-State: AGRZ1gIhQF9nfJIz2bsa9qzei5ShmvptvXnD1u+HyStJPnpcwhy1OYLA
        JBUO9PXN3IarPbJwxc6XPhFtjEk0
X-Google-Smtp-Source: AJdET5dI5dG/HTduDwCcv9jQhf9b+UHyozNiMuaQuK7bWxxEMwEpjZiFZt+zajrEgufJ22Q2EC+k7w==
X-Received: by 2002:a63:1c61:: with SMTP id c33mr1809335pgm.354.1542203941278;
        Wed, 14 Nov 2018 05:59:01 -0800 (PST)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id x36-v6sm25342026pgl.43.2018.11.14.05.59.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 05:59:00 -0800 (PST)
Date:   Wed, 14 Nov 2018 05:59:00 -0800 (PST)
X-Google-Original-Date: Wed, 14 Nov 2018 13:58:57 GMT
Message-Id: <pull.78.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.78.git.gitgitgadget@gmail.com>
References: <pull.78.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] Some left-over add-on for bw/config-h
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

Back when bw/config-h was developed (and backported to Git for Windows), I
came up with a patch to use git_dir if commondir is NULL, and contributed
that as v1 of this patch. However, it was deemed a bug if that happens, so
let's instead detect that condition and report it.

Change since v1:

 * Be loud about this bug instead of papering over it.

Johannes Schindelin (1):
  config: report a bug if git_dir exists without commondir

 config.c | 2 ++
 1 file changed, 2 insertions(+)


base-commit: 8858448bb49332d353febc078ce4a3abcc962efe
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-78%2Fdscho%2Fbw%2Fconfig-h-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-78/dscho/bw/config-h-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/78

Range-diff vs v1:

 1:  a3854e4ed8 ! 1:  0767f98378 do_git_config_sequence(): fall back to git_dir if commondir is NULL
     @@ -1,8 +1,9 @@
      Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     -    do_git_config_sequence(): fall back to git_dir if commondir is NULL
     +    config: report a bug if git_dir exists without commondir
      
     -    Just some defensive programming.
     +    This did happen at some stage, and was fixed relatively quickly. Make
     +    sure that we detect very quickly, too, should that happen again.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ -14,7 +15,7 @@
       	if (opts->commondir)
       		repo_config = mkpathdup("%s/config", opts->commondir);
      +	else if (opts->git_dir)
     -+		repo_config = mkpathdup("%s/config", opts->git_dir);
     ++		BUG("git_dir without commondir");
       	else
       		repo_config = NULL;
       

-- 
gitgitgadget
