Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6707A1F453
	for <e@80x24.org>; Mon,  1 Oct 2018 12:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbeJATPF (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Oct 2018 15:15:05 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42218 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729148AbeJATPF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Oct 2018 15:15:05 -0400
Received: by mail-qt1-f194.google.com with SMTP id z8-v6so13654522qto.9
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 05:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=/nBHM/N8FXMWKw7y8GDTYsyIOR2P1BtEOmoglkhbaUI=;
        b=jIsRXMuiRAMDKVH0E96JXxlGzVShR+pfOZbUZolGy7ealolO3XkeAXcTH7AEaG6jUI
         ZiTT7BD9rpSCTf6V98xeJHyB/h0elGHTy40aqfHvnUdMpiVsYwGT+GRnx5Ux2QgQEcm9
         CDiJmkgl3QkOaLN5Xouwgfm9KGR64xq+VE7+RV3wniOcgp050x48dd3Jxz/03SHM195d
         0OnIi3Juc6SP+2AObLKfO31cRLURxfA+PrBsDRPpV89WkJ3+FZt7JI+ZI0ehyK+G/WCb
         VvDYertBH5EYIndoWlpw0mcuOpFrQsy267WYiiPEvlWI89k6M8BYbC4gPiDj7ZuqF8fD
         8AwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/nBHM/N8FXMWKw7y8GDTYsyIOR2P1BtEOmoglkhbaUI=;
        b=j/HIPUf6rWGDlDXqF1uB2o+6yCYybnyDdLvnxVAIjxPSPkvF9CHXuwCuzNM4Z1y8II
         rmntG5w4Fn8nrC5CWlwXrDM1bgDKRiqLlfNJ0L5DVYRVB7l/IJn7HZjH5IY7FFuLRpon
         7f7DPHkizegc9U31BlORLPuXfv4Q3loHc8O/1u9LDu6hFdV9PdzXL71gUvhkcKM4/MUl
         W8El3cHKiB219r773mEbzMcY3JCMzxjhyNzfnsavfa4mgFgSQpx5qichVSy1LCCGu19T
         9xjzOMK3kUb7kSLBwjVLTegHAzct2esoy4FoAWoXu9LmamNbxtjvrpQB5Vz7bbo8FxwO
         Rypg==
X-Gm-Message-State: ABuFfogSjfa0F6uxKP6OR2pX0VEhj8BqZ6qBc8U0iwEe0yijV/XOFh8o
        rqqwRUbnJ1K3ldyoRdVb4Qw=
X-Google-Smtp-Source: ACcGV60jfbpTHmqmFTKygbyKiv/ZFg9cbpo0HfWxcjfoDOXM6fRom1gLaCrx/ut6wjgeBLF58NcEFw==
X-Received: by 2002:ac8:3290:: with SMTP id z16-v6mr8425777qta.209.1538397447545;
        Mon, 01 Oct 2018 05:37:27 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:f5be:873:b4e5:f5e1? ([2001:4898:8010:0:def4:873:b4e5:f5e1])
        by smtp.gmail.com with ESMTPSA id m64-v6sm7175374qkf.18.2018.10.01.05.37.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 05:37:26 -0700 (PDT)
Subject: Re: Git Evolve
To:     Stefan Xenos <sxenos@google.com>, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <CAPL8ZivFmHqS2y+WmNR6faRMnuahiqwPVYsV99NiJ1QLHOs9fQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5539c3ab-9c55-fc9a-6e78-9ab128cc30bc@gmail.com>
Date:   Mon, 1 Oct 2018 08:37:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPL8ZivFmHqS2y+WmNR6faRMnuahiqwPVYsV99NiJ1QLHOs9fQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/29/2018 7:00 PM, Stefan Xenos wrote:
> Hello, List!

Hello! Welcome.

> I'm interested in porting something like Mercurial's evolve command to
> Git. I'll be following up with a formal proposal shortly, but before I
> do I thought I'd introduce myself to the list and find out if anyone
> else is interested in this topic.

I'm CC'ing some contributors who have also expressed interest in this topic.

> What is the evolve command?

I'm snipping the rest of your thread because I'm vaguely familiar with 
how this is used in hg, but I haven't used it myself. Instead, I'm going 
to ask you the same questions I asked the last time I had a conversation 
about this with someone. In my opinion, these questions should have good 
answers before we start working on the solution, or else we could paint 
ourselves into a corner as we build the first pieces.

---

What would the command-line experience look like for this workflow? Be 
specific, including examples!

How does one create a commit that obsoletes another? Are we in the 
middle of an interactive rebase, or are we simply checking out the 
commit? How does a use keep track of their progress in a topic?

How do I view which commits in my topic are obsolete, and to what commits?

If I want to obsolete commits on one machine and then finish the work on 
another machine, how do I do that? Similarly: how can I share obsolete 
commits with other users so they can apply them (or not)?

Do obsolescence markers live in the ref space? (This is one way to help 
answer the question above.)

Can I make multiple commits obsolete into one commit (merge patches)? 
Can I make my commit obsolete in multiple ways (split a patch)? How is 
this communicated to the user?

---

In my opinion, a good way to move forward is to create a patch that adds 
a design document to Documentation/technical that answers these 
questions. Then we can dig in more to make the vision clearer.

I'm not a UX expert, but this seems like a place where we could use 
someone with expertise in the area. If we are not careful, we could end 
up with something even harder to use than interactive rebase. The main 
goal here is to make it easy to rewrite a topic (plus, the ability to do 
so in stages).

I look forward to see what goes on in this space. Count me in to review 
the technical details.

Thanks,
-Stolee
