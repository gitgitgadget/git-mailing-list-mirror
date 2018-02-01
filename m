Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BD0A1F576
	for <e@80x24.org>; Thu,  1 Feb 2018 06:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751405AbeBAGk3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 01:40:29 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:51485 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbeBAGk3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 01:40:29 -0500
Received: by mail-wm0-f47.google.com with SMTP id r71so3615309wmd.1
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 22:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7bgrY9o8OGjMkm0Pse5Skl0eO2b5ukOBwbOfVLrYRfA=;
        b=gFr99crq0V1ai6Z33ASRJfu84PS6NMz0aZANYNK5O7ve72EtHFTIGL/fW/cjaSaXPu
         YVdMlDcsKNmDp2ed1txoVPjY5GMFIwFSK3UyrgUbpsxC1okalZclKd/VMTgp+q8AoKWD
         OiteDrQt9vOj8L7Z0FDvhksjUa2QqJOOveB5Tn/DH/AR2uBUqRLV2TIZPI2sRhYtC921
         zIFtwd7CIo4cb8EaMO0+NhkmoC2nMYrXWijDy0t+mRRZgnHjXUW4A/qAcWE1A14fv1JF
         fXcN0gktXUmUytSfZawBfZbpyHyfg+/p2+FEUHU/U7VqLgEOVutEm4MSlBjwaBrZAf4+
         J/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7bgrY9o8OGjMkm0Pse5Skl0eO2b5ukOBwbOfVLrYRfA=;
        b=dFKRvIo5YNfAQjnk1zBQqeHH5S0DlEgII1klpJyaJSUb7UTCi/CJsixPL2zrXwUzCU
         U7DVkWw3r35Y0ua3eY55X7Q8Ob5hucN1v0sJwfgt+1vX5berAnmHRV4OPFFkJSP6ox+6
         ikVRiUzWcxwuoTHe1gR/g/FQhKduFhfJPtZTJEKj9Oa6yfKxnxCOYCw9giP5oBH3cQ/j
         cC4qRLwPfultlkbRLBDMpbPZupvAe5juFtlti6zFU/RafhzHD58yfgWmoZybsnSG6Zjo
         0resdG891LAAnn5ZgGmQqqoz1H2gzGsMUp7J88z1Mb62ezxshFPvOYDQ9okZbxLd71Lb
         LpBQ==
X-Gm-Message-State: AKwxytf7EK8gWLbohP/apN+4hhsEbMZCklwpC5eWwFGlT104vS0lTkqv
        9OB80zEAyE6HfDt9G9kTLwsTZo4zm2g8YE7pAdQ=
X-Google-Smtp-Source: AH8x224o8hOUvk/oDmK+Di1cpDIap1vUj8eb7UaqcwhhkZYh/8ymLdaW4s8Gscc+dHQ2mZ8bgmoRB1jO4FRvHw0pK+E=
X-Received: by 10.80.211.7 with SMTP id g7mr61189425edh.76.1517467227501; Wed,
 31 Jan 2018 22:40:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.177.180 with HTTP; Wed, 31 Jan 2018 22:40:07 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1801311441430.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
 <647382ac70bfb7035345304a32d08f4e7b51cd40.1516225925.git.johannes.schindelin@gmx.de>
 <b3b37af6-4b65-5a44-a395-6f75a4adc98e@talktalk.net> <CA+P7+xr4KtR4q8Y=-+pv2TzvP009zRVR6a_zh2GOZXt_LXrFOg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1801292230550.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <nycvar.QRO.7.76.6.1801311441430.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 31 Jan 2018 22:40:07 -0800
Message-ID: <CA+P7+xoau5Zq0ZjR5LXPocADU1AM9nW0d1Gsk8+_s4_MMu9uOg@mail.gmail.com>
Subject: Re: [PATCH 2/8] sequencer: introduce the `merge` command
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 31, 2018 at 5:48 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Jake & Phillip,
>
> On Mon, 29 Jan 2018, Johannes Schindelin wrote:
>
>> On Sat, 20 Jan 2018, Jacob Keller wrote:
>>
>> > On Fri, Jan 19, 2018 at 6:45 AM, Phillip Wood <phillip.wood@talktalk.net> wrote:
>> > > On 18/01/18 15:35, Johannes Schindelin wrote:
>> > >>
>> > >> This patch adds the `merge` command, with the following syntax:
>> > >>
>> > >>       merge <commit> <rev> <oneline>
>> > >
>> > > I'm concerned that this will be confusing for users. All of the other
>> > > rebase commands replay the changes in the commit hash immediately
>> > > following the command name. This command instead uses the first
>> > > commit to specify the message which is different to both 'git merge'
>> > > and the existing rebase commands. I wonder if it would be clearer to
>> > > have 'merge -C <commit> <rev> ...' instead so it's clear which
>> > > argument specifies the message and which the remote head to merge.
>> > > It would also allow for 'merge -c <commit> <rev> ...' in the future
>> > > for rewording an existing merge message and also avoid the slightly
>> > > odd 'merge - <rev> ...'. Where it's creating new merges I'm not sure
>> > > it's a good idea to encourage people to only have oneline commit
>> > > messages by making it harder to edit them, perhaps it could take
>> > > another argument to mean open the editor or not, though as Jake said
>> > > I guess it's not that common.
>> >
>> > I actually like the idea of re-using commit message options like -C,
>> > -c,  and -m, so we could do:
>> >
>> > merge -C <commit> ... to take message from commit
>>
>> That is exactly how the Git garden shears do it.
>>
>> I found it not very readable. That is why I wanted to get away from it in
>> --recreate-merges.
>
> I made up my mind. Even if it is not very readable, it is still better
> than the `merge A B` where the order of A and B magically determines their
> respective roles.
>
>> > merge -c <commit> ...  to take the message from commit and open editor to edit
>> > merge -m "<message>" ... to take the message from the quoted test
>> > merge ... to merge and open commit editor with default message
>
> I will probably implement -c, but not -m, and will handle the absence of
> the -C and -c options to construct a default merge message which can then
> be edited.
>
> The -m option just opens such a can of worms with dequoting, that's why I
> do not want to do that.
>

I agree, I don't see a need for "-m".

> BTW I am still trying to figure out how to present the oneline of the
> commit to merge (which is sometimes really helpful because the label might
> be less than meaningful) while *still* allowing for octopus merges.
>
> So far, what I have is this:
>
>         merge <original> <to-merge> <oneline>
>
> and for octopus:
>
>         merge <original> "<to-merge> <to-merge2>..." <oneline>...
>
> I think with the -C syntax, it would become something like
>
>         merge -C <original> <to-merge> # <oneline>
>

I like this, especially given you added the "#" for one of the other
new commands as well, (reset I think?)

> and
>
>         merge -C <original> <to-merge> <to-merge2>...
>         # Merging: <oneline>
>         # Merging: <oneline2>
>         # ...
>

I really like this, since you can show each oneline for all the
to-merges for an octopus.

> The only qualm I have about this is that `#` really *is* a valid ref name.
> (Seriously, it is...). So that would mean that I'd have to disallow `#`
> as a label specifically.
>
> Thoughts?
>

I think it's fine to disallow # as a label.

Thanks,
Jake

> Ciao,
> Dscho
