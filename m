Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 639CD1F42D
	for <e@80x24.org>; Wed,  9 May 2018 07:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933733AbeEIHT5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 May 2018 03:19:57 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:39259 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933715AbeEIHT4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 May 2018 03:19:56 -0400
Received: by mail-ua0-f196.google.com with SMTP id v17so13052474uak.6
        for <git@vger.kernel.org>; Wed, 09 May 2018 00:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DPxjH1l7BXyE79SMXQw2hkmCr37mux0LwpREnNjVmmI=;
        b=YKipRL3Vi+nh4Tf2SI+CddnyjJVFQPeRrY1WC1Czd2io2iGB5nhA0xVxggh46b70Lm
         IGSbTjvjGaLezcAzQfla1HL1r5qOdKqIv3Z36inyTX2CChOgtc5sqWF68QENn/XnvWEL
         VPj5n6Q9U9gLMPTjKPBJzELEwefBCnwYyKokiMCAE5wAJCTv/t4jE9blJ8nBykZ9D8cn
         X1e41MCxUhYNPcn4MeLpyxfdj64G9c3A4h8B6eKdb+EPcyjD3l7fHezQQdgKcK1NA/GT
         LXHCUYn2ZBotu8ArsFlyEe/RhyNKa2WTct9js38LqjqM2NNy9nc8X5GRJ3R1U4vqRyk3
         CO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DPxjH1l7BXyE79SMXQw2hkmCr37mux0LwpREnNjVmmI=;
        b=PaKt9XsPK8zyvD+LVhf4Y/9Lxp8O537Xuj8PdE0ow70KiitRZLTvFrhID+OEDd6hNP
         qBGFm0RF0iQ9Bniv8PN5/Kq4nxEqLK0az+1i+T8vKe4ZzBCrjhHZfsdkiiwm3qt48Gzl
         c3g5AKF7uY1rn8Xqbht76VZ1WAmTqqZXw5tjhTSVw8v2dIeXVqkuoVYAEVRYn+9VW8gM
         2a8J+hlidDURAkenOl6ReBeBESBCnh2IfWJnu0KTFzWi4UI4gZH68Ggq6d6dgP714GSx
         YKxkmG4qqG/cOihcT4od/kT1vnYBHbm+wpLCrYBvnhoJxFhkk7neDXO8Dr/cLEdPnYdS
         bqIQ==
X-Gm-Message-State: ALQs6tBCzTxu1+32Md8wdT6rJkO6QTtJscvb4Kgsb7NDMkvwVNYLit0M
        mH5oOPr3CRvVwjZp9AXNZRIJtGpR9WuFg3i703c2Mg==
X-Google-Smtp-Source: AB8JxZqWQW0VaB4GInCQ5BSJ6yssFVmDy5s2aAQBfUmg/gw7gUF20OFc8Hs/y9mcXPRSf80A2Cq4DkgCVSfIQ09QNVs=
X-Received: by 10.176.78.199 with SMTP id x7mr37300577uah.110.1525850395901;
 Wed, 09 May 2018 00:19:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.100.7 with HTTP; Wed, 9 May 2018 00:19:55 -0700 (PDT)
In-Reply-To: <20180508133905.6jhhhp6l7avjkctl@pflmari>
References: <20180508121104.rtsrektxiihvpqtx@pflmari> <20180508122256.nyv6ddcoifygfpk4@pflmari>
 <CAKPyHN3YMU3oZaW-wR2ZMV6aMwoeFGMmiJBQXtvipVvkWPLZVQ@mail.gmail.com> <20180508133905.6jhhhp6l7avjkctl@pflmari>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Wed, 9 May 2018 09:19:55 +0200
Message-ID: <CAKPyHN1bGtCBZUh7cDAN-t+5DTutvyL6FLwynALTGZA5ijqwrA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gitk: add an option to run gitk on an item in the
 file list
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 8, 2018 at 3:39 PM, Alex Riesen
<alexander.riesen@cetitec.com> wrote:
> Bert Wesarg, Tue, May 08, 2018 15:17:03 +0200:
>> On Tue, May 8, 2018 at 2:22 PM, Alex Riesen <alexander.riesen@cetitec.com> wrote:
>> > +proc flist_gitk {} {
>> > +    global flist_menu_file findstring gdttype
>> > +
>> > +    set x [shellquote $flist_menu_file]
>>
>> this needs to handle cdup, i.e., if gitk is run from a subdirectory,
>> all paths needs to be prefixed with $cdup, like: [file join $cdup
>> $flist_menu_file]
>
> That, indeed, is easily done:
>
>     set x [shellquote [file join $cdup $flist_menu_file]]
>     if {[file isdirectory $flist_menu_file]} {
>         exec sh -c "cd $x&&gitk" &
>     } else {
>         exec gitk -- $x &
>     }
>
>
> It just doesn't seem to work: gitk does not find any commits!
> Maybe that's because the file panel lists only files for the current
> subdirectory (without the path from the repo top-level)? E.g.
>
>     mkdir tst
>     cd tst
>     git init
>     mkdir a
>     touch top-file a/sub-file
>     git add -A ; git commit -m.
>     cd a
>     gitk
>
> Gitk lists only sub-file.
>
> Frankly, this listing limited to just a sub-directory confuses me a bit. Is
> there anyway to get to display full repository without changing to the top
> level?

I noticed that too, while testing your patch and I'm also confused.
But was not able to send a request to Paul yet. ls-tree --full-tree
seems to be one that should be used here, I think.

Bert
