Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE0D21F404
	for <e@80x24.org>; Thu,  8 Feb 2018 12:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752432AbeBHMFl (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 07:05:41 -0500
Received: from mail-oi0-f53.google.com ([209.85.218.53]:43574 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbeBHMFj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 07:05:39 -0500
Received: by mail-oi0-f53.google.com with SMTP id 4so3285030ois.10
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 04:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7jhpvP3/gjbJ8epG9Ukcf5RL/CLt7nZqVY3rgG4VUG4=;
        b=nHifsDHJSDS03qWGO+pZU6nPP44E1xEycph8zsJdpT/vYKBzPyDzk2UUOWgjh7fcwC
         aZ2XjnPsN8jSuafAQwfFQT4yaut8MBb1o/JdSOfFkbl0LLLdBYD8er1br0T05R6tk+aY
         3ttKFkdU9qK41ItC3+FpEgF6rJRNjLJehJIhhlIQigAmoERP4sVyMSR9bQ8oE8fMiLXB
         pYryPZfybiSzLmz+lVczCFlVDzx3yfhp1VZSEg3XyTHxb30sF1nzPW4I0brRqsO7BMZz
         GEYjP84NJ8CnwRwVdLuT808nKUJ0X381ohoG+unwZwzG9IXizvymR6tGXvyImXntGuVS
         Vmpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7jhpvP3/gjbJ8epG9Ukcf5RL/CLt7nZqVY3rgG4VUG4=;
        b=fikGswX8lMB+toy2EZ/oxp+bVA+Q5YeV6pcV3wtH9NKRflUf9y6eMkfKE9D7jCZKJ5
         F0663ml0lVprVcHPW56X4Gg+nSMBA9nSaRtxnp09D4X86yrkqlXqjWz/ZQEoZoTcqfZd
         4Whp6NTPYNTPJ2v+IelZaXYtuXLakmxpwPpd8P8Twu96DErh47SWvEdEVWD3AI3Cw/cd
         DzXdMjftKaCbRgYM1INnJaIPiOahgYjJP8dfZAQZ0eqyguNhCpW9Mqm4lRgO/c8eZYxJ
         jyP/yDLXXN00L8BgFgxm0yE+bPa3eXMO2HKSLNQxEYOx4LJTYf6UsA/Caz0GNVJ02sK+
         EnuA==
X-Gm-Message-State: APf1xPADU31AhisJBUqGRwq5xdY7/YpszpcdJVhoZ66mhVoUDPacccQ8
        lxcKe7qYHWjUVGJvH0ZSrCI01nHHgKw3qA4T+pk=
X-Google-Smtp-Source: AH8x227jzrs1C4vrbozgQwkQVJOhPgwStj04u5sDoqnLMEH56qYp52hRSgzGGTDWWB2qvZKkA3FIUTGKwXrA2w4zfh0=
X-Received: by 10.202.196.208 with SMTP id u199mr310043oif.117.1518091538834;
 Thu, 08 Feb 2018 04:05:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Thu, 8 Feb 2018 04:05:08 -0800 (PST)
In-Reply-To: <xmqqr2pw7ge3.fsf@gitster-ct.c.googlers.com>
References: <20180131110547.20577-1-pclouds@gmail.com> <xmqqr2pw7ge3.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 8 Feb 2018 19:05:08 +0700
Message-ID: <CACsJy8AJGr_5vjDGVp7h-2DbOvi3=uY3waoSm+Ko-muAuLxdoA@mail.gmail.com>
Subject: Re: [PATCH v2 00/41] Automate updating git-completion.bash a bit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 8, 2018 at 2:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> I posted a proof of concept a while back [1]. This is the full version.
>>
>> This series lets "git" binary help git-completion.bash to complete
>> --<stuff> so that when a new option is added, we don't have to update
>> git-completion.bash manually too (people often forget it). As a side
>> effect, about 180 more options are now completable.
>>
>> parse-options is updated to allow developers to flag certain options
>> not to be completable if they want finer control over it.  But by
>> default, new non-hidden options are completable. Negative forms must
>> be handled manually. That's for the next step.
>
> Everybody seems to be in favour of the approach taken by this
> series.  Is it in a good enough shape that we can merge it to 'next'
> and then go incremental from now on?

Not until v3. v2 breaks Mac OS because I used some fancy bash feature.
There are some good improvements in __gitcomp_builtin() suggested by
Eric and Szeder, which will be in v3 as well.

> Or do we want to keep it in
> 'pu' to give easier access to volunteer guinea pigs and wait until
> the way to handle '--no-foo' options are figured out?

Oh the --no-foo thing is definitely not part of this version. Once
this series lands though, people can start improving --no-foo per
command, even in parallel. "git foo -h" will also benefit from that
effort because we will be able to show --no- form only when we mean to
allow --no-.
--=20
Duy
