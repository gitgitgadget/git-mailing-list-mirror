Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F41C61F6BF
	for <e@80x24.org>; Thu,  1 Sep 2016 15:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933938AbcIAPwT (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 11:52:19 -0400
Received: from mail-oi0-f49.google.com ([209.85.218.49]:32883 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933337AbcIAPwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 11:52:16 -0400
Received: by mail-oi0-f49.google.com with SMTP id c15so122745728oig.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2016 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Fr7fFzdmwcmWVud6/dYF01bh89C8TZ414acYhOA81H0=;
        b=yDi7huQb8/xe9lnEJiLx/kCLZp4R5JtYtGHWDpNLWr19KYHE+DcTIPl5NMYM2ZCTSP
         FYFU4bh4Qg6suHiymkUZIAzOokf+h4Z3Nbi4RdJ4sDQKPR0FsOt8M9E1nECDjOo/fY+8
         xPjlQPN+QaRrYZgmi2KJX/Fjkw2UsFQggs70cWJL4eWoAL8nMxUBIqBag7FHG47tOiXo
         q82oetDGQlEvb2a2T9CkAZjGAVr/Jdc15FshWHsizNFVYqS9S2BVAbC863xcyO94dX7q
         OzbhVebDC9EZE9CnHs6gsJdyWg0gXq8D/LgBNc5fRT9TdMLjg5fgGEDk644vXm022AnI
         ce8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Fr7fFzdmwcmWVud6/dYF01bh89C8TZ414acYhOA81H0=;
        b=FazD3m8dGkrObwL2naLIiB1AlziPIkZIyzHJI9GC8DUJbfd3a5qgUpvfHi2MbyRjOp
         cvnXnHiTALHMFleASLHuXg1zc/D+YnIVt5H0byHSjf18mmrY+hA8ML8JkFCpuK83yjyQ
         th7MybRg1s4eK53XYKUbAzxWW8fsuwiQlwswv5QQwjKooSOEt1SAIJxrmF53JqK2p/h/
         LejOKWB5rhIS/NSX3EUy2BSGo+gxMEsN/h1Q2/wdoxQ3hhxWbMOQkyoZgXr74ekebwLV
         0hyyox15jOt2/kq02ZX66JzLFQ1TkIBnWETeD2aqJz7NSHopRRW21m2HBvMroxV/84/u
         Mc2Q==
X-Gm-Message-State: AE9vXwOqgPb5Jomdsynhce7heSmJC9xeoRYwBMxD/wJnuEDONs2rRBdrZNPMXZ/GSrUKB7caHPApsbByCLk4nA==
X-Received: by 10.202.62.130 with SMTP id l124mr15517758oia.97.1472745135639;
 Thu, 01 Sep 2016 08:52:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.245.203 with HTTP; Thu, 1 Sep 2016 08:51:55 -0700 (PDT)
In-Reply-To: <CA+P7+xpz8UNt6bBgrJvsHdFE+MQ4J80K1ed+b41XH_CG6HYYTA@mail.gmail.com>
References: <CAKkAvazQxhtQauSb3MTVhzoK=xWbjMzQLBPQZUpp1n7VMUMJbQ@mail.gmail.com>
 <20160828105159.GA5477@ikke.info> <4114ccbc-6b23-b7fe-ce4a-fcd0c9e4038a@gmail.com>
 <CA+P7+xrGh687cYHJmYyXiWfjg_8i2-31FZOvk4bEMsO1FU22WA@mail.gmail.com>
 <xmqqy43f9wzh.fsf@gitster.mtv.corp.google.com> <CA+P7+xpz8UNt6bBgrJvsHdFE+MQ4J80K1ed+b41XH_CG6HYYTA@mail.gmail.com>
From:   ryenus <ryenus@gmail.com>
Date:   Thu, 1 Sep 2016 23:51:55 +0800
Message-ID: <CAKkAvaxD75sC-S7QBG6gXYbSMmBz5hpe8ZEYRRUt_BE99yvrYg@mail.gmail.com>
Subject: Re: Notation for current branch?
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Kevin Daudt <me@ikke.info>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jacob Keller <jacob.keller@gmail.com> writes:
> "git symbolic-ref" seems like the right thing if you need to obtain
> the current branch name, and there's no reason to not just use HEAD
> there.

Really? Any reason why `git rev-parse --abbrev-ref '@{-1}'` works,
but not `git symbolic-ref '@{-1}'`, or even `git symbolic-ref @`?

BTW, possible to make the curly brances optional in `@{n}`, `@{-n}`,
and the alike? coz they require quoting/escaping, and more typing :(
