Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 488781F453
	for <e@80x24.org>; Tue, 18 Sep 2018 19:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbeISBPs (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Sep 2018 21:15:48 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44977 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbeISBPs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Sep 2018 21:15:48 -0400
Received: by mail-ed1-f66.google.com with SMTP id s10-v6so2903216edb.11
        for <git@vger.kernel.org>; Tue, 18 Sep 2018 12:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EdAD8zZu2lmdf7Lp2uaR6VRLkYnNK+GxA0WqludZWao=;
        b=h4AomQAxP3q04mg48+gkVZwe3wspZW45oLA+hm0eFqpMl0MHzaR3FqRH1wkfP1Aapc
         en9Jxvn7hdARr9Wzxvp28t7Y8zxuyPZQFSAYtlzOnGG2tAIJ9tWGscNYqKJwaXcaXohu
         D/lGU9NwiaQIXRg/jRq6crzMEKRpXzA+S+LkMMjHQq/UEZNcJUsFDtXVRCv0drYtADh3
         w3E3wHY4bdTO7OSOP18hjmfLKZPD/I52KjCnp1MLE9eX+mg4l1EsVT+k/R14sYCHhbyR
         r7y++e8NibS5Hck60uhdotAQrkrp38fDUP1Wt8mHSIyyH803N34XCxHxTVNUqjaT9/nu
         MQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EdAD8zZu2lmdf7Lp2uaR6VRLkYnNK+GxA0WqludZWao=;
        b=UDgt2vb6XRN/ZfvLzyzDRxFP7+7i4DPQDSJ1CriFRCcFpfCHo6HEt/72nrvLVNpTFs
         YUN8SBETnm2lR82/KGFfPzAvKcxFz00UjNeooIaKcruHsb0JkWHmIlSCrKaio0WwIh9Z
         yvg/kOd9JRUhBqjiG2IZNOSTTZPmrJEP0Oi8diZRIWGbdHz9aYWjEaFXJNBLvYHDPoQD
         tK6Hy83aCI6RYLTDgJjSHbcrc4CrO8QxT9USWRc3X8zlEj9GE4ZIYbJZqqJb6aL4PT8r
         jUozerY8+x2Ik8qUSlktKgwF1Ste2jnCW6l3QQvMsHayUMmGkG03s0DzCkpsTc/wOqdW
         JsYQ==
X-Gm-Message-State: APzg51CAFZND8JqQ5qc8Lr6q7HFVQVw06knGeGYpdPwt0zRgqBuPOyIE
        tGELTjWCPlhluJqjO8NrMTdWIye4e/LnkFTywDg=
X-Google-Smtp-Source: ANB0VdbA9lj0muy6d/Gk0X2FJCBZqZm5lrc2ry59gQY/dUWoVuTYBKjBHCBs2fiqMdYbQDdWhIQFV5G1krxPOtmILkE=
X-Received: by 2002:aa7:c708:: with SMTP id i8-v6mr52373952edq.231.1537299702248;
 Tue, 18 Sep 2018 12:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180820154120.19297-1-pclouds@gmail.com> <20180916063146.9850-1-pclouds@gmail.com>
 <xmqq1s9s82zx.fsf@gitster-ct.c.googlers.com> <CACsJy8C5QOLvg4pzy_pThQoyGh9ohdeVHXsuYwQHQypn3oBxkw@mail.gmail.com>
 <xmqq7ejk6i46.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7ejk6i46.fsf@gitster-ct.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 18 Sep 2018 12:41:30 -0700
Message-ID: <CA+P7+xq1zMM=S+HBTAfTJcPVo35PtUCq+staQ8SnSXxP0RShXA@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] Make 'git commit' not accidentally lose staged content
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 12:26 PM Junio C Hamano <gitster@pobox.com> wrote:
> FWIW, I didn't mean to say that we should give users a way to
> recover.  Your "commit -a" or "commit $path" protection just
> prevents the situation from happening, and I think it is sufficient.
>
> The sole point I wanted to raise by bringing up the above was that
> we should have the same degree of protection against "add $path" or
> "add -u".
>
> Of course, "index log" is interesting and it may even turn out to be
> useful (I was skeptical about "reference log" the same way, but it
> turned out to be useful without burdening the system too heavily),
> and it may even remove the need for the "do not accidentally lose
> information by adding more to the index" protection.  But until that
> happens, if we are to have such a protection, we would wnat to give
> the same degree of protection to "commit" and "add".

I think having both is good. There are a lot of ways to accidentally
throw away work, and it's pretty frustrating to have it happen. But
the reflog is also somewhat complicated, and I've definitely seen a
lot of developers who've never heard of it, and struggle with the
concept.

I personally think having the nice "it looks like you're about to
throw away all your changes, are you sure" style of protection using
something like --clobber-index is useful as a mode, even if we have an
index log of sorts. Having it be default helps new people, even if it
does get in the way of someone who knows what they're doing. Having it
be configurable, to me, sort of defeats the point, since it means
having to tell people to turn this on.

I personally don't mind having to type an extended option to clobber
when I know it's what I want, but I can see that being painful.

However, if we had a reflog for the index, this becomes less of a
problem since recovery is much easier.

Thanks,
Jake
