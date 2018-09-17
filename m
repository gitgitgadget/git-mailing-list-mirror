Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 605D31F404
	for <e@80x24.org>; Mon, 17 Sep 2018 13:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbeIQSuv (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 14:50:51 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:36346 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727547AbeIQSuv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 14:50:51 -0400
Received: by mail-ed1-f46.google.com with SMTP id f4-v6so12898946edq.3
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 06:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=Td1eqYQ52h4l37QfJtOndxHUSDLkdahhw2Ax+wdR4+U=;
        b=AqB5cpTv57E5ByIx8dHlqzvBafjB7d3AEboCPAGqo1gQ41dnCCCd2xJQHFkh3SW9Py
         B5Tim3DGzHh2SCakANm5Bk3b1e1OfWsbBvAisK0cR7/+oXn6xDPIHXTTVJPhSe8kEAi7
         GkGr8za9/t7uVjzflfDZ2pz+2GLU3WSFRC7P1IaK5Kw7oWY/RbrpLQ6Rm+ELRUlBr6GZ
         pIcpZrMycw69ZOdzvfn9JzDBn0tmgdpufNMBsTFQ8CQgnlmPFmN9rlAnxdX4LIc40Okw
         ampSca22DIRxk+iMvWKgiRNkzIKO9t6tbqrujBJiFwkNK1lfNPMf5yPTsp3SCtdxJRHL
         aAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=Td1eqYQ52h4l37QfJtOndxHUSDLkdahhw2Ax+wdR4+U=;
        b=UhqAT20hgvm/MsDWhUGefW7kELHZeKS2PPpncKtSdDMGon810mSD8tUooviP21bovN
         POjcB73GuCuAXB7pTN+qr/R1ZvDXz6PRffPpk8tUeh4eFZ1ZmyyHTIk3CZqOCS/S4HyC
         xG84LSoNvhzcDqjruXbnPvN1FYXnJJWXbny49rdtUtO27M4aiQjQpijTPJEMdm+STeF1
         uKiLF3ktwQEZ9pg5IFWelZlz5TtMqKEDHLL+yi5MvZhGAQCH/GtwGmc3Sa8ESgNAcdML
         Cu0iVLi5cA1LSew2ff4vrUvcIJYByo/gVvuj+LaxrHs1XxWVZ9Q08NJGuMPX5wxtIaOl
         86MQ==
X-Gm-Message-State: APzg51DYwGiygmtudbTyPzbVEU/PPCysAlF/e2fZkMSlDAiwqRPMjvhA
        KMBJL3bs10jcL2IRtTwRSwPU45NJYkM=
X-Google-Smtp-Source: ANB0VdYB4pSPnxBW3ivRwftO1Oa7KZa/9v020YT6ouyrEUJp9X9qTgiZO1pPycclsfdY9NFY3oGkog==
X-Received: by 2002:a50:8f84:: with SMTP id y4-v6mr43276495edy.71.1537190611305;
        Mon, 17 Sep 2018 06:23:31 -0700 (PDT)
Received: from evledraar (157-157-127-103.dsl.dynamic.simnet.is. [157.157.127.103])
        by smtp.gmail.com with ESMTPSA id w22-v6sm8461924eda.34.2018.09.17.06.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 06:23:30 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Nikola Milekic <nikolamilekic@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Differences between git show HEAD and git show head
References: <CACU07Yt5vh36tHcHxV-b_5MNLc-RzqGQ7=nkJq-DTqNgmYP+wA@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACU07Yt5vh36tHcHxV-b_5MNLc-RzqGQ7=nkJq-DTqNgmYP+wA@mail.gmail.com>
Date:   Mon, 17 Sep 2018 15:23:28 +0200
Message-ID: <875zz4l0kv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 17 2018, Nikola Milekic wrote:

> Hi,
>
> On Windows, when using multiple workspaces and git 2.19.0.windows.1,
> 'git show HEAD' and 'git show head' return different results when
> executed from a secondary workspace (the one without the .git
> directory).
>
> 'git show HEAD' shows the HEAD of the current workspace, while git
> show head shows the HEAD of the main workspace (the one with the .git
> directory). I find this to be highly misleading, especially for users
> like myself who are not used to typing HEAD in all caps. Is this
> indented behavior or a bug?

This is an outstanding bug in git that's tricky to solve (maybe you're
interested!), here's a recent discussion about it:
https://public-inbox.org/git/87ziclb2pa.fsf@gmail.com/
