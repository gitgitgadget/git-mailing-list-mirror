Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04CB31FEB3
	for <e@80x24.org>; Fri, 13 Jan 2017 01:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750869AbdAMBNS (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 20:13:18 -0500
Received: from mail-lf0-f53.google.com ([209.85.215.53]:36602 "EHLO
        mail-lf0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbdAMBNS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 20:13:18 -0500
Received: by mail-lf0-f53.google.com with SMTP id z134so22457210lff.3
        for <git@vger.kernel.org>; Thu, 12 Jan 2017 17:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VkQ6qI4v9K+2+mXfh+BsImShWEnwQaU4ZgLKzwkGy68=;
        b=QE0LDBJNYXRnkOrd/nE6KSKLK0MCeeyTE5qegOij1lmwrN6m3XQLObOUDqN8yTLFj/
         WmOrpGsPS96aTGedCTj6JFeYe14eXjXdpAJ2iIReXvSWoP0JcKAIH0WpblwKzVIbXCDl
         YqFc6yBFthIkDqSL56MftfW8sCuCNy3CzJBoLnBMBMVjZgkiXPOpYkZahF2vZoNNLZLE
         L3I3BzXH9tqYei5XqHePiudONpoYXC0SI/9jvkTbTZ/eZB6pUMlqToaruP/4gMLrsnrM
         IbnBcTMXxP+wJA7WTytvOvLEVLNt3NopnLzxOu+X700sTqqzQvNc9V2269Ole7DSO8E2
         1DSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VkQ6qI4v9K+2+mXfh+BsImShWEnwQaU4ZgLKzwkGy68=;
        b=GVlZmzpR29F8vH6ATd3+bp1315m80C3fWK2hT/Lps5pAzMwnqNVvBKXK48/s8vKGLU
         TnyNspoUHp1tpBm3yPAvzABLCsA36JRzQdBtxn4QXMPXhoPM7gZ++/Bc2cXblUcbnPUA
         tKZEsnCt91C/yWG5LnGSAXHyw667Gtp8K/HEKCiGROjYbeIM+jijdfkOgk4NHTA79oUB
         BcdpHKwokMhwH5HjmpZSsVG2d4CD9IFggPml7LutEHKVb2O5vAvNF1npkdF23vsEDoZ5
         9g5yaCFqkt2BbJAB5NO70PpO7zQzvun1bJtWIwOG1J7tf3ufhnZNvl1NM2Im52L6qwNj
         +LkA==
X-Gm-Message-State: AIkVDXKMx/xsa+qaAC5ZicbFlt62HD7Hwp1odfHm3S7Gj18sKl31f5dZ5reP02rD6BNBb09hlsGxzbGqPHC3PQ==
X-Received: by 10.46.7.1 with SMTP id 1mr6583620ljh.76.1484269996027; Thu, 12
 Jan 2017 17:13:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.199.13 with HTTP; Thu, 12 Jan 2017 17:13:15 -0800 (PST)
In-Reply-To: <xmqq8tqfj15z.fsf@gitster.mtv.corp.google.com>
References: <87r347swz1.fsf@sonnengebleicht.fritz.box> <xmqqd1frj1lt.fsf@gitster.mtv.corp.google.com>
 <xmqq8tqfj15z.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 13 Jan 2017 02:13:15 +0100
Message-ID: <CAP8UFD3JDWVVTWsSQcnh+dOHoZDcipVUFwkfQYNOAyV4431C2w@mail.gmail.com>
Subject: Re: Bug report: Documentation error in git-bisect man description
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Manuel Ullmann <ullman.alias@posteo.de>, git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 13, 2017 at 12:42 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Manuel Ullmann <ullman.alias@posteo.de> writes:
>>
>> Hmmm, I tend to agree, modulo a minor fix.
>>
>> If the description were in a context inside a paragraph like this:
>>
>>       When you want to tell 'git bisect' that a <rev> belongs to
>>       the newer half of the history, you say
>>
>>               git bisect (bad|new) [<rev>]
>>
>>       On the other hand, when you want to tell 'git bisect' that a
>>       <rev> belongs to the older half of the history, you can say
>>
>>               git bisect (good|old) [<rev>]
>>
>> then the pairing we see in the current text makes quite a lot of
>> sense.
>
> Actually, the above is _exactly_ what was intended.  I misread the
> current documentation when I made the comment, and I think that the
> current one _IS_ correct.  The latter half of the above is not about
> a single rev.  You can paint multiple commits with the "older half"
> color, i.e.
>
>         On the other hand, when you want to tell 'git bisect' that
>         one or more <rev>s  belong to the older half of the history,
>         you can say
>
>                 git bisect (good|old) [<rev>...]
>
> In contrast, you can mark only one <rev> as newer (or "already
> bad").  So pairing (bad|good) and (new|old) like you suggested
> breaks the correctness of the command line description.

Yeah, I agree.

> If (bad|new) and (good|old) bothers you because they may mislead the
> readers to think bad is an opposite of new (and good is an opposite
> of old), the only solution I can think of to that problem is to
> expand these two lines into four and list them like this:
>
>         git bisect bad [<rev>]
>         git bisect good [<rev>...]
>         git bisect new [<rev>]
>         git bisect old [<rev>...]

Maybe it would be more complete and a bit clearer if it was:

           git bisect (bad|new|<term-new>) [<rev>]
           git bisect (good|old|<term-old>) [<rev>...]
