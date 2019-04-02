Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29B9C20248
	for <e@80x24.org>; Tue,  2 Apr 2019 19:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbfDBTHJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 15:07:09 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:52396 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbfDBTHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 15:07:09 -0400
Received: by mail-it1-f195.google.com with SMTP id x132so5009687itf.2
        for <git@vger.kernel.org>; Tue, 02 Apr 2019 12:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m7Fnl+NRmaVX5Q28tvHO2Erurvf0mYOwE6C6uF/vs18=;
        b=zYQ5PtylmPhV5BvUl3GvuqWmT5an2yrMRChlnt6r8DQRZ8/zlWoJe1Y8QUDGc8Db8D
         rUYmmvbJuC/7r+l2zC9ZnStHkVsCZuXM7W7RUkPZmgBB2pRF1xfC57OttQEoBPdDhT4m
         X/tnodIsn1lUCMxcdC44jKlk0qndbZZYkvwf8InAtmylP8GhFZkdLOmzne0vGYUtRAzs
         lsvKrm2wK9FYllcnhKG9uGlUtdsy9//Q1GCcGe3IxdOI+/JAuNSB2aeGhH4ZXWEORYpJ
         19RMsviQIWcnkBPAx7yVItDpqbKX6sQT2oLANGV+dVXw4mzpBkGE2LP0GWy94ctxYm9x
         h2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m7Fnl+NRmaVX5Q28tvHO2Erurvf0mYOwE6C6uF/vs18=;
        b=kqZzTXEZC71sEHuBxHgmfXqWGruikv/5gPtKJqON9jjzvgFK3YDnSwvxiq+DHq2n7v
         BuuefWZAGY1YnywkqbDrzM2dXNwl20zAGaJfl5lcOKAaGVD7bEiW3iTKbANHxmpgYnT9
         WFR6YKrvNKjj47ZsPmhu0L5KfgJdO2zGSJ8YAL2IogkFIf5afmmb3erY1eATUWbVfrBr
         rM1tiYrfZSEAR5a//2cqYiRnEgaG7mwC67HWxJpIUrlHRqjexwnYsBXSgitFuWoCjO4/
         HGMCU9+Kn1Qk1iwxIHLS46y/oqVhCL0FshPzcARJUVf8Vh8svG3skdRcq45f8S74zNYu
         B3FA==
X-Gm-Message-State: APjAAAUO/DWOxhpZqMa0k7XFEsfssNgKtayI2CMxQfSwNFpQRoh5MH6r
        7LjEMnPDoUeTabOCtGpS9NTOJugirnP1aH/sE/U8wg==
X-Google-Smtp-Source: APXvYqwa+BC1nqF5lQNszNNvYq3DX4uhtbF53EfkvRNoviYF5MKtkuDujQeZ/ePGiGmR1cj2srviGbgKHuvDJ+Hsfyc=
X-Received: by 2002:a24:4511:: with SMTP id y17mr5337250ita.20.1554232028518;
 Tue, 02 Apr 2019 12:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
 <20190402005245.4983-1-matheus.bernardino@usp.br> <CACsJy8BSDz1JO+w1N9w2W1zxY+EWTxiU6yB_V0eeOD--g-TzeA@mail.gmail.com>
In-Reply-To: <CACsJy8BSDz1JO+w1N9w2W1zxY+EWTxiU6yB_V0eeOD--g-TzeA@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 2 Apr 2019 16:06:57 -0300
Message-ID: <CAHd-oW5K5VrbhfYw+-bWmYXbysH1z8b2kSuDvxhPKBXgXj=KXw@mail.gmail.com>
Subject: Re: Make the git codebase thread-safe
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Zager <szager@chromium.org>,
        Stefan Zager <szager@google.com>,
        Zachary Turner <zturner@chromium.org>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        David Kastrup <dak@gnu.org>, Alfredo Goldman <gold@ime.usp.br>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 1, 2019 at 10:07 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Tue, Apr 2, 2019 at 7:52 AM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> > I downloaded chromium to give it a try and got (on a machine with i7 and
> > SSD, running Manjaro Linux):
> >
> > - 17s on blame for a file with long history[2]
> > - 2m on blame for a huge file[3]
> > - 15s on log for both [2] and [3]
> > - 1s for git status
> >
> > It seems quite a lot, especially with SSD, IMO.
>
> There have been a couple of optimizations that are probably still not
> enabled by default because they only benefit large repos. So you may
> want to check and turn them on before measuring anything:
> commit-graph, pack bitmap, untracked cache or fsmonitor. All these
> should be mentioned in 'git help config' (as starting point). Also
> search "threads" in that man page because some commands may have multi
> threads support but disabled by default for the same reason.

Nice, thanks for the suggestions!

> From your command list though, I think you might get the same results
> (maybe with a bit faster 'git status') even with all optimizations on.

Yes, you were right. With the optimizations on, I got the following
times on those same files:

- 17~18s on blame for about_flags.cc
- 1m50s~2m on blame for sqlite3.c
- 15s on log for both
- 0.3~0.5s on git status

> --
> Duy
