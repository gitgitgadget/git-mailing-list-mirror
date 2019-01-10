Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 878C31F803
	for <e@80x24.org>; Thu, 10 Jan 2019 21:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfAJVak (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 16:30:40 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:37850 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728938AbfAJVak (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 16:30:40 -0500
Received: by mail-pf1-f175.google.com with SMTP id y126so5901536pfb.4
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 13:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wrlqxejlftSuQNEoxoE6kFLPUOcCb9VtdRxWN+B5WqU=;
        b=PGuiLKgjk+ymSn/1x4mWsmxZLOXEedOJqvV+FsZuk5DOxDYGUcOqNGYWBb4xn2NmLv
         4awXBeTRpXSzS791mkZ4g7EGYyQ4LyAF4tNTXYiuonVRLGAplB54TqvC4wVMTxUmkwqc
         JNF707sCq0UmXMq+L7BPESkrW4/38/p/4FYmeN/ixb7hXS7MRxNdfx6xWOuyHYiVVqOz
         PbX8drr8BDCHk+jBX3AnRUnYacQ+QkwkrGO4Pd/qxFlMMl0XjclC48YCXsg23fR9zoGF
         WfeTcTFsYB+eYLxbOMkVtjpyDkN4NoMiQkSSlxw/vFN8aRwrJjInMHAekCyqLMfhOT7u
         RiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wrlqxejlftSuQNEoxoE6kFLPUOcCb9VtdRxWN+B5WqU=;
        b=YLdsWZkaJc1aKls1I3c+fBLwnxwkNVBacZG+053szMiMcSXaNCQ3jarG0Jr3FRv6MB
         xyR5/a+mFasoSL4VFPo3baQcdOHaQkth2lS6B2hsaETKQyorSrKT5aXbj2eJtSqcx4bl
         90zo54S3TnyyqkFq1apFuciDlNPelEApDz3W/yJ4wEqt3oTI17d8cMDdJNEejkgypnJD
         7ulm3p/jw3o1byvEbZjBd3F2lN+PD5OdqvGy6L9gjpM1gO7CZ1kMUwUZIUXSanDTwwft
         x+s2NGHSKZiCntziFJGzegLLAYY1bVT/MBATMiPQ3rK+RNeuJsI7+KUuLYAH1gomEnSD
         5UNQ==
X-Gm-Message-State: AJcUukegUHhY7TX1ahtutBEjUy5Z0T0p8itQXJhDK/4BjUtectIdnji9
        jFf19p+7ixawx1R1CYmhJyE9g8xN
X-Google-Smtp-Source: ALg8bN6t4jgjCb65kkWHWK20TzuvQKsA5CjqgGqn1cSnyUDvWKUrZJUUKxIcyVRnEHGbwMe73siBtg==
X-Received: by 2002:a63:1b58:: with SMTP id b24mr10717621pgm.247.1547155838855;
        Thu, 10 Jan 2019 13:30:38 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id l3sm122110769pga.92.2019.01.10.13.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 13:30:38 -0800 (PST)
Date:   Thu, 10 Jan 2019 13:30:36 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Robin Shen <robin@onedev.io>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jgit-dev@eclipse.org" <jgit-dev@eclipse.org>
Subject: Re: Introducing OneDev - an open source git server with interesting
 features
Message-ID: <20190110213036.GC17382@google.com>
References: <SG2PR04MB3205E9C83085CFF2F426FE65B9890@SG2PR04MB3205.apcprd04.prod.outlook.com>
 <20190107222631.GB192553@google.com>
 <SG2PR04MB320586447FF738E008C373FFB9840@SG2PR04MB3205.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR04MB320586447FF738E008C373FFB9840@SG2PR04MB3205.apcprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robin Shen wrote:

> Yes it is using JGit for most operations. JGit API is very well
> designed and is a joy to use. The performance is very good, except
> for long operations such as full clone. So for pull/push I am
> calling native git, but for other operations which may need to be
> executed several times during a request I am using JGit which is
> much faster thanks for the in-process cache.
>
> I also filed several suggestions/bugs while using JGit:
>
> https://bugs.eclipse.org/bugs/buglist.cgi?email1=robin%40pmease.com&emailreporter1=1&emailtype1=substring&product=JGit&query_format=advanced

Thanks, that's very helpful.

[...]
> As to compared to other software listed here, I am only used GitHub
> intensively, so can not provide any valuable information.

No worries.  Thanks for indulging my questions. :)

Jonathan
