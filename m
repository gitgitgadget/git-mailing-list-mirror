Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 549F91F42E
	for <e@80x24.org>; Fri,  4 May 2018 07:27:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbeEDH1d (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 03:27:33 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:42246 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbeEDH1c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 03:27:32 -0400
Received: by mail-qk0-f195.google.com with SMTP id j10so15910676qke.9
        for <git@vger.kernel.org>; Fri, 04 May 2018 00:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Euhgk37ueUytHa6F5gcBDGQ8Wb/YPfJa2+PMWBbIbvg=;
        b=rzk+nRbliLoVWFakwF8V07iz4u9g0UP0AKZ0T8uqrlfXiFTOPlTcpDWu7LPZ07hPfd
         21BcVsqi1UU5vzcxrb0nbxBVX+Yqs8kmbBk05NGK3x5ahX7h2xCsje9G3gX9GEJfUKXB
         BLV4XW3WjJ8JzlZFUqnu4240z64mFYb6Hha9ZCGGfP4X1mLbHgJOqzKSvDdKkD6A7eJx
         cSo7TDRfJV6dTokxfxguafMLp2QpdXScIn92NZ2RK6aapEme+9KJBQ+zwT3KlhVWtlxn
         9FCSQK0dbMZ8mIOgtiajQaR8tpiTCbHJRyjv3z8qf6M+JXIQnjpRmUVLqz/SC/TQXGLh
         BWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Euhgk37ueUytHa6F5gcBDGQ8Wb/YPfJa2+PMWBbIbvg=;
        b=f1GKN2VvvXF/dqd1t81+gd024o/N4DB8DiFfusygvcx9HiIODLJqNhcwCZpOCICKas
         quVWJQUI/h0Ag85yYe4ewIDb2WLOyTvKbkDk2299E3sE7VNvIf+FUHU2FkQAsr4pjH9K
         dLimhELEC9DOL6hLRN8N9wpsVaOxs/OXmwmQKK2QZZ9Stmw3BrYSywbfUQsCPWaS34gK
         Ak07bew8GH5E/EU+yczAuQSo/5JNhMp3nKdth4X5fLGzeANLAQeMnR/6xPMjo/wyYOS5
         xYm3wrJ+JR1iiQDVDOWe4RV2oMKf86r4wWM4mAsyg1oDjYbKQSP2bVkbC40k0z7CL7cv
         I4hA==
X-Gm-Message-State: ALKqPweVYFVuKOBllyRzhl2l1jsvsyA8JHMkvlIshhBAiR7l9D8mK4yq
        ZWX4TsZxofkUo6qf0AT8D+/Qip74RSvBpXPJ+/w=
X-Google-Smtp-Source: AB8JxZoXS0lqXEZXsXqAIO7tpHXTdSsKvbeKWNY/r0Rh6xzVlfn8NRm6daQSS9TtQjr5JfwkVtJOvkZUncybbsjyoPw=
X-Received: by 10.55.190.134 with SMTP id o128mr5359711qkf.141.1525418851823;
 Fri, 04 May 2018 00:27:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Fri, 4 May 2018 00:27:31 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1805040843050.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de>
 <CAPig+cQv7tNCNhDdThhhDYEE=XmB0xO35Qjvpw+-MgCg0W3ovQ@mail.gmail.com> <nycvar.QRO.7.76.6.1805040843050.77@tvgsbejvaqbjf.bet>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 4 May 2018 03:27:31 -0400
X-Google-Sender-Auth: xSQlnAoHHJIf535S4IxfM8H4MAk
Message-ID: <CAPig+cSVve5vK6F6CgOoTahKZtzU5Pvv8c6DJzFSMeeqcB1fug@mail.gmail.com>
Subject: Re: [PATCH 02/18] Add a new builtin: branch-diff
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 4, 2018 at 2:52 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Thu, 3 May 2018, Eric Sunshine wrote:
>> On Thu, May 3, 2018 at 11:30 AM, Johannes Schindelin
>> <johannes.schindelin@gmx.de> wrote:
>> > +static const char * const builtin_branch_diff_usage[] = {
>> > +       N_("git rebase--helper [<options>] ( A..B C..D | A...B | base A B )"),
>>
>> The formatting of "<options>" vs. "base" confused me into thinking
>> that the latter was a literal keyword, but I see from reading patch
>> 3/18 that it is not a literal at all, thus probably ought to be
>> specified as "<base>".
>
> Good point. Or maybe BASE?

Indeed, that's probably more consistent with 'A', 'B', etc. than <base>.

> Or I should just use the same convention as in the man page. Or not, as
> the usage should be conciser.
>
> This is what I have currently:
>
> static const char * const builtin_branch_diff_usage[] = {
> N_("git branch-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
> N_("git branch-diff [<options>] <old-tip>...<new-tip>"),
> N_("git branch-diff [<options>] <base> <old-tip> <new-tip>"),
> NULL
> };

I can live with this. It's more verbose but more self-explanatory,
thus likely a good choice.
