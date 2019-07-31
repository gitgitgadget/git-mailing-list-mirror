Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26B181F731
	for <e@80x24.org>; Wed, 31 Jul 2019 20:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfGaUGo (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 16:06:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37939 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfGaUGo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 16:06:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so71009829wrr.5
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 13:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ubULMhF08UQPQnSqxR6V+LYKIgbU0Xmaq/s5Xg16C+0=;
        b=H1TKvnAxNdIGgywLZVzDQ1O3a5JLXYHaVnPQL2EGu3v9dJDcp9KHnmS9sF8TBW/YEK
         eXhacdH2Yj1LxH/YHxP0+qBboNZF+J4N+dFOs7on0w6qTr49U/CQZYenRd6NqAOXUHgB
         Kjs8wj2mim01QzVUzLdKHK7ZNNaLILhJ8VIBbpj45/y5V/FOAX8+pA3c7A84qvZKtPa1
         gtWBKb+KxPV8t8oY8S7a58jK5EPUicVIC4wh+QxcAml9obU0KYlWp5UjOuWxahHYRcl2
         fhbki3PlTWSr/NNQEPEhMQzbIU5b58puBSbygCh/aNynf0pjaZxq071eXuYY93qK3aYH
         o5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ubULMhF08UQPQnSqxR6V+LYKIgbU0Xmaq/s5Xg16C+0=;
        b=kAIwSg8/pyZeHKP/serqFE2hPKAYcMeNxW1N15WYgLL21csfM/pmIEpG6cd3cLVqLp
         1SeO2lDwWTidPG5LO8fc/AkL1aOHqw4W+g/trTO6an1sUM21ifegfyCHCnQHiXDZnvvc
         sBoN6P5kYVuDl13B5wgzmGDwo8FBkr8Nt7y5TOc13v59dD0QOdL87KKH5i74dfdVW9Nj
         i/7YOh1610/6FMsTMLWW1Mwi3w+qvym8JIpyz8jBoACk+yhEJkDEwsU8XDzrRnUEL5LL
         wbFT3DjgeZV52IZctttEjJp09TXB3oqKKl5nTBrO6EcQIFHwvO6Z81WYefJ+UT6nmrod
         TZbw==
X-Gm-Message-State: APjAAAVC3osKdySTHsx+ofFEGvuxEApX4NLNH4xk+jm9drGWt97CQw+v
        tBRwsmKt8qQSh43TbB3Id5Yf8gFu
X-Google-Smtp-Source: APXvYqyYAaK2azltn4LnVQ3W2fYvw+ALbvwZVIWqDyc/6q94OGF9jlgqbtsG4fiToTsAohvP5u3aOg==
X-Received: by 2002:adf:eb51:: with SMTP id u17mr3628630wrn.257.1564603601702;
        Wed, 31 Jul 2019 13:06:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j9sm78140592wrn.81.2019.07.31.13.06.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 13:06:41 -0700 (PDT)
Date:   Wed, 31 Jul 2019 13:06:41 -0700 (PDT)
X-Google-Original-Date: Wed, 31 Jul 2019 20:06:39 GMT
Message-Id: <pull.300.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.300.git.gitgitgadget@gmail.com>
References: <pull.300.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 0/1] Make the includeif:onbranch feature more robust
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

I actually stumbled over this while rebasing the VFS for Git patches, in
relation with the pre-command hook that we still support there (we're slowly
migrating toward Trace2, of course).

Once I figured out what the problem was, I hunted for a way to trigger this
bug in plain Git, and git help -a is the one I settled on. It had to be a
command that uses the early config machinery (and git help -a uses it to
list all aliases), and it had to be a command that does not discover a .git 
directory automatically (cmd_help is listed without any flags in git.c, so:
check).

Of course, part of me wants to just go and dig into the refs part of the
code to introduce an equivalent to the "early config" machinery (calling it
"early ref store"), but:

 1. We're really in feature freeze, and I want this bug fix to go into
    v2.23.0.
 2. It is actually a pretty obscure thing to want: a branch-dependent config
    that is used that early that the Git directory was not yet discovered. I 
    could imagine that some power user wants to play some games at some
    stage, say, with the pager depending on the name of the current branch,
    but even then, to run into the issue with this here patch where it
    simply ignores the includeif.onbranch: setting in the early config code
    path, a command has to be run that does not immediately set up 
    the_repository->gitdir but still wants to use the configured pager.

So yes, this patch introduces a known issue, but it does fix a BUG() where
no bug should be reported.

Changes since v1:

 * Now using my correct email address for Git contributions.

Johannes Schindelin (1):
  config: work around bug with includeif:onbranch and early config

 config.c                | 3 ++-
 t/t1309-early-config.sh | 5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)


base-commit: 026dd738a6e5f1e42ef0f390feacb5ed6acc4ee8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-300%2Fdscho%2Fonbranch-and-early-config-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-300/dscho/onbranch-and-early-config-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/300

Range-diff vs v1:

 1:  4aa8834013 ! 1:  ea1a746113 config: work around bug with includeif:onbranch and early config
     @@ -1,4 +1,4 @@
     -Author: Johannes Schindelin <johasc@microsoft.com>
     +Author: Johannes Schindelin <johannes.schindelin@gmx.de>
      
          config: work around bug with includeif:onbranch and early config
      

-- 
gitgitgadget
