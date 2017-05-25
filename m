Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFCE01FA14
	for <e@80x24.org>; Thu, 25 May 2017 10:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759491AbdEYKo5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 06:44:57 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:32780 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759207AbdEYKo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 06:44:56 -0400
Received: by mail-io0-f181.google.com with SMTP id p24so134101134ioi.0
        for <git@vger.kernel.org>; Thu, 25 May 2017 03:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=c7N6PI0wHHr+yNhrdp6pSf/PnaYEZ6opfdXUPPUvkNc=;
        b=ePduNrBcTQakMhj0dw2Nw7WgqxsOr6W5PFk29ukX0fVnwujSvzuHMWV2uWzviRSiDt
         JvlL86d0apntmbC6tNyiMeS609+VqPzCsrSFTpVS6dTaoWbXjhBGDhFD4tuqvAw5z/hu
         WKOknUFxDmzhXMgg7IF6d1x4UZYrqlfUdgT886dbxO+030xP+P+WMHZ6TYAxk1ddgrrj
         JPqwNd5X1TsZg9RjD0JyoXCInHVhnmNgV++NiMZLxFGCdqzCWSIEukUNZwKtcfSt3rF/
         KvZ0m15tzEKOMWMnAoLQn19lA8C1ggj7NyujvA9PefEa1SnRyaC9y1EkdQaaMdFY5axr
         Ja7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=c7N6PI0wHHr+yNhrdp6pSf/PnaYEZ6opfdXUPPUvkNc=;
        b=VJCaU6faqiOM3KFnaaZAXm+x20W6I7soDR+1DgTH5mxJSRcTekM1HAUGXgJljH0YU4
         fIQ4H7FB6/hC7YHJMj9VYedZjsvS05vjmX5aAtT7vseiVPlEiAYakd2Rob7TIQjsN0uP
         jf9V8bfTgurjQnNsvtBLXQgruIobJ0WZhRJeZVGPCJY4QP9kNL/2t03arMnarfkpCwxF
         zBT0svPCf4fxv7EKt/dnF6oN3OtKV2pooC64foHh3zaumNFSXUgEnTrMZuh0rs6iCTN2
         3J/Ncg/zjzQWdN0BkGdypYBdUYo1pQChNsy39GUtL55k2fXlf+dYOJuX5IDDvIzkW28V
         bzEg==
X-Gm-Message-State: AODbwcCWtMLxVXlRy6ERIdnMAzkQz+M2VfQvWBMKILbAq+2xJ+uOMqgY
        StRS2uXqn1QevvpUT9p+hzP19RB0rw==
X-Received: by 10.107.138.21 with SMTP id m21mr36309637iod.80.1495709095153;
 Thu, 25 May 2017 03:44:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Thu, 25 May 2017 03:44:34 -0700 (PDT)
In-Reply-To: <xmqqo9ujk9ii.fsf@gitster.mtv.corp.google.com>
References: <xmqqpof3srw4.fsf@gitster.mtv.corp.google.com> <20170520115429.12289-1-avarab@gmail.com>
 <xmqqbmqko7c2.fsf@gitster.mtv.corp.google.com> <CACBZZX4d4-EGiUtJQT8cvuMzm0c5DUu5sxUb11kUnJu3ocuSHw@mail.gmail.com>
 <xmqqo9ujk9ii.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Thu, 25 May 2017 12:44:34 +0200
Message-ID: <CACBZZX5Aa9cQngCgMVP2kb8Jnk_V7coK-f5J6jMOhn=AWCrXzQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Update sha1dc from upstream & optionally make it a submodule
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Marc Stevens <marc@marc-stevens.nl>,
        Michael Kebe <michael.kebe@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 23, 2017 at 3:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Seems like it would be useful to have a way to ex-post-facto say "past
>> history should use these URLs". i.e. if all git.git mirrors go down
>> and we have to re-host, then you can just clone git.git and off you
>> go, but the same isn't true of past submodule urls, or is it?
>
> I do not know how heavily you are used to use submodules, but I
> think submodule's URL is copied to the config of the superproject,
> and that URL is what will be used from there on, so "past history or
> future history will use that URL" is already the case, no?

I haven't used them much, just starting to get familiar with them now again=
.

I thought given your "if it is ever rewound away in the upstream
history..." that if we e.g. pegged upstream to that github URL now
that if that got rewound, anyone working with git.git in the future
would be in for some pain if they needed to check out and test old
tags.

But from what you're saying here that seems like a non-issue, i.e. in
such a scenario we'd just mirror the original repo[1], change the URL
in git.git to that, and then anyone could easily use older history
since it would be pointing to the new mirror.

I.e. in the spirit of my last reply, this seems like deviating from
the default workflow around submodules out of concern for an extremely
unlikely scenario, which, if it happened, would be easily mitigated
for both past & future git.git history.

1. Or likely just ask upstream kindly to push a tag with the old history.
