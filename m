Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC27520D12
	for <e@80x24.org>; Fri,  2 Jun 2017 06:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751172AbdFBGhn (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 02:37:43 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36610 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbdFBGhl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 02:37:41 -0400
Received: by mail-oi0-f54.google.com with SMTP id h4so80543573oib.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 23:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jBVI0S5GMXbDGfDz9wT+cfwTiU+SeJSEfBoENxO7j9A=;
        b=IICb87UY6Lev4/Mmc8hBv0JAe+rAsVYflg06/Pvggp4ka2xRuVuujoY6UeEwtPogTb
         i7zwYKKLDw8AQ7zCnZKWs+JE6TFZuAfrrkLNF4LSKMxLM9dagdY6YdjCioTcnZ5XxqD5
         ngV8Z9qP0TYkEqDFDHp1rExWVZdzNF6wSvgakEp9v8VOjz/LpJaZNivv4xhhuBq4zkLn
         12ORB0LADLb3l3o7WobPG2J0Ze0ebWy4CykDQQrO624BXCSLcgh1pcZiC5qao8EZZUo2
         9Rbtr+ZzFU1tHfScFVMaAdlj6GRhpSB3XVzD1JsGKpfht3CkCqCLENvz4OEi4AINayVz
         PZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=jBVI0S5GMXbDGfDz9wT+cfwTiU+SeJSEfBoENxO7j9A=;
        b=lmwpbHnga8R+psQrMYx/nB3BCpzYXNkbalPCsIuJ18cPxibJ+UyQCCrD9WBOtIuuri
         uA111is6Xp3y706EsmY94+eIVMWSQg6hTl7z8xUB6BS/jLZiEpzhJ3PWRRzgeIIWgmMQ
         o8YBiPfWuPrqoy8cVKo5YUXYcA3y0HKFtrfNYf8KD77Q6j3jpL6hSWMhEbeENl3Oixrl
         tBmvEUgP/LgYAcJ7XMz90p8Un5yCY1N174SaSaxASWRFHGVC8jv7IpFnAzGAkn/UsTVE
         be+QcOivyKZYveMasmysiaCRR6qL63Cri9ur5uc/T7YKMk3IsaoHfkAbbtZDLAXpKizC
         vZOQ==
X-Gm-Message-State: AODbwcA4Gtj7qEMWWxOfTL64eO6vgCsCl7O3aQ4dmxt7P9iZHwmI15s7
        lZdTQdc8FFb0excwYTfcOMD1wnT2WxqZKBo=
X-Received: by 10.202.45.214 with SMTP id t205mr3165411oit.199.1496385460899;
 Thu, 01 Jun 2017 23:37:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.22.199 with HTTP; Thu, 1 Jun 2017 23:37:40 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <532E194B-3A76-4416-A652-4B1DCE78AB8A@gmail.com>
References: <CAH8yC8mjTXQ_5uRedHi=fytKtQttyq_WemGFNQTP9C3PK4x5cQ@mail.gmail.com>
 <532E194B-3A76-4416-A652-4B1DCE78AB8A@gmail.com>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Fri, 2 Jun 2017 02:37:40 -0400
Message-ID: <CAH8yC8k9pJHLuzWneb4aRAEF2zOTCVO_5YJxrCpw28x8bDox0A@mail.gmail.com>
Subject: Re: How to avoid "Please tell me who you are..."?
To:     Davide Fiorentino <davide.fiorentino@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 2, 2017 at 2:30 AM, Davide Fiorentino
<davide.fiorentino@gmail.com> wrote:
> Is there a reason why you don't want or can't set those details?

Well, they don't exist so there's nothing to set.

The machine below its a CubieBoard used for testing. I remote into it
with test@. As a matter of policy, no check-ins occur on it. Other
than the password database and authroized_keys file, there is no
information on it to be lost or stolen.

Jeff

> On June 2, 2017 7:02:22 AM GMT+01:00, Jeffrey Walton <noloader@gmail.com>
> wrote:
>>
>> I'm working on a test machine. It mostly needs to be a clone of
>> upstream. On occasion it needs to test a particular commit.
>>
>> When I attempt to test a commit it produces:
>>
>>     $ git cherry-pick eb3b27a6a543
>>
>>     *** Please tell me who you are.
>>
>>     Run
>>
>>       git config --global user.email "you@example.com"
>>       git config --global user.name "Your Name"
>>
>>     to set your account's default identity.
>>     Omit --global to set the identity only in this repository.
>>
>> This is a nameless test account, so there is no information to provide.
>>
>> How do I tell Git to ignore these checks?
>>
>> Thanks in advance.
