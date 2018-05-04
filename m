Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DCD1200B9
	for <e@80x24.org>; Fri,  4 May 2018 14:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751311AbeEDOpV (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 10:45:21 -0400
Received: from mail-ot0-f179.google.com ([74.125.82.179]:46135 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbeEDOpU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 10:45:20 -0400
Received: by mail-ot0-f179.google.com with SMTP id t1-v6so24724326ott.13
        for <git@vger.kernel.org>; Fri, 04 May 2018 07:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ah/Hq+txy8M7hXfA5FqbGZ4Oo1M1yW/oRVjN3VnrM+g=;
        b=WVCtoTgXku3rMAnvV5ntIdbgO9eTG7S5jEgMPKdIlaxnptbRB4PJKv00ej8UEhh4oI
         bcKWZHIjoK8euUT9beh9hA68pddB8QTHDDTBFjnNZ7sJQQ0raoyGBJmpNuEMH7uH+BcX
         18nwF9xH3GwirtKY4trQGFMbJWG6H2ZIXPjnz4ZM6QneDYI0tcbqxJI22HEa4sP1jrdl
         LuYOx9MvrAIyVuQSLW+JvM54cocR1xk90+L08YR7TmzMj8WtDqa52WLHUVELx1lqlWNb
         X9DpCEATtzJKr6NM4/20g4CMrahVyBZ3HNfN8ZAne/CdDGWFn6UcTaPM9eJo2UEoL8vg
         zxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ah/Hq+txy8M7hXfA5FqbGZ4Oo1M1yW/oRVjN3VnrM+g=;
        b=sQa9bzkxYau5slOSEGqmkstrnOO9Kf+dPHpcZgYrR7y7S08gKjzFn1zQsCNxveoNvz
         QqMjT9+6MEaREt/f0I0JGKdp1AL8iWhAAGJgQyuWJA1koxUNs+8WXTsOGQ5Q+2IRfphJ
         hj8H+XIwCY+BEhwl3+hfpt/RF4vk2y+eGGG2bhDYzypZnH8mz/8qdSVTVS2FQGP4smp5
         9j7Fa2ou+nwcBVWDNZqCr5LqjCNi62MD6cYCzkialY7Xfs1Tsmdxkum5X9eKnK9D2XD+
         kwkGGJSf0iZedZcbVfs5Ab8lzSb+r7gxoN+vHcIKABqiiBbc5sg330LGAmhVjLqOduKn
         GGhw==
X-Gm-Message-State: ALQs6tCeXNjtbPYh7C7AMOmXZC/lIuMxmO3/9Xk812vXBKQ9l9br3Eqd
        +7mbwanujzedTKa/GAOIE0lUQrDYalnXi5V10zQ=
X-Google-Smtp-Source: AB8JxZp+MRlRoggxztRQOi5Al8dSjkePTWkOCUa5To19YEUH1nglHwTgL3IhytzidHSPrWnuZdzfEbloJlhBaCRQJyA=
X-Received: by 2002:a9d:2fa6:: with SMTP id r35-v6mr21074785otb.356.1525445119923;
 Fri, 04 May 2018 07:45:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Fri, 4 May 2018 07:44:49 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1805040919400.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de>
 <CACsJy8DF8twvST0tcHfFqYWaV_0dVRCfJj-QuuCK=0h+gjJ0wQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1805032229050.77@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1805032232080.77@tvgsbejvaqbjf.bet>
 <CACsJy8CRCb2go5qUBOdiSNvvAShotD=e4Cm3Jo1OxNk212YtCA@mail.gmail.com> <nycvar.QRO.7.76.6.1805040919400.77@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 4 May 2018 16:44:49 +0200
Message-ID: <CACsJy8AnWC8bLfhj25quzHokber-wrWdSsJiCDra=Ymr++0-nQ@mail.gmail.com>
Subject: Re: [PATCH 02/18] Add a new builtin: branch-diff
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 4, 2018 at 9:23 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Oh, okay. It was not at all clear to me what the exact format and role of
> these lines are...

Noted. I'm making more updates in this file in another topic and will
add some explanation so the next guy will be less confused.

> So that's what `info` does: it influences whether/where
> the command is listed in `git help`'s output... Interesting. I thought the
> lines here were trying to automate parts of the tab completion or
> something.

Oh it does many things. The completion part is coming (so yeah you
don't need to update git-completion.bash at all, as long as you have a
line here and use parse_options() ;-), but I think it's mainly for
"git help" and command listing in "git help git" (this command for
example should show up under the "Main porcelain commands" in that man
page when you put a line here)
-- 
Duy
