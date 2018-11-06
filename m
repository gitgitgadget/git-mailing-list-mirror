Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6548D1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 15:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbeKGAi1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 19:38:27 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:36906 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729574AbeKGAi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 19:38:26 -0500
Received: by mail-wm1-f51.google.com with SMTP id p2-v6so12255825wmc.2
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 07:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=4mEqruectBFzAUaJu9/dFv6Tt31KoDw+NiS7VPI50Q4=;
        b=Zeef5+NRiUWiHwHZRnQWxlYM6bBbGIGmIm9J0L/b5kxLFSCA1Z/8ZV6bbNrep2NjJr
         cG951bGuauhIqXjR7sQL1yOeUPlRV7FEJPCLkisDFeEzWpNFrbhO9sh4tiL7F6qH0iz5
         jq5broDb70P56TwIP0RLRq6p56Sv3XuKDtNo0CQbpF1HSsM5UogaUn8yXnKN1JGvZzCe
         r1luP1U/vXD+R+urWn15ALkgRibTcHmessnoS8p3I05ewMTIDYPRAGGtZTIBPxKfLdYq
         wKGZilHMkk32J3VsSNcd5vFs0a3nKFWXabybD6y+51+T2f9OMjRjZ89GRkyRENQu0kBe
         gBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=4mEqruectBFzAUaJu9/dFv6Tt31KoDw+NiS7VPI50Q4=;
        b=O76b2wvrFdmCSrB4R5VRMrf7opqXwCUipzNPG4v9W8Mnyx0m0QJXG+u7IbJ1SFMofN
         rySlbhfM8CtF1VbDM7esffw/3BYP2P2hAr1ssAtuTBIdwPBLQLjZjKtMARoIxIE0pVAb
         NumNiz7Q1Va7LUm0iZvZLrAt0mcVStnY6KtTvi6kjZ+QOr6ofjL4asv8gkSz8RgkuW5M
         AMmsltTxe4XM6XpwPcYhD4MlldQm18vi0geRJ2X0FCyACKf5J2TdsOAgGN0Pc5iP3Fgl
         FO9PDmhTj1QwBdK1yap8xZwm/D/bahSmfe1X/lJ7M7t1HQ7RAzYa4rln9LCJbpJ8l1qV
         O97Q==
X-Gm-Message-State: AGRZ1gKMaxA/HQr2ug2JZpz71P+GR+03ri9EvlY7NIDl/NKd2TN9AQYk
        ljRM9w4QZYjt0ZIyNS9fhtIdBQRUVCg=
X-Google-Smtp-Source: AJdET5eVn6yw1EPvxV7Q4rTTSVMpPSDFxcPv4AjZc8nLX7t5/6UTSGAOs4dm32588jUoBfklkWz+dA==
X-Received: by 2002:a1c:e714:: with SMTP id e20-v6mr2223231wmh.83.1541517164736;
        Tue, 06 Nov 2018 07:12:44 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id z8sm1252890wrw.78.2018.11.06.07.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 07:12:43 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Steffen Jost <jost@tcs.ifi.lmu.de>
Cc:     git@vger.kernel.org
Subject: Re: Checkout deleted semi-untracked file
References: <d4624773-739c-f698-514d-458ce2ef5503@tcs.ifi.lmu.de>
        <871s8qdzph.fsf@evledraar.gmail.com>
        <4C6A1C5B.4030304@workspacewhiz.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <d4624773-739c-f698-514d-458ce2ef5503@tcs.ifi.lmu.de>
Date:   Tue, 06 Nov 2018 16:12:42 +0100
Message-ID: <875zxa6xzp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 06 2018, Steffen Jost wrote:

> Hello!
>
> A brief discussion on the git user mailing list on Google Groups recommended me to file the following as a bug report.
>
> The problem led to an actual file loss, but I suspect that this might be intended:
>
> 1) .gitignore is added to the repository (which then causes problems)
> 2) A file is added, repeatedly edited and comitted to a remote repository.
> 3) Later on, the file is added to .gitignore and "git rm --cached file" is executed (since the file now contains information private to each developer).
> 4) Several commits happen.
> 5) I checkout an old branch which has not yet seen the change in .gitignore in the master branch. The file is reverted to the state of the branch.
> 6) I checkout master, and the file with all later changes is irrevocably lost.
>
> I usually advise my students to check-in their .gitignore file into the repository. Apparently this is a bad advice, since it now led to a somewhat painful file loss for me.
>
> So what is the actual advice on this? Google turned up mixed advice there, and the git user mailing list on Google Groups recommended me submitting this as a bug here. However, I think this works as intended. However, I don't know either how to avert this problem, apart from not checking in the .gitignore file (or checking it in under a different name and copying it manually).

This recent thread should be a good starting point:
https://public-inbox.org/git/4C6A1C5B.4030304@workspacewhiz.com/

My reply here I think has an overview of some of the caveats:
https://public-inbox.org/git/871s8qdzph.fsf@evledraar.gmail.com/

tl;dr: Git assumes that a pattern in .gitignore means you don't care
about the contents, since it's meant for *.o and the like. This leads to
data loss in some situations (such as yours).

Various suggestions in that thread of ways forward, but none have
been implemented>
