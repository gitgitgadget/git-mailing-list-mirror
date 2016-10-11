Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79854207EC
	for <e@80x24.org>; Tue, 11 Oct 2016 10:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752209AbcJKKyB (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 06:54:01 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33990 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbcJKKyA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 06:54:00 -0400
Received: by mail-it0-f65.google.com with SMTP id e203so1351772itc.1
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 03:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8/Ev7ap2X1L0Ywb9daPNkaeZBTAwFWIC0eR2EAbClu8=;
        b=oXfMy/pelCnC3JQp5PtQmHQM9A+VeunxRqYXSqdsXjCcvHi/kA8xNeYp2B7mlWWtc4
         hu2ErdFJwn2NgP6VKB4jvZmVKEFIlwBEB5Q7GmEfobP4FCoxeqkeMq0JQdEqB0WZUpxh
         ow58653PiV+Vh8YzSv8IgMFsW3dItXpN1PYgzU8Jzk3zBeuvD2E01knL0Mp6mKpsIx3A
         L+8ZOM6ZMVDD9Vlmv25ytk2cjgW2BolI0pLZUO2Pkryi3M2ZGBwmXByIN4zGk78ypD6i
         e8RjbYMJKeiNPaYa8SwurUFap77oJ/RQIVTD/DpNeloosdrFKlpY5esGOyut3/bfu/Oq
         SECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8/Ev7ap2X1L0Ywb9daPNkaeZBTAwFWIC0eR2EAbClu8=;
        b=bp//d/3hbpINLhCB2fw4AQ5zvUPspaPmb19Opt41v9wSGXXzdwrqpqLU5FMBUkyxkg
         RE72xCa3u0m7ZW6a9ZXsGRRVrbBtzDZ5bz/Rmwgcb0O/4XJAa8pCtzf0EuGzTYeFbGuZ
         oSk/Q4oMuONrt2VsRf+rF5iqjjLbb5s2+mTfmqMYvuFU6njFGzDtbgyBsT02AwvkdKhF
         fQ1bbnliklJbGHKLAf/aaFBqaQYAyx7WrJxZjUZJ8OrXcc6JrUc62RRVi69gWOI/XQyD
         pUIFS4Tbgi7UFe0Y9c13y/YJYqyYxcb46MBulRLTTKjm/e1ZA7X2V3gAJG9pTdcuLsB4
         E67g==
X-Gm-Message-State: AA6/9RnJIz0C048GDOQDRtJ7WNQNjAxBbod+mIODn7MNjPcLvVV1a/aKAqaIVmSuQ7syjjr6wMvMTG+r1hym2w==
X-Received: by 10.36.112.135 with SMTP id f129mr16422036itc.3.1476183234140;
 Tue, 11 Oct 2016 03:53:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.230.206 with HTTP; Tue, 11 Oct 2016 03:53:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1610111142490.35196@virtualbox>
References: <20161006114124.4966-1-pclouds@gmail.com> <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610071319520.35196@virtualbox> <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com>
 <0347de20-72a7-b384-389f-4b2ad5789973@kdbg.org> <20161007175052.sxyk7y2ytjh36phr@sigill.intra.peff.net>
 <alpine.DEB.2.20.1610081034430.35196@virtualbox> <20161009060149.voqjoiltqi6jub7g@sigill.intra.peff.net>
 <CACsJy8BpYYJmBm32YsQyuP58uhLE+sn8WdhiHyY6xzcqPVjMVQ@mail.gmail.com>
 <20161009205854.byq2wqgemtmwudfb@sigill.intra.peff.net> <alpine.DEB.2.20.1610111142490.35196@virtualbox>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 11 Oct 2016 17:53:23 +0700
Message-ID: <CACsJy8Aufm7g9SnckiXbMCOOvsLMqESRHLR+Zd94HxPeJj=gTw@mail.gmail.com>
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 4:44 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 9 Oct 2016, Jeff King wrote:
>
>> On Sun, Oct 09, 2016 at 06:32:38PM +0700, Duy Nguyen wrote:
>>
>> > > If you mean ambiguity between the old "alias.X" and the new "alias.X.*",
>> > > then yes, I think that's an unavoidable part of the transition.  IMHO,
>> > > the new should take precedence over the old, and people will gradually
>> > > move from one to the other.
>> >
>> > Do we really need to treat this differently than
>> >
>> > [alias]
>> >     d2u = !dos2unix
>> >     d2u = C:/cygwin/bin/dos3unix.exe
>> >
>> > ?
>> >
>> > Another similar case is one d2u (could be either old syntax or new) is
>> > defined in ~/.gitconfig and the other d2u in $GIT_DIR/config. In
>> > either case, the "latest" d2u definition wins.
>>
>> Yeah, that's reasonable, too. So:
>>
>>   [alias]
>>     d2u = "!dos2unix"
>>
>> acts exactly as if:
>>
>>   [alias "d2u"]
>>     command = dos2unix
>>     type = shell
>>
>> was specified at that point, which is easy to understand.
>
> It is easy to understand, and even easier to get wrong or out of sync. I
> really liked the ease of *one* `git config` call to add new aliases.

I was about to bring this up. Although to me, "git config --global
alias.foo bar" is more convenient, but not using it is not exactly
easy to get wrong or out of sync. For adding alias.$name.* I was
thinking about "git config --global --edit", not executing "git
config" multiple times.

> Not sure that I like the need for more such calls just to add *one* alias (one
> config call for "shell", one for "don't cd up", etc).

We could add git-alias if more alias types pop up (and in my opinion
git-alias is the right call, we've been abusing git-config for alias
manipulation for a long time).
-- 
Duy
