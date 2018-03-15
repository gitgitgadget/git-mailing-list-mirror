Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B06A01F404
	for <e@80x24.org>; Thu, 15 Mar 2018 23:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933155AbeCOXyq (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 19:54:46 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:40855 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932838AbeCOXyp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 19:54:45 -0400
Received: by mail-qt0-f194.google.com with SMTP id y6so9174334qtm.7
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 16:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=rXa02BujO6wRF2FLC9k9TKsDZYoM7oJM3CCvoM1olu8=;
        b=a7O+AEsDf87rmQah6dBKovWJDe5UR/JezddTriWJq21ZLeItE2Ry9xRCiFnJJNYZli
         xNK3kg0184EvjgtWV6wqBbG9/x9pjQ4YXdBWwblqRB6UWWCkHkpiGVOM+OqiAzNFGJ7g
         hunSUYp8bA8524NqiNWkj0pIUjc47neEEj4LKtk/7ajKn9LE9uM9WFO1geXwlyQQ/V10
         6+x1Kcqz5j9yp1IHWwEic9ERFXWJdwKOAF2fUzu0oEDDfTzudkLh4nByWsZ7AoSTf6nT
         A7wwJvlMJZvJ8JoegAp5UgvIMn+JuZnl3Xo4sTAKjoiIPaHrX31WH1gYYPuO3ruENbvM
         Ok8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=rXa02BujO6wRF2FLC9k9TKsDZYoM7oJM3CCvoM1olu8=;
        b=TPiE+zAviEsDHp7S5JqznOukRucFXuoTXRxkeBJ2+uG0j6HMv2OLIT4s5AG0o1PPwB
         89iqrxC0n1hA4ujdTvxwh4d7BWqEl+fpK8J+e+zI36cbLXlSBmV5+nl1Yrwr1jKA3xPk
         jOqRJ2IZjKqHU74RasAd1jQ0PZaI7aQhvEfQnRridm8ObjNJqLzsfdtU1i4aZ6evcJui
         e0wX3WiSmTkSxO9yaRelvvDdjUEevUeI231fM1FRirMahCfhgavD/uOWpZi8MumOTC8b
         gwhpPexLZiXg/DvmYcOflb/egkFg0XfONb6aOlYrnrwm7NDlVrtq9J5HFTrtiXb/Ngu6
         a2Pg==
X-Gm-Message-State: AElRT7EIdyUz/bupnP1d6qnLLbnwvBqX0ZshqA+AnoztgoGqETlHjfMO
        4IpAXCIAuP5YCsKBwUrONPvZ2lTAOazCEWe2NqWwmw==
X-Google-Smtp-Source: AG47ELt3cCgWjbSsnHVhTe/Ffwhj2aWWfc49UyTAvpdr8/eUO7yexWCSlllC16N4fpJ+twlqSiKs3xzpz9Y12w1egS0=
X-Received: by 10.200.38.188 with SMTP id 57mr15533171qto.220.1521158085002;
 Thu, 15 Mar 2018 16:54:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Thu, 15 Mar 2018 16:54:44 -0700 (PDT)
In-Reply-To: <328BE614-1927-450A-85D1-7391D0BB5C47@gmail.com>
References: <20180315225746.18119-1-lars.schneider@autodesk.com>
 <20180315225746.18119-5-lars.schneider@autodesk.com> <CAPig+cSvBi1pJYC-DND1_x9rHhmoAPs90B_3Fg53-X5FjtCQhA@mail.gmail.com>
 <328BE614-1927-450A-85D1-7391D0BB5C47@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 15 Mar 2018 19:54:44 -0400
X-Google-Sender-Auth: -k3S7FljM18oBSwzTVKW43_5hf8
Message-ID: <CAPig+cQpDKHwzjCHpka+v1uGaJNfJGSmXpAVwPWVXSf5F1pR-g@mail.gmail.com>
Subject: Re: [PATCH v12 04/10] utf8: teach same_encoding() alternative UTF
 encoding names
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 15, 2018 at 7:35 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>> On 16 Mar 2018, at 00:25, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>        if (is_encoding_utf8(src) && is_encoding_utf8(dst))
>>>                return 1;
>>> +       if (same_utf_encoding(src, dst))
>>> +               return 1;
>>>        return !strcasecmp(src, dst);
>>> }
>>
>> This seems odd. I would have expected the newly-added generalized
>> conditional to replace the original UTF-8-specific conditional, not
>> supplement it. That is, shouldn't the entire function body be:
>>
>>    if (same_utf_encoding(src, dst))
>>        return 1;
>>    return !strcasecmp(src, dst);
>
> No, because is_encoding_utf8() returns "true" (=1) if the encoding
> is NULL. That is not the case for UTF-16 et al. The caller of
> same_encoding() might expect that behavior.
> I could have moved the "UTF-8" == NULL assumption into
> same_utf_encoding() but that did not feel right.
> Does this make sense?

Not particularly.

Looking at 677cfed56a (commit-tree: cope with different ways "utf-8"
can be spelled., 2006-12-30), which introduced is_encoding_utf8()
along with its builtin NULL-check, I can see why that function wants
to treat NULL the same as UTF-8.

However, I'm having a tough time imagining cases in which callers
would want same_encoding() to return true if both arguments are NULL,
but outright crash if only one is NULL (which is the behavior even
before this patch). In other words, same_encoding() takes advantage of
is_encoding_utf8() for its convenience, not for its NULL-handling.
Given that view, the two explicit is_encoding_utf8() calls in
same_encoding() seem redundant once the same_utf_encoding() call is
added.
