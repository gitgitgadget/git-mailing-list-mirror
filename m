Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 916682079E
	for <e@80x24.org>; Sun, 15 Jan 2017 14:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751053AbdAOO0y (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Jan 2017 09:26:54 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36454 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbdAOO0x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2017 09:26:53 -0500
Received: by mail-wm0-f53.google.com with SMTP id c85so126411473wmi.1
        for <git@vger.kernel.org>; Sun, 15 Jan 2017 06:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f8nxghSmrdz/nALXNXd5ObnBBCyvLniayG5RHx11VjA=;
        b=CFxJUHPwLBdCbWbiilf1gxkVsFDibUiBYmD/sMlHNIgLfv/LCKcajhBt0B0c1rLaju
         Tr2GUmuBrQwW+NnL97rqSYxjBhc1mdVSa0lIHQG/gJQC3LtBvWN6aFPTrYdw4tMZsymK
         nsRT8C0XVNxLTEn8Z3tL4itlb14cEqA72riDkcvkHqJerzhgmx/KJrq7X6oSGZiOvEYG
         2ng07Dt+IHHrG92QJu1mfiHIKaAE300D2HpO5q4rmZHM6W1FPktUIkjnffDmWad420lA
         /Z2iCjNtlDuF74qnqvI0Q5Sr9EZ5se45SU0ufZsbpKRs4cMxQyBQcOutgbH97X2SwE3k
         nLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=f8nxghSmrdz/nALXNXd5ObnBBCyvLniayG5RHx11VjA=;
        b=h1o503E2LvJ0T9/zQbvOlvXlhQhh6I5j5OkCD7Nb6gyvbic1b8SAL7ee8vv4rhcRCK
         c3rQJ9OlfOsppet7YyIxvgL9QlmgeWp6Xy5dRBa2XikUW12EVBCWTXYYfRlZRuXdulwt
         bkmmZUZAgmVD6PYSRA85hi1jV7eXKacufCZkKxC21lq/DIbCqHHLSjhu/ZQxyFDWOktz
         q5DxQ+pUrIynf8EApFTKKVULpv9jfNaRf/iNNGu2XSPRw9r6w4Hpt3UKcRDGJ9Y1gded
         E05jRezCR/gx4XyzzuG1ZUqN2O1IzrDa+2WXCpHQe5E8lB4kTq7W9tDcFmPu4GBUK/G9
         NqQQ==
X-Gm-Message-State: AIkVDXLW+1sOZgVZG9pSZOGA3kWZgHIeo56BCmkPJNO2Ze3kt8d9nUSgc3ZwfUqHsSP34g==
X-Received: by 10.28.26.7 with SMTP id a7mr8585923wma.21.1484490412394;
        Sun, 15 Jan 2017 06:26:52 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id 123sm21331691wml.6.2017.01.15.06.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jan 2017 06:26:51 -0800 (PST)
Date:   Sun, 15 Jan 2017 14:26:58 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     KES <kes-kes@yandex.ru>
Cc:     git <git@vger.kernel.org>
Subject: Re: feature request: allow to stash changed files
Message-ID: <20170115142658.GA20721@hank>
References: <2141311484484121@web16g.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2141311484484121@web16g.yandex.ru>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/15, KES wrote:
> http://stackoverflow.com/questions/3040833/stash-only-one-file-out-of-multiple-files-that-have-changed-with-git#comment32451416_3040833
> 
> Sometimes poople are forced to save stash for changed files. But there is no such option (

You may just be lucky.  I've been wishing for something like that for
a while now as well, and finally got around to write a patch this
weekend.
