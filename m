Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F776207B3
	for <e@80x24.org>; Fri,  5 May 2017 22:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbdEEWuM (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 18:50:12 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:36420 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbdEEWuM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 18:50:12 -0400
Received: by mail-io0-f173.google.com with SMTP id p80so23496955iop.3
        for <git@vger.kernel.org>; Fri, 05 May 2017 15:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T6tz2TSehoeIGawio07vvPBS9DUIn4Dlxcxc9Iqn57o=;
        b=Kcaf+DM6/zwOiZI5WIr46phMt1Y0WJDojeCPXk4AY11gBOOqlRswj/p1hwCI0R2Heo
         sY63RC0XBeHelZ/32EFdmNUQuyVHO+kLl69s7ceh+pSDWzGXyvYC39U0e0RwvlJxX73x
         ruQmOKxUk3M/55I3KCEbjYJif37bV5dIz7y0jvjWG/0ggjmkJjKRxYPCIH/o7PyWnmqm
         J82dh6Ph8JQ28C4BXTXWjF0zyeoD6Sq3JLPv1XK4XBDvQKaRxJQJvGdqHbX+UTdlcbbE
         /uJf9P8laV4kaohN1z+5juuaor+gzOaZeujKWkWIzeLCHlawcNYQ7vcLAB2ZV6Dj61Rv
         ykWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T6tz2TSehoeIGawio07vvPBS9DUIn4Dlxcxc9Iqn57o=;
        b=caUROgbrEQTyl2UpdrRopZZuc6SBfvyZANTffkEov+G+iYiTTXICyfxkEMil7tP+zy
         blnpR/1zx4nFDefzTntfaT7giugl0wYRrsJx+PMJiyacYIamKfuaI5dQFg67zv3vx94V
         jPKzbR0coARpYhXhsniGlAaJEq7MtKezcWDiKyq/Zd0pxQNNRLX6hTzLPIju70tG+S6F
         LIy8PljxRxQDMQENrqGuCZOc3GRmMvrOB9Hq92iWYwjZXZbZJ+pJZqvwlT9wBrq0Jiqp
         8ypPPnpv5ygJrIJZjbK6FQ4lAuAclMEyAZELE94w5A3nLmtCiwPOMVjvJvZanGSDXn4k
         wnIw==
X-Gm-Message-State: AN3rC/67CTO6637rOeOri9mR6WxqX963SviYevq4/BHxO4GkLmVXwXpv
        5t7f3BIPLhKOXAq17d75MOkg2R9oZg==
X-Received: by 10.107.138.9 with SMTP id m9mr47186651iod.80.1494024611300;
 Fri, 05 May 2017 15:50:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Fri, 5 May 2017 15:49:50 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1705052328380.146734@virtualbox>
References: <1494009820-2090-1-git-send-email-bnmvco@gmail.com>
 <1494009820-2090-3-git-send-email-bnmvco@gmail.com> <alpine.DEB.2.21.1.1705052328380.146734@virtualbox>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 6 May 2017 00:49:50 +0200
Message-ID: <CACBZZX6_GbqNpTXTB8UQJzvD2nx_UTN8fwHV8Aczg+b9XoO_tg@mail.gmail.com>
Subject: Re: [PATCH 2/3] add--interactive: add builtin helper for interactive add
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Daniel Ferreira <bnmvco@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 6, 2017 at 12:30 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Daniel,
>
>
> On Fri, 5 May 2017, Daniel Ferreira wrote:
>> +static void print_modified(void)
>> +{
>> +     int i;
>> +     struct add_interactive_status s;
>> +     const char *modified_fmt = _("%12s %12s %s");
>
> We cannot really translate that...

He copied this from the *.perl code:

    # TRANSLATORS: you can adjust this to align "git add -i" status menu
    my $status_fmt = __('%12s %12s %s');

And one translation at least makes use of that (and probably others should).

But porting the /* TRANSLATORS: ... */ comment over is missing, and
should be added.
