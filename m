Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDD8820A10
	for <e@80x24.org>; Sun,  1 Oct 2017 16:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751128AbdJAQGk (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 12:06:40 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:55201 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbdJAQGj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 12:06:39 -0400
Received: by mail-wm0-f44.google.com with SMTP id i124so6495781wmf.3
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 09:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2XXs0RKLdO8i9WouQANr9KImNqeg8vgqoqrqbOgD9a4=;
        b=M/ZdYFE9MIRdQy2hhJbfK4ja2bTXNJSg4e1f7NrCTTHKAfzHKbF9RJhgPkOpq0zET4
         S4cO+7/W9tl5m9kzK3lxgW2+rno2IQWBoTSfwh0yhcQLqfzxtAJqYLNSfgf/8kwcUS2J
         +qHua5eBc7jSHzIOW4pxuo9fsLZJLwmkuvLyOVmQe1qJNynmTabtZfU4lcAhQmTNq+J1
         fFD9XDNWsqqYxRTzXH2P6/p4C06fu5vIYXK0LGO6Scf0dWAiGiZyCx8SHawNSdQw/ztc
         h8ySDWaeAEbaDY7qetglW20pyr+tp4kFUDHAqfojQCNfWoOojT2Bl4kLFPN6JU4mp4ql
         JEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2XXs0RKLdO8i9WouQANr9KImNqeg8vgqoqrqbOgD9a4=;
        b=MSr4PYBimqWT60gnjMgrljcxtqbIHHMfpdwIFBSP3THtxc4+IlQYk5+JXERtdg2U3X
         uM8u2p7yNsn0fHUH/TxUp8sCVhCHNo6kKI54oTEJVHU+WtfiYndNetzF41o3Khtl2yNc
         I+wi/JgeuV7i1odlMCeO4m6bSbTDgYrVa30wpoqCMpMiZZ+sa9AOmQEwJh+K2caTJCTA
         96cSpc8Rz+85wdp+Ixx9h2zl9oiJ+JeN+2wmo1O4RNAgu1wRMU8LNGjvG8/XzKxvz1Iv
         L+wM2QymEaB+5d07g5G184mhy//qeWTmfzRkkfkSXmXhcKAWntJYyQWybmO0YBRcKcGV
         pfmw==
X-Gm-Message-State: AHPjjUju9dphNODUVVXztXKV8X3OPQ8q0F1GiogJTW0BqqNvylXbOWTW
        Iii4CeI2JpreKnwLsFJfLH9V9SC/C6cEIj1mnQ==
X-Google-Smtp-Source: AOwi7QCivTxXkXdPtQXPH6+uZECnDjuu+Qn5BZzRH7mUHdpvKWrlX+2o6sQBgzGwaXsryhkwJBGr6h12frtyNWuTvAA=
X-Received: by 10.80.165.141 with SMTP id a13mr16640163edc.200.1506873998464;
 Sun, 01 Oct 2017 09:06:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.146.166 with HTTP; Sun, 1 Oct 2017 09:06:38 -0700 (PDT)
In-Reply-To: <20171001141719.GB20406@alpha.vpn.ikke.info>
References: <CAJYFCiNj22McSaKcCVMDVgah5cAqHYHja_b2jj6VAaAA=zSM1g@mail.gmail.com>
 <20171001134155.GA20406@alpha.vpn.ikke.info> <20171001141719.GB20406@alpha.vpn.ikke.info>
From:   Yubin Ruan <ablacktshirt@gmail.com>
Date:   Mon, 2 Oct 2017 00:06:38 +0800
Message-ID: <CAJYFCiNmDpNNdbRsN-F-mOtcOEVruawEKUtA9h3BAFZZWKStsQ@mail.gmail.com>
Subject: Re: will git rebase has side effect
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-10-01 22:17 GMT+08:00 Kevin Daudt <me@ikke.info>:
> Forgot to cc the mailing list.
>
> On Sun, Oct 01, 2017 at 09:23:23PM +0800, Yubin Ruan wrote:
>> Suppose that I have such a history of commit locally:
>>
>> A --> B --> C --> D
>>
>> If I then add a few more commits locally
>>
>> A --> B --> C --> D --> E --> F --> G
>>
>> And then I do a rebase and squash F and G into one single commit H.
>> What side effect will this rebase have? How will this affect "git push
>> origin master"?
>>
>> Yubin
>
> Hello Yubin,
>
> So the situation is this:
>
>             [origin/master]
>                   |
> A --> B --> C --> D --> E --> F --> G
>                                     |
>                                  [master]
>
> Then you squash (F' is the result of squashing F and G):
>
>             [origin/master]
>                   |
> A --> B --> C --> D --> E --> F'
>                               |
>                            [master]
>
> When you want to push now, it's just as if you just created just two
> commits in the first place, and you can just push normally (assuming no
> one else has pushed in the mean time.

Hmm..You mean, if I do a squash, it will only affects those commits
that has been squashed, not any other commits, and their parent-child
relations remain the same?

Yubin

> The situation is different when you have pushed already:
>
>                               [origin/master]
>                                     |
> A --> B --> C --> D --> E --> F --> G
>                                     |
>                                  [master]
>
> Then after you squash, the history would look as follows:
>
>                               [origin/master]
>                                     |
> A --> B --> C --> D --> E --> F --> G
>                          \
>                           --> F'
>                               |
>                            [master]
>
> This sitation would look to git like you created F', and someone else
> had pushed F and G. It will reject the push, saying you would need to
> merge these changes first (but you don't want this, because you are
> merging the same changes together).
>
> To solve this, you can use git push --force-with-lease=master origin,
> which will force the push, overwriting the history the remote already
> had.
>
> Hope this helps, Kevin.
>
> nb. --force-with-lease is a safer version of just (-f|--force), because
> it will prevent you from overwriting history you don't have locally, for
> example when someone else did push already.
>
>
