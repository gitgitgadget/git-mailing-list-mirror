Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F04E6202A7
	for <e@80x24.org>; Wed,  5 Jul 2017 18:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbdGESvc (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 14:51:32 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:32993 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbdGESvb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 14:51:31 -0400
Received: by mail-pf0-f182.google.com with SMTP id e7so133936651pfk.0
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 11:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Uir8fSuPnPVGzHnrnenwE3hIzH289n3XTEPHACnkEZA=;
        b=eGeE1eS4z8tX4Gb2NvVttVbr/PXMLcqfGzKnbYVbPutuFV4xz8XXVy++IC9lQ6pSsM
         3Hh70weJQu6vGuHAUzsunzMRYSHKz3ys4pBxZciAzQUsul4T9JzukPJN7kkU+frrW3JG
         BEPQtCoW/KsHWaJhqMmEfYIc8I6uuv82riwpJZiC7VQiofntEOjR1ZZx0RRKcGi/mpUa
         Cce7ZHGsmQWMsEiaA5zHkaZl6/1q1309s2QTlye+4QCNR6EpbnLqe39U9uHaV7STCQ8e
         opM0COdc5NZdYxBdp7VYwN3QSPexvgcbSqo8iuMxojCdRrW/v/oUK4gfsA6zdoPsOeqE
         azJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Uir8fSuPnPVGzHnrnenwE3hIzH289n3XTEPHACnkEZA=;
        b=luUMeQN5bxS/nw0ZNZzIhamVswvCi43/cvlNflkiES9+v7pnxYZ+/jUN9Qdv32dZXQ
         q8wjxGyY7nCCUG69LHmMrwfC59oruJVuwRhgi395ZHE3LwjM4JAQz7ij9p6J2bwA9//r
         51cV9H7zbLUEBykW1PIz1Qq7gHI7SwplsuMedZ29RHdYlkbDFFJevEzkX2+CZ8kDXgyf
         aYdKxnlzs6G6GNfTdx0p18sO85d225+d0Q+swmI5UZRZSCWD7VKZsktTGE+j/QrVctNa
         0CGa1PY3OKv3KmiR6EKH7LPTi4vb4SxbnBLuO/z8/zDhA5ohwA7jlmA6AEC0DonjvV5g
         NmaA==
X-Gm-Message-State: AIVw110AMX0vRuhC11ZPVATOr547aRL/Hi7AGmiwkFSwgNDOGe5LmgzB
        jrSJJGtw0fz64JQbyBZs8dT9629GDJTigmo=
X-Received: by 10.98.12.146 with SMTP id 18mr21640640pfm.167.1499280690911;
 Wed, 05 Jul 2017 11:51:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.184.2 with HTTP; Wed, 5 Jul 2017 11:51:10 -0700 (PDT)
In-Reply-To: <EA42AB04-D538-4B4A-BC19-CAE9A80EEA76@mazzo.li>
References: <1499116727-757-1-git-send-email-f@mazzo.li> <xmqqvan8jdje.fsf@gitster.mtv.corp.google.com>
 <CAPB=P5xsssm=RiAkEuAtpxe52+-sNAPVP2qnQGctLjNZFYznkg@mail.gmail.com>
 <CAPc5daXn=PJ47JkZQNnReNNSUhQK3eJm0Namd-A+e9TM4Dnr2A@mail.gmail.com>
 <CAPB=P5z7MA+TuVaFLUQQdOoJXUb74YxEPS6k4O+NorneVpLitg@mail.gmail.com>
 <xmqqa84ikj61.fsf@gitster.mtv.corp.google.com> <EA42AB04-D538-4B4A-BC19-CAE9A80EEA76@mazzo.li>
From:   Mike Rappazzo <rappazzo@gmail.com>
Date:   Wed, 5 Jul 2017 14:51:10 -0400
Message-ID: <CANoM8SXVYHfHqhf7oNfNUeDUWfpc9QGd8hvxu+g94aWEfQ1ZDQ@mail.gmail.com>
Subject: Re: [PATCH] push: add config option to --force-with-lease by default.
To:     Francesco Mazzoli <f@mazzo.li>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 5, 2017 at 12:43 PM, Francesco Mazzoli <f@mazzo.li> wrote:
>> On 5 Jul 2017, at 17:17, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> The take-away lesson that the earlier thread gave me was that the
>> order in which the three options are ranked by their desirebility
>> in the UI (and the order we would like to encourage users to use)
>> is, from the most to the least preferrable:
>>
>> - "--force-with-lease=<ref>:<expect>" that is safer than "--force";
>>
>> - "--force" that is known to be dangerous, and does not pretend to
>>   be anything but;
>>
>> - "--force-with-lease" that pretends to be safer but is not.
>>
>> The last form should eventually be eliminated, as there is no way to
>> correctly intuit what the expected object should be.
>
> What's not clear to me is what the intended workflow using
> `--force-with-lease=<ref>:<expect>` is. Intuitively it seems extremely
> cumbersome to manually pluck a revision each time, especially when
> dealing with commits that all have the same description.
>
> On the other hand for my workflow `--force-with-lease` works quite well
> because I tend to use it in cases where me and a colleague are working
> on the same PR, and thus I'm not doing anything else (including fetching).
>
> Moreover, it seems to me that the problem `--force-with-lease` is
> just one of marketing. `--force-with-lease` is strictly more "safe"
> than `--force` in the sense that it'll reject some pushes that `--force`
> will let through. I think that if we advertise it better including its
> drawbacks it can still be better than no checks at all.
>
> Francesco

I am in your camp on this, and I will also only ever explicitly fetch.
I would hate for --force-with-lease to disappear.

However, I believe that the problem is that there are many third party
tools which do a fetch behind the scenes (for example Atlassian
SourceTree).  This can update the local refs without a user
necessarily thinking about it.  This can lead to a force-with-lease
being used unsafely (without the stated lease).

_Mike
